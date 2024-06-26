Local lcVersionFile, lcVersionText

lcVersionFile = 'InstalledFiles\ObjectExplorerVersion.h'
Erase (m.lcVersionFile)

lcVersionText = Textmerge('#DEFINE VERSION_NUMBER "Ver <<pcVersion>> : <<pcVersionDate>>"')
Strtofile(m.lcVersionText, m.lcVersionFile)

