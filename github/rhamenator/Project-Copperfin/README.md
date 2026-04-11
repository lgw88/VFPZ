# Project Copperfin

Project Copperfin is a clean-room blueprint for a modern successor to Visual FoxPro-style business application development.

Current engineering priority:

- security and speed first
- language choice second

This folder captures the current plan for a new platform that can:

- preserve access to legacy xBase/FoxPro-era data and application assets
- work with modern relational databases such as SQLite, PostgreSQL, SQL Server, and Oracle
- interoperate deeply with the .NET ecosystem and produce .NET-consumable outputs
- provide a modern runtime, designer, reporting stack, and migration path
- add modern security, packaging, deployment, and observability
- avoid direct reuse of FoxPro/VFP branding

Why "Copperfin"?

- `Copper` signals durable infrastructure, wiring, and business systems.
- `Fin` signals navigation, movement, and forward compatibility.
- It does not reuse the Fox/FoxPro/VFP brand family.

Important note:

- `Copperfin` is a working codename and branding starter, not a legal clearance opinion.
- A formal trademark review should happen before public release, filing, or product launch.

Contents:

- [`LICENSE`](E:/Project-Copperfin/LICENSE)
- [`SECURITY.md`](E:/Project-Copperfin/SECURITY.md)
- [`remaining-work.md`](E:/Project-Copperfin/remaining-work.md)
- [`docs/01-product-charter.md`](E:/Project-Copperfin/docs/01-product-charter.md)
- [`docs/02-architecture.md`](E:/Project-Copperfin/docs/02-architecture.md)
- [`docs/03-compatibility-and-migration.md`](E:/Project-Copperfin/docs/03-compatibility-and-migration.md)
- [`docs/04-security-model.md`](E:/Project-Copperfin/docs/04-security-model.md)
- [`docs/05-roadmap.md`](E:/Project-Copperfin/docs/05-roadmap.md)
- [`docs/06-branding.md`](E:/Project-Copperfin/docs/06-branding.md)
- [`docs/07-clean-room-rules.md`](E:/Project-Copperfin/docs/07-clean-room-rules.md)
- [`docs/08-reference-map.md`](E:/Project-Copperfin/docs/08-reference-map.md)
- [`docs/09-adr-cpp-first.md`](E:/Project-Copperfin/docs/09-adr-cpp-first.md)
- [`docs/10-dotnet-interop.md`](E:/Project-Copperfin/docs/10-dotnet-interop.md)
- [`docs/11-engineering-spec-dotnet.md`](E:/Project-Copperfin/docs/11-engineering-spec-dotnet.md)
- [`docs/12-vfp-asset-editing-and-execution.md`](E:/Project-Copperfin/docs/12-vfp-asset-editing-and-execution.md)
- [`docs/13-index-format-notes.md`](E:/Project-Copperfin/docs/13-index-format-notes.md)
- [`docs/14-hybrid-studio-and-visual-studio-host.md`](E:/Project-Copperfin/docs/14-hybrid-studio-and-visual-studio-host.md)
- [`docs/15-local-product-archeology.md`](E:/Project-Copperfin/docs/15-local-product-archeology.md)
- [`docs/16-vfp9-equivalent-subsystems.md`](E:/Project-Copperfin/docs/16-vfp9-equivalent-subsystems.md)
- [`docs/17-modern-designer-direction.md`](E:/Project-Copperfin/docs/17-modern-designer-direction.md)
- [`docs/18-native-security-and-rbac.md`](E:/Project-Copperfin/docs/18-native-security-and-rbac.md)
- [`docs/19-polyglot-and-ai-subprojects.md`](E:/Project-Copperfin/docs/19-polyglot-and-ai-subprojects.md)
- [`docs/20-runtime-build-and-debug-pipeline.md`](E:/Project-Copperfin/docs/20-runtime-build-and-debug-pipeline.md)
- [`docs/21-database-federation-and-query-translation.md`](E:/Project-Copperfin/docs/21-database-federation-and-query-translation.md)
- [`docs/22-vfp-language-reference-coverage.md`](E:/Project-Copperfin/docs/22-vfp-language-reference-coverage.md)
- [`docs/23-vfp-help-and-component-mining.md`](E:/Project-Copperfin/docs/23-vfp-help-and-component-mining.md)
- [`assets/logo.svg`](E:/Project-Copperfin/assets/logo.svg)

Recommended next build order:

