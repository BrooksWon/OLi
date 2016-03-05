//
//  NSData-AES.h
//  Encryption
//
//  Created by Jeff LaMarche on 2/12/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

// Supported keybit values are 128, 192, 256
//#define KEYBITS		256
typedef enum {
	eKeyBits128 = 0,			// 128
	eKeyBits192,				// 192
	eKeyBits256					// 256
} AESKeyBits;

#define AESEncryptionErrorDescriptionKey	@"description"

@interface NSData(AES)
- (NSString *)base64EncodedString;
- (NSData *)AESEncryptWithPassphrase:(NSString *)pass keybits:(AESKeyBits)kbs;
- (NSData *)AESDecryptWithPassphrase:(NSString *)pass keybits:(AESKeyBits)kbs;
@end

// below can support CBC
@interface NSData(AESAdditions)
- (NSData*)AES128EncryptWithKey:(NSString*)key initVector:(NSData*)iv;
- (NSData*)AES128DecryptWithKey:(NSString*)key initVector:(NSData*)iv;
@end