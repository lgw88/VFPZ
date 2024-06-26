Readme.Txt for the Collection Inspector

This tool is designed to let you drill into object hierarchies, including collections, while debugging. To run it, issue the following command:

DO <path>Inspector.APP WITH oObject, "Object Name"

That is, you pass two parameters. The first is an object reference to the object you want to inspect. The second is the name to use for that object in the form; if you omit that parameter, a default value will be used. The object you pass must be in scope when you call the Inspector, so most often, you'll do this when sitting at a breakpoint in the application you're testing.

Once the tool is open, use the treeview to navigate. 

Send comments, questions and bugs to Tamar E. Granor, tamar@thegranors.com.