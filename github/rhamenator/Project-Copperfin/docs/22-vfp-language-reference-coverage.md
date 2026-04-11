# VFP Language Reference Coverage

This document anchors Copperfin's command/runtime backlog to the official Visual FoxPro reference instead of memory.

## Primary Sources

- Microsoft Learn language index:
  - <https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/dd5f4hyy(v=vs.71)>
- Microsoft Learn general reference:
  - <https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/h9f898ae(v=vs.71)>
- Microsoft Learn VFP home page:
  - <https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/mt490117(v=msdn.10)>
- Local fallback when Learn coverage is incomplete or too terse:
  - [`C:\vDosPlus\FPD26\FOXHELP.DBF`](C:/vDosPlus/FPD26/FOXHELP.DBF)
  - companion memo file in the same directory

## Generated Inventory

The generated command inventory lives here:

- [`docs/generated/vfp-language-reference-summary.json`](E:/Project-Copperfin/docs/generated/vfp-language-reference-summary.json)
- [`docs/generated/vfp-language-reference-commands.json`](E:/Project-Copperfin/docs/generated/vfp-language-reference-commands.json)
- [`docs/generated/vfp-language-reference-commands.txt`](E:/Project-Copperfin/docs/generated/vfp-language-reference-commands.txt)
- [`docs/generated/vfp-chm-index-summary.json`](E:/Project-Copperfin/docs/generated/vfp-chm-index-summary.json)
- [`docs/generated/vfp-chm-command-topics.json`](E:/Project-Copperfin/docs/generated/vfp-chm-command-topics.json)
- [`docs/generated/vfp-foxtools-topics.json`](E:/Project-Copperfin/docs/generated/vfp-foxtools-topics.json)
- [`docs/generated/vfp-chm-topic-manifest.json`](E:/Project-Copperfin/docs/generated/vfp-chm-topic-manifest.json)

Refresh it with:

```powershell
powershell -ExecutionPolicy Bypass -File E:\Project-Copperfin\scripts\export-vfp-reference-index.ps1
powershell -ExecutionPolicy Bypass -File E:\Project-Copperfin\scripts\export-vfp-chm-topic-index.ps1
```

Current official index snapshot from the Learn language-reference page:

- `429` command entries
- `413` function entries
- `323` property entries
- `83` method entries
- `72` system variable entries
- `69` event entries
- `22` object entries
- `4` preprocessor-directive entries
- `3` operator entries

Current local CHM snapshot from the installed VFP help set:

- `dv_foxhelp.chm` is the main product help and the command-behavior source that matters most
- `foxtools.chm` is supplemental and much smaller
- the local indexer now emits both a command-topic view and a broader topic manifest, so it can capture `foxtools` functions that are not indexed as `Command` topics
- the generated CHM outputs give local keyword-to-HTML mappings for offline behavior lookup, including `RegFn()`, `RegFn32()`, and `CallFn()`

## Current Copperfin Runtime Surface

The native runtime/parser currently has first-pass support for these command families:

- `DO`, `DO FORM`, `REPORT FORM`, `LABEL FORM`
- `ACTIVATE POPUP`, `ACTIVATE MENU`, `RELEASE POPUP`, `RELEASE MENU`
- `RETURN`
- `IF/ELSE/ENDIF`
- `DO CASE/CASE/OTHERWISE/ENDCASE`
- `FOR/ENDFOR`
- `DO WHILE/ENDDO`
- `LOOP`, `CONTINUE`, `EXIT`
- `TEXT/ENDTEXT` with first-pass literal `TEXT TO ... [ADDITIVE] [NOSHOW]` capture
- `LOCATE`
- `SCAN/ENDSCAN`
- `CALCULATE`
- `COUNT`
- `SUM`
- `AVERAGE`
- `TOTAL`
- `READ EVENTS`, `CLEAR EVENTS`
- `REPLACE`
- `APPEND BLANK`
- `DELETE`, `RECALL`
- `SET FILTER TO/OFF`
- `SET ORDER TO TAG`
- `SEEK`
- `GO` / `GOTO`
- `SKIP`
- `SELECT`
- `USE`, `USE IN`, `USE AGAIN`
- `SET DATASESSION TO`
- `SET DEFAULT TO`
- `SET`
- `ON ERROR`
- `PUBLIC`
- `LOCAL`

The current indexed-search slice covers `SET ORDER TO TAG`, command/function `SEEK`, `INDEXSEEK()`, `ORDER()`, `TAG()`, `SET EXACT`, `SET NEAR`, and command-level one-off `SEEK ... TAG/ORDER` probes for local DBF-backed cursors, and the runtime now preserves the actual inspected index-file identity for `ORDER(alias, 1)` plus `TAG(indexFile, ...)` across supported xBase index extensions instead of assuming `.cdx`.

The expression/function layer currently has first-pass support for these VFP-facing built-ins:

