//
//  NSString+PublicEncrypt.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "NSString+PublicEncrypt.h"

#import "CommonCrypto/CommonDigest.h"
#import "NSData-AES.h"
#import "GTMBase64.h"

static const NSString *OLi_AESKey = @"BrooksWon.Mobile";
static const unsigned char OLi_AESInitVector[] =
{ 0x54, 0x43, 0x4D, 0x6F, 0x62, 0x69, 0x6C, 0x65, 0x5B, 0x41, 0x45, 0x53, 0x5F, 0x49, 0x56, 0x5D };

@implementation NSString (PublicEncrypt)

- (NSString *)MD5EncodedString
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString *)base64EncodedString
{
    return [GTMBase64 stringByEncodingData:[self dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)aesEncryptAndBase64Encode
{
    return [NSString aesEncryptAndBase64Encode:self];
}

- (NSString *)aesDecryptAndBase64Decode
{
    return [NSString aesDecryptAndBase64Decode:self];
}

+ (NSString *)aesEncryptAndBase64Encode:(NSString*)aOrigin
{
    NSString *secret = nil;
    if ([aOrigin length] == 0)
        return secret;
    
    NSData *data = [aOrigin dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrypt = [data AES128EncryptWithKey:[NSString stringWithFormat:@"%@",OLi_AESKey] initVector:[NSData dataWithBytes:OLi_AESInitVector length:16]];
    if (encrypt)
        secret = [GTMBase64 stringByEncodingData:encrypt];
    return secret;
}

+ (NSString *)aesDecryptAndBase64Decode:(NSString*)aOrigin
{
    NSString *secret = nil;
    if ([aOrigin length] == 0)
        return secret;
    NSData *data = [GTMBase64 decodeString:aOrigin];
    NSData *decrypt = [data AES128DecryptWithKey:[NSString stringWithFormat:@"%@",OLi_AESKey] initVector:[NSData dataWithBytes:OLi_AESInitVector length:16]];
    if (decrypt) {
        secret = [[NSString alloc] initWithData:decrypt encoding:NSUTF8StringEncoding];
    }
    return secret;
}

@end
