#include "copperfin/vfp/asset_inspector.h"

#include <algorithm>
#include <cctype>
#include <filesystem>
#include <vector>

namespace copperfin::vfp {

namespace {

std::string lowercase_extension(const std::filesystem::path& path) {
    std::string ext = path.extension().string();
    std::transform(ext.begin(), ext.end(), ext.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return ext;
}

bool is_dbf_family_asset(AssetFamily family) {
    switch (family) {
        case AssetFamily::project:
        case AssetFamily::form:
        case AssetFamily::class_library:
        case AssetFamily::report:
        case AssetFamily::label:
        case AssetFamily::menu:
        case AssetFamily::table:
        case AssetFamily::database_container:
            return true;
        case AssetFamily::index:
        case AssetFamily::unknown:
        case AssetFamily::program:
        case AssetFamily::header:
            return false;
    }
    return false;
}

bool is_index_extension(const std::string& extension) {
    return extension == ".cdx" || extension == ".dcx" || extension == ".idx" ||
           extension == ".ndx" || extension == ".mdx";
}

void append_if_missing(std::vector<std::string>& paths, const std::string& candidate) {
    if (candidate.empty()) {
        return;
    }

    const auto found = std::find(paths.begin(), paths.end(), candidate);
    if (found == paths.end()) {
        paths.push_back(candidate);
    }
}

std::vector<std::string> companion_index_paths_for(const std::filesystem::path& path, AssetFamily family) {
    std::vector<std::string> candidates;
    const auto with_extension = [&](const char* extension) {
        std::filesystem::path candidate = path;
        candidate.replace_extension(extension);
        return candidate.string();
    };

    switch (family) {
        case AssetFamily::table:
            append_if_missing(candidates, path.string() + ".cdx");
            append_if_missing(candidates, path.string() + ".idx");
            append_if_missing(candidates, path.string() + ".ndx");
            append_if_missing(candidates, path.string() + ".mdx");
            append_if_missing(candidates, with_extension(".cdx"));
            append_if_missing(candidates, with_extension(".idx"));
            append_if_missing(candidates, with_extension(".ndx"));
            append_if_missing(candidates, with_extension(".mdx"));
            return candidates;
        case AssetFamily::database_container:
            append_if_missing(candidates, with_extension(".dcx"));
            return candidates;
        case AssetFamily::project:
        case AssetFamily::form:
        case AssetFamily::class_library:
        case AssetFamily::report:
        case AssetFamily::menu:
        case AssetFamily::index:
        case AssetFamily::program:
        case AssetFamily::header:
        case AssetFamily::unknown:
            return candidates;
    }
    return candidates;
}

}  // namespace

AssetFamily asset_family_from_path(const std::string& path) {
    const std::string ext = lowercase_extension(std::filesystem::path(path));

    if (ext == ".pjx" || ext == ".pjt") {
        return AssetFamily::project;
    }
    if (ext == ".scx" || ext == ".sct") {
        return AssetFamily::form;
    }
    if (ext == ".vcx" || ext == ".vct") {
        return AssetFamily::class_library;
    }
    if (ext == ".frx" || ext == ".frt") {
        return AssetFamily::report;
    }
    if (ext == ".lbx" || ext == ".lbt") {
        return AssetFamily::label;
    }
    if (ext == ".mnx" || ext == ".mnt") {
        return AssetFamily::menu;
    }
    if (is_index_extension(ext)) {
        return AssetFamily::index;
    }
    if (ext == ".dbc") {
        return AssetFamily::database_container;
    }
    if (ext == ".dbf") {
        return AssetFamily::table;
    }
    if (ext == ".prg") {
        return AssetFamily::program;
    }
    if (ext == ".h") {
        return AssetFamily::header;
    }
    return AssetFamily::unknown;
}

const char* asset_family_name(AssetFamily family) {
    switch (family) {
        case AssetFamily::unknown:
            return "unknown";
        case AssetFamily::project:
            return "project";
        case AssetFamily::form:
            return "form";
        case AssetFamily::class_library:
            return "class_library";
        case AssetFamily::report:
            return "report";
        case AssetFamily::label:
            return "label";
        case AssetFamily::menu:
            return "menu";
        case AssetFamily::index:
            return "index";
        case AssetFamily::table:
            return "table";
        case AssetFamily::database_container:
            return "database_container";
        case AssetFamily::program:
            return "program";
        case AssetFamily::header:
            return "header";
    }
    return "unknown";
}

AssetInspectionResult inspect_asset(const std::string& path) {
    AssetInspectionResult result;
    result.path = path;
    result.family = asset_family_from_path(path);

    if (!std::filesystem::exists(path)) {
        result.ok = false;
        result.error = "Path does not exist.";
        return result;
    }

    if (result.family == AssetFamily::index) {
        const IndexParseResult index_result = parse_index_probe_from_file(path);
        if (!index_result.ok) {
            result.ok = false;
            result.error = index_result.error;
            return result;
        }

        result.ok = true;
        result.indexes.push_back({.path = path, .probe = index_result.probe});
        return result;
    }

    if (!is_dbf_family_asset(result.family)) {
        result.ok = true;
        return result;
    }

    const DbfParseResult header_result = parse_dbf_header_from_file(path);
    if (!header_result.ok) {
        result.ok = false;
        result.error = header_result.error;
        return result;
    }

    result.ok = true;
    result.header_available = true;
    result.header = header_result.header;

    for (const auto& companion_index : companion_index_paths_for(std::filesystem::path(path), result.family)) {
        if (!std::filesystem::exists(companion_index)) {
            continue;
        }

        const IndexParseResult index_result = parse_index_probe_from_file(companion_index);
        if (index_result.ok) {
            result.indexes.push_back({.path = companion_index, .probe = index_result.probe});
        }
    }

    return result;
}

}  // namespace copperfin::vfp
