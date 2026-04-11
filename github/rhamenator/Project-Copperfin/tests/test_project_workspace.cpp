#include "copperfin/studio/project_workspace.h"

#include <algorithm>
#include <cstdlib>
#include <iostream>

namespace {

int failures = 0;

void expect(bool condition, const std::string& message) {
    if (!condition) {
        std::cerr << "FAIL: " << message << "\n";
        ++failures;
    }
}

copperfin::vfp::DbfRecord make_record(
    std::size_t record_index,
    std::initializer_list<copperfin::vfp::DbfRecordValue> values) {
    copperfin::vfp::DbfRecord record;
    record.record_index = record_index;
    record.values.assign(values.begin(), values.end());
    return record;
}

void test_build_project_workspace() {
    copperfin::studio::StudioDocumentModel document;
    document.path = R"(E:\Project-Copperfin\samples\demo.pjx)";
    document.kind = copperfin::studio::StudioAssetKind::project;
    document.table_preview_available = true;
    document.table_preview.records = {
        make_record(0, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "H"},
            {.field_name = "KEY", .field_type = 'C', .display_value = "DEMOAPP"},
            {.field_name = "HOMEDIR", .field_type = 'M', .display_value = R"(E:\Project-Copperfin\samples)"},
            {.field_name = "OUTFILE", .field_type = 'M', .display_value = R"(E:\Project-Copperfin\build\demoapp.exe)"},
            {.field_name = "DEBUG", .field_type = 'L', .display_value = "true"},
            {.field_name = "SAVECODE", .field_type = 'L', .display_value = "false"}
        }),
        make_record(1, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "K"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "main.prg"},
            {.field_name = "MAINPROG", .field_type = 'L', .display_value = "true"},
            {.field_name = "COMMENTS", .field_type = 'M', .display_value = "Application entry point"},
            {.field_name = "LOCAL", .field_type = 'L', .display_value = "true"}
        }),
        make_record(2, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "K"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "forms\\customer.scx"},
            {.field_name = "COMMENTS", .field_type = 'M', .display_value = "Customer maintenance"},
            {.field_name = "EXCLUDE", .field_type = 'L', .display_value = "false"}
        }),
        make_record(3, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "K"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "reports\\invoice.frx"},
            {.field_name = "EXCLUDE", .field_type = 'L', .display_value = "true"}
        })
    };

    const auto workspace = copperfin::studio::build_project_workspace(document);
    expect(workspace.available, "project workspace should be available for PJX documents");
    expect(workspace.project_title == "DEMOAPP", "workspace should use the project key as its title");
    expect(workspace.entries.size() == 4U, "workspace should include all project records");
    expect(workspace.groups.size() >= 3U, "workspace should group header, program, and form/report items");
    expect(workspace.build_plan.available, "build plan should be available");
    expect(workspace.build_plan.can_build, "build plan should be buildable with entries and an output path");
    expect(workspace.build_plan.output_path == R"(E:\Project-Copperfin\build\demoapp.exe)", "build plan should keep the explicit output path");
    expect(workspace.build_plan.startup_item == "main.prg", "build plan should choose the main program as startup item");
    expect(workspace.build_plan.startup_record_index == 1U, "build plan should keep the startup record index");
    expect(workspace.build_plan.debug_enabled, "build plan should capture project debug settings");
    expect(workspace.build_plan.excluded_items == 1U, "build plan should count excluded items");

    const auto forms_group = std::find_if(workspace.groups.begin(), workspace.groups.end(), [](const auto& group) {
        return group.id == "forms";
    });
    expect(forms_group != workspace.groups.end(), "workspace should include a forms group");
}

void test_build_project_workspace_with_excluded_assets() {
    copperfin::studio::StudioDocumentModel document;
    document.path = R"(E:\Project-Copperfin\samples\legacy.pjx)";
    document.kind = copperfin::studio::StudioAssetKind::project;
    document.table_preview_available = true;
    document.table_preview.records = {
        make_record(0, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "H"},
            {.field_name = "KEY", .field_type = 'C', .display_value = "LEGACYAPP"},
            {.field_name = "HOMEDIR", .field_type = 'M', .display_value = R"(D:\OLD\APP)"},
            {.field_name = "OUTFILE", .field_type = 'M', .display_value = "<memo block 918>"}
        }),
        make_record(1, {
            {.field_name = "TYPE", .field_type = 'C', .display_value = "K"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "forms\\legacy.scx"},
            {.field_name = "EXCLUDE", .field_type = 'L', .display_value = "true"},
            {.field_name = "KEY", .field_type = 'C', .display_value = "LEGACY"}
        })
    };

    const auto workspace = copperfin::studio::build_project_workspace(document);
    expect(workspace.available, "legacy project workspace should still be available");
    expect(
        workspace.build_plan.output_path == R"(E:\Project-Copperfin\samples\LEGACYAPP.exe)",
        "workspace should fall back to a default output path when the stored memo output is unresolved");
    expect(
        workspace.build_plan.startup_item == R"(forms\legacy.scx)",
        "workspace should choose a real asset as startup even when every asset is excluded");
    expect(
        workspace.build_plan.startup_record_index == 1U,
        "workspace should keep the excluded asset record index when it becomes the startup fallback");
}

}  // namespace

int main() {
    test_build_project_workspace();
    test_build_project_workspace_with_excluded_assets();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
