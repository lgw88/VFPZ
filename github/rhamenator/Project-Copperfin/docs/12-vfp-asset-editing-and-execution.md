# VFP Asset Editing And Execution

## Goal

Copperfin should be able to open, inspect, edit, preserve, and progressively execute legacy VFP application assets.

This includes both source-like artifacts and designer metadata artifacts.

## Priority Asset Families

Projects:

- `.pjx`
- `.pjt`

Forms and classes:

- `.scx`
- `.sct`
- `.vcx`
- `.vct`

Reports:

- `.frx`
- `.frt`

Labels:

- `.lbx`
- `.lbt`

Menus:

- `.mnx`
- `.mnt`

Code and headers:

- `.prg`
- `.h`

Data and metadata:

- `.dbf`
- `.fpt`
- `.cdx`
- `.dbc`

## Product Promise

Copperfin should support these modes:

### 1. Inspect

- read asset metadata safely
- show dependencies and structure
- identify unsupported features

### 2. Round-Trip Edit

- edit supported properties and code
- preserve non-understood metadata where possible
- write files back without destructive reshaping

### 3. Normalize

- import assets into an internal editable workspace model
- generate source-control-safe text representations
- keep links back to original binary assets

### 4. Execute

- run PRG/business logic in the Copperfin runtime
- bind project/forms/reports/menus into a compatibility host
- mix legacy assets with modern connectors and .NET integrations

## Editing Strategy

### Binary Asset Rule

For binary VFP assets, Copperfin should not immediately rewrite everything into a new format.

Instead:

1. parse into normalized internal metadata
2. preserve raw/original records where needed
3. edit through structured models
4. write back only through a round-trip-safe serializer

### Source Control Rule

Each editable asset should have:

- original binary source
- normalized internal representation
- canonical text serialization for diff/review when possible

This mirrors the value proposition of tools like SCCText without making the binary asset the only truth humans can inspect.

## Execution Strategy

### Stage 1: Code Execution

Support:

- `.prg`
- command/eval logic
- work area and query operations
- report invocation hooks

### Stage 2: Project And Asset Binding

Support:

- project loading
- form/class/report/menu registration
- dependency resolution
- asset identity and lookup

### Stage 3: Compatibility Host

Support:

- loading imported forms and class libraries into Copperfin Studio/runtime
- binding controls, data sessions, menus, and reports
- bridging unsupported areas with diagnostics rather than silent failure

### Stage 4: Mixed-Mode Runtime

Support:

- legacy VFP assets
- SQL connectors
- .NET service or library calls
- modern security policy

## Round-Trip Safety Requirements

For supported asset types, Copperfin should:

- preserve object identity and ordering where required
- preserve unsupported fields as opaque data when necessary
- avoid destructive reformatting
- emit explicit warnings when write-back fidelity cannot be guaranteed

## First Milestones

### Milestone A

- inspect PJX/SCX/VCX/FRX/LBX/MNX structure
- produce dependency and property reports

### Milestone B

- round-trip edit a limited subset of properties safely
- serialize canonical text snapshots for diffing

### Milestone C

- load project and PRG execution together
- bind forms/reports into a compatibility workspace

### Milestone D

- mixed-mode execution with .NET and SQL connectors

## Key Risks

- binary asset edge cases not documented in public help
- preserving designer metadata exactly enough for round-trip confidence
- unsupported ActiveX or COM behaviors
- hidden dependencies stored in project metadata or resource records

## Recommended Validation Artifacts

- golden copies of representative PJX/SCX/VCX/FRX/MNX files
- binary diff checks after no-op round trip
- property-level round-trip tests
- execution traces for imported sample applications
