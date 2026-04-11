#include "copperfin/vfp/dbf_table.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <filesystem>
#include <fstream>
#include <limits>
#include <optional>
#include <sstream>
#include <unordered_map>

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

std::uint32_t read_be_u32(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return (static_cast<std::uint32_t>(bytes[offset]) << 24U) |
           (static_cast<std::uint32_t>(bytes[offset + 1]) << 16U) |
           (static_cast<std::uint32_t>(bytes[offset + 2]) << 8U) |
           static_cast<std::uint32_t>(bytes[offset + 3]);
}

void write_le_u16(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint16_t value) {
    bytes[offset] = static_cast<std::uint8_t>(value & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
}

std::uint16_t read_be_u16(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return static_cast<std::uint16_t>((static_cast<std::uint16_t>(bytes[offset]) << 8U) |
                                      static_cast<std::uint16_t>(bytes[offset + 1]));
}

void write_be_u16(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint16_t value) {
    bytes[offset] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>(value & 0xFFU);
}

void write_le_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value) {
    bytes[offset] = static_cast<std::uint8_t>(value & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 2U] = static_cast<std::uint8_t>((value >> 16U) & 0xFFU);
    bytes[offset + 3U] = static_cast<std::uint8_t>((value >> 24U) & 0xFFU);
}

std::int64_t read_le_i64(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    std::uint64_t value = 0U;
    for (std::size_t index = 0; index < 8U; ++index) {
        value |= static_cast<std::uint64_t>(bytes[offset + index]) << (index * 8U);
    }
    return static_cast<std::int64_t>(value);
}

void write_le_i64(std::vector<std::uint8_t>& bytes, std::size_t offset, std::int64_t value) {
    const std::uint64_t raw = static_cast<std::uint64_t>(value);
    for (std::size_t index = 0; index < 8U; ++index) {
        bytes[offset + index] = static_cast<std::uint8_t>((raw >> (index * 8U)) & 0xFFU);
    }
}

void write_be_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value) {
    bytes[offset] = static_cast<std::uint8_t>((value >> 24U) & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 16U) & 0xFFU);
    bytes[offset + 2U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 3U] = static_cast<std::uint8_t>(value & 0xFFU);
}

std::string trim_right(std::string text) {
    while (!text.empty() && std::isspace(static_cast<unsigned char>(text.back())) != 0) {
        text.pop_back();
    }
    return text;
}

std::string trim_both(std::string text) {
    text = trim_right(std::move(text));
    const auto first = std::find_if(text.begin(), text.end(), [](unsigned char ch) {
        return std::isspace(ch) == 0;
    });
    text.erase(text.begin(), first);
    return text;
}

std::string lowercase_copy(std::string text) {
    std::transform(text.begin(), text.end(), text.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return text;
}

std::string read_ascii_name(const std::vector<std::uint8_t>& bytes, std::size_t offset, std::size_t length) {
    std::string value;
    value.reserve(length);
    for (std::size_t index = 0; index < length && (offset + index) < bytes.size(); ++index) {
        const auto raw = bytes[offset + index];
        if (raw == 0U) {
            break;
        }
        value.push_back(static_cast<char>(raw));
    }
    return trim_right(std::move(value));
}

std::string load_file_string(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {};
    }
    return {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };
}

std::vector<std::uint8_t> read_binary_file(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {};
    }

    return {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };
}

bool write_binary_file(const std::string& path, const std::vector<std::uint8_t>& bytes) {
    std::ofstream output(path, std::ios::binary | std::ios::trunc);
    if (!output) {
        return false;
    }

    output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    return static_cast<bool>(output);
}

std::string infer_memo_sidecar_path(const std::string& path) {
    std::filesystem::path file_path(path);
    const std::string ext = file_path.extension().string();

    if (ext == ".scx") {
        return file_path.replace_extension(".sct").string();
    }
    if (ext == ".vcx") {
        return file_path.replace_extension(".vct").string();
    }
    if (ext == ".frx") {
        return file_path.replace_extension(".frt").string();
    }
    if (ext == ".lbx") {
        return file_path.replace_extension(".lbt").string();
    }
    if (ext == ".mnx") {
        return file_path.replace_extension(".mnt").string();
    }
    if (ext == ".pjx") {
        return file_path.replace_extension(".pjt").string();
    }
    if (ext == ".dbc") {
        return file_path.replace_extension(".dct").string();
    }
    if (ext == ".dbf") {
        return file_path.replace_extension(".fpt").string();
    }
    return {};
}

