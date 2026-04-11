# Copperfin Visual Studio Extension

This is the first installable VSIX baseline for Copperfin.

Current scope:

- targets Visual Studio 2022 and later compatible major versions
- builds an installable VSIX at `bin\Release\net472\Copperfin.VisualStudio.vsix`
- builds a standalone Windows shell at `..\Copperfin.Studio\bin\Release\net472\Copperfin.Studio.exe`
- builds UI smoke tests at `..\Copperfin.DesignerSmokeTests\bin\Release\net472\Copperfin.DesignerSmokeTests.exe`
- registers a FoxPro text content type for `PRG`, `H`, `QPR`, `MPR`, and `SPR`
- adds project-aware IntelliSense/statement-completion for FoxPro code files, including keywords, common functions, project symbols, aliases, and asset names
- adds first-pass Quick Info hover help for FoxPro keywords, functions, aliases, symbols, and asset names
- adds first-pass FoxPro call-signature help for common runtime functions such as `SELECT()`, `ALIAS()`, `SQLCONNECT()`, `SQLEXEC()`, `CREATEOBJECT()`, and `SYS()`
- adds `F12` go-to-definition navigation for indexed project procedures, functions, classes, defines, aliases, and common asset names
- registers a `Copperfin Visual Designer` editor for `PJX`, `SCX`, `VCX`, `FRX`, `LBX`, and `MNX`
- adds an `Open In Copperfin Studio` command under `Tools`
- adds the same command to Solution Explorer item context menus
- adds PJX-aware `Build`, `Run`, and `Debug` commands under `Tools` and the Solution Explorer item context menu
- opens a Copperfin document surface inside Visual Studio for registered asset types
- loads a structured object/property snapshot from the native Studio host for the open asset
- lets that document surface launch the native `copperfin_studio_host.exe`
- launches the native `copperfin_studio_host.exe` against the active document or selected project item
- supports inline editable `SCX/SCT` and `VCX/VCT` slices with object selection, a simple design surface, drag-move, and safe property edits sourced from flattened VFP `PROPERTIES` blobs
- supports inline editable `FRX/FRT` and `LBX/LBT` layout slices for `HPOS`, `VPOS`, `WIDTH`, `HEIGHT`, `EXPR`, and key font fields
- now uses a section-aware report/label shell with named bands, a modernized design surface, and a dedicated left-pane section explorer instead of treating reports and labels as flat record lists
- reuses the same shared WinForms designer controls in the standalone Copperfin Studio shell
- the standalone Copperfin Studio shell now opens multiple assets as tabs in one session instead of forcing one-document-at-a-time editing
- includes automated UI smoke tests that render the shared design surface and load real VFP sample assets
- supports asset-aware property-grid editing for `MNX/MNT` menu items
- now surfaces `PJX/PJT` as a grouped project workspace with item grouping, startup/build-plan summary, and project-entry editing
- now surfaces the platform's native security/RBAC stance and `.NET`/Python/MCP extensibility story inside project workspaces
- now surfaces a shared project debugger pane for `PJX` workflows, backed by the native runtime host and showing pause reason, call stack, locals, globals, and runtime events
- now surfaces shared `Task List`, `Code References`, `Data Explorer`, `Object Browser`, `Toolbox`, `Builders`, `Coverage`, and `Database` panes for project workspaces so Visual Studio and standalone Studio share more VFP-style utility-window behavior
- now makes the modern extensibility story more explicit inside project workspaces, including Python/R sidecars plus user-selected AI debugging assistance through policy-controlled AI/MCP integrations
- now carries a native database-federation profile into the shared shells so relational, document, and vector query-planning stories show up beside classic project tooling

Current limitations:

- the registered document surface is still a first designer shell, not yet a full inline VFP 9-fidelity designer across all asset families
- the standalone Studio shell is still a managed host around the shared designer controls, not the finished native IDE experience
- the highest-fidelity inline layout experience is still in the form/class/report/label families rather than project-system tooling
- it still relies on the external native build/runtime hosts for project build/debug/run workflows instead of owning a full in-process Copperfin compiler/debugger inside Visual Studio
- it does not yet render forms/reports inline inside the Visual Studio document with full VFP 9 fidelity, even though reports and labels now have a section-aware designer shape
- the debugger pane is a first runtime-facing surface, not yet the finished VFP 9-level watch/coverage/task-window experience
- the new project utility panes are still summary-first panes, not yet the full interactive VFP 9-equivalent Project Explorer/Data Explorer/Object Browser/Coverage toolchain
- database federation and polyglot query translation are now modeled in the shell, but the actual backend translators still need deeper implementation beyond the current architectural contract
- FoxPro editor assistance is still a first pass inspired by VFPX and XSharp patterns, not yet a full semantic language service with rename, refactor, or complete symbol resolution

Why VS 2022 as the baseline:

- Visual Studio 2022 is the 64-bit turning point that matches Copperfin's x64-first direction
- Microsoft ships the relevant managed extension SDK for VS 2022 through NuGet packages in the `17.x` line
- supporting older IDEs would add compatibility drag before we have the actual designer stack built
- Visual Studio Code is not the primary target for VFP-style designers because its extension model is much weaker for host-integrated visual editors, designers, and project-system experiences

Build note:

- the extension currently looks for `copperfin_studio_host.exe` at `COPPERFIN_STUDIO_HOST_PATH`
- if that variable is not set, it falls back to `E:\Project-Copperfin\build\Release\copperfin_studio_host.exe`

Suggested first-use flow:

1. Build `copperfin_studio_host.exe`
2. Rebuild the VSIX project
3. Install `bin\Release\net472\Copperfin.VisualStudio.vsix`
4. Open or select a `PJX`, `SCX`, `VCX`, `FRX`, `LBX`, or `MNX` file in Visual Studio
5. Double-click the asset to open the `Copperfin Visual Designer` shell, or use `Tools -> Open In Copperfin Studio`

Suggested UI regression flow:

1. Build `..\Copperfin.DesignerSmokeTests\Copperfin.DesignerSmokeTests.csproj`
2. Run `..\Copperfin.DesignerSmokeTests\bin\Release\net472\Copperfin.DesignerSmokeTests.exe`
3. Keep the smoke tests green as report/label/form/project shells evolve

Repeatable Windows validation:

```powershell
E:\Project-Copperfin\scripts\validate-windows.ps1
```
