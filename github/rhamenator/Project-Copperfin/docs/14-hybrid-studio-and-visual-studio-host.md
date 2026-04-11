# Hybrid Studio And Visual Studio Host

## Goal

Copperfin should let a developer open legacy VFP assets inside a modern development environment and edit them with behavior close to the original VFP designers.

That means:

- double-click an `SCX`, `VCX`, `FRX`, `LBX`, `MNX`, or `PJX` in Visual Studio
- get a real designer surface, not a hex view or generic text editor
- preserve round-trip safety for the binary asset pairs
- integrate with modern build, source control, debugging, and .NET workflows

## Decision

Copperfin should use a hybrid model:

- Visual Studio extension as the outer shell
- native Copperfin Studio designer engine as the real editor/runtime surface

Visual Studio is the workspace host.
Copperfin Studio is the designer host.

## Why Not Visual Studio Alone

Visual Studio is strong at:

- project and solution management
- source control integration
- build orchestration
- code navigation
- debugging shells
- extension points

Visual Studio is not a natural match for FoxPro-era binary designer semantics such as:

- `SCX/SCT` object graphs and property records
- `VCX/VCT` class inheritance and designer metadata
- `FRX/FRT` and `LBX/LBT` band/report/label layout models
- `MNX/MNT` menu generation workflows
- VFP-style property sheets, builders, data sessions, and object inspectors

If we try to model those assets as ordinary Visual Studio designers, we will either lose fidelity or spend years fighting the host.

## Product Shape

The product should have three layers:

### 1. Copperfin Core

Responsibilities:

- DBF/FPT/CDX/IDX/NDX/MDX/DBC fidelity
- asset parsing and round-trip serialization
- runtime and compatibility services
- provider abstraction for SQLite, PostgreSQL, SQL Server, Oracle, and others
- security and trust policy

### 2. Copperfin Studio

Responsibilities:

- forms designer
- class designer
- reports designer
- labels designer
- menus designer
- project explorer
- toolbox and builder surfaces
- property grid and object inspector
- event/method editors
- data environment and data-session tooling

This is the actual replacement for the visual productivity layer of `vfp9.exe`.

### 3. Visual Studio Extension

Responsibilities:

- project and solution integration
- file associations for legacy asset families
- PRG and header editing integration
- build/run/debug commands
- launch/attach to Copperfin Studio designers
- source control and diff integration
- .NET reference/package workflow
- migration/analyzer commands

## Host Model

The first implementation should support two host modes:

### Mode A: External Designer Host

Flow:

1. developer opens a legacy asset in Visual Studio
2. VS extension resolves Copperfin asset type
3. VS launches native Copperfin Studio editor process with file and context
4. designer edits asset through Copperfin round-trip model
5. VS refreshes project state and diagnostics after save

Why start here:

- simpler process isolation
- fewer Visual Studio UI constraints
- cleaner native rendering and performance
- easier crash containment

### Mode B: Embedded Designer Surface

Flow:

1. developer opens supported asset in Visual Studio
2. VS hosts a Copperfin designer surface through an integration bridge
3. edits, selection, and property changes flow through the native designer engine

Use later for:

- mature forms and reports designer surfaces
- tighter Visual Studio experience for common workflows

Recommendation:

- start with Mode A
- make Mode B optional after the native designer engine stabilizes

## Asset Support Matrix

### Project Assets

Files:

- `PJX`
- `PJT`

Designer expectations:

- project explorer
- asset references
- build options
- dependency graph
- source and binary asset inventory

### Form Assets

Files:

- `SCX`
- `SCT`

Designer expectations:

- visual layout canvas
- control selection and movement
- property grid
- event/method editor
- data environment editor
- z-order, tab order, and builder actions

### Class Library Assets

Files:

- `VCX`
- `VCT`

Designer expectations:

- class browser
- inheritance view
- property and method editing
- visual class design for UI classes

### Report Assets

Files:

- `FRX`
- `FRT`

Designer expectations:

- band layout surface
- expressions and calculated controls
- grouping and sorting
- preview and export hooks

### Label Assets

Files:

- `LBX`
- `LBT`