std::vector<std::filesystem::path> infer_structural_index_sidecar_paths(const std::string& path) {
    std::vector<std::filesystem::path> candidates;
    const std::filesystem::path file_path(path);
    if (file_path.empty()) {
        return candidates;
    }

    candidates.push_back(file_path.parent_path() / (file_path.stem().string() + ".cdx"));

    std::filesystem::path full_name = file_path;
    full_name += ".cdx";
    candidates.push_back(std::move(full_name));
    return candidates;
}

bool has_companion_structural_index(const std::string& path) {
    const auto candidates = infer_structural_index_sidecar_paths(path);
    return std::any_of(
        candidates.begin(),
        candidates.end(),
        [](const std::filesystem::path& candidate) {
            std::error_code ignored;
            return std::filesystem::exists(candidate, ignored);
        });
}

std::optional<std::string> unsupported_indexed_table_mutation_error(const std::string& path, const DbfHeader& header) {
    if (header.has_production_index() || has_companion_structural_index(path)) {
        return "Indexed DBF mutation is not yet supported for tables with structural/production indexes.";
    }
    return std::nullopt;
}

struct RawFieldDescriptor {
    std::string name;
    char type = '\0';
    std::uint32_t offset = 0;
    std::uint8_t length = 0;
    std::uint8_t decimal_count = 0;
};

std::vector<RawFieldDescriptor> read_raw_field_descriptors(const std::vector<std::uint8_t>& table_bytes) {
    std::vector<RawFieldDescriptor> fields;
    std::size_t descriptor_offset = 32U;
    while ((descriptor_offset + 32U) <= table_bytes.size() && table_bytes[descriptor_offset] != 0x0DU) {
        fields.push_back({
            .name = read_ascii_name(table_bytes, descriptor_offset, 11U),
            .type = static_cast<char>(table_bytes[descriptor_offset + 11U]),
            .offset = read_le_u32(table_bytes, descriptor_offset + 12U),
            .length = table_bytes[descriptor_offset + 16U],
            .decimal_count = table_bytes[descriptor_offset + 17U]
        });
        descriptor_offset += 32U;
    }
    return fields;
}

std::optional<char> normalize_logical_value(std::string value) {
    value = trim_both(std::move(value));
    std::transform(value.begin(), value.end(), value.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });

    if (value.empty() || value == "null" || value == "?") {
        return '?';
    }
    if (value == "t" || value == "true" || value == "y" || value == "yes" || value == ".t.") {
        return 'T';
    }
    if (value == "f" || value == "false" || value == "n" || value == "no" || value == ".f.") {
        return 'F';
    }
    return std::nullopt;
}

std::optional<RawFieldDescriptor> find_raw_field(
    const std::vector<RawFieldDescriptor>& fields,
    const std::string& field_name) {
    const std::string normalized = trim_both(field_name);
    const auto found = std::find_if(fields.begin(), fields.end(), [&](const RawFieldDescriptor& field) {
        return trim_both(field.name) == normalized;
    });
    if (found == fields.end()) {
        return std::nullopt;
    }
    return *found;
}

bool supports_direct_field_writes(char field_type) {
    return field_type == 'C' || field_type == 'N' || field_type == 'F' || field_type == 'L' || field_type == 'D' || field_type == 'I' ||
           field_type == 'Y' || field_type == 'T';
}

bool supports_table_field_storage(char field_type) {
    return supports_direct_field_writes(field_type) || field_type == 'M';
}

bool supports_blank_field_initialization(char field_type) {
    return field_type == 'C' || field_type == 'N' || field_type == 'F' || field_type == 'D' || field_type == 'L' ||
           field_type == 'I' || field_type == 'Y' || field_type == 'T' || field_type == 'M';
}

std::vector<std::uint8_t> create_empty_memo_sidecar(std::uint16_t block_size = 512U) {
    std::vector<std::uint8_t> bytes(block_size, 0U);
    write_be_u32(bytes, 0U, 1U);
    write_be_u16(bytes, 6U, block_size);
    return bytes;
}

