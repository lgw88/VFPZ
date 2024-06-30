# VFPOAuth

Author: Olaf Doschke

This is a VFP binding to the OAuth 1.0a protocol, also usable in other languages as OLE class.

VFPOAuth currently supports the process needed to get an access token and access token secret for signing/authorizing of further requests.

Implemented is the general OAuth process of OAuth 1.0a authentication as described in [http://oauth.net/core/1.0a/#anchor9](http://oauth.net/core/1.0a/#anchor9), steps 6.1 - 6.3 (including 6.3.2)

Usage in VFP is best described by looking into _test.prg, Usage via OLE is done by registering vfpoauth.exe or vfpoauthst.dll (single threaded) or vfpoauthmt.dll (multi threaded). Due to all versions using the same OLE class names only one of these three should be registered, though.

## Usage in VFP
Open vfpoauth.pjx and open _test.prg to see the usage of VFPOAuth.

Cantral class is the VFPOAuthAPI class in libvfpoauthapi.prg, which needs to be instantiated and then inited to usage of some service provider via a 
call to .OAuthInit(), for example .OAuthInit("twitter") or .OAuthInit("google"). You may try other service providers via .OAuthInit() without parameter.

The properties .OAuth.cConsumerKey and .OAuth.cConsumerSecret need to be set to the key and secret you get from the service provider by registering your app with one of them, or you set these values in the sources of the respective class.

.AuthLogin() then starts the login process up to the point the user grants or denies access and if granting access gets an OAuth verifier from the service provider. (Steps 6.1 and 6.2 of the OAuth 1.0a Core description). VFPOauth automatically starts the standard browser for the step the user logs in and grants access.

After setting the .OAuthVerifier property to that verifier value, a call to .AuthAccessToken() finalizes the process and retrieves an Access Token and Secret (Step 6.3 of the OAuth 1.0a Core description)

## Usage in other languages
You need to register either the vfpoauth.exe by calling it with /regserver as parameter, or use the 32bit regsrv32 to register either vfpoauthst.dll or vfpoauthmt.dll

Either of these three files needs to be accompanied by the C++ runtime msvcr71.dll, all vfp9*.dlls and vfpencryption71.fll

You need to create an object instance of VFPOauth.VFPOAuthAPI and then init what OAuth service provider to use it for via a call to .OAuthInit(), for 
example .OAuthInit("twitter") or .OAuthInit("google"). You may try other service providers via .OAuthInit() without parameter.

The properties .OAuth.cConsumerKey and .OAuth.cConsumerSecret need to be set to the key and secret you get from the service provider by registering your app with one of them.

.AuthLogin() then starts the login process up to the point the user grants or denies access and if granting access gets an OAuth verifier from the service provider. (Steps 6.1 and 6.2 of the OAuth 1.0a Core description). VFPOauth automatically starts the standard browser for the step the user logs in and grants access.

After your code sets the .OAuthVerifier property to that verifier value you need to get from your user, a call to .AuthAccessToken() finalizes the process and retrieves an Access Token and Secret (Step 6.3 of the OAuth 1.0a Core description)

## OAuth 1.0a
You find a ddescription and further material on OAuth in 
[http://oauth.net/](http://oauth.net/)
[http://oauth.net/core/1.0a/](http://oauth.net/core/1.0a/)
[http://oauth.net/core/1.0a/#anchor9](http://oauth.net/core/1.0a/#anchor9)
