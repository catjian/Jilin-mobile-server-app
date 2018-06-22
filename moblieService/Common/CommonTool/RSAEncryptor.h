//
//  RSAEncryptor.h
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2017/7/24.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define DIF_Public_Key @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBRVNqf4kmwJseVcUBaFT2Nq8x759jiCW35RamiL8J3Yjrlc5CzEQc8YN1rnlilpgURBzz8pmUB4MfAdDtMaBelXy0HfWuNfvjc+Q0yiVTSSD6JGxe1M5xkIB+yLx1DL5dPq3Kk6Dju8vSlC8v3adiIQDdbIBwncLH8bPIoelHZwIDAQAB"
#define DIF_Public_Key @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBRVNqf4kmwJseVcUBaFT2Nq8x759jiCW35RamiL8J3Yjrlc5CzEQc8YN1rnlilpgURBzz8pmUB4MfAdDtMaBelXy0HfWuNfvjc+Q0yiVTSSD6JGxe1M5xkIB+yLx1DL5dPq3Kk6Dju8vSlC8v3adiIQDdbIBwncLH8bPIoelHZwIDAQAB"


#define DIF_EncryptString(s) [RSAEncryptor encryptString:s publicKey:DIF_Public_Key]
#define DIF_DecryptString(s) [RSAEncryptor decryptString:s privateKey:DIF_Public_Key]

@interface RSAEncryptor : NSObject

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

@end