std::optional<std::int64_t> parse_scaled_currency_value(const std::string& value) {
    std::string text = trim_both(value);
    if (text.empty()) {
        return static_cast<std::int64_t>(0);
    }

    bool negative = false;
    if (!text.empty() && (text.front() == '+' || text.front() == '-')) {
        negative = text.front() == '-';
        text.erase(text.begin());
    }
    if (text.empty()) {
        return std::nullopt;
    }

    const std::size_t dot = text.find('.');
    if (dot != text.rfind('.')) {
        return std::nullopt;
    }

    std::string whole_text = dot == std::string::npos ? text : text.substr(0U, dot);
    std::string frac_text = dot == std::string::npos ? std::string{} : text.substr(dot + 1U);
    if (whole_text.empty()) {
        whole_text = "0";
    }
    if (whole_text.find_first_not_of("0123456789") != std::string::npos ||
        frac_text.find_first_not_of("0123456789") != std::string::npos ||
        frac_text.size() > 4U) {
        return std::nullopt;
    }

    long long whole = 0;
    try {
        whole = std::stoll(whole_text);
    } catch (const std::exception&) {
        return std::nullopt;
    }

    while (frac_text.size() < 4U) {
        frac_text.push_back('0');
    }

    long long fractional = 0;
    try {
        fractional = frac_text.empty() ? 0LL : std::stoll(frac_text);
    } catch (const std::exception&) {
        return std::nullopt;
    }

    constexpr long long scale = 10000LL;
    if (whole > (std::numeric_limits<long long>::max() / scale)) {
        return std::nullopt;
    }

    long long scaled = (whole * scale) + fractional;
    if (negative) {
        scaled = -scaled;
    }
    return static_cast<std::int64_t>(scaled);
}

std::optional<std::pair<std::uint32_t, std::uint32_t>> parse_datetime_storage_value(const std::string& value) {
    const std::string text = trim_both(value);
    if (text.empty()) {
        return std::pair<std::uint32_t, std::uint32_t>{0U, 0U};
    }

    const std::string lowered = lowercase_copy(text);
    constexpr const char* julian_prefix = "julian:";
    constexpr const char* millis_prefix = "millis:";
    if (lowered.rfind(julian_prefix, 0U) != 0U) {
        return std::nullopt;
    }

    const std::size_t millis_pos = lowered.find(millis_prefix);
    if (millis_pos == std::string::npos || millis_pos <= 7U) {
        return std::nullopt;
    }

    const std::string julian_text = trim_both(text.substr(7U, millis_pos - 7U));
    const std::string millis_text = trim_both(text.substr(millis_pos + 7U));
    if (julian_text.empty() || millis_text.empty()) {
        return std::nullopt;
    }

    std::size_t consumed = 0U;
    unsigned long julian = 0;
    unsigned long millis = 0;
    try {
        julian = std::stoul(julian_text, &consumed, 10);
        if (consumed != julian_text.size()) {
            return std::nullopt;
        }
        millis = std::stoul(millis_text, &consumed, 10);
        if (consumed != millis_text.size()) {
            return std::nullopt;
        }
    } catch (const std::exception&) {
        return std::nullopt;
    }

    if (julian > std::numeric_limits<std::uint32_t>::max() || millis > std::numeric_limits<std::uint32_t>::max()) {
        return std::nullopt;
    }
    return std::pair<std::uint32_t, std::uint32_t>{
        static_cast<std::uint32_t>(julian),
        static_cast<std::uint32_t>(millis)
    };
}

std::string format_currency_display_value(std::int64_t scaled) {
    const bool negative = scaled < 0;
    const std::uint64_t magnitude = negative
        ? static_cast<std::uint64_t>(-(scaled + 1)) + 1U
        : static_cast<std::uint64_t>(scaled);

    std::ostringstream stream;
    if (negative && magnitude != 0U) {
        stream << '-';
    }
    stream << (magnitude / 10000U) << '.';
    const std::uint64_t fractional = magnitude % 10000U;
    stream.width(4);
    stream.fill('0');
    stream << fractional;
    return stream.str();
}

DbfWriteResult write_memo_field_bytes(
    std::vector<std::uint8_t>& table_bytes,
    std::size_t field_offset,
    std::vector<std::uint8_t>& memo_bytes,
    const std::string& value,
    std::size_t record_count) {
    if ((field_offset + 4U) > table_bytes.size()) {
        return {.ok = false, .error = "Record data is truncated.", .record_count = record_count};
    }

    const std::string memo_value = value;
    if (memo_value.empty()) {
        write_le_u32(table_bytes, field_offset, 0U);
        return {.ok = true, .record_count = record_count};
    }

    if (memo_bytes.size() < 8U) {
        memo_bytes = create_empty_memo_sidecar();
    }

    std::uint16_t block_size = read_be_u16(memo_bytes, 6U);
    if (block_size == 0U) {
        block_size = 512U;
        if (memo_bytes.size() < block_size) {
            memo_bytes.resize(block_size, 0U);
        }
        write_be_u16(memo_bytes, 6U, block_size);
    }

    std::uint32_t next_free_block = read_be_u32(memo_bytes, 0U);
    if (next_free_block == 0U) {
        next_free_block = 1U;
        write_be_u32(memo_bytes, 0U, next_free_block);
    }

    const auto required_bytes = static_cast<std::size_t>(8U + memo_value.size());
    const auto required_blocks = static_cast<std::uint32_t>((required_bytes + block_size - 1U) / block_size);
    const std::size_t block_offset = static_cast<std::size_t>(next_free_block) * block_size;
    const std::size_t new_total_size = block_offset + (static_cast<std::size_t>(required_blocks) * block_size);
    if (memo_bytes.size() < new_total_size) {
        memo_bytes.resize(new_total_size, 0U);
    }

    for (std::size_t index = 0; index < 4U; ++index) {
        memo_bytes[block_offset + index] = 0U;
    }
    memo_bytes[block_offset + 3U] = 1U;
    write_be_u32(memo_bytes, block_offset + 4U, static_cast<std::uint32_t>(memo_value.size()));
    std::fill(
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(block_offset + 8U),
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(new_total_size),
        static_cast<std::uint8_t>(0U));
    std::copy(
        memo_value.begin(),
        memo_value.end(),
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(block_offset + 8U));

    write_be_u32(memo_bytes, 0U, next_free_block + required_blocks);
    write_le_u32(table_bytes, field_offset, next_free_block);
    return {.ok = true, .record_count = record_count};
}

