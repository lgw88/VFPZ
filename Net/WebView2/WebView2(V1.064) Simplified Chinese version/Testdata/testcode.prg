     Procedure testcode()
               *--查找当前运行的表单对象
               Local loFindForm
               For Each loFrm In _vfp.Forms 
                   If Lower( lofrm.name ) == Lower( "webview2_Property_Method" ) Then 
                      m.loFindForm = m.lofrm
                      Exit 
                   Endif 
               Endfor 
               If Vartype( m.loFindForm ) == "O" And !Isnull( m.loFindForm ) Then 
                  m.loFindForm.Waitwindow( '我休眠5秒后刷新数据，模拟单线阻塞...' ) &&Window Nowait 
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
