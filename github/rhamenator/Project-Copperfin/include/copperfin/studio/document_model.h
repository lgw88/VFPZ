#pragma once

#include "copperfin/vfp/asset_inspector.h"
#include "copperfin/vfp/dbf_table.h"

#include <string>
#include <vector>

namespace copperfin::studio {

enum class StudioAssetKind {
    unknown,
    project,
    form,
    class_library,
    report,
    label,
    menu,
    index,
    table,
    database_container,
    program,
    header
};

struct StudioOpenRequest {
    std::string path;
    std::string symbol;
    std::string property_name;
    std::string property_value;
    std::size_t line = 0;
    std::size_t column = 0;
    std::size_t record_index = 0;
    bool launched_from_visual_studio = false;
    bool read_only = false;
    bool load_full_table = false;
    bool apply_property_update = false;
};

struct StudioDocumentModel {
    std::string path;
    std::string display_name;
    std::string sidecar_path;
    StudioAssetKind kind = StudioAssetKind::unknown;
    bool has_sidecar = false;
    bool read_only = false;
    bool launched_from_visual_studio = false;
    vfp::AssetInspectionResult inspection{};
    bool table_preview_available = false;
    vfp::DbfTable table_preview{};
};

struct StudioPropertySnapshot {
    std::string name;
    char type = '\0';
    bool is_null = false;
    std::string value;
};

struct StudioObjectSnapshot {
    std::size_t record_index = 0;
    bool deleted = false;
    std::string title;
    std::string subtitle;
    std::vector<StudioPropertySnapshot> properties;
};

struct StudioOpenResult {
    bool ok = false;
    StudioDocumentModel document{};
    std::string error;
};

[[nodiscard]] StudioAssetKind studio_asset_kind_from_vfp_family(vfp::AssetFamily family);
[[nodiscard]] const char* studio_asset_kind_name(StudioAssetKind kind);
[[nodiscard]] std::string infer_sidecar_path(const std::string& path, StudioAssetKind kind);
[[nodiscard]] std::vector<StudioObjectSnapshot> build_object_snapshot(const StudioDocumentModel& document);
StudioOpenResult open_document(const StudioOpenRequest& request);

}  // namespace copperfin::studio
