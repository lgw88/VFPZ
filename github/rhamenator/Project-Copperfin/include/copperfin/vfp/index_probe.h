#pragma once

#include <cstdint>
#include <string>
#include <vector>

namespace copperfin::vfp {

enum class IndexKind {
    unknown,
    cdx,
    dcx,
    idx,
    ndx,
    mdx
};

struct IndexTagProbe {
    std::string name_hint;
    std::string key_expression_hint;
    std::string for_expression_hint;
    std::uint32_t name_offset_hint = 0;
    std::uint32_t key_expression_offset_hint = 0;
    std::uint32_t for_expression_offset_hint = 0;
    bool inferred_name = false;
};

struct IndexProbe {
    IndexKind kind = IndexKind::unknown;
    std::uint64_t file_size = 0;
    std::uint32_t block_size = 0;
    std::uint32_t root_node_offset_hint = 0;
    std::uint32_t free_node_offset_hint = 0;
    std::uint32_t end_of_file_offset_hint = 0;
    std::uint16_t key_length_hint = 0;
    std::uint16_t max_keys_hint = 0;
    std::uint16_t group_length_hint = 0;
    std::uint8_t flags = 0;
    std::uint8_t signature = 0;
    std::string key_expression_hint;
    std::string for_expression_hint;
    std::vector<IndexTagProbe> tags;
    bool multi_tag = false;
    bool production_candidate = false;

    [[nodiscard]] bool looks_like_index() const;
};

struct IndexParseResult {
    bool ok = false;
    IndexProbe probe{};
    std::string error;
};

[[nodiscard]] IndexKind index_kind_from_path(const std::string& path);
[[nodiscard]] const char* index_kind_name(IndexKind kind);
IndexParseResult parse_index_probe(
    const std::vector<std::uint8_t>& bytes,
    std::uint64_t file_size,
    IndexKind kind);
IndexParseResult parse_index_probe_from_file(const std::string& path);

}  // namespace copperfin::vfp
