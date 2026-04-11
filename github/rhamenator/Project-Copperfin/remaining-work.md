# Remaining Work

This file is the working guide for the remaining Copperfin implementation effort.

It is intentionally ordered by dependency depth:

1. deepest shared engine layers first
2. runtime semantics next
3. designer/runtime integration after that
4. IDE shells and workflow surfaces on top
5. portability after the Windows-first product is genuinely solid

The goal is not merely feature count. The goal is to finish the stack in an order where each completed layer reduces risk for the layers above it.

## North Star

Copperfin should eventually provide:

- full behavioral compatibility with the parts of `vfp9.exe` that FoxPro developers expect in real projects
- a full Visual Studio 2022+ experience for FoxPro/VFP assets and code
- a full standalone Copperfin IDE experience
- native security and policy controls
- first-class .NET interoperability
- modern database federation
- modern AI/MCP/polyglot workflows where they add value
- a future path to macOS and Linux without poisoning the Windows-first core

## Working Rules

- Keep the trusted runtime, data engine, and compatibility core native-first.
- Do not let designer or shell shortcuts dictate runtime semantics.
- Treat XSharp as an accelerator for language-service, project-system, and modern tooling ideas.
- Treat VFPX as an accelerator for FoxPro-specific workflow, tooling, and parity expectations.
- Reuse ideas and reference behavior aggressively, but keep Copperfin implementation clean-room.
- Do not start real cross-platform host work until the Windows runtime and standalone IDE core are stable enough to port.

## Priority Ladder

The implementation order should be:

1. Data fidelity and execution engine
2. Compatibility semantics and runtime safety
3. Report/form/menu/class runtime parity
4. Compiler/build/debug pipeline completion
5. Shared design model and visual-designer fidelity
6. Visual Studio and standalone IDE parity
7. Modernization layers: database federation, AI/MCP, polyglot, security polish
8. Portability work for standalone IDE and core runtime

## Gap Matrix

Current repo status against the Windows-first product goal:

