Define Class pakOAuthGoogle As pakOAuth
   cBaseURL            = 'https://www.google.com/'
   cUserAgent          = 'VFPOAuth for Google'
   
   cRedirectURI        = 'oob'

   cUrlTokenRequest    = 'accounts/OAuthGetRequestToken'
   cUrlAuthorize       = 'accounts/OAuthAuthorizeToken'
   cUrlTokenAccess     = 'accounts/OAuthGetAccessToken'
   cScope              = 'https://www.google.com/calendar/feeds/'
      
   IsAbstract          = .F.
   
   Procedure ServiceProviderParameters()
      Local lcParameters
      
      Text To lcParameters NoShow TextMerge
scope=<<This.oEnDecode.UrlEncode(This.cScope)>>,
xoauth_displayname=VFPOAuthAPI
      EndText
      
      Return lcParameters 
   EndProc

Enddefine
