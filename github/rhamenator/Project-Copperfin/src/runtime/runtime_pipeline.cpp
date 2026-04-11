#include "copperfin/runtime/runtime_pipeline.h"

#include <cctype>
#include <algorithm>
#include <filesystem>
#include <fstream>
#include <optional>
#include <sstream>

namespace copperfin::runtime {

namespace {

std::string sanitize_file_name(const std::string& value) {
    std::string sanitized;
    sanitized.reserve(value.size());
    for (const char ch : value) {
        if ((ch >= 'A' && ch <= 'Z') ||
            (ch >= 'a' && ch <= 'z') ||
            (ch >= '0' && ch <= '9') ||
            ch == '-' || ch == '_') {
            sanitized.push_back(ch);
        } else {
            sanitized.push_back('_');
        }
    }
    return sanitized.empty() ? "copperfin_app" : sanitized;
}

std::string trim_copy(std::string value) {
    const auto is_space = [](unsigned char ch) {
        return std::isspace(ch) != 0;
    };
    value.erase(value.begin(), std::find_if(value.begin(), value.end(), [&](unsigned char ch) {
        return !is_space(ch);
    }));
    while (!value.empty() && is_space(static_cast<unsigned char>(value.back()))) {
        value.pop_back();
    }
    return value;
}

std::string lowercase_copy(std::string value) {
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return value;
}

std::string quote_manifest_value(const std::string& value) {
    std::string escaped;
    escaped.reserve(value.size());
    for (const char ch : value) {
        if (ch == '\\') {
            escaped += "\\\\";
        } else if (ch == '\n') {
            escaped += "\\n";
        } else if (ch == '\r') {
            escaped += "\\r";
        } else {
            escaped.push_back(ch);
        }
    }
    return escaped;
}

bool write_text_file(const std::filesystem::path& path, const std::string& contents, std::string& error) {
    std::ofstream output(path, std::ios::binary);
    if (!output) {
        error = "Unable to create file: " + path.string();
        return false;
    }

    output << contents;
    if (!output.good()) {
        error = "Unable to write file: " + path.string();
        return false;
    }

    return true;
}

std::string build_launcher_program_source(const RuntimePackagePlan&) {
    std::ostringstream stream;
    stream << "using System;\n";
    stream << "using System.Collections.Generic;\n";
    stream << "using System.Diagnostics;\n";
    stream << "using System.IO;\n\n";
    stream << "internal static class Program\n";
    stream << "{\n";
    stream << "    private static int Main(string[] args)\n";
    stream << "    {\n";
    stream << "        var baseDir = AppContext.BaseDirectory;\n";
    stream << "        var runtimeHost = Path.Combine(baseDir, \"copperfin_runtime_host.exe\");\n";
    stream << "        var manifest = Path.Combine(baseDir, \"app.cfmanifest\");\n";
    stream << "        if (!File.Exists(runtimeHost))\n";
    stream << "        {\n";
    stream << "            Console.Error.WriteLine(\"Copperfin runtime host was not found beside the launcher.\");\n";
    stream << "            return 3;\n";
    stream << "        }\n";
    stream << "        if (!File.Exists(manifest))\n";
    stream << "        {\n";
    stream << "            Console.Error.WriteLine(\"Copperfin manifest was not found beside the launcher.\");\n";
    stream << "            return 4;\n";
    stream << "        }\n\n";
    stream << "        var forwarded = new List<string> { \"--manifest\", Quote(manifest) };\n";
    stream << "        foreach (var arg in args)\n";
    stream << "        {\n";
    stream << "            if (string.Equals(arg, \"--debug\", StringComparison.OrdinalIgnoreCase) ||\n";
    stream << "                string.Equals(arg, \"/debug\", StringComparison.OrdinalIgnoreCase))\n";
    stream << "            {\n";
    stream << "                forwarded.Add(\"--debug\");\n";
    stream << "            }\n";
    stream << "        }\n\n";
    stream << "        var startInfo = new ProcessStartInfo\n";
    stream << "        {\n";
    stream << "            FileName = runtimeHost,\n";
    stream << "            Arguments = string.Join(\" \", forwarded),\n";
    stream << "            WorkingDirectory = baseDir,\n";
    stream << "            UseShellExecute = false\n";
    stream << "        };\n\n";
    stream << "        using var process = Process.Start(startInfo);\n";
    stream << "        if (process is null)\n";
    stream << "        {\n";
    stream << "            Console.Error.WriteLine(\"Copperfin runtime host could not be started.\");\n";
    stream << "            return 5;\n";
    stream << "        }\n";
    stream << "        process.WaitForExit();\n";
    stream << "        return process.ExitCode;\n";
    stream << "    }\n\n";
    stream << "    private static string Quote(string value)\n";
    stream << "    {\n";
    stream << "        return \"\\\"\" + value.Replace(\"\\\"\", \"\\\"\\\"\") + \"\\\"\";\n";
    stream << "    }\n";
    stream << "}\n";
    return stream.str();
}

std::string build_launcher_project_source(const RuntimePackagePlan& plan) {
    std::ostringstream stream;
    stream << "<Project Sdk=\"Microsoft.NET.Sdk\">\n";
    stream << "  <PropertyGroup>\n";
    stream << "    <OutputType>Exe</OutputType>\n";
    stream << "    <TargetFramework>net8.0-windows</TargetFramework>\n";
    stream << "    <ImplicitUsings>enable</ImplicitUsings>\n";
    stream << "    <Nullable>enable</Nullable>\n";
    stream << "    <UseWindowsForms>false</UseWindowsForms>\n";
    stream << "    <AssemblyName>" << sanitize_file_name(plan.project_title) << "</AssemblyName>\n";
    stream << "    <RootNamespace>Copperfin.Generated</RootNamespace>\n";
    stream << "    <PublishSingleFile>false</PublishSingleFile>\n";
    stream << "  </PropertyGroup>\n";
    stream << "</Project>\n";
    return stream.str();
}

bool copy_file_if_exists(
    const std::filesystem::path& source,
    const std::filesystem::path& destination,
    std::string& error) {
    if (!std::filesystem::exists(source)) {
        error = "Source file does not exist: " + source.string();
        return false;
    }

    std::error_code directory_error;
    std::filesystem::create_directories(destination.parent_path(), directory_error);
    if (directory_error) {
        error = "Unable to create directory: " + destination.parent_path().string();
        return false;
    }

    std::error_code copy_error;
    std::filesystem::copy_file(source, destination, std::filesystem::copy_options::overwrite_existing, copy_error);
    if (copy_error) {
        error = "Unable to copy file to: " + destination.string();
        return false;
    }

    return true;
}

std::string resolve_project_item_source(
    const studio::StudioDocumentModel& document,
    const studio::StudioProjectEntry& entry) {
    const std::filesystem::path base_dir = std::filesystem::path(document.path).parent_path();

    if (!entry.relative_path.empty()) {
        const std::filesystem::path from_relative = base_dir / entry.relative_path;
        if (std::filesystem::exists(from_relative)) {
            return from_relative.lexically_normal().string();
        }
    }

    if (entry.name.empty()) {
        return {};
    }

    const std::filesystem::path raw(entry.name);
    if (raw.is_absolute()) {
        if (std::filesystem::exists(raw)) {
            return raw.lexically_normal().string();
        }

        const std::filesystem::path from_filename = base_dir / raw.filename();
        return from_filename.lexically_normal().string();
    }

    return (base_dir / raw).lexically_normal().string();
}

std::string relative_asset_path(const studio::StudioProjectEntry& entry) {
    const std::string path = !entry.relative_path.empty() ? entry.relative_path : entry.name;
    if (!path.empty()) {
        return path;
    }
    return "record_" + std::to_string(entry.record_index) + ".asset";
}

std::string resolve_working_directory(
    const studio::StudioDocumentModel& document,
    const studio::StudioProjectWorkspace& workspace) {
    const std::filesystem::path document_dir = std::filesystem::path(document.path).parent_path();
    if (!workspace.home_directory.empty()) {
        const std::filesystem::path home_directory(workspace.home_directory);
        if (std::filesystem::exists(home_directory)) {
            return home_directory.lexically_normal().string();
        }
    }
    return document_dir.lexically_normal().string();
}

std::string join_strings(const std::vector<std::string>& values) {
    std::ostringstream stream;
    for (std::size_t index = 0; index < values.size(); ++index) {
        stream << values[index];
        if ((index + 1U) != values.size()) {
            stream << ";";
        }
    }
    return stream.str();
}

bool is_prg_path(const std::string& value) {
    return trim_copy(std::filesystem::path(value).extension().string()) == ".prg";
}

bool is_xasset_path(const std::string& value) {
    const std::string extension = trim_copy(std::filesystem::path(value).extension().string());
    return extension == ".scx" ||
        extension == ".vcx" ||
        extension == ".frx" ||
        extension == ".lbx" ||
        extension == ".mnx";
}

bool should_stage_asset(const RuntimePackageAsset& asset) {
    return asset.exists && (!asset.excluded || asset.required_for_runtime);
}

std::vector<std::filesystem::path> infer_companion_source_paths(const std::filesystem::path& source) {
    std::vector<std::filesystem::path> companions;
    const std::string extension = trim_copy(lowercase_copy(source.extension().string()));
    const auto same_stem = [&](const char* companion_extension) {
        auto path = source;
        path.replace_extension(companion_extension);
        return path;
    };

    if (extension == ".pjx") {
        companions.push_back(same_stem(".pjt"));
    } else if (extension == ".scx") {
        companions.push_back(same_stem(".sct"));
    } else if (extension == ".vcx") {
        companions.push_back(same_stem(".vct"));
    } else if (extension == ".frx") {
        companions.push_back(same_stem(".frt"));
    } else if (extension == ".lbx") {
        companions.push_back(same_stem(".lbt"));
    } else if (extension == ".mnx") {
        companions.push_back(same_stem(".mnt"));
    } else if (extension == ".dbf") {
        companions.push_back(same_stem(".fpt"));
        companions.push_back(same_stem(".cdx"));
        companions.push_back(same_stem(".idx"));
        companions.push_back(same_stem(".ndx"));
        companions.push_back(same_stem(".mdx"));
    } else if (extension == ".dbc") {
        companions.push_back(same_stem(".dct"));
        companions.push_back(same_stem(".dcx"));
    }

    return companions;
}

void copy_companion_files_if_present(
    const RuntimePackageAsset& asset,
    std::vector<std::string>& warnings) {
    const std::filesystem::path source(asset.source_path);
    const std::filesystem::path staged(asset.staged_path);
    for (const auto& companion_source : infer_companion_source_paths(source)) {
        if (!std::filesystem::exists(companion_source)) {
            continue;
        }

        auto companion_destination = staged;
        companion_destination.replace_extension(companion_source.extension().string());
        std::string error;
        if (!copy_file_if_exists(companion_source, companion_destination, error)) {
            warnings.push_back(error);
        }
    }
}

}  // namespace

const char* build_configuration_name(BuildConfiguration configuration) {
    switch (configuration) {
        case BuildConfiguration::debug:
            return "debug";
        case BuildConfiguration::release:
            return "release";
    }
    return "debug";
}

BuildConfiguration parse_build_configuration(const std::string& value) {
    return trim_copy(value) == "release"
        ? BuildConfiguration::release
        : BuildConfiguration::debug;
}

RuntimePackagePlan create_runtime_package_plan(
    const studio::StudioDocumentModel& document,
    const studio::StudioProjectWorkspace& workspace,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile,
    const std::string& output_root,
    BuildConfiguration configuration,
    bool enable_security,
    bool emit_dotnet_launcher) {
    RuntimePackagePlan plan;
    plan.project_path = document.path;
    plan.project_title = workspace.project_title.empty()
        ? std::filesystem::path(document.path).stem().string()
        : workspace.project_title;
    plan.configuration = configuration;
    plan.security_enabled = enable_security;
    plan.emit_dotnet_launcher = emit_dotnet_launcher;

    if (!workspace.available) {
        plan.warnings.push_back("Project workspace is not available.");
        return plan;
    }

    const std::filesystem::path root(output_root);
    const std::filesystem::path package_root = root / sanitize_file_name(plan.project_title);
    const std::filesystem::path content_root = package_root / "content";
    plan.package_root = package_root.string();
    plan.content_root = content_root.string();
    plan.manifest_path = (package_root / "app.cfmanifest").string();
    plan.debug_manifest_path = (package_root / "app.cfdebug").string();
    plan.launcher_project_path = (package_root / "launcher" / "Copperfin.GeneratedLauncher.csproj").string();
    plan.launcher_source_path = (package_root / "launcher" / "Program.cs").string();
    plan.launcher_output_path = (package_root / (sanitize_file_name(plan.project_title) + ".exe")).string();
    plan.runtime_host_destination_path = (package_root / "copperfin_runtime_host.exe").string();
    plan.working_directory = content_root.lexically_normal().string();
    plan.startup_item = workspace.build_plan.startup_item;
    const std::string source_working_directory = resolve_working_directory(document, workspace);

    for (const auto& entry : workspace.entries) {
        RuntimePackageAsset asset;
        asset.record_index = entry.record_index;
        asset.relative_path = relative_asset_path(entry);
        asset.source_path = resolve_project_item_source(document, entry);
        asset.staged_path = (content_root / asset.relative_path).lexically_normal().string();
        asset.type_title = entry.type_title;
        asset.excluded = entry.excluded;
        asset.exists = !asset.source_path.empty() && std::filesystem::exists(asset.source_path);
        if (entry.record_index == workspace.build_plan.startup_record_index) {
            asset.required_for_runtime = true;
            plan.startup_source_path = asset.staged_path;
            plan.debug_plan.startup_source_path = asset.source_path;
        }
        if (!asset.exists && !entry.excluded && entry.group_id != "project") {
            plan.warnings.push_back("Missing project asset: " + asset.source_path);
        }
        plan.assets.push_back(std::move(asset));
    }

    if (plan.startup_source_path.empty()) {
        plan.warnings.push_back("No startup source asset could be resolved.");
    }
    if (plan.debug_plan.startup_source_path.empty()) {
        plan.warnings.push_back("No source-side startup asset could be resolved for debugging.");
    }

    plan.debug_plan.manifest_path = plan.debug_manifest_path;
    plan.debug_plan.startup_item = plan.startup_item;
    plan.debug_plan.working_directory = source_working_directory;
    plan.debug_plan.source_roots = {
        source_working_directory,
        plan.content_root
    };
    plan.debug_plan.supports_breakpoints =
        is_prg_path(plan.debug_plan.startup_source_path) ||
        is_xasset_path(plan.debug_plan.startup_source_path);
    plan.debug_plan.supports_step_debugging = plan.debug_plan.supports_breakpoints;

    if (enable_security && !security_profile.available) {
        plan.warnings.push_back("Security was requested but no native security profile is available.");
    }
    if (emit_dotnet_launcher && !extensibility_profile.dotnet_output.available) {
        plan.warnings.push_back(".NET launcher generation was requested but no .NET output profile is available.");
    }

    plan.ok = true;
    return plan;
}

std::string build_runtime_manifest_text(
    const RuntimePackagePlan& plan,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile) {
    std::ostringstream stream;
    stream << "manifest_version=1\n";
    stream << "project_title=" << quote_manifest_value(plan.project_title) << "\n";
    stream << "project_path=" << quote_manifest_value(plan.project_path) << "\n";
    stream << "package_root=" << quote_manifest_value(plan.package_root) << "\n";
    stream << "content_root=" << quote_manifest_value(plan.content_root) << "\n";
    stream << "working_directory=" << quote_manifest_value(plan.working_directory) << "\n";
    stream << "startup_item=" << quote_manifest_value(plan.startup_item) << "\n";
    stream << "startup_source=" << quote_manifest_value(plan.startup_source_path) << "\n";
    stream << "configuration=" << build_configuration_name(plan.configuration) << "\n";
    stream << "security_enabled=" << (plan.security_enabled ? "true" : "false") << "\n";
    stream << "security_mode=" << quote_manifest_value(security_profile.mode) << "\n";
    stream << "security_roles=" << security_profile.roles.size() << "\n";
    stream << "dotnet_enabled=" << (extensibility_profile.dotnet_output.available ? "true" : "false") << "\n";
    stream << "dotnet_story=" << quote_manifest_value(extensibility_profile.dotnet_output.primary_story) << "\n";
    stream << "language_integrations=" << extensibility_profile.languages.size() << "\n";
    stream << "ai_features=" << extensibility_profile.ai_features.size() << "\n";

    for (const auto& asset : plan.assets) {
        stream << "asset="
               << asset.record_index << "|"
               << quote_manifest_value(asset.relative_path) << "|"
               << quote_manifest_value(asset.staged_path) << "|"
               << quote_manifest_value(asset.type_title) << "|"
               << (asset.excluded ? "true" : "false") << "|"
               << (asset.exists ? "true" : "false") << "\n";
    }

    for (const auto& warning : plan.warnings) {
        stream << "warning=" << quote_manifest_value(warning) << "\n";
    }

    return stream.str();
}

std::string build_debug_manifest_text(const RuntimePackagePlan& plan) {
    std::ostringstream stream;
    stream << "debug_manifest_version=1\n";
    stream << "startup_item=" << quote_manifest_value(plan.debug_plan.startup_item) << "\n";
    stream << "startup_source=" << quote_manifest_value(plan.debug_plan.startup_source_path) << "\n";
    stream << "working_directory=" << quote_manifest_value(plan.debug_plan.working_directory) << "\n";
    stream << "supports_breakpoints=" << (plan.debug_plan.supports_breakpoints ? "true" : "false") << "\n";
    stream << "supports_step_debugging=" << (plan.debug_plan.supports_step_debugging ? "true" : "false") << "\n";
    stream << "source_roots=" << quote_manifest_value(join_strings(plan.debug_plan.source_roots)) << "\n";
    return stream.str();
}

RuntimeMaterializeResult materialize_runtime_package(
    const RuntimePackagePlan& plan,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile,
    const std::string& runtime_host_source_path) {
    if (!plan.ok) {
        return {.ok = false, .error = "Package plan is not valid."};
    }

    std::error_code directory_error;
    std::filesystem::create_directories(plan.package_root, directory_error);
    if (directory_error) {
        return {.ok = false, .error = "Unable to create package root."};
    }
    std::filesystem::create_directories(plan.content_root, directory_error);
    if (directory_error) {
        return {.ok = false, .error = "Unable to create content root."};
    }
    if (plan.emit_dotnet_launcher) {
        std::filesystem::create_directories(std::filesystem::path(plan.launcher_project_path).parent_path(), directory_error);
        if (directory_error) {
            return {.ok = false, .error = "Unable to create launcher directory."};
        }
    }

    RuntimePackagePlan materialized_plan = plan;
    for (auto& asset : materialized_plan.assets) {
        if (!should_stage_asset(asset)) {
            continue;
        }

        std::string error;
        const std::filesystem::path destination = std::filesystem::path(plan.content_root) / asset.relative_path;
        if (!copy_file_if_exists(asset.source_path, destination, error)) {
            materialized_plan.warnings.push_back(error);
            continue;
        }
        copy_companion_files_if_present(asset, materialized_plan.warnings);
        asset.copied = true;
    }

    std::string error;
    if (!write_text_file(plan.manifest_path, build_runtime_manifest_text(materialized_plan, security_profile, extensibility_profile), error)) {
        return {.ok = false, .error = error};
    }
    if (!write_text_file(plan.debug_manifest_path, build_debug_manifest_text(materialized_plan), error)) {
        return {.ok = false, .error = error};
    }

    if (!copy_file_if_exists(runtime_host_source_path, plan.runtime_host_destination_path, error)) {
        return {.ok = false, .error = error};
    }

    if (plan.emit_dotnet_launcher) {
        if (!write_text_file(plan.launcher_project_path, build_launcher_project_source(plan), error)) {
            return {.ok = false, .error = error};
        }
        if (!write_text_file(plan.launcher_source_path, build_launcher_program_source(plan), error)) {
            return {.ok = false, .error = error};
        }
    }

    return {.ok = true, .plan = std::move(materialized_plan)};
}

}  // namespace copperfin::runtime
