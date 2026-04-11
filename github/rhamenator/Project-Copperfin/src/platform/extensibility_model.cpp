#include "copperfin/platform/extensibility_model.h"

namespace copperfin::platform {

ExtensibilityProfile default_extensibility_profile() {
    ExtensibilityProfile profile;
    profile.available = true;

    profile.languages = {
        {"xbase", "Native Copperfin/xBase Runtime", "native", "trusted core", "Primary runtime and build target for FoxPro-style applications.", true},
        {"dotnet", ".NET Managed Components", "hosted interop", "policy-managed interop", "Managed assemblies can be called from Copperfin and Copperfin logic can be surfaced as .NET-consumable outputs.", true},
        {"c-abi", "Native C ABI Modules", "binary plugin", "signed plugin boundary", "Performance-sensitive extensions can be linked or loaded through stable native interfaces.", false},
        {"rust", "Rust Native Components", "native library", "signed plugin boundary", "Rust is acceptable for safety-sensitive helpers behind stable native interfaces.", false},
        {"python", "Python Sidecar And Analytics Jobs", "out-of-process sidecar", "restricted external process boundary", "Python support is positioned as a sidecar or job facility for data science and automation, not the trusted core.", false},
        {"r", "R Analytics And Statistical Jobs", "out-of-process sidecar", "restricted external process boundary", "R support is positioned as a sidecar or job facility for statistical computing, reporting, and reproducible data-science workflows.", false}
    };

    profile.ai_features = {
        {"mcp-host", "MCP Host Facility", "Expose Copperfin tools through an MCP host so developers can use preferred AI models and assistants.", "policy-managed external tool boundary", false},
        {"ai-assist", "AI-Assisted Developer Workflow", "Optional vibe-coding and code-intelligence helpers for designers, migration, and diagnostics.", "policy-managed external tool boundary", false},
        {"local-models", "Local Or Enterprise AI Backends", "Use local or enterprise-approved models rather than forcing one hosted provider.", "policy-managed external tool boundary", false},
        {"model-selection", "User-Selected AI Models", "Let developers choose the model used for AI debugging and assistance instead of hard-coding one provider or model family.", "policy-managed external tool boundary", false},
        {"ai-debug-assist", "AI Debugging Assistance", "Allow developers to send debugger context, stack traces, and runtime telemetry to an approved assistant workflow for optional debugging help.", "policy-managed external tool boundary", false}
    };

    profile.dotnet_output.available = true;
    profile.dotnet_output.native_host_executables = true;
    profile.dotnet_output.managed_wrappers = true;
    profile.dotnet_output.nuget_sdk = true;
    profile.dotnet_output.primary_story =
        "Copperfin applications should be able to ship as native executables with first-class .NET compatibility, and selected modules should be exposable as managed wrappers or NuGet-consumable SDK outputs.";

    profile.guardrails = {
        "The trusted execution core stays native-first and security-first.",
        ".NET interop is first-class, but managed loading is policy-controlled and auditable.",
        "Python and R are supported through sidecars or job runners, not as the product core.",
        "MCP and AI tooling are opt-in developer features with audit, provider policy, and user-selected model controls.",
        "Release outputs must preserve a clear .NET consumption story even when the executable is native."
    };

    return profile;
}

}  // namespace copperfin::platform