| Area | Status | Notes |
| --- | --- | --- |
| DBF/FPT basic read fidelity | Implemented | Real DBF parsing, memo decoding, and inspector/design-surface consumption are in place for representative assets. |
| DBF local-table mutation core | Partial | Native DBF append/field-update/delete-flag writes now exist for local table-backed runtime flows, including first-pass shared memo-backed `M` field persistence via FoxPro-compatible sidecars, first-pass fixed-width `I`/`Y`/`T` field create/replace/append support, and fail-fast safety guards that block indexed-table mutation plus unsupported-field `APPEND BLANK` corruption until broader storage fidelity exists, but broader field-type coverage, repair, and transactional safety still need work. |
| CDX/DCX inspection | Partial | First-pass real directory-leaf tag-name parsing now replaces whole-file tag-name heuristics, page-local per-tag key/`FOR` expression hints are surfaced for the shared `CDX/DCX` path, and focused `DCX` probe/companion coverage now locks down that shared parser entry point, but deeper metadata, write fidelity, and richer order/collation behavior remain incomplete. |
| MDX inspection | Partial | First-pass multi-tag enumeration now surfaces tag-name hints from printable metadata runs in `MDX` files and through same-base companion inspection, but real layout parsing, expression extraction, and write fidelity remain incomplete. |
| DBC/database container fidelity | Missing | The architecture and backlog exist, but the repo does not yet have a first-class DBC runtime/editing implementation. |
| Work areas and data sessions | Partial | `SELECT`, plain `USE`, `USE AGAIN`, `SET DATASESSION`, cursor identity functions, session-scoped synthetic SQL cursors and SQL handles, session-local SQL cursor auto-allocation that now follows the current selected work-area flow, freed-work-area reuse plus side-effect-free `SELECT(0)` probing, strict `USE ... IN <alias>` targeting plus first-pass non-selected-target preservation, and first indexed search semantics are working, but broader alias/session edge cases remain. |
| Local query/mutation commands | Partial | `GO`, `SKIP`, `SEEK`, `LOCATE`, `SCAN`, `REPLACE`, `APPEND BLANK`, `DELETE`, `RECALL`, first-pass `SET FILTER TO/OFF`, aggregate built-ins, first-pass `CALCULATE`, first-pass command-level `COUNT`/`SUM`/`AVERAGE` with basic scope/`WHILE` and `IN` targeting support, and first-pass `TOTAL` with `IN` targeting now exist for local DBF cursors, but broader xBase table/query commands are still missing. |
| SQL pass-through/remote cursor behavior | Partial | Synthetic SQL cursor/session plumbing exists, and read-only remote cursor flow now covers first-pass local-style field lookup, filter-aware navigation, `LOCATE`, and aggregate semantics over synthetic `SQLEXEC()` result rows, but broader SQL pass-through and writable remote-cursor parity are still far from VFP complete. |
| PRG execution engine | Partial | Structured stepping, breakpoints, fault containment, first-pass `DO CASE/CASE/OTHERWISE/ENDCASE`, `DO WHILE/ENDDO`, `LOOP`/`CONTINUE`/`EXIT`, and literal `TEXT/ENDTEXT` block capture now exist, but the runtime is still well short of the practical full FoxPro/VFP surface. |
| Forms/classes runtime parity | Partial | Bootstrapped `SCX/VCX` startup and extracted method dispatch exist, but lifecycle/container/data-environment fidelity is still incomplete. |
| Reports/labels runtime parity | Partial | `FRX/LBX` preview/event-loop launch works, but real report execution/output semantics remain incomplete. |
| Menus runtime parity | Partial | Startup activation and action dispatch work, but richer menu navigation/state semantics are still unfinished. |
| Build/package/debug pipeline | Partial | Native build/package/runtime/debug hosts are wired end to end, but the compiler/runtime contract still relies on heuristics and line-based manifests. |
| Shared designers | Partial | Shared VS/Studio designer shells exist for major asset families, but fidelity and round-trip depth are not yet production grade. |
| Visual Studio integration | Partial | Asset editors, project panes, and first-pass FoxPro language assistance exist, but the IDE story is not yet full-fidelity. |
| Standalone Copperfin IDE | Partial | The managed Studio shell is usable for early workflows, but it is not yet the finished standalone IDE. |
| Language service | Partial | Completion, hover, call signatures, and go-to-definition exist, but semantic resolution, references, and refactoring remain incomplete. |
| .NET interoperability | Partial | Build-time launcher generation and documented architecture exist, but broad first-class runtime interop is still incomplete. |
| Database federation | Missing | Platform models exist, but deterministic backend translators are not yet implemented. |
| Security/policy controls | Partial | Project/workspace security models exist, but runtime-enforced policy and enterprise controls are not complete. |

## Phase A: Core Data And Compatibility Engine

This is the deepest layer and should continue to absorb the most effort until it is boringly reliable.

### Progress Notes

