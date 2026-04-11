#include "copperfin/vfp/asset_inspector.h"
#include "copperfin/vfp/dbf_header.h"
#include "copperfin/vfp/index_probe.h"

#include <cstdint>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
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

std::vector<std::uint8_t> make_vfp_header() {
    std::vector<std::uint8_t> bytes(32U, 0U);
    bytes[0] = 0x30U;
    bytes[1] = 126U;
    bytes[2] = 4U;
    bytes[3] = 7U;
    bytes[4] = 10U;
    bytes[8] = 0xA1U;
    bytes[9] = 0x00U;
    bytes[10] = 0x40U;
    bytes[11] = 0x00U;
    bytes[28] = 0x05U;
    bytes[29] = 0x03U;
    return bytes;
}

void write_le_u16(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint16_t value);
void write_le_u32(std::vector<std::uint8_t>& bytes, std::size_t offset, std::uint32_t value);
void write_ascii(std::vector<std::uint8_t>& bytes, std::size_t offset, const std::string& value);

std::vector<std::uint8_t> make_synthetic_cdx_family_bytes(bool include_second_tag, bool include_for_expression) {
    std::vector<std::uint8_t> bytes(16U * 512U, 0U);
    bytes[0] = 0x00U;
    bytes[1] = 0x04U;
    bytes[12] = 0x0AU;
    bytes[14] = 0xE0U;
    bytes[15] = 0x01U;
    bytes[1024U] = 0x03U;
    write_le_u16(bytes, 1026U, include_second_tag ? 2U : 1U);

    if (include_second_tag) {
        write_ascii(bytes, (3U * 512U) - 20U, "CUSTOMER_I");
        write_ascii(bytes, (3U * 512U) - 10U, "COMPANY_NA");
        write_ascii(bytes, 4U * 512U, "UPPER(company_name)");
        write_ascii(bytes, 11U * 512U, "customer_id");
    } else {
        write_ascii(bytes, (3U * 512U) - 10U, "NAME");
        write_ascii(bytes, 4U * 512U, "UPPER(NAME)");
    }

    if (include_for_expression) {
        write_ascii(bytes, 5U * 512U, "DELETED() = .F.");
    }

    return bytes;
}

void test_parse_dbf_header() {
    const auto bytes = make_vfp_header();
    const auto result = copperfin::vfp::parse_dbf_header(bytes);

    expect(result.ok, "parse_dbf_header should succeed for a valid synthetic header");
    expect(result.header.version == 0x30U, "version should be parsed");
    expect(result.header.record_count == 10U, "record_count should be parsed");
    expect(result.header.header_length == 161U, "header_length should be parsed");
    expect(result.header.record_length == 64U, "record_length should be parsed");
    expect(result.header.has_structural_cdx(), "structural CDX flag should be detected");
    expect(result.header.has_database_container(), "database container flag should be detected");
    expect(result.header.version_description() == "Visual FoxPro", "version description should match Visual FoxPro");
    expect(result.header.last_update_iso8601() == "2026-04-07", "last update date should be formatted as ISO 8601");
}

void test_parse_dbf_header_rejects_short_input() {
    const auto result = copperfin::vfp::parse_dbf_header({0x30U, 0x00U});
    expect(!result.ok, "parse_dbf_header should reject short input");
}

