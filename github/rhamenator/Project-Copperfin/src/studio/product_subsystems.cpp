#include "copperfin/studio/product_subsystems.h"

namespace copperfin::studio {

const char* product_host_kind_name(ProductHostKind kind) {
    switch (kind) {
        case ProductHostKind::native_ide:
            return "native_ide";
        case ProductHostKind::visual_studio_shell:
            return "visual_studio_shell";
        case ProductHostKind::shared_service:
            return "shared_service";
    }
    return "shared_service";
}

const std::vector<ProductSubsystemDescriptor>& product_subsystems() {
    static const std::vector<ProductSubsystemDescriptor> subsystems = {
        {
            .id = "ide-shell",
            .title = "IDE Shell",
            .vfp9_equivalent = "vfp9.exe shell, taskpane.app, Toolbox.app",
            .copperfin_component = "copperfin-studio-shell + copperfin-vsix",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "partial",
            .parity_scope = "workspace shell, document hosting, tool window orchestration, command surfaces",
            .modern_editor_direction = "feel like a modern Visual Studio shell with dockable panes, searchable tool windows, and richer diagnostics rather than a clone of the VFP chrome"
        },
        {
            .id = "forms-designer",
            .title = "Forms Designer",
            .vfp9_equivalent = "SCX/SCT designer",
            .copperfin_component = "cf_form_surface",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "partial",
            .parity_scope = "layout canvas, property grid, builders, container editing, event hookups, data environment integration",
            .modern_editor_direction = "keep FoxPro form behavior but use modern Visual Studio-style selection adorners, property browsing, snapping, and document tabs"
        },
        {
            .id = "class-designer",
            .title = "Class Designer",
            .vfp9_equivalent = "VCX/VCT designer",
            .copperfin_component = "cf_class_surface",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "partial",
            .parity_scope = "visual class editing, inheritance navigation, method/property browsing, builder actions",
            .modern_editor_direction = "blend Visual Studio designer idioms with a class hierarchy explorer and source/designer split views"
        },
        {
            .id = "report-designer",
            .title = "Report Designer",
            .vfp9_equivalent = "FRX/FRT designer, ReportBuilder.app, ReportPreview.app, ReportOutput.app",
            .copperfin_component = "cf_report_surface + cf_reporting_apps",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "partial",
            .parity_scope = "band editing, expression authoring, grouping, preview, export, report listeners, builder workflows",
            .modern_editor_direction = "look closer to SSRS and current Visual Studio report tooling with stronger outlines, inspectors, live preview, and clearer band/property panes"
        },
        {
            .id = "label-designer",
            .title = "Label Designer",
            .vfp9_equivalent = "LBX/LBT designer",
            .copperfin_component = "cf_label_surface",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "partial",
            .parity_scope = "label layout, expression editing, stock settings, print dimensions, preview workflows",
            .modern_editor_direction = "share the report-designer visual language so label editing feels like a focused modern layout designer, not a legacy modal editor"
        },
        {
            .id = "menu-designer",
            .title = "Menu Designer",
            .vfp9_equivalent = "MNX/MNT menu designer",
            .copperfin_component = "cf_menu_surface",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "partial",
            .parity_scope = "menu tree editing, prompt/command/setup/cleanup editing, generation, preview",
            .modern_editor_direction = "use a Visual Studio-style hierarchy/tree editor with command detail panes instead of reproducing the old menu dialogs verbatim"
        },
        {
            .id = "project-manager",
            .title = "Project Manager",
            .vfp9_equivalent = "PJX/PJT project manager",
            .copperfin_component = "cf_project_explorer",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "partial",
            .parity_scope = "asset inventory, build settings, dependency graph, main program selection, excluded item handling",
            .modern_editor_direction = "feel like Solution Explorer plus project properties, while still surfacing VFP-specific concepts such as generated assets and main-program semantics"
        },
        {
            .id = "runtime-engine",
            .title = "Runtime And Execution Engine",
            .vfp9_equivalent = "vfp9r.dll, vfp9t.dll, executable runtime behavior",
            .copperfin_component = "cf_runtime",
            .host_kind = ProductHostKind::shared_service,
            .current_status = "planned",
            .parity_scope = "command execution, PRG runtime, event dispatch, forms/report/menu runtime behavior, deployment runtime",
            .modern_editor_direction = "invisible to end users except through faster, safer execution and clearer diagnostics"
        },
        {
            .id = "builders-wizards",
            .title = "Builders And Wizards",
            .vfp9_equivalent = "builder.app, wizard.app, Wizards folder",
            .copperfin_component = "cf_builders + cf_wizards",
            .host_kind = ProductHostKind::native_ide,
            .current_status = "planned",
            .parity_scope = "guided configuration, app scaffolding, control/report builders, template-driven generation",
            .modern_editor_direction = "use task-based tool windows and property-driven panels similar to modern Visual Studio item/template experiences"
        },
        {
            .id = "object-browser",
            .title = "Object And Reference Browsers",
            .vfp9_equivalent = "objectbrowser.app, browser.app, Foxref.app",
            .copperfin_component = "cf_browser_tools",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "planned",
            .parity_scope = "symbol browsing, reference search, object inspection, navigation between designer artifacts and code",
            .modern_editor_direction = "feel like Object Browser, Go To, and Find All References inside Visual Studio rather than standalone legacy dialogs"
        },
        {
            .id = "data-explorer",
            .title = "Data Explorer And Environment Tools",
            .vfp9_equivalent = "DataExplorer.app, data environment tooling",
            .copperfin_component = "cf_data_explorer",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "planned",
            .parity_scope = "connection browsing, table/query exploration, data session binding, connector-aware inspection",
            .modern_editor_direction = "feel like Server Explorer or SQL tooling in Visual Studio while preserving VFP data-session semantics"
        },
        {
            .id = "debugger",
            .title = "Debugger And Diagnostics",
            .vfp9_equivalent = "VFP debugger, coverage.app, tasklist.app",
            .copperfin_component = "cf_debugger + cf_diagnostics",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "planned",
            .parity_scope = "breakpoints, stepping, watch windows, call stack, coverage, task and error surfaces",
            .modern_editor_direction = "lean into modern Visual Studio debugging panes and diagnostic lists rather than reproducing older floating tool windows"
        },
        {
            .id = "toolbox-task-pane",
            .title = "Toolbox And Task Pane",
            .vfp9_equivalent = "Toolbox.app, taskpane.app, gallery.app",
            .copperfin_component = "cf_toolbox + cf_task_panes",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "planned",
            .parity_scope = "control palette, snippets, common actions, contextual productivity panels",
            .modern_editor_direction = "use searchable categorized toolboxes and contextual task panes instead of static legacy palettes"
        },
        {
            .id = "build-deploy",
            .title = "Build And Deployment",
            .vfp9_equivalent = "Project build, executable generation, redistributable runtime packaging",
            .copperfin_component = "cf_build_host + cf_packaging",
            .host_kind = ProductHostKind::visual_studio_shell,
            .current_status = "planned",
            .parity_scope = "build/run/debug commands, executable packaging, runtime bundling, deployment output",
            .modern_editor_direction = "use familiar Visual Studio build output, publish, and configuration surfaces while keeping VFP-compatible build concepts"
        }
    };

    return subsystems;
}

}  // namespace copperfin::studio
