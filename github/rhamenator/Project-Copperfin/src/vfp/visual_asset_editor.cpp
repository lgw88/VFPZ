#include "copperfin/vfp/visual_asset_editor.h"

#include "copperfin/vfp/dbf_header.h"
#include "copperfin/vfp/dbf_table.h"

#include <array>
#include <algorithm>
#include <cctype>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <optional>
#include <sstream>
#include <vector>

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

std::uint16_t read_be_u16(const std::vector<std::uint8_t>& bytes, std::size_t offset) {
    return static_cast<std::uint16_t>((static_cast<std::uint16_t>(bytes[offset]) << 8U) |
                                      static_cast<std::uint16_t>(bytes[offset + 1]));
}

void write_le_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value) {
    bytes[offset] = static_cast<std::uint8_t>(value & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 2U] = static_cast<std::uint8_t>((value >> 16U) & 0xFFU);
    bytes[offset + 3U] = static_cast<std::uint8_t>((value >> 24U) & 0xFFU);
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
    std::string ext = file_path.extension().string();
    std::transform(ext.begin(), ext.end(), ext.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });

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
    return {};
}

struct RawFieldDescriptor {
    std::string name;
    char type = '\0';
    std::uint32_t offset = 0;
    std::uint8_t length = 0;
};

VisualAssetEditResult replace_memo_field_value(
    const std::string& table_path,
    std::size_t record_index,
    const std::string& field_name,
    const std::string& new_value);

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

VisualAssetEditResult replace_non_memo_field_value(
    const std::string& table_path,
    std::size_t record_index,
    const RawFieldDescriptor& field,
    const std::string& new_value) {
    auto table_bytes = read_binary_file(table_path);
    if (table_bytes.empty()) {
        return {.ok = false, .error = "Unable to open the visual asset table."};
    }

    const auto header_result = parse_dbf_header(table_bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }

    if (record_index >= header_result.header.record_count) {
        return {.ok = false, .error = "Record index is out of range for the asset."};
    }

    const std::size_t record_offset = header_result.header.header_length +
                                      (record_index * header_result.header.record_length);
    const std::size_t field_offset = record_offset + field.offset;
    if ((field_offset + field.length) > table_bytes.size()) {
        return {.ok = false, .error = "Record data is truncated."};
    }

    std::fill_n(table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset), field.length, static_cast<std::uint8_t>(' '));

    switch (field.type) {
        case 'C': {
            const std::string text = trim_both(new_value);
            if (text.size() > field.length) {
                return {.ok = false, .error = "Character value is too large for the target field."};
            }
            std::copy(text.begin(),
                      text.end(),
                      table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset));
            break;
        }
        case 'N':
        case 'F': {
            const std::string text = trim_both(new_value);
            if (text.empty()) {
                break;
            }
            if (text.size() > field.length) {
                return {.ok = false, .error = "Numeric value is too large for the target field."};
            }
            const auto padding = static_cast<std::ptrdiff_t>(field.length - text.size());
            std::copy(text.begin(),
                      text.end(),
                      table_bytes.begin() + static_cast<std::ptrdiff_t>(field_offset) + padding);
            break;
        }
        case 'L': {
            const auto logical_value = normalize_logical_value(new_value);
            if (!logical_value.has_value()) {
                return {.ok = false, .error = "Logical fields only accept true/false values."};
            }
            table_bytes[field_offset] = static_cast<std::uint8_t>(*logical_value);
            break;
        }
        default:
            return {.ok = false, .error = "Direct updates are not implemented for this field type yet."};
    }

    if (!write_binary_file(table_path, table_bytes)) {
        return {.ok = false, .error = "Unable to write the visual asset table."};
    }

    return {.ok = true};
}

VisualAssetEditResult replace_field_value(
    const std::string& table_path,
    std::size_t record_index,
    const RawFieldDescriptor& field,
    const std::string& new_value) {
    if (field.type == 'M') {
        return replace_memo_field_value(table_path, record_index, field.name, new_value);
    }

    return replace_non_memo_field_value(table_path, record_index, field, new_value);
}

