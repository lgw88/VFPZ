# Reference Map

## Local References

Installed VFP 9:

- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209)
- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9\Ffc`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209/Ffc)
- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209/Wizards)
- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209/Samples)
- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9\dv_foxhelp.chm`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209/dv_foxhelp.chm)
- [`C:\Program Files (x86)\Microsoft Visual FoxPro 9\foxtools.chm`](C:/Program%20Files%20(x86)/Microsoft%20Visual%20FoxPro%209/foxtools.chm)
- [`docs/generated/vfp-chm-command-topics.json`](E:/Project-Copperfin/docs/generated/vfp-chm-command-topics.json)
- [`docs/generated/vfp-foxtools-topics.json`](E:/Project-Copperfin/docs/generated/vfp-foxtools-topics.json)
- [`docs/generated/vfp-chm-topic-manifest.json`](E:/Project-Copperfin/docs/generated/vfp-chm-topic-manifest.json)

Legacy local help fallback:

- [`C:\vDosPlus\FPD26\FOXHELP.DBF`](C:/vDosPlus/FPD26/FOXHELP.DBF)

Mounted VFP 9 media:

- [`H:\program files\microsoft visual foxpro 9`](H:/program%20files/microsoft%20visual%20foxpro%209)

Legacy/reference code on `E:\`:

- [`E:\xBaseEngineRFV`](E:/xBaseEngineRFV)
- [`E:\VFPSource`](E:/VFPSource)
- [`E:\VFPSource\ReportBuilder`](E:/VFPSource/ReportBuilder)
- [`E:\VFPSource\DataExplorer`](E:/VFPSource/DataExplorer)
- [`E:\VFPSource\taskpane`](E:/VFPSource/taskpane)
- [`E:\VFPSource\toolbox`](E:/VFPSource/toolbox)
- [`E:\VFPSource\obrowser`](E:/VFPSource/obrowser)
- [`E:\VFPSource\foxref`](E:/VFPSource/foxref)
- [`E:\DotNetFromVFP`](E:/DotNetFromVFP)
- [`E:\VFP - Installers`](E:/VFP%20-%20Installers)

## Web References

- [Microsoft Learn VFP language reference](https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/dd5f4hyy(v=vs.71))
- [Microsoft Learn VFP general reference](https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/h9f898ae(v=vs.71))
- [Microsoft Learn VFP home page](https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/mt490117(v=msdn.10))
- [VFPX project index](https://vfpx.github.io/projects/)
- [VFPX FFC](https://github.com/VFPX/FFC)
- [VFPX ReportingApps](https://github.com/VFPX/ReportingApps)
- [VFPX HelpFile](https://github.com/VFPX/HelpFile)
- [VFPX VFPInstallers](https://github.com/VFPX/VFPInstallers)
- [VFPX DataExplorer 3](https://vfpx.github.io/projects/)
- [VFPX Project Explorer](https://vfpx.github.io/projects/)
- [VFPX TaskPaneManager](https://vfpx.github.io/projects/)
- [VFPX Toolbox](https://vfpx.github.io/projects/)
- [VFPX CodeReferences](https://vfpx.github.io/projects/)
- [VFPX Automated Test Harness](https://vfpx.github.io/projects/)
- [VFPX GoFish](https://vfpx.github.io/projects/)
- [VFPX PEM Editor](https://vfpx.github.io/projects/)
- [VFPX GoToDefinition](https://github.com/VFPX/GoToDefinition)
- [VFPX FoxcodePlus](https://github.com/VFPX/FoxcodePlus)
- [VFPX FoxBin2Prg](https://vfpx.github.io/projects/)
- [VFPX ProjectHookX](https://vfpx.github.io/projects/)
- [VFPX FoxUnit](https://vfpx.github.io/projects/)
- [VFPX FoxMock](https://vfpx.github.io/projects/)
- [VFPX DeployFox](https://vfpx.github.io/projects/)
- [VFPX pdfium-vfp](https://vfpx.github.io/projects/)
- [VFPX VFPRuntimeInstallers](https://vfpx.github.io/projects/)
- [XSharpPublic](https://github.com/X-Sharp/XSharpPublic)

## Key Lessons Pulled From The References

- FFC indicates the framework layer is central.
- ReportingApps proves reporting deserves its own maintained subsystem.
- Local `ReportBuilder`, `DataExplorer`, `taskpane`, `toolbox`, `obrowser`, and `foxref` source trees are direct clean-room guidance for Copperfin report surfaces, data explorer tooling, task panes, toolbox UX, object browsing, and code/reference search.
- HelpFile shows documentation gaps become operational risk.
- The official Learn language reference is now the canonical command/function inventory for Copperfin parity planning, with local VFP help, generated CHM manifests, and `FOXHELP.DBF` serving as fallbacks when individual pages are incomplete or inaccessible.
- The VFPX project index highlights community successors for project explorer, data explorer, toolbox/task panes, code references, and automated testing, which are all directly relevant to Copperfin's missing parity surfaces.
- The broader VFPX ecosystem also highlights project hooks, source-control-friendly serializers, property/method tooling, automated testing, deployment helpers, and PDF/report adjuncts that Copperfin should treat as real subsystem inputs rather than optional trivia.
- `GoToDefinition` and `FoxcodePlus` are especially relevant to the editor parity story: they validate definition navigation, richer member hints, error-list-style assistance, and deeper IntelliSense as expected IDE behavior for FoxPro developers.
- The local `foxref`, `DataExplorer`, `toolbox`, `tasklist`, `taskpane`, `coverage`, `obrowser`, and `builders` trees are now the clearest next-wave parity references for code references, data exploration, toolbox/task panes, coverage, object browsing, and builder workflows.
- `DataExplorer` points toward an explorer-first workspace with object-specific actions such as browse, query generation, definition viewing, and procedure execution instead of a flat inspector-only pane.
- `toolbox` points toward a customizable operator palette with categories, favorites, saved filters, and add-in extensibility rather than a hard-coded command strip.
- `obrowser` points toward progressive search and noise-control toggles so deep object inspection stays usable at scale.
- `tasklist` points toward task items that stay attached to real files, classes, methods, and lines instead of becoming detached notes.
- `builders` and `coverage` point toward context-aware builders plus explicit analysis/export modes for debugging and quality tooling.
- XSharp shows that an xBase-family stack can sustain a modern compiler, runtime, project system, and tools layer inside the contemporary .NET and Visual Studio ecosystem, which reinforces Copperfin's hybrid native-runtime plus VS-host strategy.
- The installed `foxtools` help and extension files point toward a narrow dispatch-style native extension boundary, which is more useful to Copperfin as an interop/reference clue than as a direct implementation model.
- The wizard/template system shows productivity and scaffolding are core product value.
- Your local xBase/FoxPro-era code provides a starting point for file engine and compatibility research.
- A modern successor should not trap users on DBF alone; connector-based SQL support is part of the modernization value proposition.
