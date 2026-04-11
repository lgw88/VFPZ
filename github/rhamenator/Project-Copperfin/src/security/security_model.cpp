#include "copperfin/security/security_model.h"

namespace copperfin::security {

NativeSecurityProfile default_native_security_profile() {
    NativeSecurityProfile profile;
    profile.available = true;
    profile.optional = true;
    profile.mode = "optional native security with platform RBAC";
    profile.package_policy = "signed packages, signed extensions, explicit trust manifests";
    profile.managed_interop_policy = ".NET and native plugin loading require allow-list policy, audit, and optional signature enforcement";

    profile.permissions = {
        {"project.open", "Open Project", "Open and inspect project assets."},
        {"asset.edit", "Edit Assets", "Modify forms, reports, labels, menus, and project metadata."},
        {"build.execute", "Build Executables", "Compile and package Copperfin applications.", true},
        {"build.release", "Release Builds", "Produce signed release outputs and deployment bundles.", true},
        {"runtime.admin", "Runtime Administration", "Change runtime settings, compatibility switches, and service configuration.", true},
        {"security.manage", "Manage Security", "Create roles, map identities, and change platform policy.", true},
        {"data.export", "Export Data", "Run privileged data exports and report outputs.", true},
        {"interop.dotnet", "Use .NET Interop", "Call or host managed .NET components from Copperfin."},
        {"interop.python", "Use Python Sidecars", "Invoke Python sidecars or offline data-science jobs under policy control.", true},
        {"ai.mcp", "Use MCP And AI Tools", "Invoke MCP tools or AI-assisted developer workflows under audit.", true},
        {"external.process", "Launch External Processes", "Launch external executables or command-line tools.", true}
    };

    profile.roles = {
        {"developer", "Developer", "Builds and edits applications but cannot change platform security.", {"project.open", "asset.edit", "interop.dotnet"}, true},
        {"build-engineer", "Build Engineer", "Owns packaging and release workflows.", {"project.open", "build.execute", "build.release", "interop.dotnet"}, false},
        {"security-admin", "Security Administrator", "Owns identity mapping, role policy, and trust settings.", {"project.open", "security.manage", "runtime.admin"}, false},
        {"auditor", "Auditor", "Reviews actions, exports, and security events without changing policy.", {"project.open", "data.export"}, false},
        {"runtime-operator", "Runtime Operator", "Operates deployed apps and approved interop facilities.", {"project.open", "runtime.admin", "interop.dotnet", "interop.python", "ai.mcp"}, false}
    };

    profile.identity_providers = {
        {"local", "Local Copperfin Identity", "native", "Built-in application and platform accounts for standalone deployments.", true},
        {"windows", "Windows/AD Identity", "windows", "Map Windows identities and groups into Copperfin roles on Windows-first deployments.", false},
        {"entra-oidc", "Microsoft Entra ID / OIDC", "federated", "Use modern enterprise identity and claims-based role mapping.", false},
        {"external", "External Identity Adapter", "adapter", "Pluggable identity adapters for other enterprise or custom providers.", false}
    };

    profile.features = {
        {"rbac", "Role-Based Access Control", "Native RBAC for the IDE, runtime, build pipeline, and privileged tools.", true, true},
        {"secrets", "Secret Providers", "Abstract secret resolution for databases, APIs, certificates, and signing keys.", true, true},
        {"audit", "Immutable Audit Stream", "Capture privileged actions, denials, exports, and interop use.", true, true},
        {"signing", "Signed Packages And Extensions", "Require or validate signatures on release outputs and extensions.", true, true},
        {"sandbox", "Interop Guardrails", "Policy controls for shell launches, Python sidecars, AI tools, and unsafe plugins.", true, true}
    };

    profile.audit_events = {
        "login.identity_resolved",
        "role.assigned_or_denied",
        "asset.modified",
        "build.executed",
        "release.signed",
        "runtime.policy_changed",
        "data.exported",
        "interop.dotnet_invoked",
        "interop.python_invoked",
        "ai.mcp_invoked",
        "external.process_launched",
        "policy.denied"
    };

    profile.hardening_profiles = {
        "bronze: local identity, audit, signed manifests",
        "silver: enterprise identity, RBAC, signed extensions, export controls",
        "gold: enterprise identity, full audit, secret providers, interop restrictions, release signing"
    };

    return profile;
}

}  // namespace copperfin::security
