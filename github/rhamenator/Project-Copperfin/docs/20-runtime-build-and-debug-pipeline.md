# Runtime, Build, And Debug Pipeline

Copperfin now has a first real runtime/build/debug pipeline slice instead of only design-time inspection.

Current native components:

- `copperfin_build_host.exe`
  - opens a `PJX/PJT` project
  - derives a runtime package plan from the project workspace
  - stages project assets into a package content tree
  - emits a runtime manifest and a debug manifest
  - bundles the native Copperfin runtime host
  - can generate and publish a `.NET` launcher executable beside the native host
- `copperfin_runtime_host.exe`
  - reads the Copperfin runtime manifest
  - executes `PRG` startup code through a native xBase runtime session
  - supports real breakpoints plus `step`, `next`, and `out` debugger actions for `PRG` execution
  - now emits structured-enough pause-state text for shared debugger panes, including call stack, locals, globals, and runtime events
  - now also bootstraps runnable `SCX/VCX/MNX` startup behavior through generated `PRG` wrappers
  - now also boots `FRX/LBX` startup assets into direct preview/event-loop mode
  - now loads full executable xAsset tables instead of only the small Studio preview slice
  - now treats `ACTIVATE MENU` and `ACTIVATE POPUP` as event-loop operations in the native runtime
  - now supports runtime action dispatch commands such as `select:<action-id>` and `invoke:<action-id>` while paused in a waiting xAsset
  - still falls back to compatibility-mode launch reporting for non-runnable xAssets and other non-`PRG` startup assets

Current package layout:

- `app.cfmanifest`
  - runtime-facing manifest
  - points at staged package content
- `app.cfdebug`
  - source/debug-facing manifest
  - points at original source assets for IDE/debug workflows
- `content/`
  - staged `PRG`, `SCX`, `VCX`, `FRX`, `LBX`, `MNX`, and related project assets
  - now also stages memo/index sidecars needed for packaged runtime fidelity, such as `SCT`, `VCT`, `FRT`, `LBT`, `MNT`, `PJT`, `FPT`, and structural index companions when present
- `copperfin_runtime_host.exe`
  - native runtime/debug launch host
- optional generated launcher
  - `.NET` executable published beside the native runtime host

Current CLI flow:

```powershell
E:\Project-Copperfin\build\Release\copperfin_build_host.exe build `
  --project "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx" `
  --output-dir "E:\Project-Copperfin\artifacts\runtime-smoke" `
  --configuration debug `
  --enable-security `
  --emit-dotnet-launcher
```

```powershell
E:\Project-Copperfin\artifacts\runtime-smoke\SOLUTION\SOLUTION.exe --debug
```

```powershell
E:\Project-Copperfin\artifacts\runtime-smoke\SOLUTION\copperfin_runtime_host.exe `
  --manifest "E:\Project-Copperfin\artifacts\runtime-smoke\SOLUTION\app.cfmanifest" `
  --debug `
  --breakpoint 12 `
  --debug-command continue `
  --debug-command step `
  --debug-command out
```

```powershell
E:\Project-Copperfin\build\Release\copperfin_runtime_host.exe `
  --manifest "E:\Project-Copperfin\artifacts\menu-debug-smoke\app.cfmanifest" `
  --debug `
  --debug-command continue `
  --debug-command select:shortcut.item1 `
  --debug-command select:shortcut.item3 `
  --debug-command select:thisitemha.item3
```

```powershell
E:\Project-Copperfin\build\Release\copperfin_runtime_host.exe `
  --manifest "E:\Project-Copperfin\artifacts\xasset-debug-smoke\app.cfmanifest" `
  --debug `
  --debug-command continue `
  --debug-command invoke:frmbooks.release
```

```powershell
E:\Project-Copperfin\build\Release\copperfin_runtime_host.exe `
  --manifest "E:\Project-Copperfin\artifacts\report-debug-smoke\app.cfmanifest" `
  --debug `
  --debug-command continue
```

Current behavior:

- runtime packaging is `Windows-first`
- generated packages are `x64`
- `.NET` launchers are emitted as `net8.0-windows` executables
- packaged runtime manifests now point at staged package content instead of stale legacy source paths
- debug manifests keep source-side paths so Visual Studio and the standalone Studio shell can debug against the editable source tree
- `PRG` startup paths now advertise real breakpoint and step-debugging support in the debug manifest
- the shared Visual Studio and standalone Studio project shells can now build a project and surface a first integrated debugger pane on top of the native runtime host
- runnable `SCX/VCX` startup assets can now be executed through generated method bootstraps from both source trees and packaged content
- runnable `FRX/LBX` startup assets can now be executed as direct preview/event-loop surfaces
- runnable `MNX/MNT` startup assets can now execute setup code and activate shortcut/menu event loops through a dedicated menu bootstrap model
- waiting menu runtimes can now dispatch concrete menu-item actions back into the native runtime
- deeper menu trees now participate in runtime execution because xAsset bootstrapping reads the full `MNX` table instead of the eight-record Studio preview
- waiting form/class/report/label xAssets now expose extracted methods as dispatchable runtime actions for debugger-driven invocation
- `DO FORM` now resolves quoted/space-containing paths through the same normalized asset-path flow used by other surface-launch commands
- startup assets that legacy projects mark as excluded are now still staged when they are required for runtime startup
- packaged xAsset startup paths now carry their memo sidecars forward so the bootstrap runtime can open real designer assets instead of dead table shells

Current limitations:

- the native execution engine is `PRG-first`, not yet the full FoxPro/VFP command/runtime surface
- xBase code embedded in `SCX/VCX` assets is now partially executable through `METHODS` bootstrapping, but deeper event/lifecycle fidelity still needs work
- `MNX` startup activation plus first nested submenu dispatch now work, but richer menu navigation, broader command routing, and broader surface parity still need work
- `FRX/LBX` now launch directly into preview/event-loop mode, but richer report execution semantics, expression evaluation, output generation, and designer/runtime parity still need work
- package manifests are line-based metadata, not the finished long-term runtime format
- build output planning is still driven by current `PJX` heuristics rather than a fully compatible FoxPro compiler/runtime

What this unlocks next:

- Visual Studio build/run/debug commands can target a real package pipeline
- the standalone Studio shell can run the same build/package flow and reuse the same debugger surface
- the future Copperfin runtime can take over the same manifest/package contract without throwing away the host and launcher work
