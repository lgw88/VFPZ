# Security Policy

Project Copperfin treats security issues as a priority, especially anywhere the platform parses legacy assets, executes runtime behavior, handles package generation, or exposes designer/debugger surfaces.

## Reporting a Vulnerability

Please report suspected vulnerabilities privately through GitHub Security Advisories for this repository. If that path is unavailable, contact the maintainers through the most direct private channel available to you and avoid opening a public issue.

When you report an issue, include:

- the affected file, feature, or artifact type
- the version, commit hash, or build output you tested
- clear reproduction steps
- any sample asset, request, or payload needed to reproduce
- the impact you observed and why you believe it is security-related

## What To Report

Useful reports usually include:

- authentication or authorization bypasses
- secret exposure or insecure default behavior
- command execution, path traversal, or unsafe file handling
- deserialization, parser, or package-format bugs
- supply-chain or build-pipeline weaknesses
- debugger, preview, or runtime privilege boundary issues

## Safe Disclosure

Please do not publicly disclose an issue until maintainers have had a chance to review and respond. If you already have a proof of concept, share the smallest reproduction that demonstrates the problem safely.

## Scope

This policy applies to the repository contents, generated artifacts, and project-specific tooling that ships alongside them.
