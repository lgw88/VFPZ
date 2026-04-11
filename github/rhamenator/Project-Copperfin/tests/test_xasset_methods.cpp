#include "copperfin/runtime/xasset_methods.h"

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

void test_build_xasset_executable_model() {
    copperfin::studio::StudioDocumentModel document;
    document.path = R"(E:\Project-Copperfin\samples\demo.scx)";
    document.kind = copperfin::studio::StudioAssetKind::form;
    document.table_preview_available = true;
    document.table_preview.records = {
        make_record(0, {
            {.field_name = "PLATFORM", .field_type = 'C', .display_value = "WINDOWS"},
            {.field_name = "OBJNAME", .field_type = 'M', .display_value = "Dataenvironment"},
            {.field_name = "BASECLASS", .field_type = 'M', .display_value = "dataenvironment"},
            {.field_name = "METHODS", .field_type = 'M', .display_value = "PROCEDURE BeforeOpenTables\r\nSET DELETED ON\r\nENDPROC"}
        }),
        make_record(1, {
            {.field_name = "PLATFORM", .field_type = 'C', .display_value = "WINDOWS"},
            {.field_name = "OBJNAME", .field_type = 'M', .display_value = "frmDemo"},
            {.field_name = "BASECLASS", .field_type = 'M', .display_value = "form"},
            {.field_name = "METHODS", .field_type = 'M', .display_value = "PROCEDURE Init\r\nSET DELETED OFF\r\nENDPROC"}
        }),
        make_record(2, {
            {.field_name = "PLATFORM", .field_type = 'C', .display_value = "WINDOWS"},
            {.field_name = "OBJNAME", .field_type = 'M', .display_value = "pgfMain"},
            {.field_name = "PARENT", .field_type = 'M', .display_value = "frmDemo"},
            {.field_name = "BASECLASS", .field_type = 'M', .display_value = "pageframe"},
            {.field_name = "METHODS", .field_type = 'M', .display_value = "PROCEDURE Page2.Activate\r\nTHISFORM.Refresh\r\nENDPROC"}
        })
    };

    const auto model = copperfin::runtime::build_xasset_executable_model(document);
    expect(model.ok, "xAsset executable model should be created for forms");
    expect(model.runnable_startup, "form model should be runnable when startup methods exist");
    expect(model.root_object_path == "frmDemo", "root object path should identify the root form");
    expect(model.methods.size() == 3U, "all methods should be extracted");
    expect(model.actions.size() == 3U, "form model should expose all extracted methods as runtime actions");
    if (model.actions.size() == 3U) {
        expect(model.actions[0].action_id == "dataenvironment.beforeopentables", "data environment startup should be dispatchable");
        expect(model.actions[1].action_id == "frmdemo.init", "root form init should be dispatchable");
        expect(model.actions[2].action_id == "frmdemo.pgfmain.page2.activate", "nested page methods should be dispatchable");
    }
    expect(model.startup_routines.size() == 2U, "startup should include data environment and form init methods");

    const std::string bootstrap = copperfin::runtime::build_xasset_bootstrap_source(model, true);
    expect(bootstrap.find("DO __cf_Dataenvironment_BeforeOpenTables") != std::string::npos, "bootstrap should call the data environment method");
    expect(bootstrap.find("DO __cf_frmDemo_Init") != std::string::npos, "bootstrap should call the form init method");
    expect(bootstrap.find("PROCEDURE __cf_frmDemo_pgfMain_Page2_Activate") != std::string::npos, "bootstrap should materialize nested object methods");
    expect(bootstrap.find("READ EVENTS") != std::string::npos, "bootstrap should optionally include READ EVENTS");
}