- 2026-04-10: the native PRG expression/runtime slice now covers first-pass `EVAL()`, `SET()`, and `&macro` substitution plus expression-driven `USE IN` close targeting. Stored expression strings can now run through the evaluator against the current record/runtime context, macro-expanded field/alias names work in expression paths, `SET()` can inspect current session/default-directory state, and focused runtime coverage now locks down restored `SET` state across data sessions.
- 2026-04-10: native PRG command coverage now includes a first-pass literal `TEXT/ENDTEXT` slice. The parser/runtime can capture multiline text blocks into variables with `TEXT TO ... [ADDITIVE] [NOSHOW]`, preserves literal block lines without stripping FoxPro comment markers inside the block, and locks that down with focused runtime regression coverage.
- 2026-04-09: `CDX/DCX` inspection now uses first-pass real directory leaf-page parsing for tag names instead of whole-file tag-name scavenging. The asset parser now lifts stored tag names from plausible compound-index directory pages, attaches first-pass page-local key and `FOR` expression hints to those tags, and validates the shape against both synthetic fixtures and the real VFP `customer.cdx` sample.
- 2026-04-09: the shared `CDX/DCX` parser path now has focused `.dcx` regression coverage. Synthetic direct-probe coverage now locks down `DCX` tag, key-expression, and `FOR`-expression extraction, and `inspect_asset()` now has a companion-collection regression for `DBC` plus same-base `.dcx`.
- 2026-04-09: `MDX` probing now moves past file-level structural recognition. The read-only probe now surfaces first-pass tag-name hints from printable metadata runs, and same-base companion inspection exercises those hints through `inspect_asset()` while deeper layout parsing remains open.
- 2026-04-09: `APPEND BLANK` now fails fast on unsupported field layouts instead of guessing blank bytes for binary storage it does not understand. The shared DBF layer now rejects tables carrying unsupported field types during blank-record initialization, focused DBF/runtime coverage locks down the unchanged-file error path, and that closes another silent-corruption seam while broader field-type fidelity remains open.
- 2026-04-09: the shared DBF mutation layer now covers first-pass FoxPro `Currency (Y)` and `DateTime (T)` field writes. `create_dbf_table_file()`, `replace_record_field_value()`, and `append_blank_record_to_file()` now persist `Y` values as signed 4-decimal scaled integers, persist `T` values through the existing `julian:<day> millis:<milliseconds>` storage contract, initialize blank appended fixed-width values to zero bytes, and round-trip that behavior through focused DBF coverage.
- 2026-04-09: the shared DBF mutation layer now covers first-pass FoxPro `Integer (I)` field writes. `create_dbf_table_file()`, `replace_record_field_value()`, and `append_blank_record_to_file()` can now persist `I` fields as 4-byte little-endian signed values, initialize blank appended integers to zero, and round-trip that behavior through focused DBF coverage.
- 2026-04-09: the shared DBF mutation layer now fails fast on indexed tables instead of silently diverging from companion structural indexes. `append_blank_record_to_file()`, `replace_record_field_value()`, and `set_record_deleted_flag()` now reject DBFs marked with production indexes or carrying same-base `.cdx` companions, and focused DBF/runtime coverage locks down the error path while true `CDX` write/rebuild support remains open.
- 2026-04-09: the shared DBF layer now has first-pass memo write fidelity for `M` fields. `create_dbf_table_file()` and `replace_record_field_value()` can now persist FoxPro-compatible memo sidecars, blank memo fields append with zero pointers instead of corrupted placeholders, and focused DBF round-trip coverage now exercises memo-backed create/update/append flows.
- 2026-04-09: `SET NEAR` now has focused data-session restoration coverage. Missed-`SEEK` behavior is locked down across `SET DATASESSION` switches so session-local nearest-record behavior stays independent and restores correctly after returning to the original session.
- 2026-04-10: synthetic SQL result cursor auto-allocation now follows each data session's current selected work-area flow instead of always forcing another `IN 0` allocation. Focused runtime coverage now locks down `SELECT 0` plus `SQLEXEC()` behavior across two data sessions so each session reuses its own selected empty work area and restores that placement after switching back.
- 2026-04-10: work-area allocation now reuses freed areas instead of monotonically climbing forever, and `SELECT(0)` now reports the next available work area without consuming it. Focused runtime coverage locks down `USE IN`, `SELECT(0)`, and subsequent `USE ... IN 0` reopening so alias/work-area selection stays closer to practical VFP behavior after closing a cursor.
- 2026-04-10: synthetic SQL result cursors now participate in a first-pass read-only local-cursor flow. The runtime can evaluate synthetic SQL fields during `SET FILTER`, `GO TOP`, `LOCATE`, aggregate built-ins, and `CALCULATE`, and focused regression coverage now locks down that filter/locate/aggregate behavior against `SQLEXEC()` result cursors.
- 2026-04-09: `SQLCONNECT()` handle numbering now restarts per data session instead of sharing one global handle sequence. Combined with the prior session-scoped SQL handle storage, this keeps synthetic SQL connection lifecycles closer to the local cursor/session model and adds focused regression coverage for cross-session handle lookup and restored SQL cursor visibility.
- 2026-04-09: synthetic SQL result cursors now have stronger data-session isolation. SQL connection handles are now scoped per data session instead of globally, and focused runtime coverage now locks down cross-session `SQLEXEC`/`SQLDISCONNECT` isolation plus restored SQL cursor lookup after `SET DATASESSION` switches.
- 2026-04-08: plain `USE <table>` now reuses the current selected work area instead of behaving like `IN 0`, so opening into an empty selected area and replacing the selected cursor now happen in place with focused runtime regression coverage.
- 2026-04-08: `USE ... IN <alias|work area>` now preserves the current selected work area when replacing a different non-selected local cursor, and focused runtime coverage now locks down both replacement and close flows for that alias/work-area edge case.
- 2026-04-08: aggregate command follow-through now includes first-pass `IN <alias|work area>` targeting for command-level `COUNT`, `SUM`, and `AVERAGE`, and `TOTAL` can now target a non-selected local DBF cursor the same way. The runtime preserves both the selected cursor position and the targeted cursor position with focused regression coverage.
- 2026-04-08: first-pass `TOTAL` now works for local DBF-backed cursors. The native PRG runtime can write grouped DBF totals with `TOTAL TO ... ON ... FIELDS ...` plus basic visibility-aware `REST`/`FOR` semantics, and the DBF layer now has focused coverage for creating output tables without corrupting FoxPro-compatible files.
- 2026-04-08: aggregate command follow-through now covers first-pass scope-clause and `WHILE` semantics for command-level `COUNT`, `SUM`, and `AVERAGE`. `ALL`, `REST`, `NEXT n`, and `RECORD n` now run through the native visibility-aware cursor engine, preserve the selected record position, and have focused regression coverage.
- 2026-04-08: command-level aggregate follow-through now exists in the native PRG runtime. First-pass `COUNT`, `SUM`, and `AVERAGE` commands can assign visibility-aware results into variables with `FOR`/`TO`, the expression parser now handles multiplicative arithmetic needed by multi-expression aggregates, and quoted `IN` alias targets now resolve cleanly across adjacent aggregate/search commands such as `USE`, `CALCULATE`, `LOCATE`, and `SCAN`.
- 2026-04-08: first-pass command-level aggregates now exist in the native PRG runtime. `CALCULATE` can assign `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` results into variables, supports `TO`/`INTO`, optional `FOR`, optional `IN` alias targeting, and reuses the shipped visibility-aware aggregate semantics with focused regression coverage.
- 2026-04-08: first-pass aggregate built-ins now exist in the native PRG runtime for local DBF-backed cursors. `COUNT()`, `SUM()`, `AVG()/AVERAGE()`, `MIN()`, and `MAX()` now evaluate across visible rows, respect `SET FILTER TO/OFF`, honor `SET DELETED ON`, and can target a named alias with focused regression coverage.
- 2026-04-08: native PRG branching now covers first-pass `DO CASE/CASE/OTHERWISE/ENDCASE`, including nested case blocks and case-driven execution inside `SCAN`, with focused runtime regression coverage.
- 2026-04-08: native PRG control flow now covers first-pass `DO WHILE/ENDDO` plus shared `LOOP`/`CONTINUE`/`EXIT` behavior across `DO WHILE`, `FOR`, and `SCAN`, with focused regression coverage for nested loops and cursor-backed iteration.
- 2026-04-08: persistent cursor filtering now has a first native runtime slice. `SET FILTER TO/OFF` is now cursor-scoped for local DBF-backed work areas, and `GO TOP/BOTTOM`, `SKIP`, `LOCATE`, `SCAN`, and `DELETE/RECALL FOR` now honor active filter visibility with regression coverage.
- 2026-04-08: local-table mutation/query flow moved forward materially in the native PRG engine. `LOCATE`, `SCAN ... ENDSCAN`, `REPLACE`, `APPEND BLANK`, `DELETE`, and `RECALL` now work against local DBF-backed cursors with persisted table writes, current-record field resolution, and regression coverage in both the DBF layer and runtime layer.
- 2026-04-08: `CDX/DCX` inspection moved beyond header-only probing. Copperfin now enumerates first-pass tag/expression hints from real file contents and surfaces them through the asset inspector and CLI.
- 2026-04-08: `GO`, `GOTO`, and `SKIP` cursor navigation now have runtime coverage in the native `PRG` engine tests, which closes one more piece of work-area behavior before broader table/session semantics.
- 2026-04-08: `USED()`, `DBF()`, and `FCOUNT()` now participate in the native cursor/session model for both local tables and synthetic SQL result cursors, with explicit regression coverage for data-session isolation and `USE IN`.
- 2026-04-08: `SELECT` now fails cleanly on missing aliases instead of inventing new work areas, and `USE AGAIN` / duplicate-open rules now participate in the native runtime with regression coverage.
- 2026-04-08: `SET ORDER TO TAG`, `SEEK`, and `FOUND()` now work as a first indexed-lookup slice for local DBF-backed cursors, using companion index metadata and explicit runtime regression coverage.
- 2026-04-10: command-level `SEEK` now accepts one-off `TAG` / `ORDER` overrides for local DBF-backed cursors without requiring a prior `SET ORDER`, which closes a focused indexed-search parity gap and keeps the active controlling order unchanged after the probe.
- 2026-04-10: indexed runtime metadata now preserves the actual inspected index file identity for loaded local-table orders. `ORDER(alias, 1)` now reports the real companion index path instead of assuming `.cdx`, `TAG(indexFile, ...)` now accepts supported xBase index extensions beyond `.cdx`, and focused runtime coverage locks that down with a synthetic `.idx` companion.
- 2026-04-08: the official Learn language-reference index is now part of the working parity process, with a generated command inventory plus `FOXHELP.DBF` as a fallback source for older or missing command-behavior details.
- 2026-04-08: the installed VFP CHM files now have a generated local keyword-to-topic index, so command behavior can be mined offline from `dv_foxhelp.chm` and `foxtools.chm` without treating the CHMs as opaque binaries.
- 2026-04-08: `SET NEAR ON/OFF` now participates in indexed `SEEK` behavior for local DBF-backed cursors, which closes another documented VFP search-behavior slice and gives the runtime a clearer path beyond exact-match-only index probes.
- 2026-04-08: `SEEK()`, `INDEXSEEK()`, `ORDER()`, and `TAG()` now have first-pass runtime coverage grounded in the installed VFP help topics, which expands the indexed-search surface from command-only behavior into documented helper functions.
- 2026-04-08: `SET LIBRARY TO`, `FoxToolVer()`, `MainHwnd()`, `RegFn32()`, and `CallFn()` now have a first-pass FoxTools compatibility bridge, giving Copperfin an initial modeled path for old DLL-call workflows without destabilizing the host runtime.
- 2026-04-08: `SET EXACT` now participates in both string comparison semantics and indexed `SEEK` behavior, and that setting is now scoped per data session instead of being treated as one global runtime toggle.

