#include "copperfin/studio/document_model.h"
#include "copperfin/studio/vs_launch_contract.h"

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
    bytes[8] = 0xA1U;
    bytes[9] = 0x00U;
    bytes[10] = 0x40U;
    bytes[11] = 0x00U;
    bytes[28] = 0x01U;
    bytes[29] = 0x03U;
    return bytes;
}

void test_parse_launch_arguments() {
    const auto result = copperfin::studio::parse_launch_arguments({
        "--path", "E:\\Forms\\customer.scx",
        "--from-vs",
        "--read-only",
        "--json",
        "--set-property",
        "--record", "3",
        "--property-name", "Left",
        "--property-value", "25",
        "--line", "25",
        "--column", "7",
        "--symbol", "cmdSave.Click"
    });

    expect(result.ok, "launch contract should parse a complete Visual Studio launch request");
    expect(result.request.path == "E:\\Forms\\customer.scx", "launch path should be captured");
    expect(result.request.launched_from_visual_studio, "launch contract should detect --from-vs");
    expect(result.request.read_only, "launch contract should detect --read-only");
    expect(result.output_json, "launch contract should detect --json");
    expect(result.request.apply_property_update, "launch contract should detect --set-property");
    expect(result.request.record_index == 3U, "launch contract should parse the record index");
    expect(result.request.property_name == "Left", "launch contract should capture the property name");
    expect(result.request.property_value == "25", "launch contract should capture the property value");
    expect(result.request.line == 25U, "launch contract should parse the line value");
    expect(result.request.column == 7U, "launch contract should parse the column value");
    expect(result.request.symbol == "cmdSave.Click", "launch contract should parse the symbol");
}

void test_parse_launch_arguments_rejects_unknown_switch() {
    const auto result = copperfin::studio::parse_launch_arguments({"--mystery"});
    expect(!result.ok, "launch contract should reject unknown switches");
}

void test_open_document_infers_form_sidecar() {
    namespace fs = std::filesystem;
    const fs::path temp_dir = fs::temp_directory_path() / "copperfin_studio_host_tests";
    fs::create_directories(temp_dir);

    const fs::path form_path = temp_dir / "customer.scx";
    const fs::path sidecar_path = temp_dir / "customer.sct";

    {
        const auto bytes = make_vfp_header();
        std::ofstream output(form_path, std::ios::binary);
        output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()));
    }

    {
        std::ofstream output(sidecar_path, std::ios::binary);
        output << "memo-sidecar";
    }

    const copperfin::studio::StudioOpenRequest request{
        .path = form_path.string(),
        .symbol = "form1",
        .line = 10U,
        .column = 2U,
        .launched_from_visual_studio = true,
        .read_only = false
    };

    const auto result = copperfin::studio::open_document(request);
    expect(result.ok, "open_document should succeed for a valid synthetic SCX file");
    expect(result.document.kind == copperfin::studio::StudioAssetKind::form, "SCX should map to a form document");
    expect(result.document.display_name == "customer.scx", "document display name should use the file name");
    expect(result.document.has_sidecar, "open_document should detect the SCT sidecar");
    expect(result.document.sidecar_path == sidecar_path.string(), "open_document should infer the SCT sidecar path");
    expect(result.document.launched_from_visual_studio, "launch metadata should flow into the Studio document");
    expect(result.document.inspection.header_available, "inspection metadata should be attached to the document");

    const auto objects = copperfin::studio::build_object_snapshot(result.document);
    expect(objects.empty(), "header-only synthetic SCX should not produce object snapshots without parsed records");

    std::error_code ignored;
    fs::remove(form_path, ignored);
    fs::remove(sidecar_path, ignored);
    fs::remove(temp_dir, ignored);
}

}  // namespace

int main() {
    test_parse_launch_arguments();
    test_parse_launch_arguments_rejects_unknown_switch();
    test_open_document_infers_form_sidecar();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
