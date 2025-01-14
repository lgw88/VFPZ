*--����WebView2��Ŀ��Echarts��Ҫ��webview_echarts�򵥽�����.scx�������ʹ����ʾ
*--����һ���շѹ��ܺ���,����Ҫ���Բ���ע   
*--�����۷������ͳ��
Function Echarts_demo1()
		 
	 If Used( 'cur_demo1' ) Then 
		 Select cur_demo1
		 
         *--���һ��VFP.oEcharts�����Է���JS��ȡ�ö��������
         Local m.loEcharts 
         m.loEcharts = Newobject( "empty" )
         
         Addproperty( m.loEcharts  , "title" )
         m.loEcharts.title = 'Ecahrts_Demo1_' + alltrim( Transform(cur_demo1.�·�) ) + '�·����۷������ͳ��' &&��1��5ʵ��DEMO
         
         *--legend
         Local lolegend
         Addproperty( m.loEcharts  , "legend" )
         m.lolegend = Newobject( "empty" )
		 m.loEcharts.legend=m.lolegend
		 
		 
         *--xAxis
         Local loxAxis
         Addproperty( m.loEcharts  , "xAxis" )
         m.loxAxis = Newobject( "empty" )
         m.loEcharts.xAxis= m.loxAxis 
         Addproperty( m.loxAxis	, 'data' 	)
         
         Local lnCount ;
             , lcFidno ;
             , lcValuestr 
             
         For m.lnCount = 2 To Fcount( 'cur_demo1' )
             m.lcFidno = Fields( m.lnCount )
             m.lcValuestr = Iif( Empty( m.lcValuestr ) , '' ;
             										   , m.lcValuestr + [,] ) + ["] + m.lcFidno + ["]
		 Endfor 
    	 m.loxAxis.data = '[' + m.lcValuestr + ']'
		 *m.loxAxis.data = '[' + ["����","��ë��","ѩ����","����","�߸�Ь","����"] + ']' 
		 *--ʵ�ʿ��Թ̶�����
		 *--��������Ƶ����ǹ̶�������

		 
         *--yAxis
*!*	         Local loyAxis 
*!*	         Addproperty( m.loEcharts  , "yAxis" )
*!*	         m.loyAxis = Newobject( "empty" )
*!*	         m.loEcharts.yAxis = m.loyAxis 
         
         
         *--series
         Local loseries
         Addproperty( m.loEcharts  , "series" )
         m.loseries = Newobject( "empty" )
         m.loEcharts.series = m.loseries 
         Addproperty( m.loseries   , 'name' 	)
         m.loseries.name = '����'
         Addproperty( m.loseries   , 'data' 	)
         
         *_vfp.SetVar('oEcharts' , m.loEcharts )


	    Local lcData
	    Text To m.lcData Textmerge Pretext  1 + 2 + 8 + 4  Noshow 
	         <<cur_demo1.����>>
	        ,<<cur_demo1.��ë��>>
	        ,<<cur_demo1.ѩ����>>
	        ,<<cur_demo1.����>>
	        ,<<cur_demo1.�߸�Ь>>
	        ,<<cur_demo1.����>>
	    Endtext 
	    *Return '[' +  m.lcData  + ']'
	    m.loseries.data = '[' +  m.lcData  + ']'
	    
	    Return m.loEcharts
	 Else 
		Return null 
	 Endif 
 
Endfunc 

*--��Ʒ����ռ�Ȼ���
*--���Echarts_demo2û�ж�̬����oEcharts�����ԣ������Ҫ���Բο���Echarts_demo1��������
Function Echarts_demo2()
	 
     Select cur_demo2
     If Used( 'cur_demo2' ) Then 
        Local lcValuestr ;
        	, lnValue 	 ;
        	, lnFidno    ;
        	, lcName  
        	
        
        For m.lnCount =1 To Fcount( 'cur_demo2' ) - 1
            *--��������
            m.lnFidno = Fields( m.lnCount ) 
            *--ֵ
            m.lnValue = cur_demo2.&lnFidno.
            *--����(45%)
            m.lcName  = Getwordnum( m.lnFidno ,  2 , '_' ) +;
            			"(" + Transform(  Round( m.lnValue / sum_all * 100 , 2 )  ;
            						   ) +  ;
            		     "%)"
            *--option(Data) ����ʵ��ֻ��һ��string
            m.lcValuestr = Iif( Empty( m.lcValuestr ) , '' ;
            										  , m.lcValuestr + "," ) + "{value:"+ Transform( m.lnValue  ) + ",name:'" + m.lcName + "'}"
        Endfor  
        Return '[' + m.lcValuestr  + ']'
     Else 
        Return ""
     Endif 
     
Endfunc