### A1. File And Index Fidelity

- Finish first-class read/write fidelity for `DBF`, `FPT`, `CDX`, `DCX`, `IDX`, `NDX`, `MDX`, and `DBC`.
- Add broader validation and repair logic for damaged or inconsistent xBase assets.
- Strengthen round-trip confidence on real-world FoxPro and dBase datasets.
- Expand metadata coverage for edge-case field types, memo storage, and index expressions.

### A2. Work Areas, Sessions, And Cursor Semantics

- Finish the remaining alias scoping and work-area selection behavior to match VFP expectations.
- Deepen data-session isolation, switching, restoration, and nested behavior.
- Extend indexed lookup beyond the first-pass `SET ORDER TO TAG` / `SEEK` / `FOUND()` slice into richer order, collation, and search behavior.
- Support remote cursors and result cursors with behavior closer to SQL pass-through in VFP.

### A3. Command And Expression Surface

- Expand the native execution engine from `PRG-first` into a broader FoxPro/VFP command surface.
- Keep closing gaps in command semantics, expression evaluation, macro/eval behavior, and runtime state changes.
- Build a compatibility corpus from the installed VFP tree, `E:\VFPSource`, your legacy projects, and regression samples.

### A4. Automation And Interop Semantics

- Deepen OLE/COM behavior beyond current object/property/method handling.
- Improve `CREATEOBJECT()` and `GETOBJECT()` parity.
- Preserve host stability when automation calls fail or behave unexpectedly.

