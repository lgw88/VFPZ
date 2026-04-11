#pragma once

#include <string>
#include <vector>

namespace copperfin::platform {

struct LanguageIntegration {
    std::string id;
    std::string title;
    std::string integration_mode;
    std::string trust_boundary;
    std::string output_story;
    bool enabled_by_default = false;
};

struct AiToolingFeature {
    std::string id;
    std::string title;
    std::string description;
    std::string trust_boundary;
    bool enabled_by_default = false;
};

struct DotNetOutputProfile {
    bool available = false;
    bool native_host_executables = false;
    bool managed_wrappers = false;
    bool nuget_sdk = false;
    std::string primary_story;
};

struct ExtensibilityProfile {
    bool available = false;
    std::vector<LanguageIntegration> languages;
    std::vector<AiToolingFeature> ai_features;
    DotNetOutputProfile dotnet_output{};
    std::vector<std::string> guardrails;
};

[[nodiscard]] ExtensibilityProfile default_extensibility_profile();

}  // namespace copperfin::platform
