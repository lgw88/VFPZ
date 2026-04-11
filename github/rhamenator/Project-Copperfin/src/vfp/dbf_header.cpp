#include "copperfin/vfp/dbf_header.h"

#include <filesystem>
#include <fstream>
#include <sstream>

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

std::string two_digit(std::uint8_t value) {
    std::ostringstream stream;
    if (value < 10U) {
        stream << '0';
    }
    stream << static_cast<unsigned int>(value);
    return stream.str();
}

}  // namespace

bool DbfHeader::looks_like_dbf() const {
    return header_length >= 32U && record_length > 0U;
}

bool DbfHeader::has_database_container() const {
    return (table_flags & 0x04U) != 0U;
}

bool DbfHeader::has_production_index() const {
    return (table_flags & 0x01U) != 0U;
}

bool DbfHeader::has_structural_cdx() const {
    return has_production_index();
}

bool DbfHeader::has_memo_file() const {
    return version == 0x83U || version == 0x8BU || version == 0xF5U;
}

std::string DbfHeader::version_description() const {
    switch (version) {
        case 0x02U:
            return "FoxBASE";
        case 0x03U:
            return "dBASE III or compatible";
        case 0x30U:
            return "Visual FoxPro";
        case 0x31U:
            return "Visual FoxPro with autoincrement";
        case 0x32U:
            return "Visual FoxPro varbinary/varchar";
        case 0x43U:
            return "dBASE IV SQL table";
        case 0x63U:
            return "dBASE IV system file";
        case 0x83U:
            return "dBASE III with memo";
        case 0x8BU:
            return "dBASE IV with memo";
        case 0xCBU:
            return "dBASE IV with memo and SQL";
        case 0xF5U:
            return "FoxPro with memo";
        default:
            return "Unknown";
    }
}

std::string DbfHeader::last_update_iso8601() const {
    const unsigned int year = 1900U + static_cast<unsigned int>(last_update_year);
    std::ostringstream stream;
    stream << year << '-' << two_digit(last_update_month) << '-' << two_digit(last_update_day);
    return stream.str();
}

DbfParseResult parse_dbf_header(const std::vector<std::uint8_t>& bytes) {
    if (bytes.size() < 32U) {
        return {.ok = false, .error = "File is smaller than the minimum DBF header size (32 bytes)."};
    }

    DbfHeader header;
    header.version = bytes[0];
    header.last_update_year = bytes[1];
    header.last_update_month = bytes[2];
    header.last_update_day = bytes[3];
    header.record_count = read_le_u32(bytes, 4U);
    header.header_length = read_le_u16(bytes, 8U);
    header.record_length = read_le_u16(bytes, 10U);
    header.table_flags = bytes[28];
    header.code_page_mark = bytes[29];

    if (!header.looks_like_dbf()) {
        return {.ok = false, .header = header, .error = "Header values do not look like a DBF-family file."};
    }

    return {.ok = true, .header = header};
}

DbfParseResult parse_dbf_header_from_file(const std::string& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) {
        return {.ok = false, .error = "Unable to open file."};
    }

    std::vector<std::uint8_t> bytes(32U, 0U);
    input.read(reinterpret_cast<char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));

    if (input.gcount() < static_cast<std::streamsize>(bytes.size())) {
        return {.ok = false, .error = "Unable to read a complete 32-byte header."};
    }

    return parse_dbf_header(bytes);
}

}  // namespace copperfin::vfp
