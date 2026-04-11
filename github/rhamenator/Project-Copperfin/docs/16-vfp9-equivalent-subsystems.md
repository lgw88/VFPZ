# VFP 9 Equivalent Subsystems

## Goal

Copperfin should explicitly replace the major product subsystems that made `vfp9.exe` feel like a complete environment.

This is not a feature ranking.
It is a product map.

The intent is to keep the whole environment in view while we build toward:

- the full VFP 9 experience inside Visual Studio
- the full VFP 9 experience inside a standalone Copperfin IDE

## Product-Level Replacement Map

### IDE Shell

VFP 9 references:

- `vfp9.exe`
- `taskpane.app`
- `Toolbox.app`

Copperfin equivalent:

- `copperfin-studio-shell`
- `copperfin-vsix`
- `cf_toolbox`
- `cf_task_panes`

Role:

- top-level windowing and workspace model
- document hosting
- tool windows
- command routing
- solution/project orchestration

### Forms Designer

VFP 9 references:

- `SCX/SCT`
- form designer workflows inside `vfp9.exe`

Copperfin equivalent:

- `cf_form_surface`

Role:

- form layout
- selection and manipulation
- event hookups
- builders
- data environment integration

### Class Designer

VFP 9 references:

- `VCX/VCT`

Copperfin equivalent:

- `cf_class_surface`

Role:

- visual class design
- inheritance navigation
- class member editing
- reusable UI library authoring

### Report System

VFP 9 references:

- `FRX/FRT`
- `ReportBuilder.app`
- `ReportOutput.app`
- `ReportPreview.app`

Copperfin equivalent:

- `cf_report_surface`
- `cf_reporting_apps`

Role:

- report design
- report preview
- report export/output
- report builder extensibility

### Label System

VFP 9 references:

- `LBX/LBT`

Copperfin equivalent:

- `cf_label_surface`

Role:

- label layouts
- stock/dimension settings
- expression-backed label fields
- print-oriented preview

### Menu Designer

VFP 9 references:

- `MNX/MNT`

Copperfin equivalent:

- `cf_menu_surface`

Role:

- menu tree editing
- command wiring
- setup/cleanup behavior
- generated menu outputs

### Project Manager

VFP 9 references:

- `PJX/PJT`

Copperfin equivalent:

- `cf_project_explorer`

Role:

- project inventory
- asset dependencies
- build settings
- main program selection
- generated output configuration

### Runtime Engine

VFP 9 references:

- `vfp9r.dll`
- `vfp9t.dll`
- runtime behavior hosted by `vfp9.exe`

Copperfin equivalent:

- `cf_runtime`

Role:

- execute PRG/application logic
- host forms/reports/menus at runtime
- provide deployment/runtime services
- bridge to .NET and external providers

### Builders And Wizards

VFP 9 references:

- `builder.app`
- `wizard.app`
- `Wizards`

Copperfin equivalent:

- `cf_builders`
- `cf_wizards`

Role:

- guided editing
- scaffolding
- business-app generation
- control/report builders

### Object Browser And Reference Tools

VFP 9 references:

- `browser.app`
- `objectbrowser.app`
- `Foxref.app`

Copperfin equivalent:

- `cf_browser_tools`

Role:

- navigate objects, symbols, and references
- bind designer artifacts to code
- provide browse/search surfaces comparable to modern IDE tooling

### Data Explorer

VFP 9 references:

- `DataExplorer.app`
- data-environment tooling

Copperfin equivalent:

- `cf_data_explorer`

Role:

- browse connections and schemas
- inspect tables/queries
- connect VFP-style workflows to modern providers

### Debugger And Diagnostics

VFP 9 references:

- debugger behavior in `vfp9.exe`
- `coverage.app`
- `tasklist.app`

Copperfin equivalent:

- `cf_debugger`
- `cf_diagnostics`

Role:

- stepping and breakpoints
- call stack and watches
- coverage and trace views
- diagnostics flowing into Visual Studio and the standalone IDE

### Build And Deployment

VFP 9 references:

- project build output
- redistributable/runtime packaging

Copperfin equivalent:

- `cf_build_host`
- `cf_packaging`

Role:

- build/run/debug
- produce executables and deployable artifacts
- package runtime dependencies
- support native and .NET-consumable outputs

## Design Stance

The parity goal is behavioral and workflow parity, not visual nostalgia.

That means:

- preserve the authoring model users expect from VFP 9
- preserve round-trip and migration behavior
- preserve productivity patterns such as builders, reports, and data environments
- modernize the shells and editors where modern IDE patterns are clearly better

For forms, reports, labels, menus, and projects, Copperfin should answer:

- what behavior from VFP must remain intact
- what modern Visual Studio pattern should replace the old chrome
- how both the standalone IDE and Visual Studio host the same core subsystem