void test_asset_family_detection() {
    using copperfin::vfp::AssetFamily;
    using copperfin::vfp::asset_family_from_path;

    expect(asset_family_from_path("sample.pjx") == AssetFamily::project, "PJX should map to project");
    expect(asset_family_from_path("sample.scx") == AssetFamily::form, "SCX should map to form");
    expect(asset_family_from_path("sample.vcx") == AssetFamily::class_library, "VCX should map to class library");
    expect(asset_family_from_path("sample.frx") == AssetFamily::report, "FRX should map to report");
    expect(asset_family_from_path("sample.lbx") == AssetFamily::label, "LBX should map to label");
    expect(asset_family_from_path("sample.mnx") == AssetFamily::menu, "MNX should map to menu");
    expect(asset_family_from_path("sample.cdx") == AssetFamily::index, "CDX should map to index");
    expect(asset_family_from_path("sample.idx") == AssetFamily::index, "IDX should map to index");
    expect(asset_family_from_path("sample.ndx") == AssetFamily::index, "NDX should map to index");
    expect(asset_family_from_path("sample.mdx") == AssetFamily::index, "MDX should map to index");
    expect(asset_family_from_path("sample.prg") == AssetFamily::program, "PRG should map to program");
    expect(asset_family_from_path("sample.h") == AssetFamily::header, "H should map to header");
    expect(asset_family_from_path("sample.xyz") == AssetFamily::unknown, "unknown extension should stay unknown");
}

void test_parse_index_probe_for_cdx() {
    const auto bytes = make_synthetic_cdx_family_bytes(true, true);

    const auto result = copperfin::vfp::parse_index_probe(bytes, 16U * 512U, copperfin::vfp::IndexKind::cdx);
    expect(result.ok, "parse_index_probe should succeed for a plausible synthetic CDX header");
    expect(result.probe.root_node_offset_hint == 1024U, "CDX root node offset should be parsed");
    expect(result.probe.key_length_hint == 10U, "CDX key length hint should be parsed");
    expect(result.probe.group_length_hint == 480U, "CDX key pool length hint should be parsed");
    expect(result.probe.multi_tag, "CDX should be treated as multi-tag");
    expect(result.probe.tags.size() == 2U, "CDX probe should enumerate tags from directory leaf pages");
    expect(result.probe.for_expression_hint == "DELETED() = .F.", "CDX probe should surface the first tag FOR expression");
    if (result.probe.tags.size() >= 2U) {
        expect(result.probe.tags[0].name_hint == "CUSTOMER_I", "directory leaf parsing should preserve the first stored tag name");
        expect(
            result.probe.tags[0].key_expression_hint == "customer_id",
            "directory tag names should still bind to the matching plain-field expression");
        expect(result.probe.tags[0].for_expression_hint.empty(), "tags should not borrow FOR expressions from a different key-expression span");
        expect(!result.probe.tags[0].inferred_name, "directory-derived tag names should not be marked as inferred");
        expect(result.probe.tags[1].name_hint == "COMPANY_NA", "directory leaf parsing should preserve the second stored tag name");
        expect(
            result.probe.tags[1].key_expression_hint == "UPPER(company_name)",
            "directory tag names should still bind to the matching functional expression");
        expect(
            result.probe.tags[1].for_expression_hint == "DELETED() = .F.",
            "page-local FOR expressions should attach to the matching CDX tag");
        expect(!result.probe.tags[1].inferred_name, "directory-derived tag names should not be marked as inferred");
    }
}

