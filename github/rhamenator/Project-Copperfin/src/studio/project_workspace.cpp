#include "copperfin/studio/project_workspace.h"

#include <algorithm>
#include <cctype>
#include <filesystem>
#include <string_view>

namespace copperfin::studio {

namespace {

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
    if (value == nullptr || value->display_value == "<memo block 0>") {
        return {};
    }
    return value->display_value;
}

bool value_as_bool(const vfp::DbfRecord& record, std::string_view field_name) {
    const std::string value = value_or_empty(record, field_name);
    return value == "true" || value == "t" || value == ".t." || value == "Y" || value == "y";
}

bool looks_like_unresolved_memo(const std::string& value) {
    return value.rfind("<memo block ", 0) == 0;
}

std::string trim_copy(std::string value) {
    value.erase(value.begin(), std::find_if(value.begin(), value.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    }));
    while (!value.empty() && std::isspace(static_cast<unsigned char>(value.back())) != 0) {
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

std::string extension_of(const std::string& value) {
    return lowercase_copy(std::filesystem::path(value).extension().string());
}

std::string fallback_relative_path(const StudioDocumentModel& document, const std::string& value) {
    if (value.empty()) {
        return {};
    }

    std::filesystem::path item_path(value);
    if (item_path.is_relative()) {
        return item_path.generic_string();
    }

    const std::filesystem::path document_dir = std::filesystem::path(document.path).parent_path();
    std::error_code error;
    const std::filesystem::path relative = std::filesystem::relative(item_path, document_dir, error);
    if (!error && !relative.empty()) {
        return relative.generic_string();
    }

    return item_path.filename().generic_string();
}

struct ProjectTypeDescriptor {
    std::string type_title;
    std::string group_id;
    std::string group_title;
};

ProjectTypeDescriptor describe_project_item(
    const std::string& type_code,
    const std::string& extension,
    const std::string& item_name) {
    if (type_code == "H") {
        return {"Project Header", "project", "Project"};
    }

    if (extension == ".scx") {
        return {"Form", "forms", "Forms"};
    }
    if (extension == ".vcx") {
        return {"Class Library", "classes", "Class Libraries"};
    }
    if (extension == ".frx") {
        return {"Report", "reports", "Reports"};
    }
    if (extension == ".lbx") {
        return {"Label", "labels", "Labels"};
    }
    if (extension == ".mnx") {
        return {"Menu", "menus", "Menus"};
    }
    if (extension == ".prg") {
        return {"Program", "programs", "Programs"};
    }
    if (extension == ".dbc") {
        return {"Database", "databases", "Databases"};
    }
    if (extension == ".dbf") {
        return {"Table", "tables", "Tables"};
    }
    if (extension == ".qpr") {
        return {"Query", "queries", "Queries"};
    }
    if (extension == ".h" || extension == ".hpp" || extension == ".ch") {
        return {"Header", "code", "Code"};
    }
    if (extension == ".dll" || extension == ".ocx") {
        return {"Library", "libraries", "Libraries"};
    }

    if (type_code == "K") {
        return {"Project Item", "project_items", "Project Items"};
    }

    if (!item_name.empty()) {
        return {"Project Item", "other_assets", "Other Assets"};
    }

    return {"Project Record", "other_records", "Other Records"};
}

std::string default_output_path(const StudioDocumentModel& document, const std::string& project_title) {
    std::filesystem::path output = std::filesystem::path(document.path).parent_path();
    const std::string stem = project_title.empty()
        ? std::filesystem::path(document.path).stem().string()
        : project_title;
    output /= stem + ".exe";
    return output.string();
}

}  // namespace

StudioProjectWorkspace build_project_workspace(const StudioDocumentModel& document) {
    StudioProjectWorkspace workspace;
    if (document.kind != StudioAssetKind::project || !document.table_preview_available) {
        return workspace;
    }

    workspace.available = true;

    const auto header_record = std::find_if(
        document.table_preview.records.begin(),
        document.table_preview.records.end(),
        [](const vfp::DbfRecord& record) {
            return value_or_empty(record, "TYPE") == "H";
        });

    if (header_record != document.table_preview.records.end()) {
        workspace.project_key = trim_copy(value_or_empty(*header_record, "KEY"));
        workspace.project_title = workspace.project_key.empty()
            ? std::filesystem::path(document.path).stem().string()
            : workspace.project_key;
        workspace.home_directory = trim_copy(value_or_empty(*header_record, "HOMEDIR"));
        workspace.output_path = trim_copy(value_or_empty(*header_record, "OUTFILE"));
        if (looks_like_unresolved_memo(workspace.output_path)) {
            workspace.output_path.clear();
        }
    } else {
        workspace.project_title = std::filesystem::path(document.path).stem().string();
    }

    if (workspace.output_path.empty()) {
        workspace.output_path = default_output_path(document, workspace.project_title);
    }

    std::vector<StudioProjectGroup> groups;

    auto ensure_group = [&](const std::string& group_id, const std::string& group_title) -> StudioProjectGroup& {
        const auto existing = std::find_if(groups.begin(), groups.end(), [&](const StudioProjectGroup& group) {
            return group.id == group_id;
        });
        if (existing != groups.end()) {
            return *existing;
        }

        groups.push_back({
            .id = group_id,
            .title = group_title
        });
        return groups.back();
    };

    for (const auto& record : document.table_preview.records) {
        const std::string type_code = trim_copy(value_or_empty(record, "TYPE"));
        const std::string name = trim_copy(value_or_empty(record, "NAME"));
        const std::string key = trim_copy(value_or_empty(record, "KEY"));
        const std::string comments = trim_copy(value_or_empty(record, "COMMENTS"));
        const std::string relative_path = fallback_relative_path(document, name);
        const ProjectTypeDescriptor descriptor = describe_project_item(type_code, extension_of(name), name);

        StudioProjectEntry entry;
        entry.record_index = record.record_index;
        entry.name = name.empty() ? ("Record " + std::to_string(record.record_index)) : name;
        entry.relative_path = relative_path;
        entry.type_code = type_code;
        entry.type_title = descriptor.type_title;
        entry.group_id = descriptor.group_id;
        entry.group_title = descriptor.group_title;
        entry.key = key;
        entry.comments = comments;
        entry.excluded = value_as_bool(record, "EXCLUDE");
        entry.main_program = value_as_bool(record, "MAINPROG");
        entry.local = value_as_bool(record, "LOCAL");

        auto& group = ensure_group(descriptor.group_id, descriptor.group_title);
        group.record_indexes.push_back(entry.record_index);
        ++group.item_count;
        if (entry.excluded) {
            ++group.excluded_count;
        }

        workspace.entries.push_back(std::move(entry));
    }

    std::sort(groups.begin(), groups.end(), [](const StudioProjectGroup& left, const StudioProjectGroup& right) {
        if (left.id == "project") {
            return true;
        }
        if (right.id == "project") {
            return false;
        }
        return left.title < right.title;
    });
    workspace.groups = std::move(groups);

    workspace.build_plan.available = true;
    workspace.build_plan.project_title = workspace.project_title;
    workspace.build_plan.project_key = workspace.project_key;
    workspace.build_plan.home_directory = workspace.home_directory;
    workspace.build_plan.output_path = workspace.output_path;
    workspace.build_plan.build_target = "x64 Windows executable";
    workspace.build_plan.total_items = workspace.entries.size();
    workspace.build_plan.excluded_items = static_cast<std::size_t>(std::count_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.excluded;
        }));

    const auto startup_entry = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.main_program && !entry.excluded;
        });
    const auto program_entry = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.group_id == "programs" && !entry.excluded;
        });
    const auto first_non_header = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.group_id != "project" && !entry.excluded;
        });
    const auto startup_entry_any = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.main_program;
        });
    const auto program_entry_any = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.group_id == "programs";
        });
    const auto first_non_header_any = std::find_if(
        workspace.entries.begin(),
        workspace.entries.end(),
        [](const StudioProjectEntry& entry) {
            return entry.group_id != "project";
        });

    const StudioProjectEntry* startup = nullptr;
    if (startup_entry != workspace.entries.end()) {
        startup = &(*startup_entry);
    } else if (program_entry != workspace.entries.end()) {
        startup = &(*program_entry);
    } else if (first_non_header != workspace.entries.end()) {
        startup = &(*first_non_header);
    } else if (startup_entry_any != workspace.entries.end()) {
        startup = &(*startup_entry_any);
    } else if (program_entry_any != workspace.entries.end()) {
        startup = &(*program_entry_any);
    } else if (first_non_header_any != workspace.entries.end()) {
        startup = &(*first_non_header_any);
    }

    if (header_record != document.table_preview.records.end()) {
        workspace.build_plan.debug_enabled = value_as_bool(*header_record, "DEBUG");
        workspace.build_plan.encrypt_enabled = value_as_bool(*header_record, "ENCRYPT");
        workspace.build_plan.save_code = value_as_bool(*header_record, "SAVECODE");
        workspace.build_plan.no_logo = value_as_bool(*header_record, "NOLOGO");
    }

    if (startup != nullptr) {
        workspace.build_plan.startup_item = startup->name;
        workspace.build_plan.startup_record_index = startup->record_index;
    }

    workspace.build_plan.can_build =
        !workspace.build_plan.output_path.empty() &&
        !workspace.entries.empty();

    return workspace;
}

}  // namespace copperfin::studio
