#pragma once

#include <string>
#include <vector>

namespace copperfin::platform {

struct DatabaseConnectorProfile {
    std::string id;
    std::string title;
    std::string family;
    std::string access_mode;
    std::string schema_shape;
    std::string translation_story;
    bool xbase_commands_first_class = false;
    bool fox_sql_translation_direct = false;
    bool ai_query_planning_optional = false;
};

struct QueryTranslationPath {
    std::string id;
    std::string title;
    std::string source_shape;
    std::string target_shape;
    std::string complexity;
    std::string strategy;
    bool deterministic_first = false;
    bool ai_optional = false;
};

struct DatabaseFederationProfile {
    bool available = false;
    std::vector<DatabaseConnectorProfile> connectors;
    std::vector<QueryTranslationPath> query_paths;
    std::vector<std::string> guardrails;
};

[[nodiscard]] DatabaseFederationProfile default_database_federation_profile();

}  // namespace copperfin::platform
