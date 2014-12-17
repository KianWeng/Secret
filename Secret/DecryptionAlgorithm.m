//
//  DecryptionAlgorithm.m
//  Secret
//
//  Created by 翁高剑 on 14/12/14.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import "DecryptionAlgorithm.h"

@implementation DecryptionAlgorithm

//CaesarShifts Algorithm
- (NSString *)CaesarShiftsForEnglish:(NSString *)encryptionString withSecretKey: (int) secretKey
{
    // originalString = [[NSString alloc] init];
    NSString *originalString, *subString, *tempString;
    long int length;
    UniChar ascii;
    originalString = [[NSString alloc] init];
    subString = [[NSString alloc] init];
    tempString = [[NSString alloc] init];
    length = encryptionString.length;
    //将明文按照密钥逐个转换为密文
    NSLog(@"the length is %li",length);
    for (int i = 0; i < length; i++)
    {
        ascii = [encryptionString characterAtIndex: i];//[originalString substringWithRange:NSMakeRange(i, 1)];
        if (ascii < 97)
        {
            ascii = (ascii - secretKey - 65) % 26 + 65;
            subString = [NSString stringWithFormat:@"%c",ascii];
        }
        else
        {
            ascii = (ascii - secretKey - 97) % 26 + 97;
            subString = [NSString stringWithFormat:@"%c",ascii];
        }
        tempString = [tempString stringByAppendingString: subString];
    }
    originalString = tempString;
    return originalString;
    
}

- (NSString *)CaesarShiftsForChinese:(NSString *)encryptionString withSecretKey:(int)secretKey
{
    //originalString = [[NSString alloc] init];
    NSString *originalString, *subString, *tempString;
    long int length;
    UniChar unicode;
    originalString = [[NSString alloc] init];
    subString = [[NSString alloc] init];
    tempString = [[NSString alloc] init];
    length = encryptionString.length;
    //将明文按照密钥逐个转换为密文
    for (int i = 0; i < length; i++)
    {
        //ascii = [subString characterAtIndex: i];//[originalString substringWithRange:NSMakeRange(i, 1)];
        unicode = [encryptionString characterAtIndex: i ];
        unicode = unicode - secretKey;
        subString = [NSString stringWithFormat:@"%C",unicode];
        tempString = [tempString stringByAppendingString: subString];
    }
    originalString = tempString;
    return originalString;
}
- (NSString *)TheRailFenceCipher: (NSString *) encryptionString
{
    //originalString = [[NSString alloc] init];
    NSString *originalString = [[NSString alloc] init];
    NSString *subString1 = [[NSString alloc] init];
    NSString *subString2 = [[NSString alloc] init];
    NSString *tempString = [[NSString alloc] init];
    long int length;
    unichar unicode;
    length = encryptionString.length;
    if (length % 2 ==0)
    {
        subString1 = [encryptionString substringToIndex: length / 2 - 1];
        subString2 = [encryptionString substringFromIndex: length / 2];
        for (int i = 0; i <= length / 2 - 1; i++)
        {
            unicode = [subString1 characterAtIndex:i];
            tempString = [NSString stringWithFormat:@"%C",unicode];
            unicode = [subString2 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
        }
    }
    else
    {
        subString1 = [encryptionString substringToIndex: (length + 1) / 2 - 1];
        subString2 = [encryptionString substringFromIndex: (length + 1) / 2];
        for (int i = 0; i <= (length + 1) / 2 - 1; i++)
        {
            unicode = [subString1 characterAtIndex:i];
            tempString = [NSString stringWithFormat:@"%C",unicode];
            unicode = [subString2 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
        }
    }
    
    originalString = tempString;
    return originalString;
}

- (NSString *)MorseCode:(NSString *)originalString
{
    //originalString = [[NSString alloc] init];
    NSString *encryptText = [[NSString alloc] init];
    NSString *tempString = [[NSString alloc] init];
    long int length;
    unichar unicode;
    NSArray *morseCode = [[NSArray alloc] init];
    morseCode = @[@"*_",@"_***",@"_*_*",@"_**",@"*",@"**_*",
                  @"__*",@"****",@"**",@"*___",@"_*_",@"*_**",
                  @"__",@"_*",@"___",@"*__*",@"__*_",@"*_*",
                  @"***",@"_",@"**_",@"***_",@"*__",@"_**_",
                  @"_*__",@"__**"];
    length = originalString.length;
    for (int i = 0; i <length; i++) {
        unicode = [originalString characterAtIndex: i];
        switch (unicode) {
            case 65:
                tempString = [tempString stringByAppendingString:morseCode[0]];
                break; break;
            case 66:
                tempString = [tempString stringByAppendingString:morseCode[1]];
                break; break;
            case 67:
                tempString = [tempString stringByAppendingString:morseCode[2]];
                break; break;
            case 68:
                tempString = [tempString stringByAppendingString:morseCode[3]];
                break; break;
            case 69:
                tempString = [tempString stringByAppendingString:morseCode[4]];
                break; break;
            case 70:
                tempString = [tempString stringByAppendingString:morseCode[5]];
                break; break;
            case 71:
                tempString = [tempString stringByAppendingString:morseCode[6]];
                break; break;
            case 72:
                tempString = [tempString stringByAppendingString:morseCode[7]];
                break; break;
            case 73:
                tempString = [tempString stringByAppendingString:morseCode[8]];
                break; break;
            case 74:
                tempString = [tempString stringByAppendingString:morseCode[9]];
                break; break;
            case 75:
                tempString = [tempString stringByAppendingString:morseCode[10]];
                break; break;
            case 76:
                tempString = [tempString stringByAppendingString:morseCode[11]];
                break; break;
            case 77:
                tempString = [tempString stringByAppendingString:morseCode[12]];
                break; break;
            case 78:
                tempString = [tempString stringByAppendingString:morseCode[13]];
                break; break;
            case 79:
                tempString = [tempString stringByAppendingString:morseCode[14]];
                break; break;
            case 80:
                tempString = [tempString stringByAppendingString:morseCode[15]];
                break; break;
            case 81:
                tempString = [tempString stringByAppendingString:morseCode[16]];
                break; break;
            case 82:
                tempString = [tempString stringByAppendingString:morseCode[17]];
                break; break;
            case 83:
                tempString = [tempString stringByAppendingString:morseCode[18]];
                break; break;
            case 84:
                tempString = [tempString stringByAppendingString:morseCode[19]];
                break; break;
            case 85:
                tempString = [tempString stringByAppendingString:morseCode[20]];
                break; break;
            case 86:
                tempString = [tempString stringByAppendingString:morseCode[21]];
                break; break;
            case 87:
                tempString = [tempString stringByAppendingString:morseCode[22]];
                break; break;
            case 88:
                tempString = [tempString stringByAppendingString:morseCode[23]];
                break; break;
            case 89:
                tempString = [tempString stringByAppendingString:morseCode[24]];
                break; break;
            case 90:
                tempString = [tempString stringByAppendingString:morseCode[25]];
                break; break;
            default:
                break;
        }
    }
    return encryptText;
}

@end