DbfWriteResult write_field_bytes(
    std::vector<std::uint8_t>& table_bytes,
    const DbfHeader& header,
    std::size_t record_index,
    const RawFieldDescriptor& field,
    const std::string& value) {
    if (record_index >= header.record_count) {
        return {.ok = false, .error = "Record index is out of range.", .record_count = header.record_count};
    }

    const std::size_t record_offset = header.header_length + (record_index * header.record_length);
    const std::size_t field_offset = record_offset + field.offset;
    if ((field_offset + field.length) > table_bytes.size()) {
        return {.ok = false, .error = "Record data is truncated.", .record_count = header.record_count};
    }

    std::fill_n(table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset), field.length, static_cast<std::uint8_t>(' '));

    switch (field.type) {
        case 'C': {
            const std::string text = trim_both(value);
            if (text.size() > field.length) {
                return {.ok = false, .error = "Character value is too large for the target field.", .record_count = header.record_count};
            }
            std::copy(text.begin(), text.end(), table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset));
            break;
        }
        case 'N':
        case 'F': {
            const std::string text = trim_both(value);
            if (!text.empty()) {
                if (text.size() > field.length) {
                    return {.ok = false, .error = "Numeric value is too large for the target field.", .record_count = header.record_count};
                }
                const auto padding = static_cast<std::ptrdiff_t>(field.length - text.size());
                std::copy(text.begin(), text.end(), table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset) + padding);
            }
            break;
        }
        case 'L': {
            const auto logical_value = normalize_logical_value(value);
            if (!logical_value.has_value()) {
                return {.ok = false, .error = "Logical fields only accept true/false values.", .record_count = header.record_count};
            }
            table_bytes[field_offset] = static_cast<std::uint8_t>(*logical_value);
            break;
        }
        case 'D': {
            std::string text = trim_both(value);
            text.erase(std::remove(text.begin(), text.end(), '-'), text.end());
            if (!text.empty() && text.size() != 8U) {
                return {.ok = false, .error = "Date values must be empty or formatted as YYYYMMDD/YYYY-MM-DD.", .record_count = header.record_count};
            }
            std::copy(text.begin(), text.end(), table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset));
            break;
        }
        case 'I': {
            const std::string text = trim_both(value);
            if (text.empty()) {
                write_le_u32(table_bytes, field_offset, 0U);
                break;
            }

            std::size_t consumed = 0U;
            long long parsed = 0;
            try {
                parsed = std::stoll(text, &consumed, 10);
            } catch (const std::exception&) {
                return {.ok = false, .error = "Integer fields only accept whole-number values.", .record_count = header.record_count};
            }
            if (consumed != text.size()) {
                return {.ok = false, .error = "Integer fields only accept whole-number values.", .record_count = header.record_count};
            }
            if (parsed < static_cast<long long>(std::numeric_limits<std::int32_t>::min()) ||
                parsed > static_cast<long long>(std::numeric_limits<std::int32_t>::max())) {
                return {.ok = false, .error = "Integer value is too large for the target field.", .record_count = header.record_count};
            }

            write_le_u32(table_bytes, field_offset, static_cast<std::uint32_t>(static_cast<std::int32_t>(parsed)));
            break;
        }
        case 'Y': {
            const auto scaled = parse_scaled_currency_value(value);
            if (!scaled.has_value()) {
                return {.ok = false, .error = "Currency fields only accept signed decimal values with up to four fractional digits.", .record_count = header.record_count};
            }
            write_le_i64(table_bytes, field_offset, *scaled);
            break;
        }
        case 'T': {
            const auto datetime = parse_datetime_storage_value(value);
            if (!datetime.has_value()) {
                return {.ok = false, .error = "DateTime fields currently accept values formatted as 'julian:<day> millis:<milliseconds>'.", .record_count = header.record_count};
            }
            write_le_u32(table_bytes, field_offset, datetime->first);
            write_le_u32(table_bytes, field_offset + 4U, datetime->second);
            break;
        }
        default:
            return {.ok = false, .error = "Direct updates are not implemented for this field type yet.", .record_count = header.record_count};
    }

    return {.ok = true, .record_count = header.record_count};
}

