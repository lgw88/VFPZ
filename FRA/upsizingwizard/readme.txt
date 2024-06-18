Quelles sont les nouveaut�s de cet Assistant Migration traduit en fran�ais?

En premier lieu, j'ai modifi� l'assistant pour pouvoir le localiser: la plupart des chaines �taient r�dig�es en anglais "en dur" dans le code, et j'ai donc ajout� de nombreuses constantes de traduction dans le fichier wizard.h (en fin de fichier) et dans les m�thodes init des classes UpsizingWizardForm et Advanced (elles sont dans la librairie upswiz.vcx).

Avec SQL Server 2005, les r�gles de l'art recommandent d'utiliser varchar(max) pour correspondre au Memo de VFP, et varbinary(max) pour correspondre au Blob de VFP.
Les d�finitions de types de donn�es sont stock�es dans la table typemap.dbf, qui est incluse dans l'app compil�.
Et justement, ces 2 d�finitions-l� ne figuraient pas dans typemap.dbf! Comme le champ RemoteType dans lequel sont stock�es les d�finitions n'avait pas la longueur requise pour "varbinary(max)", je l'ai modifi� en C(20). J'ai �galement d�fini ces 2 types de donn�es comme correspondances par d�faut pour SQL Server.
La correspondance par d�faut est d�finie dans le champ "default" de la table TypeMap.

J'ai corrig� une erreur capitale dans le UpsizeEngine.prg: Si dans une migration vers SQL Server, vous demandiez que vos r�gles RI soient migr�es en forme d�clarative, et que vous aviez plusieurs tables enfants relatives � la m�me table parent (plusieurs FK se r�ferrant � la m�me PK), alors vous obteniez une erreur parceque l'assistant essayait de cr�er une PK � chaque occurence de FK rencontr�e.
J'ai ajout� un test sur m.llPKexists=... � la ligne 175.

****************************************************
What's new in this French localised Upsizing Wizard?

First of all, I've set the wizard ready for localize: most of strings were "hard coded" in english directly in methods, so I've added a lot of new localisation constants in wizard.h (bottom of the file), and in init methods of UpsizingWizardForm class and Advanced class (in upswiz.vcx library).

With SQL Server 2005, it's a best practice to use varchar(max) - for mapping VFP Memo - and varbinary(max) - for mapping VFP Blob.
All data type definitions are stored in typemap.dbf, which is a included in the compiled app.
There was none of these 2 data types in typemap.dbf! and the RemoteType field of that table was not long enough to store "varbinary(max)", so I defined it as C(20), added these two data type as "by default".
Default mapping is stored in the boolean field "default" of table TypeMap.

I corrected a main error in UpsizeEngine.prg: an error was raised when you choose to upsize RI in declarative form (SQL Server) and if you have many child tables related to the same parent table (i.e. many FK referring to the same PK). In that case, upsizeengine failed while trying to create a PK for each FK.
I've put a test on m.llPKexists=... on line 175.


