#ifndef _VFP2CWINSOCK_H__
#define _VFP2CWINSOCK_H__

const int DEFAULT_WINSOCK_TIMEOUT	= 4000;
const int VFP2C_MAX_IP_LEN			= 16;

#ifdef __cplusplus
extern "C" {
#endif

void _stdcall SaveWinsockError(char *pFunction);
bool _stdcall VFP2C_Init_Winsock(VFP2CTls& tls);
void _stdcall VFP2C_Destroy_Winsock(VFP2CTls& tls);

void _fastcall AIPAddresses(ParamBlk *parm);
void _fastcall ResolveHostToIp(ParamBlk *parm);

#ifdef __cplusplus
}
#endif

#endif // _VFP2CWINSOCK_H__