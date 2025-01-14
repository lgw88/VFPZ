*RSA PEM format encryption and decryption
*Get/manually set public key | private key
*Use RSA EncryptPKCS1v15 encryption
*Use RSA DecryptPKCS1v15 Decryption

*--Regarding AES encryption decryption, please refer to: https://lzltool.cn/AES
*PaddingMode
#Define None 0 && NoPadding
#Define PKCS7 1&&PKCS7 currently only supports this
#Define Zeros 2 && Zeros
#Define ANSIX923 3 && ANSIX923
#Define ISO10126 4 && ISO10126


The key is that it is free! It can be packaged and run in any of your commercial software without any dependencies, and should support at least Win2000. Of course, it is also supported on mobile devices, but this is beyond the scope of VFP. I will also include DES, SM2, and SM4 in the future.
