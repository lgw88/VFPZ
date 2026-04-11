# Product Charter

## Working Name

Copperfin Studio

Related product names:

- Copperfin Runtime
- Copperfin Designer
- Copperfin Reports
- Copperfin Migrator
- Copperfin Gateway
- Copperfin Shield

## Mission

Build a modern business application platform that lets organizations keep using legacy FoxPro/xBase-era data and application patterns while gaining modern security, deployment, tooling, and maintainability.

Implementation stance:

- security and speed drive implementation choices
- native C++ is preferred for the trusted core and performance-critical path
- other stacks are allowed only for outer tooling and services when they do not weaken those goals
- .NET compatibility is a product requirement, not an optional add-on
- Rust is acceptable for selected subsystems where memory safety and performance both matter

## Problem

Legacy FoxPro systems still run critical line-of-business workflows, but teams are boxed in by:

- aging runtimes and deployment methods
- shrinking maintainer pools
- weak built-in security assumptions
- difficult source control and CI/CD practices
- fragile installer/runtime dependencies
- poor interoperability with modern identity, APIs, and observability stacks
- pressure to move data into mainstream SQL platforms without a safe bridge

## Product Thesis

The winning successor is not just an interpreter.

It must be a full platform that combines:

- data compatibility
- multi-database connectivity
- language/runtime compatibility
- first-class .NET interoperability
- visual/business-app productivity
- reporting
- scaffolding
- migration tooling
- security by default
- native performance and native desktop control

## Decision Drivers

Ordered by importance:

1. Security
2. Speed
3. Compatibility
4. .NET ecosystem fit
5. Maintainability
6. Developer ergonomics

Language and framework choices should be judged against these, not the other way around.

## Primary Users

- organizations running legacy FoxPro/VFP business systems
- consultants maintaining xBase/FoxPro estates
- internal IT teams modernizing line-of-business software
- developers who want rapid desktop/data-driven business app creation

## Non-Goals For Version 1

- perfect bug-for-bug compatibility with every undocumented runtime edge case
- pixel-perfect recreation of the original IDE shell
- support for every third-party ActiveX control on day one
- full cloud-native rewrite of every legacy app automatically

## Success Criteria

- open legacy DBF/FPT/CDX/DBC assets safely and accurately
- connect to SQLite, PostgreSQL, SQL Server, and Oracle through a consistent data access layer
- run a meaningful subset of FoxPro-style business logic with tests
- host and call .NET components from Copperfin applications cleanly
- generate .NET-consumable assemblies or executables so Copperfin-built logic can be reused in .NET applications
- ship as a 64-bit-first platform with a modernization story stronger than late-stage VFP had
- import or map common forms/reports/projects into a modern workspace
- package apps without brittle shared-machine setup
- enforce modern authn, authz, audit, secrets, and policy controls

## Product Principles

1. Compatibility where it preserves business value.
2. Modern defaults where legacy behavior is unsafe.
3. Clean-room implementation only.
4. Tooling first, not just runtime first.
5. Documentation and migration guidance are product features.
6. Database choice should be a deployment decision, not a rewrite trigger.
