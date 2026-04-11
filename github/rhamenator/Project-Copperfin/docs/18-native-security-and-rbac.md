# Native Security And RBAC

## Why This Has To Be Native

Copperfin will not be credible as a serious FoxPro successor if security is only an afterthought or an external bolt-on.

The platform needs native, optional security that can be enabled without rewriting legacy applications from scratch.

## Product Position

Security should be:

- built into the platform
- optional for teams that need compatibility-first migration
- enforceable at IDE, build, runtime, package, and interop boundaries

## Native Security Surface

Core concepts:

- native identity providers
- role-based access control
- secrets abstraction
- audit trails
- signed packages and extensions
- policy for managed/native/plugin/AI interop

Current baseline in code:

- a native security profile with explicit permissions, roles, providers, features, audit events, and hardening profiles
- surfaced in the Studio host JSON and the project workspace summary

## Initial Role Model

Recommended platform roles:

- `developer`
- `build-engineer`
- `security-admin`
- `auditor`
- `runtime-operator`

These should control:

- opening and editing assets
- building and releasing executables
- runtime administration
- security policy changes
- data export
- .NET interop
- Python sidecars
- MCP/AI tooling
- external process launches

## Identity Modes

Copperfin should support:

- local platform identity for standalone deployments
- Windows/AD identity for Windows-first deployments
- Microsoft Entra ID / OIDC for enterprise environments
- external identity adapters later

## Trust Boundaries

The security layer must govern:

- native runtime actions
- managed .NET loading
- Python or other language sidecars
- MCP and AI-assisted tooling
- package signing and extension loading

## Hardening Profiles

Suggested deployment tiers:

- `bronze`
  local identity, audit, signed manifests
- `silver`
  enterprise identity, RBAC, signed extensions, export controls
- `gold`
  enterprise identity, full audit, secret providers, interop restrictions, release signing

## Non-Negotiable Direction

Legacy compatibility should be allowed.

Legacy insecurity should not be the default.
