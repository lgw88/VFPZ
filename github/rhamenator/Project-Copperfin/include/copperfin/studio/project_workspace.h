#pragma once

#include "copperfin/studio/document_model.h"

#include <cstddef>
#include <string>
#include <vector>

namespace copperfin::studio {

struct StudioProjectEntry {
    std::size_t record_index = 0;
    std::string name;
    std::string relative_path;
    std::string type_code;
    std::string type_title;
    std::string group_id;
    std::string group_title;
    std::string key;
    std::string comments;
    bool excluded = false;
    bool main_program = false;
    bool local = false;
};

struct StudioProjectGroup {
    std::string id;
    std::string title;
    std::size_t item_count = 0;
    std::size_t excluded_count = 0;
    std::vector<std::size_t> record_indexes;
};

struct StudioProjectBuildPlan {
    bool available = false;
    bool can_build = false;
    std::string project_title;
    std::string project_key;
    std::string home_directory;
    std::string output_path;
    std::string build_target;
    std::string startup_item;
    std::size_t startup_record_index = 0;
    std::size_t total_items = 0;
    std::size_t excluded_items = 0;
    bool debug_enabled = false;
    bool encrypt_enabled = false;
    bool save_code = false;
    bool no_logo = false;
};

struct StudioProjectWorkspace {
    bool available = false;
    std::string project_title;
    std::string project_key;
    std::string home_directory;
    std::string output_path;
    std::vector<StudioProjectGroup> groups;
    std::vector<StudioProjectEntry> entries;
    StudioProjectBuildPlan build_plan{};
};

[[nodiscard]] StudioProjectWorkspace build_project_workspace(const StudioDocumentModel& document);

}  // namespace copperfin::studio
