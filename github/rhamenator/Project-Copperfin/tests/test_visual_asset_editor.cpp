#include "copperfin/vfp/dbf_table.h"
#include "copperfin/vfp/visual_asset_editor.h"

#include <cstdint>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <process.h>
#include <string>
#include <vector>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

void write_le_u16(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint16_t value) {
    bytes[offset] = static_cast<std::uint8_t>(value & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
}

void write_le_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value) {
    bytes[offset] = static_cast<std::uint8_t>(value & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 2U] = static_cast<std::uint8_t>((value >> 16U) & 0xFFU);
    bytes[offset + 3U] = static_cast<std::uint8_t>((value >> 24U) & 0xFFU);
}

void write_be_u16(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint16_t value) {
    bytes[offset] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>(value & 0xFFU);
}

void write_be_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value) {
    bytes[offset] = static_cast<std::uint8_t>((value >> 24U) & 0xFFU);
    bytes[offset + 1U] = static_cast<std::uint8_t>((value >> 16U) & 0xFFU);
    bytes[offset + 2U] = static_cast<std::uint8_t>((value >> 8U) & 0xFFU);
    bytes[offset + 3U] = static_cast<std::uint8_t>(value & 0xFFU);
}

void write_ascii(std::vector<std::uint8_t>& bytes, std::size_t offset, const std::string& value) {
    for (std::size_t index = 0; index < value.size(); ++index) {
        bytes[offset + index] = static_cast<std::uint8_t>(value[index]);
    }
}

void write_field_descriptor(
    std::vector<std::uint8_t>& bytes,
    std::size_t offset,
    const std::string& name,
    char type,
    std::uint32_t field_offset,
    std::uint8_t field_length) {
    write_ascii(bytes, offset, name);
    bytes[offset + 11U] = static_cast<std::uint8_t>(type);
    write_le_u32(bytes, offset + 12U, field_offset);
    bytes[offset + 16U] = field_length;
}

