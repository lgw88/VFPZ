#pragma once

#include <string>
#include <vector>

namespace copperfin::security {

struct NativePermission {
    std::string id;
    std::string title;
    std::string description;
    bool high_risk = false;
};

struct NativeRole {
    std::string id;
    std::string title;
    std::string description;
    std::vector<std::string> permission_ids;
    bool default_assignment = false;
};

struct NativeIdentityProvider {
    std::string id;
    std::string title;
    std::string kind;
    std::string description;
    bool enabled_by_default = false;
};

struct NativeSecurityFeature {
    std::string id;
    std::string title;
    std::string description;
    bool enabled_by_default = false;
    bool optional = true;
};

struct NativeSecurityProfile {
    bool available = false;
    bool optional = true;
    std::string mode;
    std::string package_policy;
    std::string managed_interop_policy;
    std::vector<NativePermission> permissions;
    std::vector<NativeRole> roles;
    std::vector<NativeIdentityProvider> identity_providers;
    std::vector<NativeSecurityFeature> features;
    std::vector<std::string> audit_events;
    std::vector<std::string> hardening_profiles;
};

[[nodiscard]] NativeSecurityProfile default_native_security_profile();

}  // namespace copperfin::security