std::vector<RawFieldDescriptor> read_raw_field_descriptors(const std::vector<std::uint8_t>& table_bytes) {
    std::vector<RawFieldDescriptor> fields;
    std::size_t descriptor_offset = 32U;
    while ((descriptor_offset + 32U) <= table_bytes.size() && table_bytes[descriptor_offset] != 0x0DU) {
        fields.push_back({
            .name = read_ascii_name(table_bytes, descriptor_offset, 11U),
            .type = static_cast<char>(table_bytes[descriptor_offset + 11U]),
            .offset = read_le_u32(table_bytes, descriptor_offset + 12U),
            .length = table_bytes[descriptor_offset + 16U]
        });
        descriptor_offset += 32U;
    }
    return fields;
}

VisualAssetEditResult replace_memo_field_value(
    const std::string& table_path,
    std::size_t record_index,
    const std::string& field_name,
    const std::string& new_value) {
    auto table_bytes = read_binary_file(table_path);
    if (table_bytes.empty()) {
        return {.ok = false, .error = "Unable to open the visual asset table."};
    }

    const auto header_result = parse_dbf_header(table_bytes);
    if (!header_result.ok) {
        return {.ok = false, .error = header_result.error};
    }

    const std::vector<RawFieldDescriptor> fields = read_raw_field_descriptors(table_bytes);

    const auto field_it = std::find_if(fields.begin(), fields.end(), [&](const RawFieldDescriptor& field) {
        return field.name == field_name;
    });
    if (field_it == fields.end()) {
        return {.ok = false, .error = "The target field was not found in the asset."};
    }
    if (field_it->type != 'M') {
        return {.ok = false, .error = "The target field is not a memo-backed field."};
    }

    if (record_index >= header_result.header.record_count) {
        return {.ok = false, .error = "Record index is out of range for the asset."};
    }

    const std::size_t record_offset = header_result.header.header_length +
                                      (record_index * header_result.header.record_length);
    const std::size_t field_offset = record_offset + field_it->offset;
    if ((field_offset + 4U) > table_bytes.size()) {
        return {.ok = false, .error = "Record data is truncated."};
    }

    const std::string memo_path = infer_memo_sidecar_path(table_path);
    if (memo_path.empty()) {
        return {.ok = false, .error = "No memo sidecar path could be inferred for the asset."};
    }

    auto memo_bytes = read_binary_file(memo_path);
    if (memo_bytes.size() < 8U) {
        return {.ok = false, .error = "Unable to open the memo sidecar."};
    }

    const std::uint16_t block_size = read_be_u16(memo_bytes, 6U);
    if (block_size == 0U) {
        return {.ok = false, .error = "Memo sidecar block size is invalid."};
    }

    std::uint32_t block_number = read_le_u32(table_bytes, field_offset);
    std::array<std::uint8_t, 4U> original_block_header = {0U, 0U, 0U, 1U};

    if (block_number != 0U) {
        const std::size_t old_block_offset = static_cast<std::size_t>(block_number) * block_size;
        if ((old_block_offset + 8U) <= memo_bytes.size()) {
            for (std::size_t index = 0; index < original_block_header.size(); ++index) {
                original_block_header[index] = memo_bytes[old_block_offset + index];
            }
        }
    }

    const std::uint32_t next_free_block = read_be_u32(memo_bytes, 0U);
    if (next_free_block == 0U) {
        return {.ok = false, .error = "Memo sidecar next-free-block pointer is invalid."};
    }

    const auto required_bytes = static_cast<std::size_t>(8U + new_value.size());
    const auto required_blocks = static_cast<std::uint32_t>((required_bytes + block_size - 1U) / block_size);
    const std::size_t new_block_offset = static_cast<std::size_t>(next_free_block) * block_size;
    const std::size_t new_total_size = new_block_offset + (static_cast<std::size_t>(required_blocks) * block_size);
    if (memo_bytes.size() < new_total_size) {
        memo_bytes.resize(new_total_size, 0U);
    }

    for (std::size_t index = 0; index < original_block_header.size(); ++index) {
        memo_bytes[new_block_offset + index] = original_block_header[index];
    }
    write_be_u32(memo_bytes, new_block_offset + 4U, static_cast<std::uint32_t>(new_value.size()));
    std::fill(
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(new_block_offset + 8U),
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(new_total_size),
        static_cast<std::uint8_t>(0U));
    std::copy(
        new_value.begin(),
        new_value.end(),
        memo_bytes.begin() + static_cast<std::ptrdiff_t>(new_block_offset + 8U));

    write_be_u32(memo_bytes, 0U, next_free_block + required_blocks);
    write_le_u32(table_bytes, field_offset, next_free_block);

    if (!write_binary_file(memo_path, memo_bytes)) {
        return {.ok = false, .error = "Unable to write the memo sidecar."};
    }
    if (!write_binary_file(table_path, table_bytes)) {
        return {.ok = false, .error = "Unable to write the visual asset table."};
    }

    return {.ok = true};
}

}  // namespace