1. File engine for DBF/FPT/CDX/DBC fidelity.
2. Connector layer for SQLite, PostgreSQL, SQL Server, and Oracle.
3. Query/runtime core with compatibility tests.
4. Forms and reports import/render pipeline.
5. Migration toolkit and packaging.
6. Security and policy layer.

Implementation bias:

- native core for performance-sensitive and trust-sensitive subsystems
- optional higher-level companion tooling only when it stays outside the product core
- first-class .NET interoperability and 64-bit support
- selective Rust use is acceptable where it materially improves safety or speed
- first-class ability to open, inspect, edit, and eventually execute legacy VFP assets

Current runnable artifacts:

- `build\Release\copperfin_inspect.exe`
  - low-level file and index inspection for DBF/VFP asset families
- `build\Release\copperfin_studio_host.exe`
  - early human-facing Studio host for opening legacy VFP assets and previewing schema/records
  - now supports `--json` snapshots for Visual Studio designer integration
  - now supports `--list-subsystems` to inspect the planned VFP 9-equivalent Copperfin subsystem map
  - now emits a structured `reportLayout` snapshot for `FRX/FRT` and `LBX/LBT` assets with named sections and placed objects
  - now emits native database-federation metadata for relational, document, and vector connector planning in the shared VS/Studio shells
- `build\Release\copperfin_build_host.exe`
  - native package/build pipeline entry point for `PJX/PJT` projects
  - stages project assets, emits runtime and debug manifests, bundles the runtime host, and can publish a generated `.NET` launcher
- `build\Release\copperfin_runtime_host.exe`
  - native runtime/debug launch host for packaged Copperfin applications
  - reads `app.cfmanifest` and now executes `PRG` startup code through a native xBase runtime session
  - supports real breakpoint and step-debugging actions for `PRG` startup paths
  - now emits richer debug state including call stack, locals, globals, and runtime events for debugger surfaces in Visual Studio and standalone Studio
  - now tracks richer VFP-style compatibility state for work areas, aliases, table cursors, data sessions, SQL pass-through cursors, and OLE automation objects in debug output
  - runtime faults now pause on the offending source line and keep the host session alive for continued debugging
  - the VSIX now registers a FoxPro text content type for `PRG`, `H`, `QPR`, `MPR`, and `SPR` files with project-aware statement completion and first-pass hover help in Visual Studio
  - now bootstraps runnable `SCX/VCX/MNX` startup behavior through generated `PRG` wrappers
  - now boots runnable `FRX/LBX` startup assets into direct preview/event-loop mode instead of treating them as inert metadata
  - packaged `SCX/VCX` startup assets now stage their memo sidecars and can launch from packaged content instead of only from source trees
  - now recognizes `ACTIVATE MENU` / `ACTIVATE POPUP` as real event-loop runtime operations
  - now supports dispatching runtime actions back into waiting xAssets through `--debug-command select:<action-id>` and `--debug-command invoke:<action-id>`
  - menu startup assets can now dispatch real menu-item selections while paused in the event loop
  - runtime xAsset execution now loads the full backing table instead of only the small Studio preview slice, so deeper menu trees and later records can participate in execution
  - form/class/report/label method surfaces now expose dispatchable runtime actions derived from extracted xBase methods
  - `DO FORM` now resolves quoted paths cleanly and launches runnable forms into the event loop instead of treating them like one-shot helper scripts
  - still reports compatibility-mode launch information for non-runnable xAssets and other startup assets while those runtimes are under construction
- `vsix\Copperfin.VisualStudio\Copperfin.VisualStudio.csproj`
  - installable Visual Studio extension baseline for VS 2022+
  - current output: `vsix\Copperfin.VisualStudio\bin\Release\net472\Copperfin.VisualStudio.vsix`
  - registers a first `Copperfin Visual Designer` document shell for `PJX/SCX/VCX/FRX/LBX/MNX`
  - now provides first-pass FoxPro editor assistance for `PRG/H/QPR/MPR/SPR`, including project-aware completion, Quick Info, call signature help, and `F12` definition navigation for indexed project symbols and assets
  - current shell shows object/property snapshots sourced from the native Studio host
  - current `SCX/SCT` and `VCX/VCT` slices expose flattened VFP `PROPERTIES` data for inline object selection, design-surface layout, drag-move, and safe property edits
  - current `FRX/FRT` and `LBX/LBT` slices now surface named report sections in a more modern Visual Studio-style designer shell, with section-aware layout editing for `HPOS/VPOS/WIDTH/HEIGHT` plus key expression/font fields
  - current `MNX/MNT` slices support asset-aware property-grid editing for menu metadata
  - current `PJX/PJT` slices now surface a grouped project workspace with project-item grouping, startup/build-plan summary, and project-entry property editing
  - project workspaces now also surface the platform's native security/RBAC posture and `.NET`/Python/MCP extensibility story
  - project workspaces now include a first integrated debugger pane backed by the native runtime host, with pause reason, call stack, locals, globals, and runtime-event summaries
  - project workspaces now include shared `Task List`, `Code References`, `Data Explorer`, `Object Browser`, `Toolbox`, `Builders`, `Coverage`, and `Database` panes so the IDE surface is moving toward classic VFP utility windows instead of only showing a build summary
  - project workspaces now explicitly surface user-selected AI debugging assistance plus Python/R data-science sidecar guidance inside the modern extensibility story
  - project workspaces now expose a native database-federation profile that distinguishes deterministic relational translation from optional AI-assisted document/vector planning
