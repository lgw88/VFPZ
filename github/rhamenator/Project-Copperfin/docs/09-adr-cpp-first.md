# ADR 001: C++-First Core

## Status

Accepted

## Decision

Copperfin will use a native C++-first architecture for the core platform, with optional non-core companion tooling allowed only when security and speed are not compromised.

This applies to:

- file engine
- runtime
- query/evaluation engine
- report engine
- designer infrastructure
- CLI tooling where practical

It does not prohibit:

- first-class .NET interoperability
- generated .NET-facing outputs
- selective Rust use where it clearly improves safety or performance

## Context

The original product family being studied was native and tightly integrated around its runtime, data engine, and desktop tooling. The project goal is not only compatibility, but also a durable modern successor with strong control over:

- binary file formats
- memory behavior
- indexing and query performance
- packaging and deployment
- desktop designer capabilities

Earlier draft notes left open a .NET-first architecture for delivery speed. After review, the preferred direction is to keep the product core native and use other stacks only at the edges if they provide clear value. The deciding factors were security and speed, not language purity.

## Reasons

1. Native code aligns better with file-format fidelity and runtime control.
2. A single native core reduces dependency on managed runtime churn.
3. It better matches the feel and deployment shape of the product family being succeeded.
4. It creates a cleaner foundation for long-lived desktop and tooling scenarios.
5. It keeps the trusted and performance-sensitive path free of unnecessary runtime layers.
6. It still allows a strong .NET compatibility layer without forcing the whole core into managed code.

## Consequences

Positive:

- tighter control over performance-sensitive subsystems
- clearer packaging story for native desktop/runtime tools
- simpler mental model for the product core

Tradeoffs:

- slower early feature velocity than a heavily managed stack
- more implementation burden for UI and infrastructure pieces
- higher need for disciplined memory, testing, and build engineering

## Follow-On Rules

- Keep subsystem APIs narrow and testable.
- Use CMake from the beginning.
- Add compatibility fixtures and regression tests early.
- Only introduce non-C++ components when they sit outside the product core or materially improve integration.
- Rust usage must stay narrow, justified, and easy to integrate.
- .NET interoperability is required, but should flow through stable bridge layers rather than collapsing the core into managed code.
