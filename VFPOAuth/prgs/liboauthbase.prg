* libOAuth
* created 2009/07/22 by Olaf Doschke - mailto:olaf.doschke@googlemail.com
* modified 2011/10/10 - changed for usage of google OAuth 1.0a authentication
* modified 2011/10/12 - refactored into OAuthbasic and a seperate libOAuth for concrete Service Providers
#Define ccCRLF   Chr(13)+Chr(10)
#Define cnBase64             13
#Define cnSha1                1

Define Class pakOAuth As Package
   * Makes authentication requests, signs requests
   * and maintains the login status
   lLoggedIn           = .F.

   cBaseURL            = ''
   cUserAgent          = ''

   cConsumerKey        = ''
   cConsumerSecret     = ''
   cRedirectURI        = 'oob'

   cRequestToken       = ''
   cRequestTokenSecret = ''

   cAccessToken        = ''
   cAccessTokenSecret  = ''

   cOAuthVerifier      = ''

   cUrlTokenRequest    = ''
   cUrlAuthorize       = ''
   cUrlTokenAccess     = ''

   IsAbstract          = .T.

   Procedure Init()
      This.AddObject('oRequest','pakRequestProxy')
      With This.oRequest
         .oFacade           = This
         .cRequestformat    = ''
         .cUserAgent        = This.cUserAgent
      Endwith
   
      This.AddObject('oEnDecode','pakEnDecode')
      This.oEnDecode.oFacade = This
      
      This.AddObject('oGUID','pakGUID')
      This.oGUID.oFacade = This
      
      This.AddObject('oTime','pakTime')
      This.oTime.oFacade = This
   Endproc

   Procedure Login()
      Local lcRequestParameters, lcBaseString, lcSignature, loRequest, lcResponse, llSuccess, lcTimestamp, lcNonce, lcServiceProviderParameters
      Local Array laKeyValuePairs[2]
      
      * Login, Step 1 - Get an RequestToken and TokenSecret from The OAuth Service Provider (eg Google, Twitter)
      
      lcNonce = This.oGUID.HexGUID()
      lcServiceProviderParameters = Nvl(This.ServiceProviderParameters(),'')
      lcTimestamp = This.oTime.UTCTime()-Datetime(1970,1,1,0,0,0)
      
      Text To lcRequestParameters NoShow TextMerge
oauth_callback=<<This.cRedirectURI>>,
oauth_consumer_key=<<This.cConsumerKey>>,
oauth_nonce=<<lcNonce>>,
oauth_signature_method=HMAC-SHA1,
oauth_timestamp=<<lcTimestamp>>,
oauth_version=1.0,
<<lcServiceProviderParameters>>
      EndText
      lcRequestParameters = Strtran(lcRequestParameters,','+ccCRLF,'&')

      loRequest = This.oRequest.SendRequest('GET', This.cBaseURL+This.cUrlTokenRequest, lcRequestParameters, This, 'return lorequest')
      Do While loRequest.ReadyState<>4
         DoEvents Force
      Enddo
      lcResponse = loRequest.ResponseText

      If Alines(laKeyValuePairs,lcResponse,2,'&')>=2
         This.cRequestToken       = Getwordnum(laKeyValuePairs[1],2,'=')
         This.cRequestTokenSecret = Getwordnum(laKeyValuePairs[2],2,'=')
         llSuccess = .T.
      Else
         This.cRequestToken       = ''
         This.cRequestTokenSecret = ''
         llSuccess = .F.
      Endif

      If llSuccess
         * Login, Step 2 - Request a PIN from the Service Provider Prompted to the User
         TEXT To lcRequestParameters NoShow TextMerge
oauth_callback=<<This.cRedirectURI>>,
oauth_token=<<This.cRequestToken>>
         ENDTEXT
         lcRequestParameters = Strtran(lcRequestParameters,','+ccCRLF,'&')

         ShellExecute(0, 'open', This.cBaseURL+This.cUrlAuthorize+'?'+lcRequestParameters, '','', 1)
      Endif

      * The client now needs to ask the user for the OAuthVerifier,
      * to finally request an Access Token via RequestAccessToken.
      * Successfully retreiving that Access Token, completes the Login.

      * This return value only tells about the partly success
      * of retrieving the RequestToken/RequestTokenSecret values.
      * So this is just intermediate success, at the point in the
      * process, the service provider will return the OAuth verifier.
      Return llSuccess
   Endproc

   Procedure RequestAccessToken()
      Lparameters tcOAuthVerifier
      Local lcRequestParameters, llSuccess
      Local Array laKeyValuePairs[2]

      llSuccess = .F.
      * Login, Step 3 - Get an AccessToken and AcccessTokenSecret from The OAuth Service Provider (eg Twitter)
      TEXT To lcRequestParameters NoShow TextMerge