## Phase B: Runtime Safety, Fault Tolerance, And Crash Containment

This layer protects real users working with broken legacy code.

### B1. Fault Isolation

- Keep runtime faults non-fatal to the host wherever possible.
- Pause execution at the offending statement with useful debugger context.
- Preserve runtime/session state well enough for diagnosis after failure.

### B2. Debug Metadata And Diagnostics

- Improve stack traces, statement context, variable inspection, and event traces.
- Capture richer runtime diagnostics for xAsset execution, report preview, menu flow, and data operations.
- Make error messages and pause reasons feel like a serious developer tool, not a prototype host.

## Phase C: Asset Runtime Parity

This is where Copperfin stops being only an engine and starts being a FoxPro application platform.

### C1. Forms And Classes

- Finish `SCX/SCT` and `VCX/VCT` event/lifecycle fidelity.
- Implement more realistic container, object, and data-environment behavior.
- Improve extracted `METHODS` execution so form/class runtime behavior is closer to VFP rather than only bootstrapped.

### C2. Reports And Labels

- Finish `FRX/FRT` and `LBX/LBT` runtime behavior.
- Improve expression evaluation, preview fidelity, output generation, and report object behavior.
- Build the output/export pipeline as a real subsystem, not only a preview shell.

### C3. Menus

