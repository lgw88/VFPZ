# Local Product Archeology

This note captures what the installed Microsoft Visual FoxPro product tree and the older DOS-era Fox trees tell us about the actual product shape we need to reproduce.

Primary reference roots:

- `C:\Program Files (x86)\Microsoft Visual FoxPro 9`
- `C:\Program Files (x86)\Common Files\Microsoft Shared\VFP`
- `C:\vDosPlus`

## VFP 9 Product Shape

The installed VFP 9 tree is not just an executable plus a runtime DLL.
It is a full platform distribution with these major layers:

- `vfp9.exe`
  - the 32-bit Windows GUI host executable
  - patched local version observed: `9.0.00.7423`
- localized resource DLLs
  - `VFP9ENU.DLL`
  - other language-specific UI/resource DLLs
- shared runtime DLLs in Common Files
  - `C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\vfp9r.dll`
  - `C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\vfp9t.dll`
- FoxPro-hosted application modules
  - `browser.app`
  - `builder.app`
  - `coverage.app`
  - `DataExplorer.app`
  - `foxcode.app`
  - `Foxref.app`
  - `objectbrowser.app`
  - `ReportBuilder.app`
  - `ReportOutput.app`
  - `ReportPreview.app`
  - `taskpane.app`
  - `Toolbox.app`
  - `wizard.app`
- source-like framework and tool assets
  - `Ffc`
  - `Tools`
  - `Wizards`
  - `Samples`
  - `Gallery`
  - `Toolbox`
- help and extension assets
  - `dv_foxhelp.chm`
  - `foxtools.fll`
  - `foxpro.h`
  - code-gen helpers like `genmenu.prg`, `scctext.prg`

That is the clearest reason parity cannot be reduced to parsing DBF-style assets. `vfp9.exe` is the host for a large set of FoxPro-native application modules and designer workflows.

## What `vfp9.exe` Tells Us

Local inspection of `vfp9.exe` shows:

- PE machine: `x86`
- subsystem: `Windows GUI`
- size of image: about `0x586000`
- patched file version: `9.0.00.7423`

Observed imported Windows subsystems include:

- `KERNEL32.dll`
- `USER32.dll`
- `GDI32.dll`
- `COMDLG32.dll`
- `COMCTL32.dll`
- `ADVAPI32.dll`
- `SHELL32.dll`
- `VERSION.dll`
- `OLEAUT32.dll`
- `OLE32.dll`
- `WINMM.dll`

That import shape says the host is tightly bound to:

- Win32 UI and windowing
- common controls and dialogs
- shell integration
- OLE/COM automation
- multimedia hooks

For Copperfin, that means parity requires more than file compatibility:

- desktop windowing and designer chrome
- shell-style file workflows
- automation/interoperability behavior
- COM-era compatibility boundaries

## What The `.app` Files Tell Us

The `.app` files in the VFP install are not ordinary PE executables.
Their headers do not begin with the PE `MZ` signature, which strongly suggests they are FoxPro-hosted application modules loaded by the VFP environment.

This matters because several high-value product surfaces are shipped as FoxPro applications rather than being hard-coded into `vfp9.exe`:

- report builder/output/preview
- browser/object browser/reference tooling
- task pane
- toolbox
- wizards/builders
- data explorer/member data editor

For parity, we should treat those as product subsystems in their own right:

- `ReportBuilder.app`, `ReportOutput.app`, `ReportPreview.app`
  - reporting is a platform subsystem, not a side feature
- `builder.app`, `wizard.app`
  - app generation and guided editing are part of the product
- `objectbrowser.app`, `browser.app`, `Foxref.app`
  - code/object inspection and navigation are part of the product
- `taskpane.app`, `Toolbox.app`
  - IDE shell workflow and discoverability are part of the product

## Shared Runtime Layer

The patched shared runtime DLLs live outside the main install tree:

- `C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\vfp9r.dll`
- `C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\vfp9t.dll`

That reinforces an important architectural split:

- IDE host
- shared runtime
- FoxPro application modules
- redistributable deployment story

Copperfin should preserve that separation even if our implementation technology changes.

## Framework And Product Content

The installed tree shows that VFP shipped as a complete business app platform:

- `Ffc`
  - foundation classes and framework behavior
- `Wizards`
  - scaffolding and business-app generation
- `Samples`
  - runnable pattern library and end-to-end examples
- `Tools`
  - developer utilities, analyzers, converters, explorers

This is why “full VFP 9 parity” includes all of the following:

- language/runtime behavior
- forms/class/report/menu/project designers
- framework classes
- builders and wizards
- project management
- report generation and preview
- reference/help/discoverability tools

## What The Older Fox Trees Add

`C:\vDosPlus` contains older DOS-era FoxBase/FoxPro material, including:

- `FOXBASE\MFOXPLUS.EXE`
- `FPD26\FOXPRO.EXE`
- `FPD26\FOXPRO.OVL`
- `FPD26\FOXPROX.EXE`
- many `.APP`-based tools, samples, and wizards

Those older trees are useful for:

- language and command behavior archaeology
- historical app packaging patterns
- wizard lineage
- report/menu/form workflow ancestry
- xBase-era migration behavior

But they are not the main source for reproducing the VFP 9 Windows IDE.

The old DOS product line helps most with:

- compatibility semantics
- legacy behavior expectations
- migration edge cases

The installed VFP 9 Windows tree helps most with:

- actual IDE/product architecture
- Windows host behavior
- designer surface expectations
- COM/automation-era integration

## Implications For Copperfin

To reproduce the full `vfp9.exe` experience, Copperfin needs all of these major product layers:

- native or native-hosted desktop IDE shell
- runtime and execution engine
- visual designers for forms, classes, reports, labels, menus, and projects
- FoxPro-hosted-tool equivalents
  - object browser
  - data explorer
  - toolbox
  - task pane
  - builders and wizards
  - report builder/preview/output
- framework class compatibility and migration support
- project build/run/debug workflow
- deployment story equivalent to IDE plus runtime plus redistributables

## Practical Guidance

Use local references like this:

- inspect `vfp9.exe` and the shared VFP DLLs for host/runtime boundaries
- inspect shipped `.app` modules to identify product subsystems we must replace
- inspect `Ffc`, `Wizards`, `Tools`, and `Samples` for workflow and behavior
- inspect source helpers like `scctext.prg` and `genmenu.prg` for clean-room clues about where executable behavior actually lives inside `SCX/VCX/MNX` assets
- use `C:\vDosPlus` mainly for older behavior/migration archaeology, not as the main IDE model

Concrete runtime guidance already surfaced from the local source tree:

- `scctext.prg`
  - treats `METHODS` as the textual source of behavior in `SCX/VCX`
  - explicitly excludes `OBJCODE` from the source-control text representation for `VCX`
  - that makes `METHODS` the safer clean-room execution seed for Copperfin
- `genmenu.prg`
  - shows `MNX` behavior is not modeled like forms/classes
  - menu procedure bodies live in menu-specific fields and generation paths rather than a simple `METHODS` blob
  - that is a strong clue that menu runtime parity will need a dedicated execution path

The key conclusion is simple:

`vfp9.exe` is the shell of a larger product organism.
Full parity means reproducing that organism, not merely opening FoxPro file formats.
