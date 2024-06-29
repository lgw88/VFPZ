Welcome to the Coverage Profiler Performance addin

This addin takes all lines in your coverage profiler, grabs the associated code and allows you to sort lines and see the lines with best and worst performance.

Although it was written as a Coverage Profiler addin, it will run as a standalone application also.

This Coverage addin simply grabs the information such as source code and performance from the information the coverage profiler gleans from the coverage log and displays it in a grid format.  By clicking on the headers for each column of the grid it will sort by that column.  You may reset the grid to the original order from the "Reset order to original"

Features:
Sort on each column.  Each time you click on the column header, it changes between Ascending and Descending.

Save the table so it can be opened later without having to reparse the log.

Open a new coverage log or saved coverage performance table.

Start and stop coverage profiling from within the form.  The log will parsed and displayed after you stop coverage profiling.

Open a coverage log in 4 different ways:  
		
		1.  Pass the path of the coverage log on the command line 
		2.  Open the log from the toolbar on the form
		3.  Run the addin form with do covaddin.scx and it will prompt for a log
		4.  Select the form from the addin button in the Coverage Profiler and it will process the open coverage log

Open a saved coverage profiler performance table in 2 ways:
		
		1.  Pass the path of the coverage performance table on the command line 
		2.  Open the table from the toolbar on the form

Other features:

Search Dialog

Search for a string in the search dialog.  Also, you can use simple expressions in the Search dialog on the numeric columns.  For instance, enter an expression such as >.5 and select one of the numeric columns such as total and search for lines with a value of >.5


Filters

You can select installed or user created filters in the filter combobox.  You can create new filters from the toolbar and it will be added to the filter combobox and persisted between sessions.  The filter expressions are saved in a text file covprofaddin.cfg.  If this file is deleted it will be created at startup.  You can delete a filter in the combobox with the delete key
Clear all filters with the toolbar button next to the filter combo.

Edit Source

There is a toolbar button to edit any line of source or you may double-click any line of code to edit the referenced file and it's source.


Options Dialog

The options dialog allows you to select values for the percentage of slow lines or methods displayed in the method and slow lines report.  You can change the durations and fields that are used to highlight slow lines.  You can change the highlight color here also.
Change the fonts used for the grid here also.  The settings are not persisted between sessions.


Reports

There are 2 simple reports for printing purposes
	1. View a simple report of the top percentage of slow lines (Percentage set in the Options dialog) of slow lines.
	2. View a simple report of the top percentage of slow methods that totals the time spent in each method.

Misc
View skipped files.

Known issues:
This addin uses the coverage profiler in unattended mode when run in standalone mode.  Because of this, if the source files can not be found, you will not be prompted for their location.  If this is a problem, run this as a coverage profiler addin.  If none of the source files can be found it will exit prior to displaying anything with a message about "no usable records".  If some of the files can be found but not all, check the "missed files" button to see which files were skipped.

The source lines may not appear to be in the correct order under some circumstances.

We try to validate a coverage log or saved coverage performance table prior to opening, but if they are not valid and we don't catch it there will be errors.

This form was designed for VFP9 of course but will run from other versions of VFP (7 and 8).  It will only run in standalone mode in VFP7 when passing a coverage performance table and not a coverage profiler log.

When closing the form, you are prompted twice that we are going to clean up temporary files.  We delete the temporary tables and xml files left behind by the coverage profiler so delete at you own risk.