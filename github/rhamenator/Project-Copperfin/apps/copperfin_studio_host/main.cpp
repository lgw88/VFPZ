#include "copperfin/studio/document_model.h"
#include "copperfin/platform/database_model.h"
#include "copperfin/platform/extensibility_model.h"
#include "copperfin/security/security_model.h"
#include "copperfin/studio/project_workspace.h"
#include "copperfin/studio/product_subsystems.h"
#include "copperfin/studio/report_layout.h"
#include "copperfin/studio/vs_launch_contract.h"
#include "copperfin/vfp/visual_asset_editor.h"

#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

namespace {

void print_usage() {
    std::cout << "Usage: copperfin_studio_host --path <asset> [--from-vs] [--read-only] [--json] [--set-property --record <n> --property-name <name> --property-value <value>] [--line <n>] [--column <n>] [--symbol <name>]\n";
    std::cout << "   or: copperfin_studio_host --list-subsystems [--json]\n";
    std::cout << "   or: copperfin_studio_host <asset>\n";
}

std::string json_escape(const std::string& value) {
    std::ostringstream stream;
    for (unsigned char ch : value) {
        switch (ch) {
            case '\"':
                stream << "\\\"";
                break;
            case '\\':
                stream << "\\\\";
                break;
            case '\b':
                stream << "\\b";
                break;
            case '\f':
                stream << "\\f";
                break;
            case '\n':
                stream << "\\n";
                break;
            case '\r':
                stream << "\\r";
                break;
            case '\t':
                stream << "\\t";
                break;
            default:
                if (ch < 0x20U) {
                    stream << "\\u"
                           << std::hex
                           << std::setw(4)
                           << std::setfill('0')
                           << static_cast<unsigned int>(ch)
                           << std::dec
                           << std::setfill(' ');
                } else {
                    stream << static_cast<char>(ch);
                }
                break;
        }
    }
    return stream.str();
}

void print_json_string(const std::string& value) {
    std::cout << "\"" << json_escape(value) << "\"";
}

void print_json_document(const copperfin::studio::StudioDocumentModel& document) {
    const auto objects = copperfin::studio::build_object_snapshot(document);
    const auto report_layout = copperfin::studio::build_report_layout(document);
    const auto project_workspace = copperfin::studio::build_project_workspace(document);
    const auto security_profile = copperfin::security::default_native_security_profile();
    const auto database_profile = copperfin::platform::default_database_federation_profile();
    const auto extensibility_profile = copperfin::platform::default_extensibility_profile();

    std::cout << "{\n";
    std::cout << "  \"status\": \"ok\",\n";
    std::cout << "  \"document\": {\n";
    std::cout << "    \"path\": ";
    print_json_string(document.path);
    std::cout << ",\n";
    std::cout << "    \"displayName\": ";
    print_json_string(document.display_name);
    std::cout << ",\n";
    std::cout << "    \"kind\": ";
    print_json_string(copperfin::studio::studio_asset_kind_name(document.kind));
    std::cout << ",\n";
    std::cout << "    \"readOnly\": " << (document.read_only ? "true" : "false") << ",\n";
    std::cout << "    \"launchedFromVisualStudio\": "
              << (document.launched_from_visual_studio ? "true" : "false") << ",\n";
    std::cout << "    \"hasSidecar\": " << (document.has_sidecar ? "true" : "false") << ",\n";
    std::cout << "    \"sidecarPath\": ";
    print_json_string(document.sidecar_path);
    std::cout << ",\n";
    std::cout << "    \"assetFamily\": ";
    print_json_string(copperfin::vfp::asset_family_name(document.inspection.family));
    std::cout << ",\n";
    std::cout << "    \"indexCount\": " << document.inspection.indexes.size() << ",\n";
    std::cout << "    \"headerVersionDescription\": ";
    if (document.inspection.header_available) {
        print_json_string(document.inspection.header.version_description());
    } else {
        std::cout << "null";
    }
    std::cout << ",\n";
    std::cout << "    \"fieldCount\": " << document.table_preview.fields.size() << ",\n";
    std::cout << "    \"recordCount\": " << document.table_preview.records.size() << ",\n";
    std::cout << "    \"fields\": [\n";
    for (std::size_t index = 0; index < document.table_preview.fields.size(); ++index) {
        const auto& field = document.table_preview.fields[index];
        std::cout << "      {\"name\": ";
        print_json_string(field.name);
        std::cout << ", \"type\": ";
        print_json_string(std::string(1U, field.type));
        std::cout << ", \"length\": " << static_cast<unsigned int>(field.length);
        std::cout << ", \"decimalCount\": " << static_cast<unsigned int>(field.decimal_count) << "}";
        if ((index + 1U) != document.table_preview.fields.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "    ],\n";
    std::cout << "    \"reportLayout\": ";
    if (!report_layout.available) {
        std::cout << "null,\n";
    } else {
        std::cout << "{\n";
        std::cout << "      \"isLabel\": " << (report_layout.is_label ? "true" : "false") << ",\n";
        std::cout << "      \"documentTitle\": ";
        print_json_string(report_layout.document_title);
        std::cout << ",\n";
        std::cout << "      \"settings\": [\n";
        for (std::size_t index = 0; index < report_layout.settings.size(); ++index) {
            const auto& setting = report_layout.settings[index];
            std::cout << "        {\"name\": ";
            print_json_string(setting.name);
            std::cout << ", \"value\": ";
            print_json_string(setting.value);
            std::cout << "}";
            if ((index + 1U) != report_layout.settings.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "      ],\n";
        std::cout << "      \"sections\": [\n";
        for (std::size_t section_index = 0; section_index < report_layout.sections.size(); ++section_index) {
            const auto& section = report_layout.sections[section_index];
            std::cout << "        {\n";
            std::cout << "          \"id\": ";
            print_json_string(section.id);
            std::cout << ",\n";
            std::cout << "          \"title\": ";
            print_json_string(section.title);
            std::cout << ",\n";
            std::cout << "          \"bandKind\": ";
            print_json_string(section.band_kind);
            std::cout << ",\n";
            std::cout << "          \"recordIndex\": " << section.record_index << ",\n";
            std::cout << "          \"top\": " << section.top << ",\n";
            std::cout << "          \"height\": " << section.height << ",\n";
            std::cout << "          \"objects\": [\n";
            for (std::size_t object_index = 0; object_index < section.objects.size(); ++object_index) {
                const auto& object = section.objects[object_index];
                std::cout << "            {\n";
                std::cout << "              \"recordIndex\": " << object.record_index << ",\n";
                std::cout << "              \"objectKind\": ";
                print_json_string(object.object_kind);
                std::cout << ",\n";
                std::cout << "              \"title\": ";
                print_json_string(object.title);
                std::cout << ",\n";
                std::cout << "              \"expression\": ";
                print_json_string(object.expression);
                std::cout << ",\n";
                std::cout << "              \"left\": " << object.left << ",\n";
                std::cout << "              \"top\": " << object.top << ",\n";
                std::cout << "              \"width\": " << object.width << ",\n";
                std::cout << "              \"height\": " << object.height << ",\n";
                std::cout << "              \"highlights\": [\n";
                for (std::size_t highlight_index = 0; highlight_index < object.highlights.size(); ++highlight_index) {
                    const auto& highlight = object.highlights[highlight_index];
                    std::cout << "                {\"name\": ";
                    print_json_string(highlight.name);
                    std::cout << ", \"value\": ";
                    print_json_string(highlight.value);
                    std::cout << "}";
                    if ((highlight_index + 1U) != object.highlights.size()) {
                        std::cout << ",";
                    }
                    std::cout << "\n";
                }
                std::cout << "              ]\n";
                std::cout << "            }";
                if ((object_index + 1U) != section.objects.size()) {
                    std::cout << ",";
                }
                std::cout << "\n";
            }
            std::cout << "          ]\n";
            std::cout << "        }";
            if ((section_index + 1U) != report_layout.sections.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "      ],\n";
        std::cout << "      \"unplacedObjects\": [\n";
        for (std::size_t object_index = 0; object_index < report_layout.unplaced_objects.size(); ++object_index) {
            const auto& object = report_layout.unplaced_objects[object_index];
            std::cout << "        {\n";
            std::cout << "          \"recordIndex\": " << object.record_index << ",\n";
            std::cout << "          \"objectKind\": ";
            print_json_string(object.object_kind);
            std::cout << ",\n";
            std::cout << "          \"title\": ";
            print_json_string(object.title);
            std::cout << ",\n";
            std::cout << "          \"expression\": ";
            print_json_string(object.expression);
            std::cout << ",\n";
            std::cout << "          \"left\": " << object.left << ",\n";
            std::cout << "          \"top\": " << object.top << ",\n";
            std::cout << "          \"width\": " << object.width << ",\n";
            std::cout << "          \"height\": " << object.height << "\n";
            std::cout << "        }";
            if ((object_index + 1U) != report_layout.unplaced_objects.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "      ]\n";
        std::cout << "    },\n";
    }
    std::cout << "    \"projectWorkspace\": ";
    if (!project_workspace.available) {
        std::cout << "null,\n";
    } else {
        std::cout << "{\n";
        std::cout << "      \"projectTitle\": ";
        print_json_string(project_workspace.project_title);
        std::cout << ",\n";
        std::cout << "      \"projectKey\": ";
        print_json_string(project_workspace.project_key);
        std::cout << ",\n";
        std::cout << "      \"homeDirectory\": ";
        print_json_string(project_workspace.home_directory);
        std::cout << ",\n";
        std::cout << "      \"outputPath\": ";
        print_json_string(project_workspace.output_path);
        std::cout << ",\n";
        std::cout << "      \"groups\": [\n";
        for (std::size_t group_index = 0; group_index < project_workspace.groups.size(); ++group_index) {
            const auto& group = project_workspace.groups[group_index];
            std::cout << "        {\n";
            std::cout << "          \"id\": ";
            print_json_string(group.id);
            std::cout << ",\n";
            std::cout << "          \"title\": ";
            print_json_string(group.title);
            std::cout << ",\n";
            std::cout << "          \"itemCount\": " << group.item_count << ",\n";
            std::cout << "          \"excludedCount\": " << group.excluded_count << ",\n";
            std::cout << "          \"recordIndexes\": [";
            for (std::size_t record_index = 0; record_index < group.record_indexes.size(); ++record_index) {
                std::cout << group.record_indexes[record_index];
                if ((record_index + 1U) != group.record_indexes.size()) {
                    std::cout << ", ";
                }
            }
            std::cout << "]\n";
            std::cout << "        }";
            if ((group_index + 1U) != project_workspace.groups.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "      ],\n";
        std::cout << "      \"entries\": [\n";
        for (std::size_t entry_index = 0; entry_index < project_workspace.entries.size(); ++entry_index) {
            const auto& entry = project_workspace.entries[entry_index];
            std::cout << "        {\n";
            std::cout << "          \"recordIndex\": " << entry.record_index << ",\n";
            std::cout << "          \"name\": ";
            print_json_string(entry.name);
            std::cout << ",\n";
            std::cout << "          \"relativePath\": ";
            print_json_string(entry.relative_path);
            std::cout << ",\n";
            std::cout << "          \"typeCode\": ";
            print_json_string(entry.type_code);
            std::cout << ",\n";
            std::cout << "          \"typeTitle\": ";
            print_json_string(entry.type_title);
            std::cout << ",\n";
            std::cout << "          \"groupId\": ";
            print_json_string(entry.group_id);
            std::cout << ",\n";
            std::cout << "          \"groupTitle\": ";
            print_json_string(entry.group_title);
            std::cout << ",\n";
            std::cout << "          \"key\": ";
            print_json_string(entry.key);
            std::cout << ",\n";
            std::cout << "          \"comments\": ";
            print_json_string(entry.comments);
            std::cout << ",\n";
            std::cout << "          \"excluded\": " << (entry.excluded ? "true" : "false") << ",\n";
            std::cout << "          \"mainProgram\": " << (entry.main_program ? "true" : "false") << ",\n";
            std::cout << "          \"local\": " << (entry.local ? "true" : "false") << "\n";
            std::cout << "        }";
            if ((entry_index + 1U) != project_workspace.entries.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "      ],\n";
        std::cout << "      \"buildPlan\": {\n";
        std::cout << "        \"available\": " << (project_workspace.build_plan.available ? "true" : "false") << ",\n";
        std::cout << "        \"canBuild\": " << (project_workspace.build_plan.can_build ? "true" : "false") << ",\n";
        std::cout << "        \"projectTitle\": ";
        print_json_string(project_workspace.build_plan.project_title);
        std::cout << ",\n";
        std::cout << "        \"projectKey\": ";
        print_json_string(project_workspace.build_plan.project_key);
        std::cout << ",\n";
        std::cout << "        \"homeDirectory\": ";
        print_json_string(project_workspace.build_plan.home_directory);
        std::cout << ",\n";
        std::cout << "        \"outputPath\": ";
        print_json_string(project_workspace.build_plan.output_path);
        std::cout << ",\n";
        std::cout << "        \"buildTarget\": ";
        print_json_string(project_workspace.build_plan.build_target);
        std::cout << ",\n";
        std::cout << "        \"startupItem\": ";
        print_json_string(project_workspace.build_plan.startup_item);
        std::cout << ",\n";
        std::cout << "        \"startupRecordIndex\": " << project_workspace.build_plan.startup_record_index << ",\n";
        std::cout << "        \"totalItems\": " << project_workspace.build_plan.total_items << ",\n";
        std::cout << "        \"excludedItems\": " << project_workspace.build_plan.excluded_items << ",\n";
        std::cout << "        \"debugEnabled\": " << (project_workspace.build_plan.debug_enabled ? "true" : "false") << ",\n";
        std::cout << "        \"encryptEnabled\": " << (project_workspace.build_plan.encrypt_enabled ? "true" : "false") << ",\n";
        std::cout << "        \"saveCode\": " << (project_workspace.build_plan.save_code ? "true" : "false") << ",\n";
        std::cout << "        \"noLogo\": " << (project_workspace.build_plan.no_logo ? "true" : "false") << "\n";
        std::cout << "      }\n";
        std::cout << "    },\n";
    }
    std::cout << "    \"securityProfile\": {\n";
    std::cout << "      \"available\": " << (security_profile.available ? "true" : "false") << ",\n";
    std::cout << "      \"optional\": " << (security_profile.optional ? "true" : "false") << ",\n";
    std::cout << "      \"mode\": ";
    print_json_string(security_profile.mode);
    std::cout << ",\n";
    std::cout << "      \"packagePolicy\": ";
    print_json_string(security_profile.package_policy);
    std::cout << ",\n";
    std::cout << "      \"managedInteropPolicy\": ";
    print_json_string(security_profile.managed_interop_policy);
    std::cout << ",\n";
    std::cout << "      \"roles\": [\n";
    for (std::size_t role_index = 0; role_index < security_profile.roles.size(); ++role_index) {
        const auto& role = security_profile.roles[role_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(role.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(role.title);
        std::cout << ",\n";
        std::cout << "          \"description\": ";
        print_json_string(role.description);
        std::cout << ",\n";
        std::cout << "          \"defaultAssignment\": " << (role.default_assignment ? "true" : "false") << ",\n";
        std::cout << "          \"permissionIds\": [";
        for (std::size_t permission_index = 0; permission_index < role.permission_ids.size(); ++permission_index) {
            print_json_string(role.permission_ids[permission_index]);
            if ((permission_index + 1U) != role.permission_ids.size()) {
                std::cout << ", ";
            }
        }
        std::cout << "]\n";
        std::cout << "        }";
        if ((role_index + 1U) != security_profile.roles.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"identityProviders\": [\n";
    for (std::size_t provider_index = 0; provider_index < security_profile.identity_providers.size(); ++provider_index) {
        const auto& provider = security_profile.identity_providers[provider_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(provider.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(provider.title);
        std::cout << ",\n";
        std::cout << "          \"kind\": ";
        print_json_string(provider.kind);
        std::cout << ",\n";
        std::cout << "          \"description\": ";
        print_json_string(provider.description);
        std::cout << ",\n";
        std::cout << "          \"enabledByDefault\": " << (provider.enabled_by_default ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((provider_index + 1U) != security_profile.identity_providers.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"features\": [\n";
    for (std::size_t feature_index = 0; feature_index < security_profile.features.size(); ++feature_index) {
        const auto& feature = security_profile.features[feature_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(feature.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(feature.title);
        std::cout << ",\n";
        std::cout << "          \"description\": ";
        print_json_string(feature.description);
        std::cout << ",\n";
        std::cout << "          \"enabledByDefault\": " << (feature.enabled_by_default ? "true" : "false") << ",\n";
        std::cout << "          \"optional\": " << (feature.optional ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((feature_index + 1U) != security_profile.features.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"auditEvents\": [";
    for (std::size_t audit_index = 0; audit_index < security_profile.audit_events.size(); ++audit_index) {
        print_json_string(security_profile.audit_events[audit_index]);
        if ((audit_index + 1U) != security_profile.audit_events.size()) {
            std::cout << ", ";
        }
    }
    std::cout << "],\n";
    std::cout << "      \"hardeningProfiles\": [";
    for (std::size_t hardening_index = 0; hardening_index < security_profile.hardening_profiles.size(); ++hardening_index) {
        print_json_string(security_profile.hardening_profiles[hardening_index]);
        if ((hardening_index + 1U) != security_profile.hardening_profiles.size()) {
            std::cout << ", ";
        }
    }
    std::cout << "]\n";
    std::cout << "    },\n";
    std::cout << "    \"extensibilityProfile\": {\n";
    std::cout << "      \"available\": " << (extensibility_profile.available ? "true" : "false") << ",\n";
    std::cout << "      \"languages\": [\n";
    for (std::size_t language_index = 0; language_index < extensibility_profile.languages.size(); ++language_index) {
        const auto& language = extensibility_profile.languages[language_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(language.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(language.title);
        std::cout << ",\n";
        std::cout << "          \"integrationMode\": ";
        print_json_string(language.integration_mode);
        std::cout << ",\n";
        std::cout << "          \"trustBoundary\": ";
        print_json_string(language.trust_boundary);
        std::cout << ",\n";
        std::cout << "          \"outputStory\": ";
        print_json_string(language.output_story);
        std::cout << ",\n";
        std::cout << "          \"enabledByDefault\": " << (language.enabled_by_default ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((language_index + 1U) != extensibility_profile.languages.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"aiFeatures\": [\n";
    for (std::size_t feature_index = 0; feature_index < extensibility_profile.ai_features.size(); ++feature_index) {
        const auto& feature = extensibility_profile.ai_features[feature_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(feature.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(feature.title);
        std::cout << ",\n";
        std::cout << "          \"description\": ";
        print_json_string(feature.description);
        std::cout << ",\n";
        std::cout << "          \"trustBoundary\": ";
        print_json_string(feature.trust_boundary);
        std::cout << ",\n";
        std::cout << "          \"enabledByDefault\": " << (feature.enabled_by_default ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((feature_index + 1U) != extensibility_profile.ai_features.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"dotNetOutput\": {\n";
    std::cout << "        \"available\": " << (extensibility_profile.dotnet_output.available ? "true" : "false") << ",\n";
    std::cout << "        \"nativeHostExecutables\": " << (extensibility_profile.dotnet_output.native_host_executables ? "true" : "false") << ",\n";
    std::cout << "        \"managedWrappers\": " << (extensibility_profile.dotnet_output.managed_wrappers ? "true" : "false") << ",\n";
    std::cout << "        \"nugetSdk\": " << (extensibility_profile.dotnet_output.nuget_sdk ? "true" : "false") << ",\n";
    std::cout << "        \"primaryStory\": ";
    print_json_string(extensibility_profile.dotnet_output.primary_story);
    std::cout << "\n";
    std::cout << "      },\n";
    std::cout << "      \"guardrails\": [";
    for (std::size_t guardrail_index = 0; guardrail_index < extensibility_profile.guardrails.size(); ++guardrail_index) {
        print_json_string(extensibility_profile.guardrails[guardrail_index]);
        if ((guardrail_index + 1U) != extensibility_profile.guardrails.size()) {
            std::cout << ", ";
        }
    }
    std::cout << "]\n";
    std::cout << "    },\n";
    std::cout << "    \"databaseProfile\": {\n";
    std::cout << "      \"available\": " << (database_profile.available ? "true" : "false") << ",\n";
    std::cout << "      \"connectors\": [\n";
    for (std::size_t connector_index = 0; connector_index < database_profile.connectors.size(); ++connector_index) {
        const auto& connector = database_profile.connectors[connector_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(connector.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(connector.title);
        std::cout << ",\n";
        std::cout << "          \"family\": ";
        print_json_string(connector.family);
        std::cout << ",\n";
        std::cout << "          \"accessMode\": ";
        print_json_string(connector.access_mode);
        std::cout << ",\n";
        std::cout << "          \"schemaShape\": ";
        print_json_string(connector.schema_shape);
        std::cout << ",\n";
        std::cout << "          \"translationStory\": ";
        print_json_string(connector.translation_story);
        std::cout << ",\n";
        std::cout << "          \"xbaseCommandsFirstClass\": " << (connector.xbase_commands_first_class ? "true" : "false") << ",\n";
        std::cout << "          \"foxSqlTranslationDirect\": " << (connector.fox_sql_translation_direct ? "true" : "false") << ",\n";
        std::cout << "          \"aiQueryPlanningOptional\": " << (connector.ai_query_planning_optional ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((connector_index + 1U) != database_profile.connectors.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"queryPaths\": [\n";
    for (std::size_t path_index = 0; path_index < database_profile.query_paths.size(); ++path_index) {
        const auto& path = database_profile.query_paths[path_index];
        std::cout << "        {\n";
        std::cout << "          \"id\": ";
        print_json_string(path.id);
        std::cout << ",\n";
        std::cout << "          \"title\": ";
        print_json_string(path.title);
        std::cout << ",\n";
        std::cout << "          \"sourceShape\": ";
        print_json_string(path.source_shape);
        std::cout << ",\n";
        std::cout << "          \"targetShape\": ";
        print_json_string(path.target_shape);
        std::cout << ",\n";
        std::cout << "          \"complexity\": ";
        print_json_string(path.complexity);
        std::cout << ",\n";
        std::cout << "          \"strategy\": ";
        print_json_string(path.strategy);
        std::cout << ",\n";
        std::cout << "          \"deterministicFirst\": " << (path.deterministic_first ? "true" : "false") << ",\n";
        std::cout << "          \"aiOptional\": " << (path.ai_optional ? "true" : "false") << "\n";
        std::cout << "        }";
        if ((path_index + 1U) != database_profile.query_paths.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "      ],\n";
    std::cout << "      \"guardrails\": [";
    for (std::size_t guardrail_index = 0; guardrail_index < database_profile.guardrails.size(); ++guardrail_index) {
        print_json_string(database_profile.guardrails[guardrail_index]);
        if ((guardrail_index + 1U) != database_profile.guardrails.size()) {
            std::cout << ", ";
        }
    }
    std::cout << "]\n";
    std::cout << "    },\n";
    std::cout << "    \"objects\": [\n";
    for (std::size_t index = 0; index < objects.size(); ++index) {
        const auto& object = objects[index];
        std::cout << "      {\n";
        std::cout << "        \"recordIndex\": " << object.record_index << ",\n";
        std::cout << "        \"deleted\": " << (object.deleted ? "true" : "false") << ",\n";
        std::cout << "        \"title\": ";
        print_json_string(object.title);
        std::cout << ",\n";
        std::cout << "        \"subtitle\": ";
        print_json_string(object.subtitle);
        std::cout << ",\n";
        std::cout << "        \"properties\": [\n";
        for (std::size_t property_index = 0; property_index < object.properties.size(); ++property_index) {
            const auto& property = object.properties[property_index];
            std::cout << "          {\"name\": ";
            print_json_string(property.name);
            std::cout << ", \"type\": ";
            print_json_string(std::string(1U, property.type));
            std::cout << ", \"isNull\": " << (property.is_null ? "true" : "false") << ", \"value\": ";
            print_json_string(property.value);
            std::cout << "}";
            if ((property_index + 1U) != object.properties.size()) {
                std::cout << ",";
            }
            std::cout << "\n";
        }
        std::cout << "        ]\n";
        std::cout << "      }";
        if ((index + 1U) != objects.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "    ]\n";
    std::cout << "  }\n";
    std::cout << "}\n";
}

void print_document(const copperfin::studio::StudioDocumentModel& document) {
    const auto report_layout = copperfin::studio::build_report_layout(document);
    const auto project_workspace = copperfin::studio::build_project_workspace(document);
    const auto security_profile = copperfin::security::default_native_security_profile();
    const auto extensibility_profile = copperfin::platform::default_extensibility_profile();
    std::cout << "status: ok\n";
    std::cout << "document.path: " << document.path << "\n";
    std::cout << "document.display_name: " << document.display_name << "\n";
    std::cout << "document.kind: " << copperfin::studio::studio_asset_kind_name(document.kind) << "\n";
    std::cout << "document.read_only: " << (document.read_only ? "true" : "false") << "\n";
    std::cout << "document.launched_from_visual_studio: "
              << (document.launched_from_visual_studio ? "true" : "false") << "\n";
    std::cout << "document.has_sidecar: " << (document.has_sidecar ? "true" : "false") << "\n";
    if (!document.sidecar_path.empty()) {
        std::cout << "document.sidecar_path: " << document.sidecar_path << "\n";
    }
    std::cout << "inspection.asset_family: "
              << copperfin::vfp::asset_family_name(document.inspection.family) << "\n";
    std::cout << "inspection.index_count: " << document.inspection.indexes.size() << "\n";
    if (document.inspection.header_available) {
        std::cout << "inspection.header.version_description: "
                  << document.inspection.header.version_description() << "\n";
    }

    if (!document.table_preview_available) {
        return;
    }

    std::cout << "preview.field_count: " << document.table_preview.fields.size() << "\n";
    std::cout << "preview.record_count: " << document.table_preview.records.size() << "\n";
    if (report_layout.available) {
        std::cout << "preview.report_layout.section_count: " << report_layout.sections.size() << "\n";
        for (const auto& section : report_layout.sections) {
            std::cout << "section[" << section.record_index << "]: " << section.title
                      << " objects=" << section.objects.size()
                      << " top=" << section.top
                      << " height=" << section.height << "\n";
        }
    }

    if (project_workspace.available) {
        std::cout << "preview.project_workspace.group_count: " << project_workspace.groups.size() << "\n";
        std::cout << "preview.project_workspace.entry_count: " << project_workspace.entries.size() << "\n";
        std::cout << "preview.project_workspace.output_path: " << project_workspace.output_path << "\n";
        std::cout << "preview.project_workspace.startup_item: " << project_workspace.build_plan.startup_item << "\n";
        for (const auto& group : project_workspace.groups) {
            std::cout << "group[" << group.id << "]: " << group.title
                      << " items=" << group.item_count
                      << " excluded=" << group.excluded_count << "\n";
        }
    }

    std::cout << "preview.security.mode: " << security_profile.mode << "\n";
    std::cout << "preview.security.role_count: " << security_profile.roles.size() << "\n";
    std::cout << "preview.extensibility.language_count: " << extensibility_profile.languages.size() << "\n";
    std::cout << "preview.extensibility.dotnet_story: " << extensibility_profile.dotnet_output.primary_story << "\n";

    if (!document.table_preview.fields.empty()) {
        std::cout << "preview.fields:";
        for (const auto& field : document.table_preview.fields) {
            std::cout << " " << field.name << "(" << field.type << "," << static_cast<unsigned int>(field.length) << ")";
        }
        std::cout << "\n";
    }

    for (const auto& record : document.table_preview.records) {
        std::cout << "record[" << record.record_index << "]";
        if (record.deleted) {
            std::cout << " deleted";
        }
        std::cout << "\n";

        for (const auto& value : record.values) {
            if (value.display_value.empty()) {
                continue;
            }
            std::cout << "  " << value.field_name << ": " << value.display_value << "\n";
        }
    }
}

void print_json_subsystems() {
    const auto& subsystems = copperfin::studio::product_subsystems();
    std::cout << "{\n";
    std::cout << "  \"status\": \"ok\",\n";
    std::cout << "  \"subsystems\": [\n";
    for (std::size_t index = 0; index < subsystems.size(); ++index) {
        const auto& subsystem = subsystems[index];
        std::cout << "    {\n";
        std::cout << "      \"id\": ";
        print_json_string(std::string(subsystem.id));
        std::cout << ",\n";
        std::cout << "      \"title\": ";
        print_json_string(std::string(subsystem.title));
        std::cout << ",\n";
        std::cout << "      \"vfp9Equivalent\": ";
        print_json_string(std::string(subsystem.vfp9_equivalent));
        std::cout << ",\n";
        std::cout << "      \"copperfinComponent\": ";
        print_json_string(std::string(subsystem.copperfin_component));
        std::cout << ",\n";
        std::cout << "      \"hostKind\": ";
        print_json_string(copperfin::studio::product_host_kind_name(subsystem.host_kind));
        std::cout << ",\n";
        std::cout << "      \"currentStatus\": ";
        print_json_string(std::string(subsystem.current_status));
        std::cout << ",\n";
        std::cout << "      \"parityScope\": ";
        print_json_string(std::string(subsystem.parity_scope));
        std::cout << ",\n";
        std::cout << "      \"modernEditorDirection\": ";
        print_json_string(std::string(subsystem.modern_editor_direction));
        std::cout << "\n";
        std::cout << "    }";
        if ((index + 1U) != subsystems.size()) {
            std::cout << ",";
        }
        std::cout << "\n";
    }
    std::cout << "  ]\n";
    std::cout << "}\n";
}

void print_subsystems() {
    const auto& subsystems = copperfin::studio::product_subsystems();
    std::cout << "status: ok\n";
    std::cout << "subsystem_count: " << subsystems.size() << "\n";
    for (const auto& subsystem : subsystems) {
        std::cout << "subsystem.id: " << subsystem.id << "\n";
        std::cout << "  title: " << subsystem.title << "\n";
        std::cout << "  vfp9_equivalent: " << subsystem.vfp9_equivalent << "\n";
        std::cout << "  copperfin_component: " << subsystem.copperfin_component << "\n";
        std::cout << "  host_kind: " << copperfin::studio::product_host_kind_name(subsystem.host_kind) << "\n";
        std::cout << "  current_status: " << subsystem.current_status << "\n";
        std::cout << "  parity_scope: " << subsystem.parity_scope << "\n";
        std::cout << "  modern_editor_direction: " << subsystem.modern_editor_direction << "\n";
    }
}

}  // namespace

int main(int argc, char** argv) {
    std::vector<std::string> args;
    args.reserve(argc > 1 ? static_cast<std::size_t>(argc - 1) : 0U);
    for (int index = 1; index < argc; ++index) {
        args.emplace_back(argv[index]);
    }

    const bool list_subsystems = std::find(args.begin(), args.end(), "--list-subsystems") != args.end();
    if (list_subsystems) {
        const bool output_json = std::find(args.begin(), args.end(), "--json") != args.end();
        if (output_json) {
            print_json_subsystems();
        } else {
            print_subsystems();
        }
        return 0;
    }

    const auto parse_result = copperfin::studio::parse_launch_arguments(args);
    if (!parse_result.ok) {
        std::cout << "status: error\n";
        std::cout << "error: " << parse_result.error << "\n";
        print_usage();
        return 2;
    }

    if (parse_result.show_help) {
        print_usage();
        return 0;
    }

    if (parse_result.request.apply_property_update) {
        const auto update_result = copperfin::vfp::update_visual_object_property({
            .path = parse_result.request.path,
            .record_index = parse_result.request.record_index,
            .property_name = parse_result.request.property_name,
            .property_value = parse_result.request.property_value
        });

        if (!update_result.ok) {
            std::cout << "status: error\n";
            std::cout << "error: " << update_result.error << "\n";
            return 4;
        }
    }

    const auto open_result = copperfin::studio::open_document(parse_result.request);
    if (!open_result.ok) {
        std::cout << "status: error\n";
        std::cout << "error: " << open_result.error << "\n";
        return 3;
    }

    if (parse_result.output_json) {
        print_json_document(open_result.document);
        return 0;
    }

    print_document(open_result.document);
    return 0;
}
