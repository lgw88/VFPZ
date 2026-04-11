#include "copperfin/vfp/dbf_table.h"

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
    std::uint8_t field_length,
    std::uint8_t decimal_count = 0U) {
    write_ascii(bytes, offset, name);
    bytes[offset + 11U] = static_cast<std::uint8_t>(type);
    write_le_u32(bytes, offset + 12U, field_offset);
    bytes[offset + 16U] = field_length;
    bytes[offset + 17U] = decimal_count;
}

std::vector<std::uint8_t> read_binary_file(const std::filesystem::path& path) {
    std::ifstream input(path, std::ios::binary);
    return {
        std::istreambuf_iterator<char>(input),
        std::istreambuf_iterator<char>()
    };
}

void test_parse_dbf_table_with_memo_sidecar() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_tests_" + std::to_string(_getpid()));
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
    write_field_descriptor(table_bytes, 64U, "OBJTYPE", 'C', 5U, 8U);
    table_bytes[96] = 0x0DU;

    table_bytes[97] = 0x20U;
    write_le_u32(table_bytes, 98U, 1U);
    write_ascii(table_bytes, 102U, "Textbox ");

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    std::vector<std::uint8_t> memo_bytes(1024U, 0U);
    write_be_u32(memo_bytes, 0U, 2U);
    write_be_u16(memo_bytes, 6U, 512U);
    memo_bytes[512] = 0U;
    memo_bytes[513] = 0U;
    memo_bytes[514] = 0U;
    memo_bytes[515] = 1U;
    write_be_u32(memo_bytes, 516U, 9U);
    write_ascii(memo_bytes, 520U, "txtTitle1");

    {
        std::ofstream output(memo_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(memo_bytes.data()), static_cast<std::streamsize>(memo_bytes.size()));
    }

    const auto result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(result.ok, "parse_dbf_table_from_file should succeed for a synthetic SCX/SCT pair");
    expect(result.table.fields.size() == 2U, "field descriptors should be parsed");
    expect(result.table.records.size() == 1U, "one record should be parsed");
    if (result.table.records.size() == 1U && result.table.records[0].values.size() >= 2U) {
        expect(result.table.records[0].values[0].display_value == "txtTitle1", "memo values should be decoded from the sidecar");
        expect(result.table.records[0].values[1].display_value == "Textbox", "character values should be trimmed");
    }

    fs::remove(table_path, ignored);
    fs::remove(memo_path, ignored);
    fs::remove(temp_dir, ignored);
}