std::vector<VisualPropertyAssignment> parse_visual_property_blob(const std::string& text) {
    std::vector<VisualPropertyAssignment> properties;
    std::stringstream stream(text);
    std::string line;
    while (std::getline(stream, line)) {
        if (!line.empty() && line.back() == '\r') {
            line.pop_back();
        }

        const auto equals = line.find('=');
        if (equals == std::string::npos) {
            if (!trim_both(line).empty()) {
                properties.push_back({.name = trim_both(line), .value = {}});
            }
            continue;
        }

        properties.push_back({
            .name = trim_both(line.substr(0U, equals)),
            .value = trim_both(line.substr(equals + 1U))
        });
    }
    return properties;
}

std::string serialize_visual_property_blob(const std::vector<VisualPropertyAssignment>& properties) {
    std::ostringstream stream;
    for (const auto& property : properties) {
        if (property.name.empty()) {
            continue;
        }

        stream << property.name;
        if (!property.value.empty()) {
            stream << " = " << property.value;
        }
        stream << "\r\n";
    }
    return stream.str();
}

bool is_property_blob_asset_path(const std::string& path) {
    std::string ext = std::filesystem::path(path).extension().string();
    std::transform(ext.begin(), ext.end(), ext.begin(), [](unsigned char ch) {
        return static_cast<char>(std::tolower(ch));
    });
    return ext == ".scx" || ext == ".vcx";
}

VisualAssetEditResult update_visual_object_property(const VisualObjectEditRequest& request) {
    if (request.path.empty()) {
        return {.ok = false, .error = "No asset path was provided."};
    }
    if (request.property_name.empty()) {
        return {.ok = false, .error = "No property name was provided."};
    }

    const auto table_result = parse_dbf_table_from_file(request.path, request.record_index + 1U);
    if (!table_result.ok) {
        return {.ok = false, .error = table_result.error};
    }
    if (request.record_index >= table_result.table.records.size()) {
        return {.ok = false, .error = "The requested object record is not currently available."};
    }

    const auto table_bytes = read_binary_file(request.path);
    if (table_bytes.empty()) {
        return {.ok = false, .error = "Unable to open the visual asset table."};
    }

    const auto fields = read_raw_field_descriptors(table_bytes);
    const auto direct_field_it = std::find_if(fields.begin(), fields.end(), [&](const RawFieldDescriptor& field) {
        return field.name == request.property_name;
    });
    if (direct_field_it != fields.end()) {
        return replace_field_value(request.path, request.record_index, *direct_field_it, request.property_value);
    }

    if (!is_property_blob_asset_path(request.path)) {
        return {.ok = false, .error = "The requested property is not exposed as a writable field on this asset."};
    }

    const auto& record = table_result.table.records[request.record_index];
    auto properties_it = std::find_if(record.values.begin(), record.values.end(), [](const DbfRecordValue& value) {
        return value.field_name == "PROPERTIES";
    });
    if (properties_it == record.values.end()) {
        return {.ok = false, .error = "The object does not expose a PROPERTIES memo field."};
    }

    auto assignments = parse_visual_property_blob(properties_it->display_value);
    auto assignment_it = std::find_if(assignments.begin(), assignments.end(), [&](const VisualPropertyAssignment& property) {
        return property.name == request.property_name;
    });
    if (assignment_it == assignments.end()) {
        assignments.push_back({.name = request.property_name, .value = request.property_value});
    } else {
        assignment_it->value = request.property_value;
    }

    return replace_memo_field_value(
        request.path,
        request.record_index,
        "PROPERTIES",
        serialize_visual_property_blob(assignments));
}

}  // namespace copperfin::vfp
