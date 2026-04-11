# Clean-Room Rules

## Objective

Build a new platform informed by behavior, file formats, workflows, and public/community references without copying proprietary implementation code into the new product.

## Allowed Inputs

- public documentation
- shipped help content
- observed product behavior
- metadata and file formats
- your own historical code
- VFPX community-maintained projects where licensing allows use and study

## Restricted Inputs

- copying proprietary Microsoft implementation into new runtime code
- transplanting binary-decompiled code into the product
- opaque reuse of original branding or copyrighted assets where not permitted

## Working Rules

1. Keep provenance notes for major design decisions.
2. Prefer behavior tests over implementation mimicry.
3. Normalize imported metadata into new internal schemas.
4. Keep modern security decisions explicit when legacy behavior is unsafe.
5. Record where a feature came from: docs, behavior tests, VFPX, or your own prior work.

## Recommended Repo Hygiene When This Moves Into Source Control

- `docs/provenance/`
- `tests/compat/`
- `specs/file-formats/`
- `fixtures/legacy-assets/`
- `notes/behavior-deltas/`

## Safe Use Of Community Projects

Use VFPX and related open projects to learn:

- what the community had to fix
- how features were organized
- what extension points mattered

Do not let them silently define architecture without documenting why.