void test_build_menu_xasset_executable_model() {
    copperfin::studio::StudioDocumentModel document;
    document.path = R"(E:\Project-Copperfin\samples\shortcut.mnx)";
    document.kind = copperfin::studio::StudioAssetKind::menu;
    document.table_preview_available = true;
    document.table_preview.records = {
        make_record(0, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "4"},
            {.field_name = "SETUP", .field_type = 'M', .display_value = "PARAMETERS Param1\nParam1 = 'ready'"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  0"}
        }),
        make_record(1, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "2"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "Shortcut"},
            {.field_name = "LEVELNAME", .field_type = 'C', .display_value = "Shortcut"},
            {.field_name = "NUMITEMS", .field_type = 'N', .display_value = "2"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  0"}
        }),
        make_record(2, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "3"},
            {.field_name = "LEVELNAME", .field_type = 'C', .display_value = "Shortcut"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  1"},
            {.field_name = "COMMAND", .field_type = 'M', .display_value = "CLEAR EVENTS"}
        }),
        make_record(3, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "3"},
            {.field_name = "LEVELNAME", .field_type = 'C', .display_value = "Shortcut"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  2"},
            {.field_name = "PROCEDURE", .field_type = 'M', .display_value = "PROCEDURE ItemAction\r\nCLEAR EVENTS\r\nENDPROC"}
        }),
        make_record(4, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "3"},
            {.field_name = "LEVELNAME", .field_type = 'C', .display_value = "Shortcut"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  3"},
            {.field_name = "PROMPT", .field_type = 'M', .display_value = "More"}
        }),
        make_record(5, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "2"},
            {.field_name = "NAME", .field_type = 'M', .display_value = "Thisitemha"},
            {.field_name = "LEVELNAME", .field_type = 'C', .display_value = "Thisitemha"},
            {.field_name = "ITEMNUM", .field_type = 'C', .display_value = "  0"}
        })
    };

    const auto model = copperfin::runtime::build_xasset_executable_model(document);
    expect(model.ok, "xAsset executable model should be created for menus");
    expect(model.runnable_startup, "menu model should be runnable when activation can be derived");
    expect(model.activation_kind == "popup", "shortcut menus should activate as popups");
    expect(model.activation_target == "Shortcut", "shortcut menus should target the first popup/submenu name");
    expect(model.startup_enters_event_loop, "menu startup should enter the runtime event loop");
    expect(model.startup_lines.size() >= 2U, "menu startup should include setup and activation lines");
    expect(model.methods.size() >= 4U, "menu methods should include wrapped setup/command/procedure code");
    expect(model.actions.size() >= 3U, "menu model should expose runnable menu actions");
    if (model.actions.size() >= 3U) {
        expect(model.actions[0].action_id == "shortcut.item1", "first action should expose the item1 action id");
        expect(model.actions[1].action_id == "shortcut.item2", "second action should expose the item2 action id");
        expect(model.actions[2].action_id == "shortcut.item3", "third action should expose the submenu action id");
        expect(model.actions[2].kind == "submenu", "submenu item should be tagged as a submenu action");
    }

    const std::string bootstrap = copperfin::runtime::build_xasset_bootstrap_source(model, true);
    expect(bootstrap.find("DO __cf_shortcut_setup") != std::string::npos, "menu bootstrap should call setup code");
    expect(bootstrap.find("ACTIVATE POPUP Shortcut") != std::string::npos, "menu bootstrap should activate the popup");
    expect(bootstrap.find("PROCEDURE __cf_Shortcut_item1_command") != std::string::npos, "menu bootstrap should materialize command routines");
    expect(bootstrap.find("PROCEDURE __cf_Shortcut_item2_ItemAction") != std::string::npos, "menu bootstrap should materialize embedded snippet procedures");
    expect(bootstrap.find("PROCEDURE __cf_Shortcut_item3_activate_popup") != std::string::npos, "menu bootstrap should materialize submenu activation routines");
    expect(bootstrap.find("READ EVENTS") == std::string::npos, "menu bootstrap should not append READ EVENTS when activation already enters the event loop");
}

void test_build_report_xasset_executable_model() {
    copperfin::studio::StudioDocumentModel document;
    document.path = R"(E:\Project-Copperfin\samples\invoice.frx)";
    document.kind = copperfin::studio::StudioAssetKind::report;
    document.table_preview_available = true;
    document.table_preview.records = {
        make_record(0, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "1"},
            {.field_name = "EXPR", .field_type = 'M', .display_value = "ENVIRONMENT = 1"}
        }),
        make_record(1, {
            {.field_name = "OBJTYPE", .field_type = 'N', .display_value = "9"},
            {.field_name = "OBJCODE", .field_type = 'N', .display_value = "4"},
            {.field_name = "TOP", .field_type = 'N', .display_value = "0"}
        })
    };

    const auto model = copperfin::runtime::build_xasset_executable_model(document);
    expect(model.ok, "xAsset executable model should be created for reports");
    expect(model.runnable_startup, "report model should be runnable without embedded methods");
    expect(model.startup_enters_event_loop, "report preview startup should enter the event loop");
    expect(model.startup_lines.size() == 1U, "report startup should be a direct preview command");
    expect(model.startup_lines[0].find("REPORT FORM") != std::string::npos, "report startup should preview the report");

    const std::string bootstrap = copperfin::runtime::build_xasset_bootstrap_source(model, true);
    expect(bootstrap.find("REPORT FORM 'E:\\Project-Copperfin\\samples\\invoice.frx' PREVIEW") != std::string::npos, "bootstrap should preview the report asset directly");
    expect(bootstrap.find("READ EVENTS") == std::string::npos, "report preview bootstrap should not append a second event loop");
}

}  // namespace

int main() {
    test_build_xasset_executable_model();
    test_build_menu_xasset_executable_model();
    test_build_report_xasset_executable_model();

    if (failures != 0) {
        std::cerr << failures << " test(s) failed.\n";
        return EXIT_FAILURE;
    }

    std::cout << "All tests passed.\n";
    return EXIT_SUCCESS;
}
