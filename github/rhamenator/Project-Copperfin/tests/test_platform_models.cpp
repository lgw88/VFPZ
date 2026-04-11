#include "copperfin/platform/database_model.h"
#include "copperfin/platform/extensibility_model.h"
#include "copperfin/security/security_model.h"

#include <algorithm>
#include <cstdlib>
#include <iostream>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

void test_default_security_profile() {
    const auto profile = copperfin::security::default_native_security_profile();
    expect(profile.available, "security profile should be available");
    expect(profile.optional, "security profile should be optional to enable");
    expect(!profile.roles.empty(), "security profile should define roles");
    expect(!profile.permissions.empty(), "security profile should define permissions");
    expect(!profile.identity_providers.empty(), "security profile should define identity providers");

    const auto security_admin = std::find_if(profile.roles.begin(), profile.roles.end(), [](const auto& role) {
        return role.id == "security-admin";
    });
    expect(security_admin != profile.roles.end(), "security profile should include a security administrator role");

    const auto ai_permission = std::find_if(profile.permissions.begin(), profile.permissions.end(), [](const auto& permission) {
        return permission.id == "ai.mcp";
    });
    expect(ai_permission != profile.permissions.end(), "security profile should include MCP/AI permissions");
}

void test_default_extensibility_profile() {
    const auto profile = copperfin::platform::default_extensibility_profile();
    expect(profile.available, "extensibility profile should be available");
    expect(profile.dotnet_output.available, "extensibility profile should include a .NET output story");
    expect(profile.dotnet_output.managed_wrappers, "extensibility profile should support managed wrappers");

    const auto python = std::find_if(profile.languages.begin(), profile.languages.end(), [](const auto& language) {
        return language.id == "python";
    });
    expect(python != profile.languages.end(), "extensibility profile should include Python as a sidecar story");

    const auto mcp = std::find_if(profile.ai_features.begin(), profile.ai_features.end(), [](const auto& feature) {
        return feature.id == "mcp-host";
    });
    expect(mcp != profile.ai_features.end(), "extensibility profile should include MCP hosting");
}

void test_default_database_profile() {
    const auto profile = copperfin::platform::default_database_federation_profile();
    expect(profile.available, "database profile should be available");
    expect(!profile.connectors.empty(), "database profile should define connectors");
    expect(!profile.query_paths.empty(), "database profile should define query translation paths");

    const auto sqlite = std::find_if(profile.connectors.begin(), profile.connectors.end(), [](const auto& connector) {
        return connector.id == "sqlite";
    });
    expect(sqlite != profile.connectors.end(), "database profile should include SQLite");
    if (sqlite != profile.connectors.end()) {
        expect(sqlite->fox_sql_translation_direct, "SQLite should support direct Fox SQL translation");
    }

    const auto mongodb = std::find_if(profile.connectors.begin(), profile.connectors.end(), [](const auto& connector) {
        return connector.id == "mongodb";
    });
    expect(mongodb != profile.connectors.end(), "database profile should include document database guidance");
    if (mongodb != profile.connectors.end()) {
        expect(mongodb->ai_query_planning_optional, "document database planning should allow optional AI assistance");
    }
}

}  // namespace

int main() {
    test_default_security_profile();
    test_default_extensibility_profile();
    test_default_database_profile();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
