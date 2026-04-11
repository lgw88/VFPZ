#include "copperfin/vfp/index_probe.h"

#include "copperfin/vfp/cdx_header.h"

#include <algorithm>
#include <cctype>
#include <filesystem>
#include <fstream>
#include <set>

namespace copperfin::vfp {

namespace {

std::uint16_t read_le_u16(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return static_cast<std::uint16_t>(bytes[offset]) |
           (static_cast<std::uint16_t>(bytes[offset + 1]) << 8U);
}

std::uint32_t read_le_u32(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return static_cast<std::uint32_t>(bytes[offset]) |
           (static_cast<std::uint32_t>(bytes[offset + 1]) << 8U) |
           (static_cast<std::uint32_t>(bytes[offset + 2]) << 16U) |
           (static_cast<std::uint32_t>(bytes[offset + 3]) << 24U);
}

std::string read_ascii_hint(const std::vector<std::uint8_t>& bytes, std::size_t offset, std::size_t length) {
    std::string value;
    value.reserve(length);

    for (std::size_t index = 0; index < length && (offset + index) < bytes.size(); ++index) {
        const auto raw = static_cast<unsigned char>(bytes[offset + index]);
        if (raw == 0U) {
            break;
        }
        if (std::isprint(raw) != 0 || std::isspace(raw) != 0) {
            value.push_back(static_cast<char>(raw));
        }
    }

    while (!value.empty() && std::isspace(static_cast<unsigned char>(value.back())) != 0) {
        value.pop_back();
    }

    return value;
}

struct PrintableRun {
    std::size_t offset = 0;
    std::string text;
};

bool is_identifier_char(char ch) {
    const auto raw = static_cast<unsigned char>(ch);
    return std::isalnum(raw) != 0 || ch == '_';
}

std::string trim_copy(std::string value) {
    const auto first = std::find_if(value.begin(), value.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    value.erase(value.begin(), first);

    const auto last = std::find_if(value.rbegin(), value.rend(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    value.erase(last.base(), value.end());
    return value;
}

std::vector<PrintableRun> collect_printable_runs(const std::vector<std::uint8_t>& bytes) {
    std::vector<PrintableRun> runs;

    for (std::size_t index = 0; index < bytes.size();) {
        const auto raw = static_cast<unsigned char>(bytes[index]);
        if (std::isprint(raw) == 0) {
            ++index;
            continue;
        }

        const std::size_t start = index;
        std::string text;
        while (index < bytes.size()) {
            const auto current = static_cast<unsigned char>(bytes[index]);
            if (std::isprint(current) == 0) {
                break;
            }
            text.push_back(static_cast<char>(current));
            ++index;
        }

        if (text.size() >= 2U) {
            runs.push_back({.offset = start, .text = std::move(text)});
        }
    }

    return runs;
}

bool looks_like_mdx_tag_name_candidate(const std::string& text) {
    if (text.size() < 2U || text.size() > 10U) {
        return false;
    }

    bool saw_alpha = false;
    for (unsigned char ch : text) {
        if (!is_identifier_char(static_cast<char>(ch))) {
            return false;
        }
        if (std::isalpha(ch) != 0) {
            saw_alpha = true;
            if (std::toupper(ch) != ch) {
                return false;
            }
        }
    }

    return saw_alpha;
}

std::vector<IndexTagProbe> collect_mdx_tag_hints(const std::vector<std::uint8_t>& bytes) {
    std::vector<IndexTagProbe> tags;
    std::set<std::string> seen_names;

    for (const PrintableRun& run : collect_printable_runs(bytes)) {
        const std::string candidate = trim_copy(run.text);
        if (!looks_like_mdx_tag_name_candidate(candidate) || !seen_names.insert(candidate).second) {
            continue;
        }

        tags.push_back({
            .name_hint = candidate,
            .name_offset_hint = static_cast<std::uint32_t>(run.offset),
            .inferred_name = false
        });
    }

    return tags;
}

bool is_valid_optional_offset(std::uint32_t offset, std::uint32_t block_size, std::uint64_t file_size) {
    if (offset == 0U || offset == 0xFFFFFFFFU) {
        return true;
    }
    if (block_size == 0U) {
        return offset < file_size;
    }
    return offset >= block_size && offset < file_size && (offset % block_size) == 0U;
}

IndexParseResult parse_cdx_family_probe(
    const std::vector<std::uint8_t>& bytes,
    std::uint64_t file_size,
    IndexKind kind) {
    const CdxParseResult cdx_result = parse_cdx_header(bytes, file_size);
    if (!cdx_result.ok) {
        return {.ok = false, .error = cdx_result.error};
    }

    IndexProbe probe;
    probe.kind = kind;
    probe.file_size = cdx_result.header.file_size;
    probe.block_size = cdx_result.header.page_size;
    probe.root_node_offset_hint = cdx_result.header.root_node_offset;
    probe.free_node_offset_hint = cdx_result.header.next_free_node_offset;
    probe.key_length_hint = cdx_result.header.key_length_hint;
    probe.group_length_hint = cdx_result.header.key_pool_length_hint;
    probe.tags.reserve(cdx_result.tags.size());
    for (const CdxTagDescriptor& tag : cdx_result.tags) {
        probe.tags.push_back({
            .name_hint = tag.name_hint,
            .key_expression_hint = tag.key_expression_hint,
            .for_expression_hint = tag.for_expression_hint,
            .name_offset_hint = tag.name_offset_hint,
            .key_expression_offset_hint = tag.key_expression_offset_hint,
            .for_expression_offset_hint = tag.for_expression_offset_hint,
            .inferred_name = tag.inferred_name
        });
    }
    if (!probe.tags.empty()) {
        probe.key_expression_hint = probe.tags.front().key_expression_hint;
        for (const IndexTagProbe& tag : probe.tags) {
            if (!tag.for_expression_hint.empty()) {
                probe.for_expression_hint = tag.for_expression_hint;
                break;
            }
        }
    }
    probe.multi_tag = true;
    probe.production_candidate = (kind == IndexKind::cdx);
    return {.ok = true, .probe = probe};
}

IndexParseResult parse_fox_idx_probe(const std::vector<std::uint8_t>& bytes, std::uint64_t file_size) {
    if (bytes.size() < 512U) {
        return {.ok = false, .error = "File is smaller than the 512-byte Visual FoxPro IDX header size."};
    }

    IndexProbe probe;
    probe.kind = IndexKind::idx;
    probe.file_size = file_size;
    probe.block_size = 512U;
    probe.root_node_offset_hint = read_le_u32(bytes, 0U);
    probe.free_node_offset_hint = read_le_u32(bytes, 4U);
    probe.end_of_file_offset_hint = read_le_u32(bytes, 8U);
    probe.key_length_hint = read_le_u16(bytes, 12U);
    probe.flags = bytes[14];
    probe.signature = bytes[15];
    probe.key_expression_hint = read_ascii_hint(bytes, 16U, 220U);
    probe.for_expression_hint = read_ascii_hint(bytes, 236U, 220U);

    const bool plausible_size = file_size >= probe.block_size && (file_size % probe.block_size) == 0U;
    const bool plausible_key = probe.key_length_hint > 0U && probe.key_length_hint <= 220U;
    const bool plausible_root = probe.root_node_offset_hint >= probe.block_size &&
                                probe.root_node_offset_hint < file_size &&
                                (probe.root_node_offset_hint % probe.block_size) == 0U;
    const bool plausible_eof = probe.end_of_file_offset_hint >= probe.block_size &&
                               probe.end_of_file_offset_hint <= file_size &&
                               (probe.end_of_file_offset_hint % probe.block_size) == 0U;
    const bool plausible_free = is_valid_optional_offset(
        probe.free_node_offset_hint,
        probe.block_size,
        file_size);

    if (!plausible_size || !plausible_key || !plausible_root || !plausible_eof || !plausible_free) {
        return {
            .ok = false,
            .probe = probe,
            .error = "Header values do not look like a Visual FoxPro IDX file."
        };
    }

    return {.ok = true, .probe = probe};
}

IndexParseResult parse_dbase_ndx_probe(const std::vector<std::uint8_t>& bytes, std::uint64_t file_size) {
    if (bytes.size() < 512U) {
        return {.ok = false, .error = "File is smaller than the 512-byte dBase NDX header size."};
    }

    const std::uint32_t root_block = read_le_u32(bytes, 0U);
    const std::uint32_t eof_block = read_le_u32(bytes, 4U);
    const std::uint32_t version_hint = read_le_u32(bytes, 8U);
    const std::uint16_t key_length = read_le_u16(bytes, 12U);
    const std::uint16_t max_keys = read_le_u16(bytes, 14U);
    const std::uint16_t numeric_or_date_flag = read_le_u16(bytes, 16U);
    const std::uint16_t group_length = read_le_u16(bytes, 18U);
    const std::uint16_t unique_flag = read_le_u16(bytes, 22U);

    IndexProbe probe;
    probe.kind = IndexKind::ndx;
    probe.file_size = file_size;
    probe.block_size = 512U;
    probe.root_node_offset_hint = root_block * probe.block_size;
    probe.end_of_file_offset_hint = eof_block * probe.block_size;
    probe.key_length_hint = key_length;
    probe.max_keys_hint = max_keys;
    probe.group_length_hint = group_length;
    probe.flags = static_cast<std::uint8_t>(unique_flag != 0U ? 0x01U : 0x00U);
    probe.signature = static_cast<std::uint8_t>(version_hint & 0xFFU);
    probe.key_expression_hint = read_ascii_hint(bytes, 24U, 100U);

    const bool plausible_size = file_size >= probe.block_size && (file_size % probe.block_size) == 0U;
    const bool plausible_root = root_block > 0U && probe.root_node_offset_hint < file_size;
    const bool plausible_eof = eof_block >= 2U && probe.end_of_file_offset_hint <= file_size;
    const bool plausible_key = key_length > 0U && key_length <= 100U;
    const bool plausible_group = group_length >= static_cast<std::uint16_t>(key_length + 8U);
    const bool plausible_max_keys = max_keys > 0U;
    const bool plausible_type_flag = numeric_or_date_flag <= 1U;

    if (!plausible_size || !plausible_root || !plausible_eof || !plausible_key ||
        !plausible_group || !plausible_max_keys || !plausible_type_flag) {
        return {
            .ok = false,
            .probe = probe,
            .error = "Header values do not look like a dBase NDX file."
        };
    }

    return {.ok = true, .probe = probe};
}

IndexParseResult parse_dbase_mdx_probe(const std::vector<std::uint8_t>& bytes, std::uint64_t file_size) {
    if (bytes.size() < 512U) {
        return {.ok = false, .error = "File is smaller than the minimum MDX probe size (512 bytes)."};
    }

    IndexProbe probe;
    probe.kind = IndexKind::mdx;
    probe.file_size = file_size;
    probe.block_size = 512U;
    probe.multi_tag = true;
    probe.production_candidate = true;

    if (file_size < 512U || (file_size % 512U) != 0U) {
        return {
            .ok = false,
            .probe = probe,
            .error = "Header values do not look like a block-oriented dBase MDX file."
        };
    }

    probe.tags = collect_mdx_tag_hints(bytes);

    return {.ok = true, .probe = probe};
}

}  // namespace

bool IndexProbe::looks_like_index() const {
    if (kind == IndexKind::unknown || file_size == 0U) {
        return false;
    }
    if (kind == IndexKind::mdx) {
        return file_size >= 512U;
    }
    return block_size != 0U &&
           file_size >= block_size &&
           root_node_offset_hint >= block_size &&
           root_node_offset_hint < file_size;
}

IndexKind index_kind_from_path(const std::string& path) {
    std::string extension = std::filesystem::path(path).extension().string();
    std::transform(extension.begin(), extension.end(), extension.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });

    if (extension == ".cdx") {
        return IndexKind::cdx;
    }
    if (extension == ".dcx") {
        return IndexKind::dcx;
    }
    if (extension == ".idx") {
        return IndexKind::idx;
    }
    if (extension == ".ndx") {
        return IndexKind::ndx;
    }
    if (extension == ".mdx") {
        return IndexKind::mdx;
    }
    return IndexKind::unknown;
}

const char* index_kind_name(IndexKind kind) {
    switch (kind) {
        case IndexKind::unknown:
            return "unknown";
        case IndexKind::cdx:
            return "cdx";
        case IndexKind::dcx:
            return "dcx";
        case IndexKind::idx:
            return "idx";
        case IndexKind::ndx:
            return "ndx";
        case IndexKind::mdx:
            return "mdx";
    }
    return "unknown";
}

IndexParseResult parse_index_probe(
    const std::vector<std::uint8_t>& bytes,
    std::uint64_t file_size,
    IndexKind kind) {
    switch (kind) {
        case IndexKind::cdx:
        case IndexKind::dcx:
            return parse_cdx_family_probe(bytes, file_size, kind);
        case IndexKind::idx:
            return parse_fox_idx_probe(bytes, file_size);
        case IndexKind::ndx:
            return parse_dbase_ndx_probe(bytes, file_size);
        case IndexKind::mdx:
            return parse_dbase_mdx_probe(bytes, file_size);
        case IndexKind::unknown:
            return {.ok = false, .error = "Unknown index extension."};
    }
    return {.ok = false, .error = "Unsupported index type."};
}

IndexParseResult parse_index_probe_from_file(const std::string& path) {
    const IndexKind kind = index_kind_from_path(path);
    if (kind == IndexKind::unknown) {
        return {.ok = false, .error = "Path does not use a known xBase index extension."};
    }

    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open file."};
    }

    const std::uint64_t file_size = static_cast<std::uint64_t>(std::filesystem::file_size(path));
    std::size_t probe_size = 512U;
    if (kind == IndexKind::cdx || kind == IndexKind::dcx || kind == IndexKind::mdx) {
        probe_size = static_cast<std::size_t>(file_size);
    }
    std::vector<std::uint8_t> bytes(probe_size, 0U);
    input.read(reinterpret_cast<char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));

    if (input.gcount() <= 0) {
        return {.ok = false, .error = "Unable to read index header bytes."};
    }

    bytes.resize(static_cast<std::size_t>(input.gcount()));
    return parse_index_probe(bytes, file_size, kind);
}

}  // namespace copperfin::vfp
