#include "copperfin/studio/document_model.h"

#include "copperfin/vfp/visual_asset_editor.h"

#include <filesystem>
#include <string_view>

namespace copperfin::studio {

namespace {

std::string filename_of(const std::string& path) {
    return std::filesystem::path(path).filename().string();
}

const vfp::DbfRecordValue* find_value(const vfp::DbfRecord& record, std::string_view field_name) {
    for (const auto& value : record.values) {
        if (value.field_name == field_name) {
            return &value;
        }
    }
    return nullptr;
}

std::string value_or_empty(const vfp::DbfRecord& record, std::string_view field_name) {
    const auto* value = find_value(record, field_name);
    if (value == nullptr) {
        return {};
    }
    return value->display_value;
}

std::string first_non_empty(const vfp::DbfRecord& record, std::initializer_list<std::string_view> field_names) {
    for (const auto field_name : field_names) {
        const std::string value = value_or_empty(record, field_name);
        if (!value.empty()) {
            return value;
        }
    }
    return {};
}

bool supports_visual_property_blob(const StudioDocumentModel& document) {
    return document.kind == StudioAssetKind::form || document.kind == StudioAssetKind::class_library;
}

void append_property_snapshots(
    const std::vector<vfp::VisualPropertyAssignment>& assignments,
    std::vector<StudioPropertySnapshot>& properties) {
    for (const auto& assignment : assignments) {
        if (assignment.name.empty()) {
            continue;
        }

        const auto existing = std::find_if(properties.begin(), properties.end(), [&](const StudioPropertySnapshot& property) {
            return property.name == assignment.name;
        });
        if (existing != properties.end()) {
            continue;
        }

        properties.push_back({
            .name = assignment.name,
            .type = 'P',
            .is_null = assignment.value.empty(),
            .value = assignment.value
        });
    }
}

}  // namespace

StudioAssetKind studio_asset_kind_from_vfp_family(vfp::AssetFamily family) {
    switch (family) {
        case vfp::AssetFamily::project:
            return StudioAssetKind::project;
        case vfp::AssetFamily::form:
            return StudioAssetKind::form;
        case vfp::AssetFamily::class_library:
            return StudioAssetKind::class_library;
        case vfp::AssetFamily::report:
            return StudioAssetKind::report;
        case vfp::AssetFamily::label:
            return StudioAssetKind::label;
        case vfp::AssetFamily::menu:
            return StudioAssetKind::menu;
        case vfp::AssetFamily::index:
            return StudioAssetKind::index;
        case vfp::AssetFamily::table:
            return StudioAssetKind::table;
        case vfp::AssetFamily::database_container:
            return StudioAssetKind::database_container;
        case vfp::AssetFamily::program:
            return StudioAssetKind::program;
        case vfp::AssetFamily::header:
            return StudioAssetKind::header;
        case vfp::AssetFamily::unknown:
            return StudioAssetKind::unknown;
    }
    return StudioAssetKind::unknown;
}

const char* studio_asset_kind_name(StudioAssetKind kind) {
    switch (kind) {
        case StudioAssetKind::unknown:
            return "unknown";
        case StudioAssetKind::project:
            return "project";
        case StudioAssetKind::form:
            return "form";
        case StudioAssetKind::class_library:
            return "class_library";
        case StudioAssetKind::report:
            return "report";
        case StudioAssetKind::label:
            return "label";
        case StudioAssetKind::menu:
            return "menu";
        case StudioAssetKind::index:
            return "index";
        case StudioAssetKind::table:
            return "table";
        case StudioAssetKind::database_container:
            return "database_container";
        case StudioAssetKind::program:
            return "program";
        case StudioAssetKind::header:
            return "header";
    }
    return "unknown";
}

std::string infer_sidecar_path(const std::string& path, StudioAssetKind kind) {
    std::filesystem::path file_path(path);
    switch (kind) {
        case StudioAssetKind::project:
            return file_path.replace_extension(".pjt").string();
        case StudioAssetKind::form:
            return file_path.replace_extension(".sct").string();
        case StudioAssetKind::class_library:
            return file_path.replace_extension(".vct").string();
        case StudioAssetKind::report:
            return file_path.replace_extension(".frt").string();
        case StudioAssetKind::label:
            return file_path.replace_extension(".lbt").string();
        case StudioAssetKind::menu:
            return file_path.replace_extension(".mnt").string();
        case StudioAssetKind::index:
        case StudioAssetKind::table:
        case StudioAssetKind::database_container:
        case StudioAssetKind::program:
        case StudioAssetKind::header:
        case StudioAssetKind::unknown:
            return {};
    }
    return {};
}

std::vector<StudioObjectSnapshot> build_object_snapshot(const StudioDocumentModel& document) {
    std::vector<StudioObjectSnapshot> objects;
    if (!document.table_preview_available) {
        return objects;
    }

    objects.reserve(document.table_preview.records.size());
    for (const auto& record : document.table_preview.records) {
        StudioObjectSnapshot snapshot;
        snapshot.record_index = record.record_index;
        snapshot.deleted = record.deleted;
        switch (document.kind) {
            case StudioAssetKind::report:
            case StudioAssetKind::label:
                snapshot.title = first_non_empty(record, {"EXPR", "NAME", "UNIQUEID"});
                snapshot.subtitle = first_non_empty(record, {"OBJTYPE", "OBJCODE", "FONTFACE", "PLATFORM"});
                break;
            case StudioAssetKind::menu:
                snapshot.title = first_non_empty(record, {"PROMPT", "NAME", "LEVELNAME"});
                snapshot.subtitle = first_non_empty(record, {"LEVELNAME", "OBJTYPE", "OBJCODE"});
                break;
            case StudioAssetKind::project:
                snapshot.title = first_non_empty(record, {"NAME", "KEY", "TYPE"});
                snapshot.subtitle = first_non_empty(record, {"TYPE", "KEY", "COMMENTS"});
                break;
            case StudioAssetKind::form:
            case StudioAssetKind::class_library:
            case StudioAssetKind::index:
            case StudioAssetKind::table:
            case StudioAssetKind::database_container:
            case StudioAssetKind::program:
            case StudioAssetKind::header:
            case StudioAssetKind::unknown:
                snapshot.title = first_non_empty(record, {"OBJNAME", "NAME", "TITLE", "UNIQUEID", "CLASS"});
                snapshot.subtitle = first_non_empty(record, {"BASECLASS", "CLASS", "OBJTYPE", "OBJCODE", "PLATFORM"});
                break;
        }
        if (snapshot.title.empty()) {
            snapshot.title = "Record " + std::to_string(record.record_index);
        }

        for (const auto& value : record.values) {
            if (value.display_value.empty()) {
                continue;
            }

            snapshot.properties.push_back({
                .name = value.field_name,
                .type = value.field_type,
                .is_null = value.is_null,
                .value = value.display_value
            });
        }

        if (supports_visual_property_blob(document)) {
            const auto* property_blob = find_value(record, "PROPERTIES");
            if (property_blob != nullptr && !property_blob->display_value.empty() && property_blob->display_value != "<memo block 0>") {
                append_property_snapshots(vfp::parse_visual_property_blob(property_blob->display_value), snapshot.properties);
            }
        }

        objects.push_back(std::move(snapshot));
    }

    return objects;
}

StudioOpenResult open_document(const StudioOpenRequest& request) {
    if (request.path.empty()) {
        return {.ok = false, .error = "No path was provided."};
    }

    const vfp::AssetInspectionResult inspection = vfp::inspect_asset(request.path);
    if (!inspection.ok) {
        return {.ok = false, .error = inspection.error};
    }

    StudioDocumentModel document;
    document.path = request.path;
    document.display_name = filename_of(request.path);
    document.kind = studio_asset_kind_from_vfp_family(inspection.family);
    document.sidecar_path = infer_sidecar_path(request.path, document.kind);
    document.has_sidecar = !document.sidecar_path.empty() && std::filesystem::exists(document.sidecar_path);
    document.read_only = request.read_only;
    document.launched_from_visual_studio = request.launched_from_visual_studio;
    document.inspection = inspection;

    if (inspection.header_available) {
        const std::size_t max_records = request.load_full_table
            ? inspection.header.record_count
            : 8U;
        const auto table_result = vfp::parse_dbf_table_from_file(request.path, max_records);
        if (table_result.ok) {
            document.table_preview_available = true;
            document.table_preview = std::move(table_result.table);
        }
    }

    return {.ok = true, .document = document};
}

}  // namespace copperfin::studio