- `SELECT()`, `ALIAS()`, `USED()`, `DBF()`, `FCOUNT()`
- `RECCOUNT()`, `RECNO()`, `FOUND()`, `EOF()`, `BOF()`, `DELETED()`
- `COUNT()`, `SUM()`, `AVG()/AVERAGE()`, `MIN()`, `MAX()`
- `EVAL()` and first-pass `&macro` substitution in expression paths
- `SQLCONNECT()`, `SQLSTRINGCONNECT()`, `SQLEXEC()`, `SQLDISCONNECT()`
- `CREATEOBJECT()`, `GETOBJECT()`
- utility coverage already used by shipped tests and bootstrap paths, including `AT()`, `RAT()`, `SUBSTR()`, `ALLTRIM()`, `STR()`, `CHR()`, `FILE()`, `SYS()`, `MESSAGE()`, `ERROR()`, `VERSION()`, `ON()`, `SET()`, and `MESSAGEBOX()`

That SQL slice now includes session-scoped synthetic cursor materialization that follows the current selected work-area flow for each data session when `SQLEXEC()` auto-opens a result cursor, plus a first-pass read-only remote-cursor layer where synthetic SQL rows participate in field lookup, filter-aware navigation, `LOCATE`, aggregate built-ins, and `CALCULATE`.

## Immediate Runtime Backlog Derived From The Official Reference

The official command inventory is much larger than the current runtime. The deepest next command groups should stay focused on data/runtime compatibility first:

### Work Areas, Sessions, And Indexed Data

- finish the remaining alias/work-area edge cases across `SELECT`, `USE`, and nested data sessions after the first strict `USE ... IN <alias>` targeting pass, first-pass non-selected target preservation, plain `USE` current-work-area reuse, freed-work-area reuse plus side-effect-free `SELECT(0)` probing, stronger synthetic SQL cursor/session isolation, per-session SQL handle lifecycle cleanup, and broader session-local `SET` restoration coverage
- keep closing expression-driven work-area targeting edges so `USE IN <expr>` and adjacent state-inspection paths behave like practical VFP code expects
- deepen order/search behavior beyond the first `SET ORDER TO TAG` / `SEEK` / `FOUND()` pass
- add adjacent data-navigation and data-search commands where VFP developers expect them to work together
- use the command inventory to pull the next search/index/data-session commands in families instead of one at a time

### Local Table Mutation And Query Flow

- add the table-editing and table-browse commands needed for real legacy business applications
- keep strengthening the shared DBF/FPT mutation path so runtime commands do not regress FoxPro-compatible memo-backed tables, first-pass fixed-width `I`/`Y`/`T` field writes, and other core FoxPro field types, and keep the new indexed-table plus unsupported-layout fail-fast guards in place until real structural/indexed storage fidelity exists
- extend the shipped filtering, locating, scanning, replacing, appending, deleting, recalling, aggregate-built-in, command-level `COUNT`/`SUM`/`AVERAGE` with first-pass scope/`WHILE`/`IN`, first-pass `TOTAL` with `IN` targeting, and `CALCULATE` families toward broader xBase parity
- keep runtime semantics ahead of shell/designer work so the same engine can power both Visual Studio and the standalone IDE

### Native Control Flow

- extend the shipped `DO CASE/CASE/OTHERWISE/ENDCASE`, `DO WHILE/ENDDO`, `LOOP`/`CONTINUE`/`EXIT`, and first-pass literal `TEXT/ENDTEXT` slice into the rest of the FoxPro control-flow surface
- keep tightening expression semantics around stored-expression evaluation, macro substitution, and runtime-state inspection beyond the first-pass `EVAL()` / `SET()` / `&macro` slice
- add the next adjacent command families such as `TEXT/ENDTEXT`, `WITH/ENDWITH`, or other control/branch semantics in coherent batches

### SQL Pass-Through And Remote Cursor Behavior

- add the broader SQL pass-through surface around the existing `SQLCONNECT` / `SQLEXEC` / `SQLDISCONNECT` slice
- bring remote cursor semantics closer to local cursor expectations where VFP does so
- use the general reference and local help corpus when Learn pages list a command but do not capture enough behavioral detail

### Automation And Compatibility Utilities

- expand the OLE/COM compatibility surface around the current `CREATEOBJECT()` / `GETOBJECT()` slice
- keep host stability and debugger fault containment mandatory for automation failures

## How To Use The References

- Use the Learn language-reference index to decide what command/function families exist and to avoid missing major areas.
- Use the Learn general reference for file structures, table/index storage, and other low-level behavior.
- Use the generated local CHM command-topic index and topic manifest to jump from a command or `foxtools` function name to the installed VFP help page that describes its behavior.
- Use installed VFP 9 help and local source trees for product-era behavior and sample patterns.
- Use `FOXHELP.DBF` and its memo file as a fallback source for older semantics when Learn pages are missing, gated, or too shallow.
