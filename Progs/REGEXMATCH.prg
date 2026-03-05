* REGEXMATCH
* Author: LGW
* Date: 2026-03-05
* Function Name: REGEXMATCH
* Description: Uses regular expression to check if a string matches a specified pattern.
* Parameters:
*   tcS   - String to check (Character)
*   tcP   - Regular expression pattern (Character)
*   tlI   - Optional, whether to ignore case; default .F.
* Return Value: Logical (.T. for match, .F. for no match)
LPARAMETERS tcS, tcP, tlI
    LOCAL llR
    llR = .F.
    TRY
        WITH CreateObject("VBScript.RegExp")
            .IgnoreCase = VARTYPE(tlI) = "L" AND tlI
            .Global = .F.          && only need to match once
            .Pattern = tcP
            llR = .Test(tcS)
        ENDWITH
    CATCH
    ENDTRY
    RETURN llR