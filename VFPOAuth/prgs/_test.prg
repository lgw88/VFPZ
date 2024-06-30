* +------+
* ! Test !
* +------+

* This is just a small test case, that gives some hints on using this API facade.

#Define ccCRLF Chr(13)+Chr(10)

Clear All
Clear

If _vfp.StartMode = 0
   Cd Justpath(Sys(16,0))
Endif
Do _loader.prg

Public goVFPOAuth
goVFPOAuth = Createobject('VFPOAuthAPI')
goVFPOAuth.OAuthInit("google") && you may also use "twitter" or "" or no parameter.

* Enter your key/secret pair here
goVFPOAuth.OAuth.cConsumerKey = "..."
goVFPOAuth.OAuth.cConsumerSecret = "..."

With goVFPOAuth
   If .AuthLogin()
      .OAuthVerifier = Inputbox('enter OAuth Verifier:','OAuth','')
      .IsLoggedIn = .AuthAccessToken()
   Else
      MessageBox('Unfortunately the first step of the login (oauth/request_token) already failed.')
   EndIf
   
   If .IsLoggedIn
      MessageBox('The API passed the test.')
      * AccessToken and AccessTokenSecret are set in goVFPOAuth.oAuth properties
   EndIf
Endwith
