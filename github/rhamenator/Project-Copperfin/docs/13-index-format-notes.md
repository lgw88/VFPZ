# Index Format Notes

This phase adds a safe xBase index probe layer to the native asset inspector.

Current coverage:

- `CDX` and `DCX`
  - Minimal header probe for block size, root node offset, free node hint, key-length hint, and key-pool hint.
  - Treated as multi-tag index containers.
  - First-pass directory leaf-page parsing now surfaces stored tag names from plausible node pages, first-pass page-local key/`FOR` expression hints are attached on top of that parser, and focused regression coverage now exercises both direct `.dcx` probing and `DBC` companion discovery.
- `IDX`
  - Visual FoxPro single-index header probe.
  - Extracts root, free-list, and EOF offsets plus key and `FOR` expression hints.
- `NDX`
  - dBase-style single-index header probe.
  - Extracts root and EOF block hints, key length, maximum key count, group length, uniqueness flag, and key expression hint.
- `MDX`
  - First-pass block-level probe with printable-run tag hint enumeration.
  - Treated as a production multi-tag index container pending deeper layout, expression, and write parsing.

Current inspector behavior:

- Direct inspection recognizes `CDX`, `DCX`, `IDX`, `NDX`, and `MDX`.
- Table inspection looks for same-base companion indexes:
  - `table.cdx`
  - `table.idx`
  - `table.ndx`
  - `table.mdx`
  - `table.dbf.cdx`
  - `table.dbf.idx`
  - `table.dbf.ndx`
  - `table.dbf.mdx`
- DBF headers now expose `has_production_index()` so the same flag can support both FoxPro structural indexes and dBase production indexes.

Local reality checks used during implementation:

- `C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Tastrade\Data\customer.cdx`
- `C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Tastrade\Data\customer.dbf`
- `E:\DBASE\DBFS\CHNGREAS.NDX`

Reference docs used to keep the probe rules grounded:

- Visual FoxPro file-type reference:
  - <https://vfphelp.com/vfp9/html/71acd830-031d-40ee-bc2b-a8d9452d0efc.htm>
- dBASE table/header reference:
  - <https://www.dbase.com/Knowledgebase/INT/db7_file_fmt.htm>

Next implementation steps:

1. Extend the new `CDX/DCX` directory-page parsing into deeper per-tag metadata extraction instead of relying on expression matching heuristics for anything beyond first-pass key/`FOR` hints.
2. Deepen `MDX` parsing beyond printable tag hints into real layout and expression metadata extraction.
3. Add expression normalization and collation metadata extraction.
4. Correlate DBF field metadata with index expressions for migration planning.
5. Build read-only reindex validation against real VFP and dBase fixtures.
