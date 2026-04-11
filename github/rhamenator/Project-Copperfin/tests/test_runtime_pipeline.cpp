#include "copperfin/platform/extensibility_model.h"
#include "copperfin/runtime/runtime_pipeline.h"
#include "copperfin/security/security_model.h"
#include "copperfin/studio/project_workspace.h"

#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

void write_text(const std::filesystem::path& path, const std::string& contents) {
    std::ofstream output(path, std::ios::binary);
    output << contents;
}

std::string read_text(const std::filesystem::path& path) {
    std::ifstream input(path, std::ios::binary);
    std::ostringstream stream;
    stream << input.rdbuf();
    return stream.str();
}

void test_materialize_runtime_package() {
    namespace fs = std::filesystem;
    const fs::path temp_root = fs::temp_directory_path() / "copperfin_runtime_pipeline_tests";
    const fs::path project_dir = temp_root / "project";
    const fs::path output_dir = temp_root / "output";
    const fs::path runtime_host = temp_root / "copperfin_runtime_host.exe";
    std::error_code ignored;
    fs::remove_all(temp_root, ignored);
    fs::create_directories(project_dir);

    write_text(project_dir / "main.prg", "DO FORM customer\n");
    write_text(project_dir / "customer.scx", "synthetic form");
    write_text(runtime_host, "runtime-host");

    copperfin::studio::StudioDocumentModel document;
    document.path = (project_dir / "demo.pjx").string();

    copperfin::studio::StudioProjectWorkspace workspace;
    workspace.available = true;
    workspace.project_title = "DemoApp";
    workspace.home_directory = project_dir.string();
    workspace.build_plan.available = true;
    workspace.build_plan.can_build = true;
    workspace.build_plan.project_title = "DemoApp";
    workspace.build_plan.output_path = (output_dir / "DemoApp.exe").string();
    workspace.build_plan.startup_item = "main.prg";
    workspace.build_plan.startup_record_index = 1U;
    workspace.entries = {
        {.record_index = 1U, .name = "main.prg", .relative_path = "main.prg", .type_title = "Program"},
        {.record_index = 2U, .name = "customer.scx", .relative_path = "customer.scx", .type_title = "Form"}
    };

    const auto plan = copperfin::runtime::create_runtime_package_plan(
        document,
        workspace,
        copperfin::security::default_native_security_profile(),
        copperfin::platform::default_extensibility_profile(),
        output_dir.string(),
        copperfin::runtime::BuildConfiguration::debug,
        true,
        true);

    expect(plan.ok, "runtime package plan should be created");

    const auto result = copperfin::runtime::materialize_runtime_package(
        plan,
        copperfin::security::default_native_security_profile(),
        copperfin::platform::default_extensibility_profile(),
        runtime_host.string());

    expect(result.ok, "runtime package should materialize");
    if (result.ok) {
        expect(fs::exists(result.plan.manifest_path), "runtime package should emit a manifest");
        expect(fs::exists(result.plan.debug_manifest_path), "runtime package should emit a debug manifest");
        expect(fs::exists(result.plan.runtime_host_destination_path), "runtime package should bundle the runtime host");
        expect(fs::exists(fs::path(result.plan.content_root) / "main.prg"), "runtime package should stage the startup source");
        expect(fs::exists(fs::path(result.plan.content_root) / "customer.scx"), "runtime package should stage project assets");
        expect(fs::exists(result.plan.launcher_project_path), "runtime package should emit a generated launcher project");
        expect(fs::exists(result.plan.launcher_source_path), "runtime package should emit a generated launcher source file");

        const std::string runtime_manifest = read_text(result.plan.manifest_path);
        const std::string debug_manifest = read_text(result.plan.debug_manifest_path);
        expect(
            result.plan.startup_source_path == (fs::path(result.plan.content_root) / "main.prg").string(),
            "runtime plan should point startup to staged package content");
        expect(
            result.plan.debug_plan.startup_source_path == (project_dir / "main.prg").string(),
            "debug plan should point startup to source content");
        expect(result.plan.debug_plan.supports_breakpoints, "debug plan should enable breakpoints for PRG startup");
        expect(result.plan.debug_plan.supports_step_debugging, "debug plan should enable step debugging for PRG startup");
        expect(runtime_manifest.find("startup_source=") != std::string::npos, "runtime manifest should include a startup source field");
        expect(debug_manifest.find("startup_source=") != std::string::npos, "debug manifest should include a startup source field");
    }

    fs::remove_all(temp_root, ignored);
}

void test_materialize_excluded_xasset_startup_package() {
    namespace fs = std::filesystem;
    const fs::path temp_root = fs::temp_directory_path() / "copperfin_runtime_pipeline_xasset_tests";
    const fs::path project_dir = temp_root / "project";
    const fs::path output_dir = temp_root / "output";
    const fs::path runtime_host = temp_root / "copperfin_runtime_host.exe";
    std::error_code ignored;
    fs::remove_all(temp_root, ignored);
    fs::create_directories(project_dir);

    write_text(project_dir / "startup.scx", "synthetic form table");
    write_text(project_dir / "startup.sct", "synthetic form memo");
    write_text(runtime_host, "runtime-host");

    copperfin::studio::StudioDocumentModel document;
    document.path = (project_dir / "demo.pjx").string();

    copperfin::studio::StudioProjectWorkspace workspace;
    workspace.available = true;
    workspace.project_title = "DemoXAsset";
    workspace.home_directory = project_dir.string();
    workspace.build_plan.available = true;
    workspace.build_plan.can_build = true;
    workspace.build_plan.project_title = "DemoXAsset";
    workspace.build_plan.output_path = (output_dir / "DemoXAsset.exe").string();
    workspace.build_plan.startup_item = "startup.scx";
    workspace.build_plan.startup_record_index = 1U;
    workspace.entries = {
        {.record_index = 1U, .name = "startup.scx", .relative_path = "startup.scx", .type_title = "Form", .excluded = true}
    };

    const auto plan = copperfin::runtime::create_runtime_package_plan(
        document,
        workspace,
        copperfin::security::default_native_security_profile(),
        copperfin::platform::default_extensibility_profile(),
        output_dir.string(),
        copperfin::runtime::BuildConfiguration::debug,
        false,
        false);

    expect(plan.ok, "xasset runtime package plan should be created");
    expect(plan.debug_plan.supports_breakpoints, "xasset startup should advertise breakpoint support");
    expect(plan.debug_plan.supports_step_debugging, "xasset startup should advertise step debugging");

    const auto result = copperfin::runtime::materialize_runtime_package(
        plan,
        copperfin::security::default_native_security_profile(),
        copperfin::platform::default_extensibility_profile(),
        runtime_host.string());

    expect(result.ok, "xasset runtime package should materialize");
    if (result.ok) {
        expect(fs::exists(fs::path(result.plan.content_root) / "startup.scx"), "packaged xasset startup should be staged even if excluded");
        expect(fs::exists(fs::path(result.plan.content_root) / "startup.sct"), "packaged xasset memo sidecar should be staged");
    }

    fs::remove_all(temp_root, ignored);
}

}  // namespace

int main() {
    test_materialize_runtime_package();
    test_materialize_excluded_xasset_startup_package();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