DbfWriteResult append_blank_record_bytes(
    std::vector<std::uint8_t>& table_bytes,
    const DbfHeader& header,
    const std::vector<RawFieldDescriptor>& fields) {
    const std::size_t insert_offset = header.header_length + (static_cast<std::size_t>(header.record_count) * header.record_length);
    if (insert_offset > table_bytes.size()) {
        return {.ok = false, .error = "Table data is truncated.", .record_count = header.record_count};
    }

    const bool had_eof_marker = !table_bytes.empty() && table_bytes.back() == 0x1AU;
    if (had_eof_marker) {
        table_bytes.pop_back();
    }

    table_bytes.resize(table_bytes.size() + header.record_length, static_cast<std::uint8_t>(' '));
    const std::size_t record_offset = insert_offset;
    table_bytes[record_offset] = 0x20U;

    for (const auto& field : fields) {
        const std::size_t field_offset = record_offset + field.offset;
        if ((field_offset + field.length) > table_bytes.size()) {
            return {.ok = false, .error = "Table field layout exceeds the record size.", .record_count = header.record_count};
        }
        if (!supports_blank_field_initialization(field.type)) {
            return {.ok = false, .error = "APPEND BLANK is not yet supported for one or more field types in this table.", .record_count = header.record_count};
        }

        switch (field.type) {
            case 'L':
                table_bytes[field_offset] = static_cast<std::uint8_t>('?');
                break;
            case 'I':
                std::fill_n(
                    table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset),
                    field.length,
                    static_cast<std::uint8_t>(0U));
                break;
            case 'Y':
            case 'T':
                std::fill_n(
                    table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset),
                    field.length,
                    static_cast<std::uint8_t>(0U));
                break;
            case 'M':
                std::fill_n(
                    table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset),
                    field.length,
                    static_cast<std::uint8_t>(0U));
                break;
            default:
                std::fill_n(
                    table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset),
                    field.length,
                    static_cast<std::uint8_t>(' '));
                break;
        }
    }

    table_bytes.push_back(0x1AU);
    write_le_u32(table_bytes, 4U, header.record_count + 1U);
    return {.ok = true, .record_count = header.record_count + 1U};
}

class MemoReader {
public:
    MemoReader() = default;

    explicit MemoReader(const std::string& path) {
        if (path.empty()) {
            return;
        }

        std::ifstream input(path, std::ios::binary);
        if (!input) {
            return;
        }

        bytes_ = {
            std::istreambuf_iterator<char>(input),
            std::istreambuf_iterator<char>()
        };

        if (bytes_.size() < 512U) {
            bytes_.clear();
            return;
        }

        block_size_ = read_be_u16(bytes_, 6U);
        if (block_size_ == 0U) {
            block_size_ = 1U;
        }
        available_ = true;
    }

    [[nodiscard]] bool available() const {
        return available_;
    }

    [[nodiscard]] std::string read_block(std::uint32_t block_number) const {
        if (!available_ || block_number == 0U) {
            return {};
        }

        const std::uint64_t offset = static_cast<std::uint64_t>(block_number) * block_size_;
        if ((offset + 8U) > bytes_.size()) {
            return {};
        }

        const std::uint32_t length = read_be_u32(bytes_, static_cast<std::size_t>(offset + 4U));
        const std::uint64_t payload_offset = offset + 8U;
        const std::uint64_t payload_end = payload_offset + length;
        if (payload_end > bytes_.size()) {
            return {};
        }

        std::string text;
        text.reserve(length);
        for (std::uint64_t index = payload_offset; index < payload_end; ++index) {
            const auto raw = static_cast<unsigned char>(bytes_[static_cast<std::size_t>(index)]);
            if (raw == 0U) {
                text.push_back(' ');
            } else if (std::isprint(raw) != 0 || std::isspace(raw) != 0) {
                text.push_back(static_cast<char>(raw));
            }
        }

        text = trim_right(std::move(text));
        if (text.size() > 160U) {
            text.resize(160U);
            text += "...";
        }
        return text;
    }

private:
    std::vector<std::uint8_t> bytes_;
    std::uint32_t block_size_ = 0;
    bool available_ = false;
};

