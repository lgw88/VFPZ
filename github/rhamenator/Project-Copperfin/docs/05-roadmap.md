# Roadmap

## Phase 0: Archaeology And Provenance

Outputs:

- behavior inventory
- file format notes
- compatibility corpus
- clean-room process

Reference sources:

- installed VFP 9 tree
- mounted VFP 9 media
- VFPX-maintained projects
- local xBase/FoxPro-era code on `E:\`

## Phase 1: Data Foundation

Ship:

- DBF/FPT/CDX/DBC inspector
- repair/validation utilities
- schema explorer
- import/export basics
- provider abstraction draft
- SQLite connector MVP
- 64-bit-first build and packaging baseline
- VFP asset inventory and binary metadata reader for PJX/SCX/VCX/FRX/MNX families

Exit criteria:

- reliable reading of representative real-world datasets

## Phase 2: Runtime Core

Ship:

- parser/evaluator
- work area model
- navigation/query basics
- compatibility test runner
- SQL-backed cursor and session prototypes
- CLR host spike
- native-to-managed marshaling prototype
- PRG execution host
- initial project and asset binding layer

Exit criteria:

- representative data-centric scripts execute correctly under tests

## Phase 3: Reports

Ship:

- report asset parser
- previewer
- PDF/HTML export
- report listener model
- provider-neutral data source bindings
- report invocation from managed hosts
- editable FRX/FRT import and round-trip strategy

Exit criteria:

- common business reports render and export predictably

## Phase 4: Forms And Designer

Ship:

- Visual Studio extension MVP for Copperfin assets
- external Copperfin Studio host
- project explorer
- forms/class metadata importer
- property/event editor
- builder/wizard skeleton
- database target configuration in project settings
- .NET reference and component integration workflow
- editable SCX/SCT and VCX/VCT workspace model
- source-control-safe serialization strategy
- first designer-host integration for SCX/SCT or FRX/FRT
- labels and menu designer planning for LBX/LBT and MNX/MNT

Exit criteria:

- imported app assets can be opened from Visual Studio, edited through Copperfin Studio, and rebuilt

## Phase 5: Security And Packaging

Ship:

- Copperfin Shield MVP
- package manifest/signing
- audit events
- environment profiles
- secure connection secret providers
- managed assembly trust policy

Exit criteria:

- imported legacy app can run under explicit policy and produce usable audit logs

## Phase 6: Migration And Integration

Ship:

- migration reports
- API gateway
- identity integration
- app modernization templates
- PostgreSQL, SQL Server, and Oracle connectors
- DBF-to-SQL retargeting workflow
- .NET wrapper generation
- NuGet packaging strategy
- mixed-mode compatibility host for imported VFP projects

Exit criteria:

- legacy estate can be preserved, wrapped, or refactored with guided tooling

## Suggested MVP

The best first real milestone is:

- a DBF/DBC inspector
- a SQLite connector
- a runtime proof for data navigation/query logic
- a migration analyzer
- a CLR interop proof-of-concept
- a round-trip-safe reader for core VFP asset files

That gets you immediate practical value without waiting for a full IDE clone.

## Performance And Security Guardrails

These rules apply from the first prototype:

- benchmark core file and query operations from the beginning
- keep the parser, evaluator, and storage engine in native code
- define trusted boundaries before adding convenience tooling
- do not move hot-path logic into higher-level wrappers for short-term convenience
- add regression tests for both correctness and performance-sensitive behaviors