*--��������Ա�Աȷ���
Function Echarts_demo3()
     *--ע������û����ȡ����VFP������ȡ��ģ���Echarts_data��ֵ,��������ֱ��д����
     *--��ʽ��Ҫ�ҾͿ�����[ [��һ������],[�ڶ�������],[����������]...]
     
     If Used( 'Echarts_data' ) Then 
        Text To  m.lcData Textmerge Pretext  1 + 2 + 8 + 4  Noshow 
        	[
        	 ['�·�', '1��', '2��', '3��'],
        	 ['С��', 43.3, 85.8, 93.7],
        	 ['С��', 83.1, 73.4, 55.1],
        	 ['С��', 86.4, 65.2, 82.5],
        	 ['С��', 72.4, 53.9, 39.1]
        	]
        Endtext 
        Return  m.lcData
     Else 
        Return ""
     Endif 
Endfunc


*--�����۷������ͳ��(�� �Զ�ˢ��,�ر�Ҫע������Լ���˽�й����� )
Function Echarts_demo5( )

		
		    
		    Text To m.lcSqlCmd noShow
				Select month(����) As �·�  
				     , Sum(����)   As ����   
				     , Sum(��ë��) As ��ë��
				     , Sum(ѩ����) As ѩ����
				     , Sum(����)   As ����  
				     , Sum(�߸�Ь) As �߸�Ь  
				     , Sum(����)   As ����	
				From Echarts_data Group By month(����)
		    Endtext 
		    
		    
		    If Sqlexec( gnConnHandle,m.lcSqlCmd, 'cur_demo5' ) < 0 Then 
		       Aerror( AErrorMsg )
       		   Messagebox( [��ȡ��Echarts_data�������۷���������ݣ�ʧ��(] + AErrorMsg[2] +[)......]  , 16  , '���̣�' + Program() )
		       Return null 
		    Endif 
		    
		
		 If Used( 'cur_demo5' ) Then 
			 Select cur_demo5
			 
	         *--���һ��VFP.oEcharts�����Է���JS��ȡ�ö��������
	         Local m.loEcharts 
	         m.loEcharts = Newobject( "empty" )
	         
	         Addproperty( m.loEcharts  , "title" )
	         m.loEcharts.title = 'Ecahrts_Demo5_' + alltrim( Transform(cur_demo5.�·�) ) + '�·����۷������ͳ��' &&��1��5ʵ��DEMO
	         
	         *--legend
	         Local lolegend
	         Addproperty( m.loEcharts  , "legend" )
	         m.lolegend = Newobject( "empty" )
			 m.loEcharts.legend=m.lolegend
			 
			 
	         *--xAxis
	         Local loxAxis
	         Addproperty( m.loEcharts  , "xAxis" )
	         m.loxAxis = Newobject( "empty" )
	         m.loEcharts.xAxis= m.loxAxis 
	         Addproperty( m.loxAxis	, 'data' 	)
	         
	         Local lnCount ;
	             , lcFidno ;
	             , lcValuestr 
	             
	         For m.lnCount = 2 To Fcount( 'cur_demo5' )
	             m.lcFidno = Fields( m.lnCount )
	             m.lcValuestr = Iif( Empty( m.lcValuestr ) , '' ;
	             										   , m.lcValuestr + [,] ) + ["] + m.lcFidno + ["]
			 Endfor 
	    	 m.loxAxis.data = '[' + m.lcValuestr + ']'
			 *m.loxAxis.data = '[' + ["����","��ë��","ѩ����","����","�߸�Ь","����"] + ']' 
			 *--ʵ�ʿ��Թ̶�����
			 *--��������Ƶ����ǹ̶�������

			 
	         *--yAxis
	*!*	         Local loyAxis 
	*!*	         Addproperty( m.loEcharts  , "yAxis" )
	*!*	         m.loyAxis = Newobject( "empty" )
	*!*	         m.loEcharts.yAxis = m.loyAxis 
	         
	         
	         *--series
	         Local loseries
	         Addproperty( m.loEcharts  , "series" )
	         m.loseries = Newobject( "empty" )
	         m.loEcharts.series = m.loseries 
	         Addproperty( m.loseries   , 'name' 	)
	         m.loseries.name = '����'
	         Addproperty( m.loseries   , 'data' 	)
	         
	         *_vfp.SetVar('oEcharts' , m.loEcharts )


		    Local lcData
		    Text To m.lcData Textmerge Pretext  1 + 2 + 8 + 4  Noshow 
		         <<cur_demo5.����>>
		        ,<<cur_demo5.��ë��>>
		        ,<<cur_demo5.ѩ����>>
		        ,<<cur_demo5.����>>
		        ,<<cur_demo5.�߸�Ь>>
		        ,<<cur_demo5.����>>
		    Endtext 
		    *Return '[' +  m.lcData  + ']'
		    m.loseries.data = '[' +  m.lcData  + ']'
		    
		    Return m.loEcharts
		 Else 
			Return null 
		 Endif 
     
Endfunc 