void test_mutate_and_append_dbf_table() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_write_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "people.dbf";
    std::vector<std::uint8_t> table_bytes(97U + (2U * 14U) + 1U, 0U);
    table_bytes[0] = 0x30U;
    write_le_u32(table_bytes, 4U, 2U);
    write_le_u16(table_bytes, 8U, 97U);
    write_le_u16(table_bytes, 10U, 14U);

    write_field_descriptor(table_bytes, 32U, "NAME", 'C', 1U, 10U);
    write_field_descriptor(table_bytes, 64U, "AGE", 'N', 11U, 3U);
    table_bytes[96U] = 0x0DU;

    table_bytes[97U] = 0x20U;
    write_ascii(table_bytes, 98U, "ALPHA     ");
    write_ascii(table_bytes, 108U, " 10");

    table_bytes[111U] = 0x20U;
    write_ascii(table_bytes, 112U, "BRAVO     ");
    write_ascii(table_bytes, 122U, " 20");
    table_bytes.back() = 0x1AU;

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    const auto replace_name = copperfin::vfp::replace_record_field_value(table_path.string(), 1U, "NAME", "BRAVOX");
    expect(replace_name.ok, "replace_record_field_value should update character fields");

    const auto replace_age = copperfin::vfp::replace_record_field_value(table_path.string(), 1U, "AGE", "21");
    expect(replace_age.ok, "replace_record_field_value should update numeric fields");

    const auto append = copperfin::vfp::append_blank_record_to_file(table_path.string());
    expect(append.ok, "append_blank_record_to_file should append a new row");
    expect(append.record_count == 3U, "append_blank_record_to_file should grow the record count");

    const auto delete_result = copperfin::vfp::set_record_deleted_flag(table_path.string(), 2U, true);
    expect(delete_result.ok, "set_record_deleted_flag should tombstone records");

    const auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "the mutated DBF should remain readable");
    expect(parse_result.table.records.size() == 3U, "mutated DBF should expose the appended record");
    if (parse_result.table.records.size() == 3U) {
        expect(parse_result.table.records[1].values[0].display_value == "BRAVOX", "character updates should persist");
        expect(parse_result.table.records[1].values[1].display_value == "21", "numeric updates should persist");
        expect(parse_result.table.records[2].deleted, "deleted-flag updates should persist");
        expect(parse_result.table.records[2].values[0].display_value.empty(), "blank appended character fields should start empty");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_create_dbf_table_file_round_trips() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_create_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "totals.dbf";
    const std::vector<copperfin::vfp::DbfFieldDescriptor> fields{
        {.name = "REGION", .type = 'C', .length = 10U},
        {.name = "AMOUNT", .type = 'N', .length = 6U},
        {.name = "QTY", .type = 'N', .length = 3U}
    };
    const std::vector<std::vector<std::string>> records{
        {"EAST", "25", "3"},
        {"WEST", "8", "4"}
    };

    const auto create_result = copperfin::vfp::create_dbf_table_file(table_path.string(), fields, records);
    expect(create_result.ok, "create_dbf_table_file should write a new DBF table");
    expect(create_result.record_count == 2U, "create_dbf_table_file should report the written record count");

    const auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "created DBF tables should round-trip through the parser");
    expect(parse_result.table.fields.size() == 3U, "created DBF tables should persist field descriptors");
    expect(parse_result.table.records.size() == 2U, "created DBF tables should persist record rows");
    if (parse_result.table.records.size() == 2U) {
        expect(parse_result.table.records[0].values[0].display_value == "EAST", "created character fields should persist");
        expect(parse_result.table.records[0].values[1].display_value == "25", "created numeric totals should persist");
        expect(parse_result.table.records[1].values[0].display_value == "WEST", "later created rows should persist");
        expect(parse_result.table.records[1].values[2].display_value == "4", "created numeric fields should round-trip");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_memo_field_create_replace_and_append_round_trip() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_memo_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "notes.dbf";
    const fs::path memo_path = temp_dir / "notes.fpt";
    const std::vector<copperfin::vfp::DbfFieldDescriptor> fields{
        {.name = "TITLE", .type = 'C', .length = 12U},
        {.name = "BODY", .type = 'M', .length = 4U}
    };
    const std::vector<std::vector<std::string>> records{
        {"FIRST", "First memo body"},
        {"SECOND", "Second memo body"}
    };

    const auto create_result = copperfin::vfp::create_dbf_table_file(table_path.string(), fields, records);
    expect(create_result.ok, "create_dbf_table_file should support memo-backed schemas");
    expect(fs::exists(memo_path), "memo-backed table creation should also create the FPT sidecar");

    auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "memo-backed created tables should remain readable");
    expect(parse_result.table.records.size() == 2U, "memo-backed created tables should persist record rows");
    if (parse_result.table.records.size() == 2U) {
        expect(parse_result.table.records[0].values[0].display_value == "FIRST", "memo-backed created character fields should persist");
        expect(parse_result.table.records[0].values[1].display_value == "First memo body", "memo-backed created memo fields should round-trip through the sidecar");
        expect(parse_result.table.records[1].values[1].display_value == "Second memo body", "later memo rows should also round-trip");
    }

    const auto replace_result = copperfin::vfp::replace_record_field_value(table_path.string(), 0U, "BODY", "Updated first memo");
    expect(replace_result.ok, "replace_record_field_value should support memo-backed fields");

    const auto append_result = copperfin::vfp::append_blank_record_to_file(table_path.string());
    expect(append_result.ok, "append_blank_record_to_file should support memo-backed tables");
    expect(append_result.record_count == 3U, "memo-backed append_blank_record_to_file should grow the record count");

    parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "memo-backed mutated tables should remain readable");
    expect(parse_result.table.records.size() == 3U, "memo-backed tables should expose appended records");
    if (parse_result.table.records.size() == 3U) {
        expect(parse_result.table.records[0].values[1].display_value == "Updated first memo", "memo field replacements should persist through the shared DBF layer");
        expect(parse_result.table.records[2].values[0].display_value.empty(), "blank appended character fields in memo-backed tables should start empty");
        expect(parse_result.table.records[2].values[1].display_value.empty(), "blank appended memo fields should start with an empty pointer");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_indexed_table_mutations_fail_fast_without_changing_files() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_index_guard_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const auto write_people_table = [](const fs::path& path, std::uint8_t table_flags) {
        std::vector<std::uint8_t> table_bytes(97U + (2U * 14U) + 1U, 0U);
        table_bytes[0] = 0x30U;
        write_le_u32(table_bytes, 4U, 2U);
        write_le_u16(table_bytes, 8U, 97U);
        write_le_u16(table_bytes, 10U, 14U);
        table_bytes[28U] = table_flags;

        write_field_descriptor(table_bytes, 32U, "NAME", 'C', 1U, 10U);
        write_field_descriptor(table_bytes, 64U, "AGE", 'N', 11U, 3U);
        table_bytes[96U] = 0x0DU;

        table_bytes[97U] = 0x20U;
        write_ascii(table_bytes, 98U, "ALPHA     ");
        write_ascii(table_bytes, 108U, " 10");

        table_bytes[111U] = 0x20U;
        write_ascii(table_bytes, 112U, "BRAVO     ");
        write_ascii(table_bytes, 122U, " 20");
        table_bytes.back() = 0x1AU;

        std::ofstream output(path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    };

    const fs::path flagged_table_path = temp_dir / "flagged.dbf";
    write_people_table(flagged_table_path, 0x01U);
    const auto flagged_original = read_binary_file(flagged_table_path);

    const auto flagged_replace = copperfin::vfp::replace_record_field_value(flagged_table_path.string(), 0U, "NAME", "OMEGA");
    expect(!flagged_replace.ok, "replace_record_field_value should reject DBFs marked with production indexes");
    expect(flagged_replace.error.find("Indexed DBF mutation") != std::string::npos, "production-index rejection should mention indexed DBF mutation");

    const auto flagged_append = copperfin::vfp::append_blank_record_to_file(flagged_table_path.string());
    expect(!flagged_append.ok, "append_blank_record_to_file should reject DBFs marked with production indexes");

    const auto flagged_delete = copperfin::vfp::set_record_deleted_flag(flagged_table_path.string(), 0U, true);
    expect(!flagged_delete.ok, "set_record_deleted_flag should reject DELETE-style writes on production-index DBFs");

    const auto flagged_recall = copperfin::vfp::set_record_deleted_flag(flagged_table_path.string(), 0U, false);
    expect(!flagged_recall.ok, "set_record_deleted_flag should reject RECALL-style writes on production-index DBFs");

    expect(read_binary_file(flagged_table_path) == flagged_original, "production-index rejection should leave the DBF bytes unchanged");

    const fs::path companion_table_path = temp_dir / "companion.dbf";
    const fs::path companion_cdx_path = temp_dir / "companion.cdx";
    write_people_table(companion_table_path, 0x00U);
    {
        std::ofstream output(companion_cdx_path, std::ios::binary);
        output << "synthetic companion index";
    }
    const auto companion_original = read_binary_file(companion_table_path);

    const auto companion_append = copperfin::vfp::append_blank_record_to_file(companion_table_path.string());
    expect(!companion_append.ok, "append_blank_record_to_file should reject DBFs with a same-base companion CDX");
    expect(companion_append.error.find("Indexed DBF mutation") != std::string::npos, "companion-CDX rejection should mention indexed DBF mutation");
    expect(read_binary_file(companion_table_path) == companion_original, "companion-CDX rejection should leave the DBF bytes unchanged");

    fs::remove_all(temp_dir, ignored);
}

void test_integer_field_create_replace_and_append_round_trip() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_integer_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "numbers.dbf";
    const std::vector<copperfin::vfp::DbfFieldDescriptor> fields{
        {.name = "NAME", .type = 'C', .length = 10U},
        {.name = "COUNT", .type = 'I', .length = 4U}
    };
    const std::vector<std::vector<std::string>> records{
        {"ALPHA", "10"},
        {"BRAVO", "-20"}
    };

    const auto create_result = copperfin::vfp::create_dbf_table_file(table_path.string(), fields, records);
    expect(create_result.ok, "create_dbf_table_file should support Integer (I) fields");

    auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "Integer-backed DBFs should remain readable after creation");
    expect(parse_result.table.records.size() == 2U, "Integer-backed DBFs should expose created rows");
    if (parse_result.table.records.size() == 2U) {
        expect(parse_result.table.records[0].values[1].display_value == "10", "created Integer fields should round-trip positive values");
        expect(parse_result.table.records[1].values[1].display_value == "-20", "created Integer fields should round-trip negative values");
    }

    const auto replace_result = copperfin::vfp::replace_record_field_value(table_path.string(), 1U, "COUNT", "21");
    expect(replace_result.ok, "replace_record_field_value should support Integer (I) fields");

    const auto append_result = copperfin::vfp::append_blank_record_to_file(table_path.string());
    expect(append_result.ok, "append_blank_record_to_file should support Integer (I) fields");
    expect(append_result.record_count == 3U, "Integer-backed append_blank_record_to_file should grow the record count");

    parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "Integer-backed DBFs should remain readable after mutation");
    expect(parse_result.table.records.size() == 3U, "Integer-backed DBFs should expose appended rows");
    if (parse_result.table.records.size() == 3U) {
        expect(parse_result.table.records[1].values[1].display_value == "21", "Integer field replacements should persist");
        expect(parse_result.table.records[2].values[0].display_value.empty(), "blank appended character fields beside Integer fields should start empty");
        expect(parse_result.table.records[2].values[1].display_value == "0", "blank appended Integer fields should initialize to zero");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_currency_and_datetime_field_round_trip() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_currency_datetime_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "ledger.dbf";
    const std::vector<copperfin::vfp::DbfFieldDescriptor> fields{
        {.name = "NAME", .type = 'C', .length = 10U},
        {.name = "BALANCE", .type = 'Y', .length = 8U},
        {.name = "STAMP", .type = 'T', .length = 8U}
    };
    const std::vector<std::vector<std::string>> records{
        {"ALPHA", "123.4500", "julian:2460401 millis:12345"},
        {"BRAVO", "-2.5000", "julian:2460402 millis:67890"}
    };

    const auto create_result = copperfin::vfp::create_dbf_table_file(table_path.string(), fields, records);
    expect(create_result.ok, "create_dbf_table_file should support Currency (Y) and DateTime (T) fields");

    auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "Currency/DateTime-backed DBFs should remain readable after creation");
    expect(parse_result.table.records.size() == 2U, "Currency/DateTime-backed DBFs should expose created rows");
    if (parse_result.table.records.size() == 2U) {
        expect(parse_result.table.records[0].values[1].display_value == "123.4500", "created Currency fields should preserve four-decimal formatting");
        expect(parse_result.table.records[0].values[2].display_value == "julian:2460401 millis:12345", "created DateTime fields should round-trip through the shared storage contract");
        expect(parse_result.table.records[1].values[1].display_value == "-2.5000", "negative Currency fields should round-trip");
    }

    const auto replace_currency = copperfin::vfp::replace_record_field_value(table_path.string(), 1U, "BALANCE", "42.0001");
    expect(replace_currency.ok, "replace_record_field_value should support Currency (Y) fields");

    const auto replace_datetime = copperfin::vfp::replace_record_field_value(table_path.string(), 1U, "STAMP", "julian:2460403 millis:222");
    expect(replace_datetime.ok, "replace_record_field_value should support DateTime (T) fields");

    const auto append_result = copperfin::vfp::append_blank_record_to_file(table_path.string());
    expect(append_result.ok, "append_blank_record_to_file should support Currency/DateTime-backed tables");
    expect(append_result.record_count == 3U, "Currency/DateTime append_blank_record_to_file should grow the record count");

    parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 5U);
    expect(parse_result.ok, "Currency/DateTime-backed DBFs should remain readable after mutation");
    expect(parse_result.table.records.size() == 3U, "Currency/DateTime-backed DBFs should expose appended rows");
    if (parse_result.table.records.size() == 3U) {
        expect(parse_result.table.records[1].values[1].display_value == "42.0001", "Currency field replacements should persist");
        expect(parse_result.table.records[1].values[2].display_value == "julian:2460403 millis:222", "DateTime field replacements should persist");
        expect(parse_result.table.records[2].values[1].display_value == "0.0000", "blank appended Currency fields should initialize to zero");
        expect(parse_result.table.records[2].values[2].display_value == "julian:0 millis:0", "blank appended DateTime fields should initialize to zero storage");
    }

    fs::remove_all(temp_dir, ignored);
}