std::string format_binary_bytes(const std::vector<std::uint8_t>& bytes) {
    std::ostringstream stream;
    stream << "0x";
    constexpr std::array<char, 16U> hex = {
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    };
    for (std::uint8_t byte : bytes) {
        stream << hex[(byte >> 4U) & 0x0FU] << hex[byte & 0x0FU];
    }
    return stream.str();
}

std::string decode_value(
    char field_type,
    const std::vector<std::uint8_t>& raw,
    const MemoReader& memo_reader,
    bool& is_null) {
    is_null = false;
    if (raw.empty()) {
        return {};
    }

    switch (field_type) {
        case 'C': {
            return trim_right(std::string(raw.begin(), raw.end()));
        }
        case 'N':
        case 'F': {
            return trim_both(std::string(raw.begin(), raw.end()));
        }
        case 'L': {
            const char value = static_cast<char>(raw[0]);
            if (value == 'Y' || value == 'y' || value == 'T' || value == 't') {
                return "true";
            }
            if (value == 'N' || value == 'n' || value == 'F' || value == 'f') {
                return "false";
            }
            return std::string(1U, value);
        }
        case 'D': {
            const std::string value(raw.begin(), raw.end());
            if (value.size() == 8U) {
                return value.substr(0U, 4U) + "-" + value.substr(4U, 2U) + "-" + value.substr(6U, 2U);
            }
            return trim_both(value);
        }
        case 'I': {
            if (raw.size() < 4U) {
                return {};
            }
            const std::int32_t value = static_cast<std::int32_t>(read_le_u32(raw, 0U));
            return std::to_string(value);
        }
        case 'T': {
            if (raw.size() < 8U) {
                return {};
            }
            const std::uint32_t julian_day = read_le_u32(raw, 0U);
            const std::uint32_t millis = read_le_u32(raw, 4U);
            std::ostringstream stream;
            stream << "julian:" << julian_day << " millis:" << millis;
            return stream.str();
        }
        case 'M':
        case 'G':
        case 'P': {
            if (raw.size() < 4U) {
                return {};
            }
            const std::uint32_t block_number = read_le_u32(raw, 0U);
            if (block_number == 0U) {
                return {};
            }
            const std::string memo_text = memo_reader.read_block(block_number);
            if (!memo_text.empty()) {
                return memo_text;
            }
            std::ostringstream stream;
            stream << "<memo block " << block_number << ">";
            return stream.str();
        }
        case 'Y': {
            if (raw.size() < 8U) {
                return {};
            }
            return format_currency_display_value(read_le_i64(raw, 0U));
        }
        case '0': {
            is_null = true;
            return "NULL";
        }
        default:
            return format_binary_bytes(raw);
    }
}

}  // namespace

DbfTableParseResult parse_dbf_table_from_file(const std::string& path, std::size_t max_records) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open table file."};
    }

    std::vector<std::uint8_t> bytes = {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };

    const DbfParseResult header_result = parse_dbf_header(bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }

    DbfTable table;
    table.header = header_result.header;

    if (bytes.size() < table.header.header_length) {
        return {.ok = false, .error = "Table file is shorter than its header length."};
    }

    std::size_t field_offset = 32U;
    while ((field_offset + 32U) <= bytes.size() && bytes[field_offset] != 0x0DU) {
        DbfFieldDescriptor field;
        field.name = read_ascii_name(bytes, field_offset, 11U);
        field.type = static_cast<char>(bytes[field_offset + 11U]);
        field.offset = read_le_u32(bytes, field_offset + 12U);
        field.length = bytes[field_offset + 16U];
        field.decimal_count = bytes[field_offset + 17U];
        table.fields.push_back(std::move(field));
        field_offset += 32U;
    }

    const MemoReader memo_reader(infer_memo_sidecar_path(path));
    const std::size_t record_count = std::min<std::size_t>(table.header.record_count, max_records);
    const std::size_t data_offset = table.header.header_length;
    const std::size_t record_length = table.header.record_length;

    for (std::size_t record_index = 0; record_index < record_count; ++record_index) {
        const std::size_t record_offset = data_offset + (record_index * record_length);
        if ((record_offset + record_length) > bytes.size()) {
            break;
        }

        DbfRecord record;
        record.record_index = record_index;
        record.deleted = bytes[record_offset] == 0x2AU;

        for (const auto& field : table.fields) {
            const std::size_t field_start = record_offset + field.offset;
            const std::size_t field_end = field_start + field.length;
            if (field_end > bytes.size()) {
                break;
            }

            std::vector<std::uint8_t> raw(
                bytes.begin() + static_cast<std::ptrdiff_t>(field_start),
                bytes.begin() + static_cast<std::ptrdiff_t>(field_end));

            bool is_null = false;
            const std::string display_value = decode_value(field.type, raw, memo_reader, is_null);
            record.values.push_back({
                .field_name = field.name,
                .field_type = field.type,
                .is_null = is_null,
                .display_value = display_value
            });
        }

        table.records.push_back(std::move(record));
    }

    return {.ok = true, .table = std::move(table)};
}

