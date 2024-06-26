# ![](New%20Class%20Dialog%20Replacement_home.png) New Class Dialog Replacement

When you type CREATE CLASS ? in the Command Window, the native New Class dialog pops up and after having filled in only three fields a new class can be created. The required fields are:

1. the class name
2. the class it must be based on; in other words the parent class
3. the classlib that it must be stored in.

That’s all and that’s simple. But I think it is a little bit too simple. Why? It is the class name that troubles me. All text books and all gurus tell us that we must pay special attention to the name of a class. It should be created according to a scheme, a philosophy. For example, the scheme may prescribe that any class’s name starts with certain characters and/or contains a reference to the type of class.

Perhaps you say now: “Agree, but that is possible with the native New Class window, isn’t it? So, what’s your problem!” The problem I see is that it may be hard to understand and/or apply the scheme. Moreover, a developer in your team may show a lack of discipline. Of course, you might consider to fire that developer. But perhaps this person has other talents that you highly appreciate.

In the long run a myriad of inconsistent class names may have been created. By that time the names in your classlibs appear to be a mess and you start to have problems remembering their purpose.

What I have done is create an alternative New Class dialog that creates the class name, based on some choices. Moreover, there is code that enables us to integrate the dialog in the Project Manager. When the developer chooses New (Class) in the Project Manager, the alternative dialog will be invoked instead of the native one.

The project manager is Peter de Valença, mailto:pvalenca@viafox.nl

Release: [Newclass_stable1.zip](Newclass_stable1.zip)