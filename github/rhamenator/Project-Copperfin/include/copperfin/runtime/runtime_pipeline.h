#pragma once

#include "copperfin/platform/extensibility_model.h"
#include "copperfin/security/security_model.h"
#include "copperfin/studio/document_model.h"
#include "copperfin/studio/project_workspace.h"

#include <cstddef>
#include <string>
#include <vector>

namespace copperfin::runtime {

enum class BuildConfiguration {
    debug,
    release
};

struct RuntimePackageAsset {
    std::size_t record_index = 0;
    std::string source_path;
    std::string staged_path;
    std::string relative_path;
    std::string type_title;
    bool excluded = false;
    bool exists = false;
    bool required_for_runtime = false;
    bool copied = false;
};

struct RuntimeDebugLaunchPlan {
    std::string manifest_path;
    std::string startup_item;
    std::string startup_source_path;
    std::string working_directory;
    std::vector<std::string> source_roots;
    bool supports_breakpoints = false;
    bool supports_step_debugging = false;
};

struct RuntimePackagePlan {
    bool ok = false;
    std::string project_path;
    std::string project_title;
    std::string package_root;
    std::string content_root;
    std::string manifest_path;
    std::string debug_manifest_path;
    std::string launcher_project_path;
    std::string launcher_source_path;
    std::string launcher_output_path;
    std::string runtime_host_destination_path;
    std::string startup_item;
    std::string startup_source_path;
    std::string working_directory;
    BuildConfiguration configuration = BuildConfiguration::debug;
    bool security_enabled = false;
    bool emit_dotnet_launcher = true;
    std::vector<RuntimePackageAsset> assets;
    RuntimeDebugLaunchPlan debug_plan{};
    std::vector<std::string> warnings;
};

struct RuntimeMaterializeResult {
    bool ok = false;
    RuntimePackagePlan plan{};
    std::string error;
};

[[nodiscard]] const char* build_configuration_name(BuildConfiguration configuration);
[[nodiscard]] BuildConfiguration parse_build_configuration(const std::string& value);

[[nodiscard]] RuntimePackagePlan create_runtime_package_plan(
    const studio::StudioDocumentModel& document,
    const studio::StudioProjectWorkspace& workspace,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile,
    const std::string& output_root,
    BuildConfiguration configuration,
    bool enable_security,
    bool emit_dotnet_launcher);

[[nodiscard]] std::string build_runtime_manifest_text(
    const RuntimePackagePlan& plan,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile);

[[nodiscard]] std::string build_debug_manifest_text(const RuntimePackagePlan& plan);

RuntimeMaterializeResult materialize_runtime_package(
    const RuntimePackagePlan& plan,
    const security::NativeSecurityProfile& security_profile,
    const platform::ExtensibilityProfile& extensibility_profile,
    const std::string& runtime_host_source_path);

}  // namespace copperfin::runtime