DbfWriteResult create_dbf_table_file(
    const std::string& path,
    const std::vector<DbfFieldDescriptor>& fields,
    const std::vector<std::vector<std::string>>& records) {
    if (fields.empty()) {
        return {.ok = false, .error = "At least one field is required to create a DBF table."};
    }

    std::vector<RawFieldDescriptor> raw_fields;
    raw_fields.reserve(fields.size());
    std::uint32_t next_offset = 1U;
    bool has_memo_fields = false;
    for (const auto& field : fields) {
        if (trim_both(field.name).empty()) {
            return {.ok = false, .error = "Field names cannot be empty."};
        }
        if (field.length == 0U) {
            return {.ok = false, .error = "Field lengths must be greater than zero."};
        }
        if (!supports_table_field_storage(field.type)) {
            return {.ok = false, .error = "Table creation is not implemented for one or more field types yet."};
        }
        if (field.type == 'M') {
            if (field.length < 4U) {
                return {.ok = false, .error = "Memo fields require a width of at least 4 bytes."};
            }
            has_memo_fields = true;
        } else if (field.type == 'I' && field.length != 4U) {
            return {.ok = false, .error = "Integer fields require a width of exactly 4 bytes."};
        } else if ((field.type == 'Y' || field.type == 'T') && field.length != 8U) {
            return {.ok = false, .error = std::string(1U, field.type) + " fields require a width of exactly 8 bytes."};
        }

        raw_fields.push_back({
            .name = trim_both(field.name),
            .type = field.type,
            .offset = next_offset,
            .length = field.length,
            .decimal_count = field.decimal_count
        });
        next_offset += field.length;
    }

    const std::uint16_t header_length = static_cast<std::uint16_t>(32U + (raw_fields.size() * 32U) + 1U);
    const std::uint16_t record_length = static_cast<std::uint16_t>(next_offset);
    std::vector<std::uint8_t> bytes(
        static_cast<std::size_t>(header_length) + (records.size() * static_cast<std::size_t>(record_length)) + 1U,
        0U);

    bytes[0] = 0x30U;
    write_le_u32(bytes, 4U, static_cast<std::uint32_t>(records.size()));
    write_le_u16(bytes, 8U, header_length);
    write_le_u16(bytes, 10U, record_length);

    std::size_t descriptor_offset = 32U;
    for (const auto& field : raw_fields) {
        const std::string field_name = field.name.substr(0U, 11U);
        std::copy(field_name.begin(), field_name.end(), bytes.begin() + static_cast<std::ptrdiff_t>(descriptor_offset));
        bytes[descriptor_offset + 11U] = static_cast<std::uint8_t>(field.type);
        write_le_u32(bytes, descriptor_offset + 12U, field.offset);
        bytes[descriptor_offset + 16U] = field.length;
        bytes[descriptor_offset + 17U] = field.decimal_count;
        descriptor_offset += 32U;
    }
    bytes[descriptor_offset] = 0x0DU;
    bytes.back() = 0x1AU;

    const DbfHeader header{
        .version = bytes[0],
        .last_update_year = 0U,
        .last_update_month = 0U,
        .last_update_day = 0U,
        .record_count = static_cast<std::uint32_t>(records.size()),
        .header_length = header_length,
        .record_length = record_length,
        .table_flags = 0U,
        .code_page_mark = 0U
    };

    std::vector<std::uint8_t> memo_bytes = has_memo_fields ? create_empty_memo_sidecar() : std::vector<std::uint8_t>{};

    for (std::size_t record_index = 0; record_index < records.size(); ++record_index) {
        if (records[record_index].size() != raw_fields.size()) {
            return {.ok = false, .error = "Record field counts must match the DBF schema.", .record_count = records.size()};
        }

        const std::size_t record_offset = header.header_length + (record_index * header.record_length);
        bytes[record_offset] = 0x20U;
        for (std::size_t field_index = 0; field_index < raw_fields.size(); ++field_index) {
            DbfWriteResult write_result;
            if (raw_fields[field_index].type == 'M') {
                write_result = write_memo_field_bytes(
                    bytes,
                    record_offset + raw_fields[field_index].offset,
                    memo_bytes,
                    records[record_index][field_index],
                    records.size());
            } else {
                write_result = write_field_bytes(
                    bytes,
                    header,
                    record_index,
                    raw_fields[field_index],
                    records[record_index][field_index]);
            }
            if (!write_result.ok) {
                return write_result;
            }
        }
    }

    if (!write_binary_file(path, bytes)) {
        return {.ok = false, .error = "Unable to write table file.", .record_count = records.size()};
    }
    if (has_memo_fields && !write_binary_file(infer_memo_sidecar_path(path), memo_bytes)) {
        return {.ok = false, .error = "Unable to write memo sidecar.", .record_count = records.size()};
    }

    return {.ok = true, .record_count = records.size()};
}