void test_update_visual_object_property_rewrites_properties_memo() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_visual_editor_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "sample.scx";
    const fs::path memo_path = temp_dir / "sample.sct";

    std::vector<std::uint8_t> table_bytes(110U, 0U);
    table_bytes[0] = 0x30U;
    table_bytes[1] = 126U;
    table_bytes[2] = 4U;
    table_bytes[3] = 7U;
    write_le_u32(table_bytes, 4U, 1U);
    write_le_u16(table_bytes, 8U, 97U);
    write_le_u16(table_bytes, 10U, 13U);
    table_bytes[28] = 0x00U;
    table_bytes[29] = 0x03U;

    write_field_descriptor(table_bytes, 32U, "OBJNAME", 'M', 1U, 4U);
    write_field_descriptor(table_bytes, 64U, "PROPERTIES", 'M', 5U, 4U);
    table_bytes[96] = 0x0DU;

    table_bytes[97] = 0x20U;
    write_le_u32(table_bytes, 98U, 1U);
    write_le_u32(table_bytes, 102U, 2U);

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    std::vector<std::uint8_t> memo_bytes(2048U, 0U);
    write_be_u32(memo_bytes, 0U, 3U);
    write_be_u16(memo_bytes, 6U, 512U);

    memo_bytes[512 + 3] = 1U;
    write_be_u32(memo_bytes, 512 + 4, 8U);
    write_ascii(memo_bytes, 520U, "txtTitle");

    const std::string properties = "Left = 10\r\nTop = 20\r\nWidth = 40\r\nHeight = 12\r\nName = \"txtTitle\"\r\n";
    memo_bytes[1024 + 3] = 1U;
    write_be_u32(memo_bytes, 1024 + 4, static_cast<std::uint32_t>(properties.size()));
    write_ascii(memo_bytes, 1032U, properties);

    {
        std::ofstream output(memo_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(memo_bytes.data()), static_cast<std::streamsize>(memo_bytes.size()));
    }

    const auto update_result = copperfin::vfp::update_visual_object_property({
        .path = table_path.string(),
        .record_index = 0U,
        .property_name = "Left",
        .property_value = "25"
    });

    expect(update_result.ok, "update_visual_object_property should succeed for a synthetic SCX/SCT pair");

    const auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 1U);
    expect(parse_result.ok, "updated synthetic SCX/SCT should remain readable");
    if (parse_result.ok && parse_result.table.records.size() == 1U) {
        const auto& record = parse_result.table.records[0];
        bool found = false;
        for (const auto& value : record.values) {
            if (value.field_name == "PROPERTIES") {
                found = true;
                expect(value.display_value.find("Left = 25") != std::string::npos, "updated PROPERTIES memo should contain the new Left value");
            }
        }
        expect(found, "updated record should still expose the PROPERTIES field");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_update_visual_object_property_rewrites_direct_fields() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_visual_editor_direct_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "sample.frx";
    const fs::path memo_path = temp_dir / "sample.frt";

    std::vector<std::uint8_t> table_bytes(178U, 0U);
    table_bytes[0] = 0x30U;
    table_bytes[1] = 126U;
    table_bytes[2] = 4U;
    table_bytes[3] = 7U;
    write_le_u32(table_bytes, 4U, 1U);
    write_le_u16(table_bytes, 8U, 161U);
    write_le_u16(table_bytes, 10U, 17U);
    table_bytes[28] = 0x00U;
    table_bytes[29] = 0x03U;

    write_field_descriptor(table_bytes, 32U, "OBJTYPE", 'N', 1U, 2U);
    write_field_descriptor(table_bytes, 64U, "HPOS", 'N', 3U, 9U);
    write_field_descriptor(table_bytes, 96U, "GRID", 'L', 12U, 1U);
    write_field_descriptor(table_bytes, 128U, "EXPR", 'M', 13U, 4U);
    table_bytes[160] = 0x0DU;
    table_bytes[161] = 0x20U;
    write_ascii(table_bytes, 162U, " 8");
    write_ascii(table_bytes, 164U, "  7812.5");
    table_bytes[173] = 'F';
    write_le_u32(table_bytes, 174U, 1U);

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    std::vector<std::uint8_t> memo_bytes(1024U, 0U);
    write_be_u32(memo_bytes, 0U, 2U);
    write_be_u16(memo_bytes, 6U, 512U);
    const std::string expr = "customer.company";
    memo_bytes[512 + 3] = 1U;
    write_be_u32(memo_bytes, 512 + 4, static_cast<std::uint32_t>(expr.size()));
    write_ascii(memo_bytes, 520U, expr);

    {
        std::ofstream output(memo_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(memo_bytes.data()), static_cast<std::streamsize>(memo_bytes.size()));
    }

    auto update_result = copperfin::vfp::update_visual_object_property({
        .path = table_path.string(),
        .record_index = 0U,
        .property_name = "HPOS",
        .property_value = "9583.333"
    });
    expect(update_result.ok, "numeric FRX field update should succeed");

    update_result = copperfin::vfp::update_visual_object_property({
        .path = table_path.string(),
        .record_index = 0U,
        .property_name = "GRID",
        .property_value = "true"
    });
    expect(update_result.ok, "logical FRX field update should succeed");

    update_result = copperfin::vfp::update_visual_object_property({
        .path = table_path.string(),
        .record_index = 0U,
        .property_name = "EXPR",
        .property_value = "\"newexpr\""
    });
    expect(update_result.ok, "memo FRX field update should succeed");

    const auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 1U);
    expect(parse_result.ok, "updated synthetic FRX/FRT should remain readable");
    if (parse_result.ok && parse_result.table.records.size() == 1U) {
        const auto& record = parse_result.table.records[0];
        for (const auto& value : record.values) {
            if (value.field_name == "HPOS") {
                expect(value.display_value == "9583.333", "updated HPOS should be reflected in the parsed table");
            }
            if (value.field_name == "GRID") {
                expect(value.display_value == "true", "updated GRID should be reflected in the parsed table");
            }
            if (value.field_name == "EXPR") {
                expect(value.display_value == "\"newexpr\"", "updated EXPR memo should be reflected in the parsed table");
            }
        }
    }

    fs::remove_all(temp_dir, ignored);
}

}  // namespace

int main() {
    test_update_visual_object_property_rewrites_properties_memo();
    test_update_visual_object_property_rewrites_direct_fields();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
