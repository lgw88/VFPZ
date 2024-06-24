### GoFish Classic 5.2.02 - Released 2024-02-03

* Added link to Issues page for GoFish Classic (at bottom left of main form).

### GoFish Classic 5.2.01 - Released 2024-02-02

#### Enhancements
* The "Code Only" checkbox filter has been enhanced to find matches in some places previously ignored. It now also includes code matches found:
    * In #Define statements
    * In MNX files in `Command`, `Procedure`, or `SkipFor` fields
    * In FRX files in `Field` records (`ObjType = 8`)
* New checkbox filter "Comments Only" has been added.

    ![](images/CommentsOnly.png)
* The Code View pane for matches in MNX files has been enhanced to be more descriptive.

    ![](images/CodeViewFor%20MNX.png)
* When opening a code window to edit, the match to the search text is highlighted.  (This code originally implemented in GoFish6 and replicated here)
* Colors in the Code View pane match the user's own colors in code windows. (Experimental)
* Removed confusing "match anywhere" checkbox in filter form; it always matches anywhere.
* Controls in the Options form referring to planned enhancements in GoFish6 have been removed.

#### Bug fixes
* When the match is to a file name of a text file (such as a PRG), the Code View pane shows the text correctly.  Previously the beginning text was lost.
* Highlighting (red box) around "Whole Word" now refreshes properly.

***

### GoFish Classic 5.1.009 - Released 2023-09-30
* Resurrected older version, now known as "GoFish Classic"

### GoFish 5.1.009 - Released 2023-01-31
* Fixed: Fixed problem with wrong object addressed in backup issue #41

### GoFish 5.1.008 - Released 2022-11-23
* Fixed: Problem with filter settings storage place from filter form #38

### GoFish 5.1.007 - Released 2022-11-22
* Fixed: Problem with Filter form issue #36

### GoFish 5.1.006 - Released 2022-11-11
* Fixed: Problem with Collate and expression length issue #34

### GoFish 5.1.005 - Released 2022-11-09
* Fixed: Highlighted match not visible in code view for SCX/VCX issue #27 
* Fixed: Due to unlucky git settings, some text files wher line end with LF instead of CRLF
* Improved: git line end logic forces checkin-as-is checkout-as-is for this repo

### GoFish 5.1.004 - Released 2022-11-01
* Fixed: GF_Search_History_Form_Settings.xml written to default folder. issue #31 
* Fixed: User preference settings ignored and overwritten. issue #29 
* Fixed: Startup parameter ignored. issue #21
* Fixed: Load history form should provide keyboard access to grid. issue #10
* Improved: buildgofish.prg forces to use of VFP9 SP2

### GoFish 5.1.003 - Released 2022-10-29
* Fixed: User preference settings ignored and overwritten. issue #29
* Fixed: Opening Filter dialog fails with class not found. issue #28

### GoFish 5.1.002 - Released 2022-10-23
* Fixed: problem with deleted settings file on startup. issue #25
* Improved: Issues bug template.

### GoFish 5.1.001 - Released 2022-10-21
* Fixed: Problem registring with Thor  issue #23

### GoFish 5.1.000 - Released 2022-10-19
* New: Option for local settings. Allows local settings and history. Select storage location if local.
* Improved: Storage of some options separated from search settings.
* Fixed: Setting Desktop will engage if form is not closed with *Ok*  issue #19
* Fixed: problem with deleted settings file on startup. issue #17

### GoFish 5.0.209- Released 2022-10-17
* Just to force right verison of the app

### GoFish 5.0.208- Released 2022-10-16
* Improved: Added options to allow control of several colours

### GoFish 5.0.206- Released 2022-10-16
* Fixed: The View Replace History button wasn't working because of a renamed file.

### GoFish 5.0.207- Released 2022-10-16
* Improved: Added option to allow code window to be opened at stored position. (Option: Open code windows at top left corner)

### GoFish 5.0.205- Released 2022-08-16
* Fixed: When the results are shown and the order of the results is changed by clicking the header of column "Proccode", "Statement" or "Code" then the error "SQL: ORDER BY clause in invalid" was thrown. This was fixed by also excluding these columns in the functions "SortColumn" and "SortColumSecondary".
* Fixed: When the search option "Whole word" was active then it could happen that too many higlightings where shown in the HTML preview. This affected only lines with an appropiate result (matching "Whole word") and having another inappropiate result (not matching "Whole word).
* Improved: Some changes were made to "gofishsearchengine.prg" so that GF can wrap up the results even faster.
* Fixed: On clicking "Edit" to open the file of the selected result could lead to error "Variable 'CR' is not found.".
* Fixed: For results that are part of a class-container and used in a form with a formset GF showed a wrong "name" (or you may call it "path") in the results. 
* Improved: When clicking "Edit" to open a form or class of the selected result and this file could not be opened then nothing happened. From now on GF will tell you that the file can´t be opened and why not.

### Gofish 5.0.202 - Released 2022-06-24
* Made the setting of Desktop for the main GoFish form an option

### Gofish 5.0.201 - Released 2022-05-19
* Set Desktop to .T. for the main GoFish form so it can be moved outside the VFP window

### Gofish 5.0.200 - Released 2022-05-14
* Changed CodePlex references to VFPX and removed reference to BitBucket
* Fixed "constant already defined issue" when building app
* Removed unneeded files from the repository
* Fixed an error displaying the options dialog
* Improved the build process

### Gofish 5.0.170 - Released 2021-03-24
1. GoFishSearchEngine class: Fixed folder paths for cFilesToSkipFile, cReplaceDetailTable, cReplaceDetailTable.
2. Options Form-> Replace tab: Added read-only fields to show values for cReplaceDetailTable and cReplaceDetailTable.

### Gofish 5.0.169 - Released 2021-03-24
1. Removed matches from a Project PJX on the "Key" field (i.e. Match Type = "<Key>" in the results grid.)

### Gofish 5.0.168 - Released 2021-03-23
1. In the search results grid, if **Match Type** is`<<<Filename>>` (i.e. matching a filename in a Project), then double-clicking on the row will now open the file with correct editor. (Contributed by Jim Nelson)
2. In the search results treeview, the results are now ordered by Class, Filename, FilePath. (Contributed by Jim Nelson)
3. GoFishSearchEngine.vcx has been converted to PRGs file. The 2 classes in the VCX are replaced by GoFishSearchEngine.prg and GoFishSearchOptions.prg. This was done to remove binaries (VCX) from the code base, in hopes of making it easier to maintain the source code in a more source control friendly style.
4. Converted GF_PEME_BaseTools.vcx to prg.

### Gofish 5.0.164 ** - Released 2021-03-19
1. Fixed a bug in Delete feature of Search History form that could allow GF to delete (essentially) all files and folders starting at the root path of the disk. Error was reported in Issue #9 on the GitHub Issue Tracker. https://github.com/mattslay/GoFish/issues/9
2. Added text source code files for VCX and SCX files, as generated by FoxBin2Prg.
3. Thor maintainers will need to release a new `Thor_Update_GoFish5.prg` updater to distribute this update.