Designer expectations:

- label layout surface
- label dimensions and print settings
- data bindings and expressions

### Menu Assets

Files:

- `MNX`
- `MNT`

Designer expectations:

- menu tree editor
- command/action editing
- generation options

## Editor Architecture

The native designer engine should be split into services:

### `cf_vfp_assets`

- reads and writes binary asset families
- preserves opaque fields where full understanding is not ready
- exposes normalized editor models

### `cf_design_model`

- canonical in-memory model for forms, reports, menus, classes, and projects
- object identity and inheritance
- selection and mutation API
- serialization back to legacy assets and text snapshots

### `cf_design_surface`

- visual composition canvas
- snap/grid/layout rules
- handles and adorners
- toolbox interaction

### `cf_property_system`

- property metadata
- categories and editors
- expression-aware values
- compatibility flags and warnings

### `cf_builders`

- guided edits similar to VFP builders and wizards
- modernized templates and data-target selectors

### `cf_report_surface`

- report and label band layout
- preview pipeline
- printer/export settings

### `cf_menu_surface`

- hierarchical menu editing
- command bindings
- generated output metadata

## Visual Studio Extension Responsibilities

The VS extension should own:

- Copperfin solution/project flavor
- open-with bindings for legacy assets
- launch and lifetime management for Copperfin Studio
- PRG/H language service integration
- task list and diagnostics
- migration commands
- connector configuration UI
- .NET package/reference workflow for managed interop

The VS extension should not own:

- actual form rendering logic
- report canvas rendering
- menu designer behavior
- binary asset write-back logic

Those must stay in the native Copperfin engine so Studio and CLI tooling share the same truth.

## Round-Trip Rule

Every visual edit must flow through the same fidelity layer used by CLI inspection and migration tools.

Rules:

- no separate Visual Studio-only serializer
- no designer-only hidden format
- original asset pairs remain first-class
- text snapshots are derived artifacts, not the only canonical source

## Debugging And Runtime Integration

Visual Studio should still be the main debugging shell for mixed modern projects.

Suggested model:

- Copperfin Studio saves asset updates
- VS project system triggers Copperfin build/run/debug commands
- PRG and runtime debugging surfaces can start in VS for source-like artifacts
- designer/runtime diagnostics flow back into VS error list and output panes

Longer term:

- native runtime debug adapter
- breakpoints in `PRG`
- event/method navigation from designers to code

## Security And Stability

The hybrid model helps security:

- native designer host can run with tighter file and plugin policy
- VS extension can stay smaller and easier to audit
- plugin loading for third-party builders/components can be mediated by Copperfin Shield

The hybrid model also helps reliability:

- designer crashes do not take down all of Visual Studio
- asset parsing bugs stay inside the Copperfin engine boundary
- CLI, Studio, and migration tools all exercise the same serialization path

## First Implementation Slice

The first practical slice should be:

1. VS extension registers Copperfin asset families and open commands.
2. VS launches external Copperfin Studio editor host.
3. Copperfin Studio can inspect and no-op round-trip `SCX/SCT`, `VCX/VCT`, `FRX/FRT`, `LBX/LBT`, and `MNX/MNT`.
4. Studio exposes read-only visual/object inspection for one designer family first.
5. Property edits are enabled only for a narrow safe subset after binary diff tests pass.

Best candidate first:

- `FRX/FRT` or `SCX/SCT`

Why:

- they carry the strongest visible user value
- they force the right shape for the fidelity layer

## Recommended Sequence

1. stabilize binary asset parsers and no-op round-trip tests
2. build native designer models
3. build external Copperfin Studio host
4. wire Visual Studio extension launch/integration
5. add safe editing for one asset family
6. add PRG/code navigation and runtime/debug integration
7. evaluate embedded-designer hosting later

## Success Criteria

Copperfin is on the right path when a developer can:

- open a VFP project from Visual Studio
- double-click an `SCX`
- see a real visual designer powered by Copperfin Studio
- edit a safe subset of properties
- save back to the original asset pair without corruption
- build/run the project through Copperfin tooling
- gradually mix in modern databases and .NET components
