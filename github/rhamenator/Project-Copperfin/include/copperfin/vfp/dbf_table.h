#pragma once

#include "copperfin/vfp/dbf_header.h"

#include <cstdint>
#include <string>
#include <vector>

namespace copperfin::vfp {

struct DbfFieldDescriptor {
    std::string name;
    char type = '\0';
    std::uint32_t offset = 0;
    std::uint8_t length = 0;
    std::uint8_t decimal_count = 0;
};

struct DbfRecordValue {
    std::string field_name;
    char field_type = '\0';
    bool is_null = false;
    std::string display_value;
};

struct DbfRecord {
    std::size_t record_index = 0;
    bool deleted = false;
    std::vector<DbfRecordValue> values;
};

struct DbfTable {
    DbfHeader header{};
    std::vector<DbfFieldDescriptor> fields;
    std::vector<DbfRecord> records;
};

struct DbfTableParseResult {
    bool ok = false;
    DbfTable table{};
    std::string error;
};

struct DbfWriteResult {
    bool ok = false;
    std::string error;
    std::size_t record_count = 0;
};

DbfTableParseResult parse_dbf_table_from_file(const std::string& path, std::size_t max_records = 10U);
DbfWriteResult create_dbf_table_file(
    const std::string& path,
    const std::vector<DbfFieldDescriptor>& fields,
    const std::vector<std::vector<std::string>>& records);
DbfWriteResult append_blank_record_to_file(const std::string& path);
DbfWriteResult replace_record_field_value(
    const std::string& path,
    std::size_t record_index,
    const std::string& field_name,
    const std::string& value);
DbfWriteResult set_record_deleted_flag(
    const std::string& path,
    std::size_t record_index,
    bool deleted);

}  // namespace copperfin::vfp