- `vsix\Copperfin.Studio\Copperfin.Studio.csproj`
  - standalone Windows shell that reuses the same shared report/label/form/menu/project designer controls outside Visual Studio
  - now opens multiple assets as tabs so the managed shell feels more like an IDE workspace instead of a single-document dialog
  - now shares the same first integrated project debugger pane used by the Visual Studio designer shell
  - current output: `vsix\Copperfin.Studio\bin\Release\net472\Copperfin.Studio.exe`
- `vsix\Copperfin.DesignerSmokeTests\Copperfin.DesignerSmokeTests.csproj`
  - automated WinForms smoke tests for the shared designer UI
  - current output: `vsix\Copperfin.DesignerSmokeTests\bin\Release\net472\Copperfin.DesignerSmokeTests.exe`
  - exercises synthetic rendering plus real `invoice.frx`, `cust.lbx`, and `solution.pjx` assets from the local VFP 9 sample tree
  - now smoke-tests the shared project debugger, task list, code references, data explorer, object browser, toolbox, builders, coverage, and database surfaces against a real VFP sample project

Quick examples:

```powershell
E:\Project-Copperfin\build\Release\copperfin_studio_host.exe --from-vs --path "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards\Template\Books\Forms\books.scx"
E:\Project-Copperfin\build\Release\copperfin_studio_host.exe "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx"
E:\Project-Copperfin\build\Release\copperfin_inspect.exe "E:\DBASE\DBFS\CHNGREAS.NDX"
E:\Project-Copperfin\build\Release\copperfin_build_host.exe build --project "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx" --output-dir "E:\Project-Copperfin\artifacts\runtime-smoke" --configuration debug --enable-security --emit-dotnet-launcher
E:\Project-Copperfin\scripts\validate-windows.ps1
```

Current MVP scope:

- open `PJX/PJT`, `SCX/SCT`, `VCX/VCT`, `FRX/FRT`, `LBX/LBT`, `MNX/MNT`, `DBF/FPT`, `CDX/DCX`, `IDX`, `NDX`, and `MDX`
- inspect headers and companion files
- preview DBF-style schema and a small number of records
- decode memo-backed preview values for synthetic and many real sidecar-backed assets

Known limitation:

- memo-heavy real-world designer files still need deeper VFP-specific decoding and presentation polish before they feel like a true visual designer
- the Visual Studio extension and standalone Studio now provide a shared project debugger pane on top of the native runtime/debug host, but they still do not provide full VFP 9-style design fidelity or the full FoxPro/VFP runtime surface
- packaged runtime output is now good enough to launch runnable `SCX/VCX/MNX` startup assets from staged package content, but broader asset-family execution and deeper event/lifecycle fidelity still need work
- packaged runtime output is now good enough to launch runnable `SCX/VCX/MNX/FRX/LBX` startup assets from staged package content, but deeper event/lifecycle fidelity still needs work
- runtime action dispatch now covers menu selection and extracted method invocation, but higher-fidelity form/report object lifecycle, richer UI event simulation, and broader runtime semantics still need work
- runtime execution no longer truncates to the Studio preview record limit, which improves parity for deeper `MNX` submenu trees and other larger xAssets
- the new standalone Studio shell shares the same editor stack, but it is still an early shell rather than the finished full-fidelity Copperfin IDE
- the standalone Studio shell now supports tabbed multi-document editing, but it still needs richer IDE chrome and workflow parity before it feels like the full VFP 9 experience
- the new project utility panes are strong parity progress, but they are still summary-driven surfaces rather than the full interactive VFP 9 Project Manager, Data Explorer, Object Browser, Coverage, and builder ecosystem