void test_append_blank_rejects_unsupported_field_layouts_without_changing_file() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_append_guard_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "unsupported.dbf";
    std::vector<std::uint8_t> table_bytes(97U + 9U + 1U, 0U);
    table_bytes[0] = 0x30U;
    write_le_u32(table_bytes, 4U, 1U);
    write_le_u16(table_bytes, 8U, 65U);
    write_le_u16(table_bytes, 10U, 9U);

    write_field_descriptor(table_bytes, 32U, "VALUE", 'B', 1U, 8U);
    table_bytes[64U] = 0x0DU;
    table_bytes[65U] = 0x20U;
    write_ascii(table_bytes, 66U, "12345678");
    table_bytes.back() = 0x1AU;

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    const auto original_bytes = read_binary_file(table_path);
    const auto append_result = copperfin::vfp::append_blank_record_to_file(table_path.string());
    expect(!append_result.ok, "append_blank_record_to_file should reject unsupported binary field layouts");
    expect(append_result.error.find("APPEND BLANK is not yet supported") != std::string::npos, "unsupported APPEND BLANK rejection should mention unsupported field types");
    expect(read_binary_file(table_path) == original_bytes, "unsupported APPEND BLANK rejection should leave the DBF bytes unchanged");

    fs::remove_all(temp_dir, ignored);
}