- Finish `MNX/MNT` runtime fidelity beyond startup and first nested dispatch.
- Improve popup/menu navigation, routing, state handling, and event semantics.

### C4. Projects

- Strengthen `PJX/PJT` project interpretation and startup/build behavior.
- Reduce heuristic-driven planning and move toward a fuller project execution model.

## Phase D: Build, Compiler, And Debug Pipeline Completion

This phase should build directly on the engine/runtime work, not the other way around.

### D1. Compiler And Package Model

- Evolve the current manifest/package flow into a fuller compiler/runtime contract.
- Improve executable generation and `.NET`-friendly outputs.
- Replace temporary heuristics where a true Copperfin build model is required.

### D2. Debugger Completion

- Add real watches, locals, breakpoint management, richer stepping, and runtime inspection.
- Improve linkage between debugger state and source/design surfaces.
- Add coverage and diagnostic tooling that is useful in day-to-day work.

### D3. Build/Run/Deploy Workflow

- Tighten build/run/debug orchestration in both shells.
- Improve deployment/runtime redistribution and packaging behavior.
- Add migration-aware build/reporting workflows for imported projects.

## Phase E: Shared Design Model And Visual Designer Fidelity

The design model should be completed before polishing host-specific shells.

### E1. Shared Design Model

- Finish high-fidelity normalized models for forms, classes, reports, labels, menus, and projects.
- Improve memo-heavy asset decoding and round-trip preservation.
- Make the shared design model strong enough that both Visual Studio and the standalone IDE can rely on the same core.

### E2. Designer Interaction

- Add toolbox-driven creation and editing of controls and designer objects.
- Improve drag/drop, resize, alignment, grouping, container editing, and property-grid fidelity.
- Add builders, wizards, and context-aware editors where FoxPro developers expect them.

### E3. Report And Label Designer Completion

- Finish section-aware editing so it behaves like a real modern report designer.
- Keep the visual direction modern, but preserve VFP workflow expectations.

## Phase F: IDE Parity On Top Of The Shared Core

This phase should consume the completed runtime and design model rather than inventing substitutes.

### F1. Visual Studio Extension

- Finish in-IDE design fidelity for `SCX/VCX/FRX/LBX/MNX/PJX`.
- Tighten build/run/debug integration so the extension feels native, not bolted on.
- Finish utility panes as real tools: Project Explorer, Data Explorer, Object Browser, Coverage, Builders, Toolbox, Task List, Code References.
- Strengthen the FoxPro language service.

### F2. Standalone Copperfin IDE

- Turn the current shell into a full standalone IDE.
- Match core workflows available in Visual Studio where appropriate.
- Own the complete designer/debug/project experience without needing Visual Studio.

## Phase G: Language Service Completion

This can progress in parallel with shell work, but it should still depend on the runtime and project index becoming stronger.

### G1. Editor Semantics

- Improve symbol resolution across includes, defines, dotted/member contexts, and project boundaries.
- Add signature help for project-defined procedures and methods.
- Improve completions using project symbols, open cursors, DBC metadata, and object members.

### G2. Navigation And Refactoring

- Add better definition resolution, peek-style workflows, references, and rename/refactor support.
- Build more semantic editor behavior inspired by XSharp without forcing Copperfin into XSharp’s runtime model.

### G3. IntelliSense Inputs

- Investigate a FOXCODE-style or metadata-driven catalog for richer completion and hints.
- Incorporate relevant ideas from `FoxcodePlus`, `GoToDefinition`, `foxref`, and `GoFish`.

## Phase H: Database Federation And Modern App Platform

This sits above the core engine. It should not destabilize parity work underneath.

### H1. Relational Backends

- Finish deterministic translation and provider behavior for SQLite, PostgreSQL, SQL Server, and Oracle.
- Make FoxPro-style data access work naturally against those backends where possible.

