//
//  NSString+PublicEncrypt.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PublicEncrypt)

/** MD5 */
- (NSString *)MD5EncodedString;

/** base64 */
- (NSString *)base64EncodedString;

/** aes加密后转换base64，使用OLi默认Key */
- (NSString *)aesEncryptAndBase64Encode;
/** 转换base64并解密aes，使用OLi默认Key */
- (NSString *)aesDecryptAndBase64Decode;

+ (NSString *)aesEncryptAndBase64Encode:(NSString*)string;
+ (NSString *)aesDecryptAndBase64Decode:(NSString*)string;

@end