void test_parse_dbf_table_rejects_truncated_visual_asset() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_asset_validation_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "broken.scx";
    std::vector<std::uint8_t> table_bytes(32U, 0U);
    table_bytes[0] = 0x30U;
    write_le_u32(table_bytes, 4U, 1U);
    write_le_u16(table_bytes, 8U, 97U);
    write_le_u16(table_bytes, 10U, 13U);

    {
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(table_bytes.data()), static_cast<std::streamsize>(table_bytes.size()));
    }

    const auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 1U);
    expect(!parse_result.ok, "parse_dbf_table_from_file should reject truncated visual assets");
    expect(parse_result.error == "Table file is shorter than its header length.", "truncated visual assets should report a header-length validation error");

    fs::remove_all(temp_dir, ignored);
}

void test_visual_asset_memo_sidecar_repair_round_trip() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() /
        ("copperfin_dbf_table_asset_repair_tests_" + std::to_string(_getpid()));
    std::error_code ignored;
    fs::remove_all(temp_dir, ignored);
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "designer.scx";
    const fs::path memo_path = temp_dir / "designer.sct";
    const std::vector<copperfin::vfp::DbfFieldDescriptor> fields{
        {.name = "OBJNAME", .type = 'C', .length = 12U},
        {.name = "PROPERTIES", .type = 'M', .length = 4U}
    };
    const std::vector<std::vector<std::string>> records{
        {"txtTitle", "Left = 10\r\nTop = 20\r\n"}
    };

    const auto create_result = copperfin::vfp::create_dbf_table_file(table_path.string(), fields, records);
    expect(create_result.ok, "create_dbf_table_file should support SCX/SCT-style memo assets");
    expect(fs::exists(memo_path), "SCX-backed table creation should emit the SCT sidecar");

    auto parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 1U);
    expect(parse_result.ok, "synthetic SCX/SCT assets should parse before repair");
    if (parse_result.ok && parse_result.table.records.size() == 1U && parse_result.table.records[0].values.size() >= 2U) {
        expect(parse_result.table.records[0].values[1].display_value.find("Left = 10") != std::string::npos,
               "synthetic SCX/SCT assets should round-trip the initial memo payload");
    }

    {
        std::vector<std::uint8_t> broken_memo(8U, 0U);
        std::ofstream output(memo_path, std::ios::binary | std::ios::trunc);
        output.write(reinterpret_cast<const char*>(broken_memo.data()), static_cast<std::streamsize>(broken_memo.size()));
    }

    const auto replace_result = copperfin::vfp::replace_record_field_value(
        table_path.string(),
        0U,
        "PROPERTIES",
        "Left = 25\r\nTop = 20\r\nWidth = 40\r\n");
    expect(replace_result.ok, "replace_record_field_value should repair an invalid SCT sidecar while updating memo-backed asset fields");

    parse_result = copperfin::vfp::parse_dbf_table_from_file(table_path.string(), 1U);
    expect(parse_result.ok, "synthetic SCX/SCT assets should parse after memo-sidecar repair");
    if (parse_result.ok && parse_result.table.records.size() == 1U && parse_result.table.records[0].values.size() >= 2U) {
        expect(parse_result.table.records[0].values[1].display_value.find("Left = 25") != std::string::npos,
               "memo-sidecar repair should preserve the updated asset memo payload");
        expect(parse_result.table.records[0].values[1].display_value.find("Width = 40") != std::string::npos,
               "memo-sidecar repair should keep the rewritten multi-line asset memo content readable");
    }

    const auto repaired_memo_bytes = read_binary_file(memo_path);
    expect(repaired_memo_bytes.size() >= 1024U, "memo-sidecar repair should rebuild a valid SCT allocation block");

    fs::remove_all(temp_dir, ignored);
}

}  // namespace

int main() {
    test_parse_dbf_table_with_memo_sidecar();
    test_mutate_and_append_dbf_table();
    test_create_dbf_table_file_round_trips();
    test_memo_field_create_replace_and_append_round_trip();
    test_indexed_table_mutations_fail_fast_without_changing_files();
    test_integer_field_create_replace_and_append_round_trip();
    test_currency_and_datetime_field_round_trip();
    test_append_blank_rejects_unsupported_field_layouts_without_changing_file();
    test_parse_dbf_table_rejects_truncated_visual_asset();
    test_visual_asset_memo_sidecar_repair_round_trip();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
