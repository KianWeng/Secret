//
//  DecryptionAlgorithm.h
//  Secret
//
//  Created by 翁高剑 on 14/12/14.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecryptionAlgorithm : NSObject

- (NSString *)DecryptionCaesarShiftsForEnglish:(NSString *)encryptionString withSecretKey: (int) secretKey;
- (NSString *)DecryptionCaesarShiftsForChinese:(NSString *)encryptionString withSecretKey: (int) secretKey;
- (NSString *)DecryptionTheRailFenceCipher: (NSString *) encryptionlString;
- (NSString *)VigenereCipher: (NSString *) string;
- (NSString *)PolybiusCipher: (NSString *) string;
- (NSString *)MultiplicationCipher: (NSString *) string;
- (NSString *)DecryptionMorseCode: (NSString *) encryptionString;

@end
