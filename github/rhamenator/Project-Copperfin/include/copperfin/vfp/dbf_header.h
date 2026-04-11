#pragma once

#include <array>
#include <cstdint>
#include <string>
#include <vector>

namespace copperfin::vfp {

struct DbfHeader {
    std::uint8_t version = 0;
    std::uint8_t last_update_year = 0;
    std::uint8_t last_update_month = 0;
    std::uint8_t last_update_day = 0;
    std::uint32_t record_count = 0;
    std::uint16_t header_length = 0;
    std::uint16_t record_length = 0;
    std::uint8_t table_flags = 0;
    std::uint8_t code_page_mark = 0;

    [[nodiscard]] bool looks_like_dbf() const;
    [[nodiscard]] bool has_database_container() const;
    [[nodiscard]] bool has_production_index() const;
    [[nodiscard]] bool has_structural_cdx() const;
    [[nodiscard]] bool has_memo_file() const;
    [[nodiscard]] std::string version_description() const;
    [[nodiscard]] std::string last_update_iso8601() const;
};

struct DbfParseResult {
    bool ok = false;
    DbfHeader header{};
    std::string error;
};

DbfParseResult parse_dbf_header(const std::vector<std::uint8_t>& bytes);
DbfParseResult parse_dbf_header_from_file(const std::string& path);

}  // namespace copperfin::vfp
