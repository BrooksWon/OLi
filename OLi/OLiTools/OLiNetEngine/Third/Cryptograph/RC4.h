#ifndef __RC4_H_INCLUDED__
#define __RC4_H_INCLUDED__
//=============================================================================
#ifdef  __cplusplus
extern "C" {
#endif
//=============================================================================
#define RC4_INT unsigned int
//=============================================================================
typedef struct rc4_key_st
{
	RC4_INT x,y;
	RC4_INT data[256];
} RC4_KEY;
//=============================================================================
const char *RC4_options(void);
void RC4_set_key(RC4_KEY *key, int len, const unsigned char *data);
void RC4_crypt(RC4_KEY *key, unsigned long len, const unsigned char *indata, unsigned char *outdata);
//=============================================================================
#ifdef  __cplusplus
}
#endif
//=============================================================================
#endif//__RC4_H_INCLUDED__
