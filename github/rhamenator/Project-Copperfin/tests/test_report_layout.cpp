#include "copperfin/studio/report_layout.h"

#include <cstdlib>
#include <iostream>
#include <string>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

copperfin::vfp::DbfRecordValue value(std::string name, std::string display_value) {
    return {
        .field_name = std::move(name),
        .field_type = 'C',
        .is_null = false,
        .display_value = std::move(display_value)
    };
}

void test_build_report_layout_groups_band_objects() {
    copperfin::studio::StudioDocumentModel document;
    document.display_name = "synthetic.frx";
    document.kind = copperfin::studio::StudioAssetKind::report;
    document.table_preview_available = true;

    document.table_preview.records = {
        {
            .record_index = 0U,
            .deleted = false,
            .values = {
                value("OBJTYPE", "1"),
                value("OBJCODE", "53"),
                value("EXPR", "ORIENTATION=0\r\nPAPERSIZE=1"),
                value("TOPMARGIN", "10"),
                value("BOTMARGIN", "12")
            }
        },
        {
            .record_index = 1U,
            .deleted = false,
            .values = {
                value("OBJTYPE", "9"),
                value("OBJCODE", "1"),
                value("VPOS", "0.000"),
                value("HEIGHT", "2000.000")
            }
        },
        {
            .record_index = 2U,
            .deleted = false,
            .values = {
                value("OBJTYPE", "9"),
                value("OBJCODE", "4"),
                value("VPOS", "2000.000"),
                value("HEIGHT", "5000.000")
            }
        },
        {
            .record_index = 3U,
            .deleted = false,
            .values = {
                value("OBJTYPE", "8"),
                value("EXPR", "customer.company"),
                value("HPOS", "1200.000"),
                value("VPOS", "2600.000"),
                value("WIDTH", "4000.000"),
                value("HEIGHT", "450.000"),
                value("FONTFACE", "Segoe UI"),
                value("FONTSIZE", "10")
            }
        },
        {
            .record_index = 4U,
            .deleted = false,
            .values = {
                value("OBJTYPE", "5"),
                value("EXPR", "\"Invoice\""),
                value("HPOS", "900.000"),
                value("VPOS", "100.000"),
                value("WIDTH", "1800.000"),
                value("HEIGHT", "350.000")
            }
        }
    };

    const auto layout = copperfin::studio::build_report_layout(document);
    expect(layout.available, "report layout should be available for report assets");
    expect(!layout.is_label, "report layout should distinguish reports from labels");
    expect(layout.sections.size() == 2U, "report layout should detect two sections");
    expect(layout.settings.size() >= 2U, "report layout should parse root settings");
    expect(layout.sections[0].band_kind == "page_header", "first section should decode the page header band");
    expect(layout.sections[1].band_kind == "detail", "second section should decode the detail band");
    expect(layout.sections[0].objects.size() == 1U, "page header should capture its label object");
    expect(layout.sections[1].objects.size() == 1U, "detail section should capture its field object");
    expect(layout.sections[1].objects[0].object_kind == "field", "detail object should retain its type");
    expect(layout.sections[1].objects[0].expression == "customer.company", "detail object should surface its expression");
}

}  // namespace

int main() {
    test_build_report_layout_groups_band_objects();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
