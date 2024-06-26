# Object Inspector

Author: Tamar Granor

This tool is designed to let you drill into object hierarchies, including collections, while debugging. To run it, issue the following command:

```
DO <path>Inspector.APP WITH oObject, "Object Name"
```

That is, you pass two parameters. The first is an object reference to the object you want to inspect. The second is the name to use for that object in the form; if you omit that parameter, a default value will be used. The object you pass must be in scope when you call the Inspector, so most often, you'll do this when sitting at a breakpoint in the application you're testing.

You can also run this tool as follows:

* In a code window or the command window, click on the name of an object of collection and then call the tool.

* Or, place the mouse over an object in an executing form, or a form or class being edited in the IDE, and call the tool.

* Or, if a form or class is being edited, call the tool to inspect the currently selected object (that is, the one shown in the Property Sheet).

* Otherwise, call the tool to paste text into the command window so that you can supply the name of the object or collection of interest.

Once the tool is open, use the treeview to navigate. 

NOTE: Unfortunately, because of the way this tool is invoked, it doesn't work from the Thor tool bar.

Send comments, questions and bugs to Tamar E. Granor, tamar@thegranors.com.