     Procedure testcode()
               *--���ҵ�ǰ���еı�����
               Local loFindForm
               For Each loFrm In _vfp.Forms 
                   If Lower( lofrm.name ) == Lower( "webview2_Property_Method" ) Then 
                      m.loFindForm = m.lofrm
                      Exit 
                   Endif 
               Endfor 
               If Vartype( m.loFindForm ) == "O" And !Isnull( m.loFindForm ) Then 
                  m.loFindForm.Waitwindow( '������5���ˢ�����ݣ�ģ�ⵥ������...' ) &&Window Nowait 
               Endif 
               
               Declare Integer Sleep In Win32api Integer
               Sleep( 1000 * 5 )
               Select test
               If Eof( 'test' ) Then 
                  Go Top 
               Else 
                  Skip 
               Endif 
      Endproc 