DbfWriteResult append_blank_record_to_file(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open table file."};
    }

    std::vector<std::uint8_t> bytes = {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };

    const DbfParseResult header_result = parse_dbf_header(bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }
    if (const auto mutation_error = unsupported_indexed_table_mutation_error(path, header_result.header); mutation_error.has_value()) {
        return {.ok = false, .error = *mutation_error, .record_count = header_result.header.record_count};
    }

    const std::vector<RawFieldDescriptor> fields = read_raw_field_descriptors(bytes);
    DbfWriteResult result = append_blank_record_bytes(bytes, header_result.header, fields);
    if (!result.ok) {
        return result;
    }
    if (!write_binary_file(path, bytes)) {
        return {.ok = false, .error = "Unable to write table file.", .record_count = header_result.header.record_count};
    }
    return result;
}

DbfWriteResult replace_record_field_value(
    const std::string& path,
    std::size_t record_index,
    const std::string& field_name,
    const std::string& value) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open table file."};
    }

    std::vector<std::uint8_t> bytes = {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };

    const DbfParseResult header_result = parse_dbf_header(bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }
    if (const auto mutation_error = unsupported_indexed_table_mutation_error(path, header_result.header); mutation_error.has_value()) {
        return {.ok = false, .error = *mutation_error, .record_count = header_result.header.record_count};
    }

    const std::vector<RawFieldDescriptor> fields = read_raw_field_descriptors(bytes);
    const auto field = find_raw_field(fields, field_name);
    if (!field.has_value()) {
        return {.ok = false, .error = "The target field was not found in the table.", .record_count = header_result.header.record_count};
    }

    DbfWriteResult result;
    std::vector<std::uint8_t> memo_bytes;
    if (field->type == 'M') {
        const std::string memo_path = infer_memo_sidecar_path(path);
        if (memo_path.empty()) {
            return {.ok = false, .error = "No memo sidecar path could be inferred for the table.", .record_count = header_result.header.record_count};
        }
        memo_bytes = read_binary_file(memo_path);
        result = write_memo_field_bytes(
            bytes,
            header_result.header.header_length + (record_index * header_result.header.record_length) + field->offset,
            memo_bytes,
            value,
            header_result.header.record_count);
    } else {
        result = write_field_bytes(bytes, header_result.header, record_index, *field, value);
    }
    if (!result.ok) {
        return result;
    }
    if (!write_binary_file(path, bytes)) {
        return {.ok = false, .error = "Unable to write table file.", .record_count = header_result.header.record_count};
    }
    if (field->type == 'M' && !write_binary_file(infer_memo_sidecar_path(path), memo_bytes)) {
        return {.ok = false, .error = "Unable to write memo sidecar.", .record_count = header_result.header.record_count};
    }
    return result;
}

DbfWriteResult set_record_deleted_flag(
    const std::string& path,
    std::size_t record_index,
    bool deleted) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open table file."};
    }

    std::vector<std::uint8_t> bytes = {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };

    const DbfParseResult header_result = parse_dbf_header(bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }
    if (const auto mutation_error = unsupported_indexed_table_mutation_error(path, header_result.header); mutation_error.has_value()) {
        return {.ok = false, .error = *mutation_error, .record_count = header_result.header.record_count};
    }
    if (record_index >= header_result.header.record_count) {
        return {.ok = false, .error = "Record index is out of range.", .record_count = header_result.header.record_count};
    }

    const std::size_t record_offset = header_result.header.header_length + (record_index * header_result.header.record_length);
    if (record_offset >= bytes.size()) {
        return {.ok = false, .error = "Record data is truncated.", .record_count = header_result.header.record_count};
    }

    bytes[record_offset] = deleted ? 0x2AU : 0x20U;
    if (!write_binary_file(path, bytes)) {
        return {.ok = false, .error = "Unable to write table file.", .record_count = header_result.header.record_count};
    }

    return {.ok = true, .record_count = header_result.header.record_count};
}

}  // namespace copperfin::vfp
