#pragma once

#include "copperfin/vfp/dbf_header.h"
#include "copperfin/vfp/index_probe.h"

#include <string>
#include <vector>

namespace copperfin::vfp {

enum class AssetFamily {
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

struct AssetInspectionResult {
    struct IndexAsset {
        std::string path;
        IndexProbe probe{};
    };

    bool ok = false;
    std::string path;
    AssetFamily family = AssetFamily::unknown;
    bool header_available = false;
    DbfHeader header{};
    std::vector<IndexAsset> indexes;
    std::string error;
};

[[nodiscard]] AssetFamily asset_family_from_path(const std::string& path);
[[nodiscard]] const char* asset_family_name(AssetFamily family);
AssetInspectionResult inspect_asset(const std::string& path);

}  // namespace copperfin::vfp
