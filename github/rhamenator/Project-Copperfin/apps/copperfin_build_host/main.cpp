#include "copperfin/platform/extensibility_model.h"
#include "copperfin/runtime/runtime_pipeline.h"
#include "copperfin/security/security_model.h"
#include "copperfin/studio/document_model.h"
#include "copperfin/studio/project_workspace.h"

#include <cstdlib>
#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

namespace {

void print_usage() {
    std::cout << "Usage: copperfin_build_host build --project <path-to-pjx> --output-dir <directory> [--configuration debug|release] [--enable-security] [--emit-dotnet-launcher] [--runtime-host <path>]\n";
}

std::string quote_argument(const std::string& value) {
    return "\"" + value + "\"";
}

std::string resolve_runtime_host_path(const std::string& override_path) {
    if (!override_path.empty()) {
        return override_path;
    }

    char* configured = nullptr;
    std::size_t configured_length = 0;
    if (_dupenv_s(&configured, &configured_length, "COPPERFIN_RUNTIME_HOST_PATH") == 0 && configured != nullptr) {
        std::string resolved(configured);
        std::free(configured);
        return resolved;
    }

    return R"(E:\Project-Copperfin\build\Release\copperfin_runtime_host.exe)";
}

bool run_dotnet_publish(const copperfin::runtime::RuntimePackagePlan& plan, std::string& error) {
    const std::filesystem::path project_path(plan.launcher_project_path);
    const std::filesystem::path output_dir(plan.package_root);
    const std::string configuration = plan.configuration == copperfin::runtime::BuildConfiguration::release ? "Release" : "Debug";

    const std::string command =
        "dotnet publish " + quote_argument(project_path.string()) +
        " -c " + configuration +
        " -r win-x64 --self-contained false" +
        " -o " + quote_argument(output_dir.string());

    const int exit_code = std::system(command.c_str());
    if (exit_code != 0) {
        error = "dotnet publish failed for generated launcher.";
        return false;
    }

    const std::filesystem::path expected = output_dir / (project_path.stem().string() == "Copperfin.GeneratedLauncher"
        ? (std::filesystem::path(plan.launcher_output_path).filename().string())
        : (project_path.stem().string() + ".exe"));
    if (!std::filesystem::exists(expected)) {
        const std::filesystem::path generated = output_dir / "Copperfin.GeneratedLauncher.exe";
        if (std::filesystem::exists(generated)) {
            std::error_code rename_error;
            std::filesystem::rename(generated, plan.launcher_output_path, rename_error);
            if (!rename_error) {
                return true;
            }
        }

        if (!std::filesystem::exists(plan.launcher_output_path)) {
            error = "Generated launcher executable was not found after publish.";
            return false;
        }
    }

    return true;
}

}  // namespace

int main(int argc, char** argv) {
    std::vector<std::string> args;
    for (int index = 1; index < argc; ++index) {
        args.emplace_back(argv[index]);
    }

    if (args.empty() || args[0] != "build") {
        print_usage();
        return 2;
    }

    std::string project_path;
    std::string output_dir;
    std::string runtime_host_override;
    auto configuration = copperfin::runtime::BuildConfiguration::debug;
    bool enable_security = false;
    bool emit_dotnet_launcher = false;

    for (std::size_t index = 1; index < args.size(); ++index) {
        const auto& arg = args[index];
        if (arg == "--project" && (index + 1U) < args.size()) {
            project_path = args[++index];
        } else if (arg == "--output-dir" && (index + 1U) < args.size()) {
            output_dir = args[++index];
        } else if (arg == "--configuration" && (index + 1U) < args.size()) {
            configuration = copperfin::runtime::parse_build_configuration(args[++index]);
        } else if (arg == "--enable-security") {
            enable_security = true;
        } else if (arg == "--emit-dotnet-launcher") {
            emit_dotnet_launcher = true;
        } else if (arg == "--runtime-host" && (index + 1U) < args.size()) {
            runtime_host_override = args[++index];
        } else {
            std::cout << "status: error\n";
            std::cout << "error: Unknown or incomplete argument: " << arg << "\n";
            print_usage();
            return 2;
        }
    }

    if (project_path.empty() || output_dir.empty()) {
        std::cout << "status: error\n";
        std::cout << "error: --project and --output-dir are required.\n";
        print_usage();
        return 2;
    }

    const auto open_result = copperfin::studio::open_document({.path = project_path});
    if (!open_result.ok) {
        std::cout << "status: error\n";
        std::cout << "error: " << open_result.error << "\n";
        return 3;
    }

    const auto workspace = copperfin::studio::build_project_workspace(open_result.document);
    const auto security_profile = copperfin::security::default_native_security_profile();
    const auto extensibility_profile = copperfin::platform::default_extensibility_profile();
    const auto plan = copperfin::runtime::create_runtime_package_plan(
        open_result.document,
        workspace,
        security_profile,
        extensibility_profile,
        output_dir,
        configuration,
        enable_security,
        emit_dotnet_launcher);

    if (!plan.ok) {
        std::cout << "status: error\n";
        std::cout << "error: Build plan creation failed.\n";
        return 4;
    }

    const std::string runtime_host_path = resolve_runtime_host_path(runtime_host_override);
    const auto materialized = copperfin::runtime::materialize_runtime_package(
        plan,
        security_profile,
        extensibility_profile,
        runtime_host_path);
    if (!materialized.ok) {
        std::cout << "status: error\n";
        std::cout << "error: " << materialized.error << "\n";
        return 5;
    }

    if (emit_dotnet_launcher) {
        std::string publish_error;
        if (!run_dotnet_publish(materialized.plan, publish_error)) {
            std::cout << "status: error\n";
            std::cout << "error: " << publish_error << "\n";
            return 6;
        }
    }

    std::cout << "status: ok\n";
    std::cout << "project.title: " << materialized.plan.project_title << "\n";
    std::cout << "package.root: " << materialized.plan.package_root << "\n";
    std::cout << "manifest.path: " << materialized.plan.manifest_path << "\n";
    std::cout << "debug.manifest.path: " << materialized.plan.debug_manifest_path << "\n";
    std::cout << "startup.item: " << materialized.plan.startup_item << "\n";
    std::cout << "startup.source: " << materialized.plan.startup_source_path << "\n";
    std::cout << "launcher.output: " << materialized.plan.launcher_output_path << "\n";
    std::cout << "security.enabled: " << (materialized.plan.security_enabled ? "true" : "false") << "\n";
    std::cout << "warnings: " << materialized.plan.warnings.size() << "\n";
    for (const auto& warning : materialized.plan.warnings) {
        std::cout << "warning: " << warning << "\n";
    }

    return 0;
}