### H2. Document And Vector Backends

- Build the backend translation layer for JSON/document/vector stores.
- Define where deterministic translation is sufficient and where AI-assisted planning is optional.
- Keep AI assistance policy-controlled and user-selectable rather than mandatory.

### H3. Modern Integration Surface

- Improve `.NET` output and consumption paths.
- Add real MCP/AI integration hooks in the product, not only in docs and shells.
- Add practical Python/R sidecar workflows for data science scenarios without making them part of the trusted core.

## Phase I: Security Completion

Security should keep growing throughout the project, but these remaining items deserve their own completion pass.

### I1. Runtime And Project Security

- Deepen native RBAC, policy enforcement, secrets handling, and audit behavior across the runtime and project model.
- Ensure generated applications can opt into native security controls cleanly.

### I2. Extension And Host Security

- Lock down managed-extension loading, interop boundaries, and external process policy.
- Make AI/MCP integration policy-aware and enterprise-friendly.

## Phase J: Portability

Do not start broad host-porting work until the Windows-first stack is solid.

### J1. Portable Core

- Keep core runtime, data engine, parser, and connector abstractions portable by boundary.
- Isolate Windows-only functionality behind shell, printing, OLE, COM, and CLR-host seams.

### J2. macOS

- Port the standalone IDE and portable core.
- Do not assume Visual Studio extension portability because VS 2022+ is Windows-only.
- If a future macOS code editor integration is needed, treat it as a separate host strategy.

### J3. Linux

- Port the standalone IDE and portable core for Red Hat/Fedora and Debian-family targets first.
- Do not couple Linux progress to Visual Studio-specific assumptions.

## XSharp Incorporation Plan

XSharp may save substantial tooling time, but it should be used selectively.

### Use XSharp As A Model For

- language-service structure
- project-system layering
- IntelliSense architecture
- signature help and navigation patterns
- debugger/tool-window organization
- modern xBase-family tooling strategy inside Visual Studio

### Do Not Blindly Import From XSharp

- runtime semantics
- compiler behavior
- language differences where XSharp diverges from VFP
- assumptions that would distort FoxPro/VFP compatibility

### Immediate XSharp Follow-Up

- audit the XSharp language-service and project-system layers for concepts we still lack
- identify which pieces can be mirrored clean-room in Copperfin
- prefer architecture and workflow ideas over direct feature cloning

## VFPX Incorporation Plan

VFPX should continue to inform FoxPro-specific parity and workflows.

### Highest-Value VFPX Inputs

- `GoToDefinition`
- `FoxcodePlus`
- `Project Explorer`
- `DataExplorer`
- `Toolbox`
- `Code References`
- `GoFish`
- `FoxBin2Prg`
- `PEM Editor`
- `Thor`
- `Automated Test Harness`
- `FoxUnit`
- `DeployFox`

### Local Source Trees To Continue Mining

- `E:\VFPSource\foxref`
- `E:\VFPSource\DataExplorer`
- `E:\VFPSource\toolbox`
- `E:\VFPSource\tasklist`
- `E:\VFPSource\taskpane`
- `E:\VFPSource\coverage`
- `E:\VFPSource\obrowser`
- `E:\VFPSource\builders`
- `E:\VFPSource\ReportBuilder`

## Agent Guidance

When spawning agents, assign them work that respects the dependency order above.

Good agent tasks:

- deepen one runtime subsystem without touching host UX
- improve one data/index format implementation
- improve one designer family on top of an already-stable model
- strengthen one language-service feature against the shared project index
- extract lessons from one XSharp or VFPX subsystem into a clean-room implementation note

Bad agent tasks:

- polishing shell UX before the shared model is ready
- building cross-platform host layers before Windows parity is credible
- inventing ad hoc designer logic outside the shared design model
- adding AI workflows into trusted runtime code paths

## Definition Of Done For The Windows-First Product

The Windows-first product is not done until:

- representative VFP applications can be opened, edited, built, run, and debugged
- runtime crashes are contained and diagnosable
- designers are truly useful, not just inspectable
- Visual Studio and standalone Copperfin Studio are both credible daily-driver environments
- native security is optional but real
- .NET interoperability is practical and documented
- modern database backends work without sacrificing core FoxPro compatibility

At that point, portability becomes a product-expansion effort instead of a moving target.
