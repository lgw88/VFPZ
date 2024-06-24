Local lcVersionFile, lcVersionText

lcVersionFile = 'InstalledFiles\Procs\Pandora.h'
Erase (m.lcVersionFile)

lcVersionText = Textmerge('#DEFINE VERSION_NUMBER "Pandora V <<pcVersion>> : <<pcVersionDate>>"')
Strtofile(m.lcVersionText, m.lcVersionFile)

