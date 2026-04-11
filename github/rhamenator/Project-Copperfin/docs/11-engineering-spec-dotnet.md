# Engineering Spec: Copperfin .NET Bridge

## Purpose

Define the first implementation shape of the `copperfin-dotnet` subsystem so the platform can:

- call managed .NET code from Copperfin logic
- expose Copperfin-native capabilities to .NET callers
- generate .NET-consumable artifacts
- stay secure, fast, and 64-bit-first

## Scope For First Implementation

In scope:

- x64 CLR hosting
- assembly load and invocation pipeline
- type marshaling for core data types
- result-set/cursor interop
- audit hooks and trust policy
- one sample native-to-managed call path
- one sample managed-to-native call path

Out of scope:

- full designer support for every managed control type
- arbitrary in-process untrusted plugin loading
- full COM replacement layer in v1

## Architecture

### Native Side

Primary native modules:

- `cf_dotnet_host`
- `cf_dotnet_marshaler`
- `cf_dotnet_policy`
- `cf_dotnet_codegen`

Responsibilities:

- initialize CLR
- load configured assemblies
- resolve method signatures
- marshal arguments and return values
- enforce trust/loading policy
- emit wrapper projects and metadata

### Managed Side

Primary managed surfaces:

- `Copperfin.ManagedBridge`
- `Copperfin.ManagedTypes`
- `Copperfin.ManagedHostTemplates`

Responsibilities:

- stable wrapper API for .NET consumers
- managed projection of native result sets and services
- generated host/application templates

## Invocation Modes

### Mode A: Native Calls Managed

Flow:

1. Copperfin runtime resolves a configured managed binding.
2. `cf_dotnet_host` loads target assembly under policy.
3. marshaler converts Copperfin values to managed equivalents.
4. managed method executes.
5. return values are normalized back into Copperfin runtime objects.

Initial use cases:

- authentication provider
- custom business rule service
- external API integration

### Mode B: Managed Calls Native

Flow:

1. .NET app references generated Copperfin wrapper package.
2. wrapper binds to native Copperfin library.
3. managed caller invokes exposed service interface.
4. native runtime executes query/report/business module.
5. results are returned as managed objects or streaming readers.

Initial use cases:

- use Copperfin reporting in a .NET application
- reuse Copperfin query and DBF access logic from C#
- embed migrated business rules inside a wider .NET estate

## Type Marshaling

First supported types:

- string
- boolean
- 32-bit and 64-bit integers
- double
- decimal/currency
- date
- datetime
- null
- byte buffer
- tabular result set

Important semantic rules:

- preserve distinctions between null, empty string, zero, and blank date
- normalize memo/blob values without truncation
- map cursor-like results to a streaming/tabular abstraction, not a lossy list of maps by default

## Security Model

Assembly loading rules:

- explicit allow-list
- signed assembly preference
- audit every load and bind event
- configurable in-process vs out-of-process mode

Default posture:

- trusted internal assemblies may run in-process
- partner or customer extensions should prefer isolated host mode

## Packaging

Phase 1 outputs:

- native Copperfin shared library
- generated C# wrapper project
- generated sample host executable

Phase 2 outputs:

- NuGet package
- SDK docs and templates
- versioned interop manifest

## Performance Targets

Initial expectations:

- interop overhead should be low enough for coarse-grained business operations
- tight record-by-record loops should stay native whenever possible
- bulk transfer paths should use batching or streaming

## Proofs Of Concept

POC 1:

- call a managed C# function from native Copperfin with strings, decimals, and dates

POC 2:

- call a native Copperfin DBF query from a C# console app and iterate rows

POC 3:

- execute a Copperfin report from a .NET wrapper and export PDF

## Open Questions

- which CLR hosting model gives the best operational balance on modern Windows
- how much wrapper generation should be static vs reflection-driven
- whether AOT-friendly managed wrappers should be a first-class target

