# FFC

**Microsoft Visual FoxPro 9.0 Foundation Classes**

The Visual FoxPro visual class (.vcx) libraries located in the Visual FoxPro FFC directory. They contain a variety of foundation classes for enhancing Visual FoxPro applications with little or no programming. You can freely distribute the foundation classes with your applications. The license governing the FFC source is contained in release (see FFC_EULA.txt).

## Release History

2014.07.04: this release fixes a bug in FRXCursor that didn't handle higher DPI displays properly (thanks to Joel Leach).

2013.03.09: this release fixes the "SET TALK" bug described in <a href="https://cathypountney.blogspot.com/2009/04/set-talk-appears-to-be-on-when-running.html" target="_blank">https://cathypountney.blogspot.com/2009/04/set-talk-appears-to-be-on-when-running.html</a>

## MailMerge Class Notes

To use:

    oMM = CREATEOBJECT("MailMerge")
        && create object
    oMM.cAppTitle = "My Application"
        && application name, used in Alerts	
    oMM.nWordProc = nWordProc
        && word processor (1 = Word 6+; 2 = CommaDelim; or
        user-defined (see below); default = 1)
    oMM.nNewDoc = nNewDoc
        && is it a new doc (1 = new, 2 = existing;
        default = 1)
    oMM.nTemplate = nTemplate
        && type of main document (Word only, 1 = form letter;
        2 = label; 3 = envelope; 4 = catalog; default = 1)
    oMM.cDocName = cDocName
        && doc file if not new
    oMM.cAlias = cTableAlias
        && alias of source table or view
    oMM.cDBCTable = cTableName
        && table name if table is part of a DBC
    oMM.cDBCName = cDatabaseName
        && DBC name if source table is part of a DBC
    ACOPY(aMyFields, oMM.aAutoFields)
        && fill in array of field names to be used
    oMM.Merge
        && do the merge

In the following example, the sample data table customer is used to create a new mailmerge form letter document in MS-Word (the defaults), using the customer.company and customer.city fields:

    ox = newobject("mailmerge",HOME()+"FFC\mailmrge.vcx")
    use c:\vfp\samples\data\customer
    set database to testdata
    ox.cAlias = "customer"
    ox.cdbctable = "customer"
    ox.cdbcname = DBC()
    DIMENSION ox.aAutoFields[2]
    ox.aAutoFields[1] = "company"
    ox.aAutoFields[2] = "city"
    ox.makeoutput

To add a custom mailmerge function:

    oMM = CREATE("MailMerge")
    DIMENSION oMM.aWPMrg[ALEN(oMM.aWPMrg,1) + 1]
    oMM.aWPMrg[ALEN(oMM.aWPMrg,1)] = "MyMailMergeFunction"
    oMM.nWordProc = ALEN(oMM.aWPMrg,1)

or just replace an existing one:

    oMM.aWPMrg[2] = "MyMailMergeFunction"
    oMM.nWordProc = 2

## PivotTable Class notes

To use:

    USE (HOME() + "samples\data\orders")
    SET DATABASE TO testdata
    DIMENSION aflds[4,1]
    aflds[1,1] = "to_country"
    aflds[2,1] = "ship_via"
    aflds[3,1] = "order_amt"
    aflds[4,1] = "emp_id"
    DIMENSION aFList[1,1]
    =AFIELDS(aFList)

    ox = NewObject("pivottable",HOME()+"FFC\pivtable.vcx")
    oPiv.cAlias = ALIAS()
    oPiv.cDBCTable = DBF()
    oPiv.cDBCName = DBC()
    oPiv.cPivFldRow = "to_country"
    oPiv.cPivFldCol = "ship_via"
    oPiv.cPivFldData = "order_amt"
    oPiv.cPivFldPage = "emp_id"
    oPiv.lHasColumnTotals = .T.
    oPiv.lHasRowTotals = .T.
    =ACOPY(aflds, oPiv.aAutoFields)
    =ACOPY(aFList, oPiv.aFldList)
    
    oPiv.MakeOutput()

## Graph Automation Class Notes

To use:

    CLOSE DATA ALL
    USE D:\TEMP2\OFFICES.DBF
        && a Fox 2.6 sample table
    
    SET PATH TO "d:\wiz55work\wzcommon"
        && needs to find registry.prg
    SET CLASS TO d:\wiz55work\automate\autgraph.vcx
    
    oG = CREATEOBJECT("AutoGraph")
    DIMENSION oG.aDataFields[1]
    oG.aDataFields[1] = "ytdsales"
    oG.cCategoryField = "ono"
    oG.nChartType = 5
        && Chart Type
    oG.nChartSubType = 1
        && Chart SubType
    oG.nAction = 1
    oG.lSeriesByRow = .F.
        && Series by Row (.T.), by Column (.F.)
    oG.cGraphDBF = "d:\wiz55work\wzgraph\wizgraph.dbf"
        && DBF containing cGraphField
    oG.cGraphFldRow = "graph_row"
        && General field containing setup Graph (series by row)
    oG.cGraphFldCol = "graph_col"
        && General field containing setup Graph (series by col)
    oG.cGraphPrevClass = "graphpreview"
        && Class containing preview form
    oG.cDefNewField = "olegraph"
        &&default field name in new table
    oG.MakeOutput()
    
    USE D:\TEMP2\VFPGRAPH.DBF
    GO BOTTOM
    MODIFY GENERAL vfpgraph.olegraph NOWAIT
