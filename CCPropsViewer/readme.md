# Cursor and Connector Properties Viewer

**This library is for displaying and setting cursors a connect properties.**

**Bugs: **
- Any bug under VFP 9.0

**New:**
- Suport for AsTopLevel form

1) Dialog description
2) Using
3) Zero connection and zero cursor
4) Example
5) File list
6) Problems

## 1) Dialog description
Button "Refresh" reload values.
Button "Options" call form for setting autorefresh interval (ms). If value is 0, then autorefresh don't call.
Button "Set properties" save changed value.
Button "OK" close form.

Other controls with gray backcolor are read-only.
Other controls with green backcolor are properties which you can set on for zero connaction or cursor.


## 2) Using
Cursor Properties:
```foxpro
SET CLASSLIB TO proper.vcx ADDITIVE
xx=CREATEOBJECT("_prop_cursor")
xx.Set(ALIAS()) && show properties for current alias (string)
xx.Set(SELE()) && show properties for current alias (number)
xx.Set(0) && show properties for zero alias
```

Connect Properties:
```foxpro
SET CLASSLIB TO proper.vcx ADDITIVE
xx=CREATEOBJECT("_prop_connect")
xx.Set(1) && show properties for connection with handle 1
xx.Set(0) && show properties for zero connection 
```

Running modal dialog:
```foxpro
SET CLASSLIB TO proper.vcx ADDITIVE
xx=CREATEOBJECT("_prop_connect")
xx.Show=1 && modal dialog (2 is modeless)
xx.Set(0) && show properties for zero connection 
```

Running dialog "As Top Level":
```foxpro
SET CLASSLIB TO proper.vcx ADDITIVE
xx=CREATEOBJECT("_prop_connect")
xx.AsTopLevel=.T.
xx.Set(0) && show properties for zero connection 
```

## 3) Zero connection and zero cursor
VFP can set properties for default cursor and connection - 0 (zero).
 VFP use these properties for new connections and cursors created by local view, remote view, `SQLEXEC()` and CursorAdapter.


## 4) Example
 The exmaple is in folder example, file test.prg.
 The file contain sample for openned table, local view, remote view a cursor created by CursorAdapter.


## 5) File list
proper.vcx,proper.vct - Visual library with needed class definition
cur_prop.h - Header file with needed any constants for internaly using
readme.md - Read me


folder example:
 XXD000.DBC,XXD000.DCT,XXD000.DCX - VFP database contain a link to DBF, connection to MDB, one local and remote view
 XXD000.MDB - Any MDB file with one table
 XXT000.DBF - Table linked to XXD001.DBC
 test.prg - Source code


## 6) Problems
This library is compiled under VFP 7.0. For other version is needly recompile before using.


