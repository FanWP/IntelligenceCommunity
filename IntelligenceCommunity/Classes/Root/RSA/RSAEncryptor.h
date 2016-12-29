//
//  RSAEncryptor.h
//  RSA
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end
