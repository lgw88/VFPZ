# Security Model

## Why Security Is A Core Product Feature

The point of Copperfin is not just to preserve legacy apps.

It is to preserve them while making them viable in modern environments where teams need:

- identity integration
- policy enforcement
- auditability
- least privilege
- package trust
- secrets hygiene

## Security Design Goals

1. Secure by default.
2. Legacy-compatible by exception, not by default.
3. Policy should be explicit and observable.
4. App authors should not have to reinvent auth and audit.

## Copperfin Shield

Copperfin Shield is the planned security layer around runtime, packaging, and deployment.

### Capabilities

- Microsoft Entra ID / OIDC / SAML integration
- local and enterprise role mapping
- secrets abstraction
- signed package verification
- executable/plugin allow-lists
- auditable file/data access events
- environment and network policy controls
- optional native RBAC for IDE, build, runtime, and interop features
- policy-controlled .NET, Python, and MCP boundaries

## Native Platform Security

Security should not depend on every application author reinventing:

- users
- roles
- package trust
- secrets handling
- audit policy

Copperfin should provide a native security profile that teams can enable when they need it.

Current direction:

- local identity plus optional enterprise identity
- native RBAC with platform roles like developer, build engineer, security admin, auditor, and runtime operator
- explicit permissions for build, release, runtime admin, data export, .NET interop, Python sidecars, MCP tools, and external process launches
- signed packages and signed extensions
- explicit allow-list policy for managed/native/plugin loading

## Security Boundaries

### Runtime Boundary

Protect:

- shell execution
- file system access
- network access
- COM/interop access
- macro/eval execution

### Data Boundary

Protect:

- database file tampering
- unsafe external table paths
- untracked schema drift
- direct writes bypassing app policy

### Deployment Boundary

Protect:

- package authenticity
- runtime dependency integrity
- configuration drift
- secrets leakage

## Recommended Defaults

- no raw shell execution unless explicitly enabled
- no external network access by default for imported legacy apps
- explicit policy for COM/ActiveX interop
- signed package manifests
- immutable audit stream for privileged actions
- per-environment secret providers

## Audit Events To Capture

- login and identity resolution
- role elevation
- schema changes
- report exports
- file import/export
- external process launches
- .NET interop calls
- Python sidecar execution
- MCP or AI-tool invocation
- policy denials
- configuration changes

## Legacy App Hardening Modes

### Bronze

- file access audit
- package manifest
- local auth

### Silver

- enterprise identity
- role policies
- report/file export controls

### Gold

- enterprise identity
- signed packages
- full audit
- network/process restrictions
- secret provider integration

## Long-Term Opportunity

Copperfin can become the modernization bridge that legacy FoxPro estates never had: business-app productivity with modern governance.