oauth_consumer_key=<<This.cConsumerKey>>,
oauth_token=<<This.cRequestToken>>,
oauth_verifier=<<tcOAuthVerifier>>,
oauth_nonce=<<This.oGUID.HexGUID()>>,
oauth_signature_method=HMAC-SHA1,
oauth_timestamp=<<This.oTime.UTCTime()-Datetime(1970,1,1,0,0,0)>>,
oauth_version=1.0
      ENDTEXT
      lcRequestParameters = Strtran(lcRequestParameters,','+ccCRLF,'&')
      * lcRequestParameters = This.SignRequest('POST',This.oRequest.cBaseUrl+This.cUrlTokenAccess, lcRequestParameters, This.cRequestToken, This.cRequestTokenSecret)
      loRequest = This.oRequest.SendRequest('POST', This.cBaseURL+This.cUrlTokenAccess, lcRequestParameters, This, 'return lorequest')
      Do While loRequest.ReadyState<>4
         DoEvents Force
      Enddo
      lcResponse = loRequest.ResponseText

      If Alines(laKeyValuePairs,lcResponse,2,'&')>=2
         This.cAccessToken       = Getwordnum(laKeyValuePairs[1],2,'=')
         This.cAccessTokenSecret = Getwordnum(laKeyValuePairs[2],2,'=')
         llSuccess = .T.
      Endif

      If Not llSuccess
         This.cOAuthVerifier     = ''
         This.cAccessToken       = ''
         This.cAccessTokenSecret = ''
      Endif

      This.lLoggedIn = llSuccess
   Endproc

   Procedure Logout()
      * there is no such thing with OAuth.
      * A user can revoke Accesss to a client instead.
      * this is typically done at some webpage of the OAuth Service Provider.
   Endproc

   Procedure OAuthParameters()
      Lparameters tcNonce, tcTimestamp
      Local lcRequestParameters

      TEXT To lcRequestParameters NoShow TextMerge
oauth_consumer_key=<<This.cConsumerKey>>,
oauth_nonce=<<tcNonce>>,
oauth_signature_method=HMAC-SHA1,
oauth_timestamp=<<tcTimestamp>>,
oauth_token=<<This.cAccessToken>>,
      ENDTEXT
      lcRequestParameters = Chrtran(lcRequestParameters,','+ccCRLF,'&')
      lcRequestParameters = Substr(lcRequestParameters,2) + Iif(Empty(This.cOAuthVerifier),'','&oauth_verifier='+This.cOAuthVerifier)+'&oauth_version=1.0'
      Return lcRequestParameters
   EndProc
   
   Procedure ServiceProviderParameters()
      Return .NULL.
   EndProc
   
   Procedure SignRequest()
      Lparameters tcRequestType, tcRequestUrl, tcRequestParameters

      Local lcRequestParameters, lcBaseString, lcSignature, lnCount, lcTimestamp, lcNonce, lcOAuthParameters, lcAllParameters
      Local lcToken, lcTokenSecret, lcConsumerSecret, lcKey
      Local laKeyValuePairs[1]

      lcToken          = Evl(Evl(This.cAccessToken      ,This.cRequestToken)      ,'')
      lcTokenSecret    = Evl(Evl(This.cAccessTokenSecret,This.cRequestTokenSecret),'')
      lcConsumerSecret = This.cConsumerSecret

      If Not 'oauth_signature_method=' $ tcRequestParameters
         lcNonce = This.oGUID.HexGUID()
         lcTimestamp = Textmerge("<<This.oTime.UTCTime()-Datetime(1970,1,1,0,0,0)>>")
         lcOAuthParameters = This.OAuthParameters(lcNonce, lcTimestamp)
      Else
         lcOAuthParameters = tcRequestParameters
         tcRequestParameters = ''
      Endif

      lcAllParameters = lcOAuthParameters+Iif(Empty(tcRequestParameters),'','&')+tcRequestParameters
      Alines(laKeyValuePairs,lcAllParameters,0,'&')
      Asort(laKeyValuePairs,1,Alen(laKeyValuePairs),0)
      lcAllParameters = ''
      For lnCount = 1 To Alen(laKeyValuePairs)
         lcAllParameters = lcAllParameters + '&' + laKeyValuePairs[lnCount]
         If laKeyValuePairs[lnCount]="oauth_nonce"
            lcNonce = Substr(laKeyValuePairs[lnCount],At("=",laKeyValuePairs[lnCount])+1)
         Endif
         If laKeyValuePairs[lnCount]="oauth_timestamp"
            lcTimestamp = Substr(laKeyValuePairs[lnCount],At("=",laKeyValuePairs[lnCount])+1)
         Endif
      Endfor
      lcAllParameters = Substr(lcAllParameters,2)

      lcBaseString = tcRequestType+'&'+ ;
         This.oEnDecode.UrlEncode(tcRequestUrl)+'&'+;
         This.oEnDecode.UrlEncode(lcAllParameters)

      lcKey = This.oEnDecode.UrlEncode(Evl(lcConsumerSecret,''))+'&'+This.oEnDecode.UrlEncode(Evl(lcTokenSecret,''))
      lcSignature  = This.oEnDecode.HMACSHA1(lcBaseString,lcKey)
      lcSignature  = This.oEnDecode.UrlEncode(Strconv(lcSignature,cnBase64))

      Return lcOAuthParameters + Iif(Empty(tcRequestParameters),'','&') + tcRequestParameters + '&oauth_signature=' + lcSignature
   EndProc

   Procedure SetContentType()
      Lparameters toRequest
      
      toRequest.SetRequestHeader('Content-Type','application/x-www-form-urlencoded')
   EndProc

Enddefine


