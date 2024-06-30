Define Class pakOAuthTwitter As pakOAuth
   cBaseURL            = 'https://api.twitter.com/'
   cUserAgent          = 'VFPOAuth for Twitter'

   cUrlTokenRequest    = 'oauth/request_token'
   cUrlAuthorize       = 'oauth/authorize'
   cUrlTokenAccess     = 'oauth/access_token'
         
   IsAbstract          = .F.
   
   Procedure ServiceProviderParameters()
      Local lcParameters
      
      Text To lcParameters NoShow TextMerge
      EndText
      
      Return lcParameters 
   EndProc

Enddefine
