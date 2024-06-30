* 2011/10/10 - Olaf Doschke

Define Class VFPOAuthAPI As Facade OlePublic
   IsAbstract    = .F.
   UserAgent     = 'VFPOAuthAPI'
   IsLoggedIn    = .F.
   
   OAuth         = .NULL.
   OAuthVerifier = ''
   
   Protected IsAbstract, UserAgent

   Procedure Init()      
      Return DoDefault()
   EndProc
   
   Procedure OAuthInit(tcServiceProvider as String)
      Try
         This.oAuth = CreateObject('pakOAuth'+Evl(tcServiceProvider,''))
         This.oAuth.oFacade = This
      Catch
         *
      Endtry
   EndProc
   
   Procedure AuthLogin()
      If IsNull(This.OAuth)
         Return .F.
      Endif
      Return This.oAuth.Login()
   EndProc
   
   Procedure AuthAccessToken()
      If IsNull(This.OAuth) OR Empty(Evl(Nvl(This.OAuthVerifier,''),''))
         Return .F.
      Endif
      Return This.oAuth.RequestAccessToken(This.OAuthVerifier)
   EndProc
   
Enddefine