void test_parse_index_probe_for_dcx() {
    const auto bytes = make_synthetic_cdx_family_bytes(false, true);

    const auto result = copperfin::vfp::parse_index_probe(bytes, 16U * 512U, copperfin::vfp::IndexKind::dcx);
    expect(result.ok, "parse_index_probe should succeed for a plausible synthetic DCX header");
    expect(result.probe.kind == copperfin::vfp::IndexKind::dcx, "DCX probe kind should be preserved");
    expect(result.probe.multi_tag, "DCX should be treated as multi-tag");
    expect(!result.probe.production_candidate, "DCX should not be flagged as a table production index");
    expect(result.probe.tags.size() == 1U, "DCX probe should reuse the shared CDX-family tag parser");
    if (!result.probe.tags.empty()) {
        expect(result.probe.tags.front().name_hint == "NAME", "DCX probe should preserve the stored tag name");
        expect(result.probe.tags.front().key_expression_hint == "UPPER(NAME)", "DCX probe should expose the key expression hint");
        expect(result.probe.tags.front().for_expression_hint == "DELETED() = .F.", "DCX probe should expose the FOR expression hint");
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

void write_ascii(std::vector<std::uint8_t>& bytes, std::size_t offset, const std::string& value) {
    for (std::size_t index = 0; index < value.size(); ++index) {
        bytes[offset + index] = static_cast<std::uint8_t>(value[index]);
    }
}

void test_parse_index_probe_for_idx() {
    std::vector<std::uint8_t> bytes(512U, 0U);
    write_le_u32(bytes, 0U, 512U);
    write_le_u32(bytes, 4U, 0xFFFFFFFFU);
    write_le_u32(bytes, 8U, 1024U);
    write_le_u16(bytes, 12U, 10U);
    bytes[14] = 0x01U;
    write_ascii(bytes, 16U, "UPPER(NAME)");
    write_ascii(bytes, 236U, "DELETED() = .F.");

    const auto result = copperfin::vfp::parse_index_probe(bytes, 1024U, copperfin::vfp::IndexKind::idx);
    expect(result.ok, "parse_index_probe should succeed for a plausible Visual FoxPro IDX header");
    expect(result.probe.kind == copperfin::vfp::IndexKind::idx, "IDX probe kind should be preserved");
    expect(result.probe.root_node_offset_hint == 512U, "IDX root node offset should be parsed");
    expect(result.probe.end_of_file_offset_hint == 1024U, "IDX end-of-file offset should be parsed");
    expect(result.probe.key_length_hint == 10U, "IDX key length should be parsed");
    expect(result.probe.key_expression_hint == "UPPER(NAME)", "IDX key expression should be extracted");
    expect(result.probe.for_expression_hint == "DELETED() = .F.", "IDX FOR expression should be extracted");
}

void test_parse_index_probe_for_ndx() {
    std::vector<std::uint8_t> bytes(512U, 0U);
    write_le_u32(bytes, 0U, 1U);
    write_le_u32(bytes, 4U, 2U);
    write_le_u16(bytes, 12U, 2U);
    write_le_u16(bytes, 14U, 42U);
    write_le_u16(bytes, 18U, 12U);
    write_le_u16(bytes, 22U, 1U);
    write_ascii(bytes, 24U, "CODE");

    const auto result = copperfin::vfp::parse_index_probe(bytes, 1024U, copperfin::vfp::IndexKind::ndx);
    expect(result.ok, "parse_index_probe should succeed for a plausible dBase NDX header");
    expect(result.probe.kind == copperfin::vfp::IndexKind::ndx, "NDX probe kind should be preserved");
    expect(result.probe.root_node_offset_hint == 512U, "NDX root block should convert to a byte offset");
    expect(result.probe.end_of_file_offset_hint == 1024U, "NDX EOF block should convert to a byte offset");
    expect(result.probe.max_keys_hint == 42U, "NDX max keys should be parsed");
    expect(result.probe.group_length_hint == 12U, "NDX group length should be parsed");
    expect(result.probe.flags == 0x01U, "NDX uniqueness flag should be projected into flags");
    expect(result.probe.key_expression_hint == "CODE", "NDX expression should be extracted");
}

void test_parse_index_probe_for_mdx() {
    std::vector<std::uint8_t> bytes(1024U, 0U);
    write_ascii(bytes, 512U, "NAME_TAG");
    write_ascii(bytes, 640U, "CITYSTATE");

    const auto result = copperfin::vfp::parse_index_probe(bytes, 1024U, copperfin::vfp::IndexKind::mdx);
    expect(result.ok, "parse_index_probe should succeed for a plausible dBase MDX file");
    expect(result.probe.kind == copperfin::vfp::IndexKind::mdx, "MDX probe kind should be preserved");
    expect(result.probe.multi_tag, "MDX should be treated as multi-tag");
    expect(result.probe.production_candidate, "MDX should be treated as a production index candidate");
    expect(result.probe.tags.size() == 2U, "MDX probe should enumerate first-pass tag hints");
    if (result.probe.tags.size() >= 2U) {
        expect(result.probe.tags[0].name_hint == "NAME_TAG", "MDX probe should expose the first tag hint");
        expect(result.probe.tags[1].name_hint == "CITYSTATE", "MDX probe should expose the second tag hint");
    }
}

void test_inspect_asset_collects_companion_indexes() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() / "copperfin_vfp_assets_tests";
    fs::create_directories(temp_dir);

    const fs::path table_path = temp_dir / "sample.dbf";
    const fs::path cdx_path = temp_dir / "sample.cdx";
    const fs::path ndx_path = temp_dir / "sample.ndx";
    const fs::path mdx_path = temp_dir / "sample.mdx";

    {
        auto bytes = make_vfp_header();
        std::ofstream output(table_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    {
        const auto bytes = make_synthetic_cdx_family_bytes(false, true);
        std::ofstream output(cdx_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    {
        std::vector<std::uint8_t> bytes(1024U, 0U);
        write_le_u32(bytes, 0U, 1U);
        write_le_u32(bytes, 4U, 2U);
        write_le_u16(bytes, 12U, 2U);
        write_le_u16(bytes, 14U, 42U);
        write_le_u16(bytes, 18U, 12U);
        write_ascii(bytes, 24U, "CODE");

        std::ofstream output(ndx_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    {
        std::vector<std::uint8_t> bytes(1024U, 0U);
        write_ascii(bytes, 512U, "NAME_TAG");
        write_ascii(bytes, 640U, "CITYSTATE");
        std::ofstream output(mdx_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    const auto result = copperfin::vfp::inspect_asset(table_path.string());
    expect(result.ok, "inspect_asset should succeed for a synthetic DBF with companion indexes");
    expect(result.header_available, "inspect_asset should expose the DBF header");
    expect(result.indexes.size() == 3U, "inspect_asset should collect same-base CDX, NDX, and MDX companions");

    bool saw_cdx = false;
    bool saw_ndx = false;
    bool saw_mdx = false;
    for (const auto& index : result.indexes) {
        saw_cdx = saw_cdx || index.probe.kind == copperfin::vfp::IndexKind::cdx;
        saw_ndx = saw_ndx || index.probe.kind == copperfin::vfp::IndexKind::ndx;
        saw_mdx = saw_mdx || index.probe.kind == copperfin::vfp::IndexKind::mdx;
        if (index.probe.kind == copperfin::vfp::IndexKind::cdx) {
            expect(!index.probe.tags.empty(), "inspect_asset should parse CDX companion tags");
            if (!index.probe.tags.empty()) {
                expect(index.probe.tags.front().name_hint == "NAME", "inspect_asset should expose the real CDX tag name");
                expect(index.probe.tags.front().key_expression_hint == "UPPER(NAME)", "inspect_asset should expose the CDX expression hint");
                expect(index.probe.tags.front().for_expression_hint == "DELETED() = .F.", "inspect_asset should expose the CDX FOR expression hint");
            }
        }
        if (index.probe.kind == copperfin::vfp::IndexKind::mdx) {
            expect(index.probe.tags.size() == 2U, "inspect_asset should expose first-pass MDX tag hints");
            if (index.probe.tags.size() >= 2U) {
                expect(index.probe.tags[0].name_hint == "NAME_TAG", "inspect_asset should expose the first MDX tag hint");
                expect(index.probe.tags[1].name_hint == "CITYSTATE", "inspect_asset should expose the second MDX tag hint");
            }
        }
    }

    expect(saw_cdx, "inspect_asset should identify CDX companions");
    expect(saw_ndx, "inspect_asset should identify NDX companions");
    expect(saw_mdx, "inspect_asset should identify MDX companions");

    std::error_code ignored;
    fs::remove(table_path, ignored);
    fs::remove(cdx_path, ignored);
    fs::remove(ndx_path, ignored);
    fs::remove(mdx_path, ignored);
    fs::remove(temp_dir, ignored);
}

void test_inspect_database_container_collects_dcx_companion() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() / "copperfin_vfp_dbc_assets_tests";
    fs::create_directories(temp_dir);

    const fs::path dbc_path = temp_dir / "sample.dbc";
    const fs::path dcx_path = temp_dir / "sample.dcx";

    {
        auto bytes = make_vfp_header();
        std::ofstream output(dbc_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    {
        const auto bytes = make_synthetic_cdx_family_bytes(false, true);
        std::ofstream output(dcx_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    const auto result = copperfin::vfp::inspect_asset(dbc_path.string());
    expect(result.ok, "inspect_asset should succeed for a synthetic DBC with a companion DCX");
    expect(result.header_available, "inspect_asset should expose the DBC header");
    expect(result.indexes.size() == 1U, "inspect_asset should collect the same-base DCX companion");
    if (result.indexes.size() == 1U) {
        expect(result.indexes.front().probe.kind == copperfin::vfp::IndexKind::dcx, "DBC companion probe should stay typed as DCX");
        expect(!result.indexes.front().probe.tags.empty(), "DBC companion inspection should parse DCX tags");
        if (!result.indexes.front().probe.tags.empty()) {
            expect(result.indexes.front().probe.tags.front().name_hint == "NAME", "DBC companion inspection should expose the DCX tag name");
            expect(result.indexes.front().probe.tags.front().key_expression_hint == "UPPER(NAME)", "DBC companion inspection should expose the DCX key expression");
        }
    }

    std::error_code ignored;
    fs::remove(dbc_path, ignored);
    fs::remove(dcx_path, ignored);
    fs::remove(temp_dir, ignored);
}

void test_parse_real_vfp_cdx_when_available() {
    const std::filesystem::path sample_path =
        "C:\\Program Files (x86)\\Microsoft Visual FoxPro 9\\Samples\\Tastrade\\Data\\customer.cdx";
    if (!std::filesystem::exists(sample_path)) {
        return;
    }

    const auto result = copperfin::vfp::parse_index_probe_from_file(sample_path.string());
    expect(result.ok, "real VFP customer.cdx should parse as a CDX-family index");
    expect(result.probe.kind == copperfin::vfp::IndexKind::cdx, "real VFP customer.cdx should stay typed as CDX");
    expect(!result.probe.tags.empty(), "real VFP customer.cdx should expose at least one parsed tag");

    bool saw_customer_id = false;
    bool saw_company_name = false;
    bool saw_customer_tag = false;
    bool saw_company_tag = false;
    for (const auto& tag : result.probe.tags) {
        saw_customer_id = saw_customer_id || tag.key_expression_hint == "customer_id";
        saw_company_name = saw_company_name || tag.key_expression_hint == "UPPER(company_name)";
        saw_customer_tag = saw_customer_tag || tag.name_hint == "CUSTOMER_I";
        saw_company_tag = saw_company_tag || tag.name_hint == "COMPANY_NA";
    }

    expect(saw_customer_id, "real VFP customer.cdx should expose the customer_id expression");
    expect(saw_company_name, "real VFP customer.cdx should expose the UPPER(company_name) expression");
    expect(saw_customer_tag, "real VFP customer.cdx should expose the CUSTOMER_I tag from directory pages");
    expect(saw_company_tag, "real VFP customer.cdx should expose the COMPANY_NA tag from directory pages");
}

}  // namespace

int main() {
    test_parse_dbf_header();
    test_parse_dbf_header_rejects_short_input();
    test_asset_family_detection();
    test_parse_index_probe_for_cdx();
    test_parse_index_probe_for_dcx();
    test_parse_index_probe_for_idx();
    test_parse_index_probe_for_ndx();
    test_parse_index_probe_for_mdx();
    test_inspect_asset_collects_companion_indexes();
    test_inspect_database_container_collects_dcx_companion();
    test_parse_real_vfp_cdx_when_available();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
