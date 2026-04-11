# Compatibility And Migration

## Compatibility Strategy

Copperfin should support migration in layers instead of promising all-or-nothing conversion.

### Layer 1: Data Compatibility

Open and validate:

- DBF tables
- memo files
- indexes
- DBC containers

Also connect to and inspect:

- SQLite databases
- PostgreSQL schemas
- SQL Server databases
- Oracle schemas

Deliverables:

- file readers/writers
- schema inspector
- repair and backup tools
- safe export to SQL/Parquet/JSON where useful
- provider-backed import and export adapters

### Layer 2: Metadata Compatibility

Read and interpret:

- project metadata
- form/class/report/menu metadata
- field rules
- relations
- properties and object trees
- source-control text representations where available

Deliverables:

- import inventory
- compatibility report
- normalized internal model
- round-trip-safe editable asset model

### Layer 3: Runtime Compatibility

Support a measured subset of language and command behavior first:

- expressions
- work areas
- table navigation
- queries
- forms event wiring
- report invocation

Deliverables:

- compatibility test corpus
- unsupported feature inventory
- fallback behavior flags

### Layer 4: UX/Designer Migration

Map imported forms, classes, reports, and menus into:

- editable modern project structure
- designer-backed metadata
- source-controlled representations
- round-trip-safe editing paths back to VFP asset files when required

### Layer 5: Execution Compatibility

Support execution of imported application assets in stages:

- run PRG and command logic in the Copperfin runtime
- load project/form/class/report metadata into a compatibility host
- bridge to .NET and SQL services during mixed-mode execution

Deliverables:

- compatibility host
- asset-to-runtime binding layer
- execution diagnostics and unsupported-feature reports

## Migration Modes

### 1. Preserve

Goal:

- keep app behavior close to legacy system

Use when:

- app is business-critical
- current workflows are stable
- modernization risk is high

### 2. Wrap

Goal:

- preserve legacy data/runtime pieces while adding modern security and integration

Use when:

- app needs identity, APIs, audit, or deployment improvements first
- app still needs to keep editing existing VFP assets during transition

### 3. Refactor

Goal:

- move forms, reports, and business logic into modern Copperfin-native project structure

Use when:

- source is available
- maintainers want long-term modernization

### 4. Replace

Goal:

- retain data and behavior requirements while rebuilding the application experience more aggressively

Use when:

- legacy UI/process no longer fits the business

### 5. Retarget

Goal:

- keep application behavior broadly intact while moving storage to a modern SQL backend

Use when:

- data scale, concurrency, reporting, or integration pressure makes file-based storage a bottleneck

## Import Pipeline

1. Scan project folder.
2. Inventory file types and dependencies.
3. Detect external controls and unsupported hooks.
4. Build normalized metadata graph.
5. Assign compatibility risk scores.
6. Generate suggested migration mode per subsystem.
7. Produce machine-readable manifest and human-readable report.
8. Produce optional target-database mapping plans.
9. Produce editable workspace mappings for VFP assets.

## High-Risk Areas

- macro substitution and dynamic eval
- private/public memory variables
- third-party ActiveX controls
- report edge cases
- undocumented UI timing behavior
- binary metadata quirks in legacy designer assets
- DBF type semantics that do not map cleanly to SQL engines
- SQL dialect differences across providers
- locking and transaction behavior mismatches
- preserving round-trip fidelity for SCX/VCX/FRX/MNX families
- keeping project references stable while assets are edited outside VFP

## Modernization Opportunities

- move business rules into testable services
- replace shared machine state with app-local manifests
- move secrets out of source and local config
- add CI validation around forms/reports/data schema
- expose app capabilities through authenticated APIs
- support mixed estates where some modules stay on DBF while others move to SQL platforms
- decouple forms and reports from any single storage engine
- preserve the ability to keep editing VFP assets while introducing a modern compatibility host

## First Migration Tool Outputs

- `inventory.json`
- `compatibility-report.md`
- `unsupported-features.csv`
- `import-manifest.json`
- `security-findings.md`
- `database-target-plan.md`
- `type-mapping-report.csv`
- `asset-roundtrip-report.md`
- `execution-compatibility-report.md`
