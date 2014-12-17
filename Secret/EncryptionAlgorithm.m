//
//  EncryptionAlgorithm.m
//  Secret
//
//  Created by 翁高剑 on 14/12/13.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import "EncryptionAlgorithm.h"

@implementation EncryptionAlgorithm
//CaesarShifts Algorithm
- (NSString *)CaesarShiftsForEnglish:(NSString *)originalString withSecretKey: (int) secretKey
{
   // originalString = [[NSString alloc] init];
    NSString *encryptText, *subString, *tempString;
    long int length;
    UniChar ascii;
    encryptText = [[NSString alloc] init];
    subString = [[NSString alloc] init];
    tempString = [[NSString alloc] init];
    length = originalString.length;
    //将明文按照密钥逐个转换为密文
    //NSLog(@"the length is %li",length);
    for (int i = 0; i < length; i++)
    {
        ascii = [originalString characterAtIndex: i];//[originalString substringWithRange:NSMakeRange(i, 1)];
        if (ascii < 97)
        {
            ascii = (ascii + secretKey - 65) % 26 + 65;
            subString = [NSString stringWithFormat:@"%c",ascii];
        }
        else
        {
            ascii = (ascii + secretKey - 97) % 26 + 97;
            subString = [NSString stringWithFormat:@"%c",ascii];
        }
        tempString = [tempString stringByAppendingString: subString];
    }
    encryptText = tempString;
    return encryptText;
    
}

- (NSString *)CaesarShiftsForChinese:(NSString *)originalString withSecretKey:(int)secretKey
{
    //originalString = [[NSString alloc] init];
    NSString *encryptText, *subString, *tempString;
    long int length;
    UniChar unicode;
    encryptText = [[NSString alloc] init];
    subString = [[NSString alloc] init];
    tempString = [[NSString alloc] init];
    length = originalString.length;
    //将明文按照密钥逐个转换为密文
    for (int i = 0; i < length; i++)
    {
        //ascii = [subString characterAtIndex: i];//[originalString substringWithRange:NSMakeRange(i, 1)];
        unicode = [originalString characterAtIndex: i ];
        unicode = unicode + secretKey;
        subString = [NSString stringWithFormat:@"%C",unicode];
        tempString = [tempString stringByAppendingString: subString];
    }
    encryptText = tempString;
    return encryptText;
}
- (NSString *)TheRailFenceCipher: (NSString *) originalString
{
    //originalString = [[NSString alloc] init];
    NSString *encryptText = [[NSString alloc] init];
    NSString *subString1 = [[NSString alloc] init];
    NSString *subString2 = [[NSString alloc] init];
    NSString *tempString = [[NSString alloc] init];
    long int length;
    unichar unicode;
    length = originalString.length;
    //NSLog(@"the length is %li",length);
    if (length % 2 ==0)
    {
        subString1 = [originalString substringToIndex: length / 2 ];
        //NSLog(@"the string is %@",subString1);
        subString2 = [originalString substringFromIndex: length / 2];
        //NSLog(@"the string is %@",subString2);
        for (int i = 0; i < length / 2; i++)
        {
            unicode = [subString1 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
            unicode = [subString2 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
            //NSLog(@"the string is %@",tempString);
        }
    }
    else
    {
        subString1 = [originalString substringToIndex: (length + 1) / 2];
        //NSLog(@"the string is %@",subString1);
        subString2 = [originalString substringFromIndex: (length + 1) / 2];
        //NSLog(@"the string is %@",subString2);
        for (int i = 0; i < (length - 1) / 2; i++)
        {
            unicode = [subString1 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
            unicode = [subString2 characterAtIndex:i];
            tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
        }
        unicode = [subString1 characterAtIndex: (length - 1) / 2];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%C",unicode]];
    }
    
    encryptText = tempString;
    return encryptText;
}

- (NSString *)MorseCode:(NSString *)originalString
{
    //originalString = [[NSString alloc] init];
    NSString *encryptText = [[NSString alloc] init];
    NSString *tempString = [[NSString alloc] init];
    long int length;
    unichar unicode;
    NSArray *morseCode = [[NSArray alloc] initWithObjects:@"*_",@"_***",@"_*_*",@"_**",@"*",@"**_*",
                                                            @"__*",@"****",@"**",@"*___",@"_*_",@"*_**",
                                                            @"__",@"_*",@"___",@"*__*",@"__*_",@"*_*",
                                                            @"***",@"_",@"**_",@"***_",@"*__",@"_**_",
                                                            @"_*__",@"__**", nil];
    length = originalString.length;
    NSLog(@"the length is %li",length);
    for (int i = 0; i <length; i++) {
        unicode = [originalString characterAtIndex: i];
        NSLog(@"the uincode is %hu",unicode);
        switch (unicode) {
            case 65:
                tempString = [tempString stringByAppendingString:morseCode[0]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 66:
                tempString = [tempString stringByAppendingString:morseCode[1]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 67:
                tempString = [tempString stringByAppendingString:morseCode[2]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 68:
                tempString = [tempString stringByAppendingString:morseCode[3]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 69:
                tempString = [tempString stringByAppendingString:morseCode[4]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 70:
                tempString = [tempString stringByAppendingString:morseCode[5]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 71:
                tempString = [tempString stringByAppendingString:morseCode[6]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 72:
                tempString = [tempString stringByAppendingString:morseCode[7]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 73:
                tempString = [tempString stringByAppendingString:morseCode[8]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 74:
                tempString = [tempString stringByAppendingString:morseCode[9]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 75:
                tempString = [tempString stringByAppendingString:morseCode[10]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 76:
                tempString = [tempString stringByAppendingString:morseCode[11]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 77:
                tempString = [tempString stringByAppendingString:morseCode[12]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 78:
                tempString = [tempString stringByAppendingString:morseCode[13]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 79:
                tempString = [tempString stringByAppendingString:morseCode[14]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 80:
                tempString = [tempString stringByAppendingString:morseCode[15]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 81:
                tempString = [tempString stringByAppendingString:morseCode[16]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 82:
                tempString = [tempString stringByAppendingString:morseCode[17]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 83:
                tempString = [tempString stringByAppendingString:morseCode[18]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 84:
                tempString = [tempString stringByAppendingString:morseCode[19]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 85:
                tempString = [tempString stringByAppendingString:morseCode[20]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 86:
                tempString = [tempString stringByAppendingString:morseCode[21]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 87:
                tempString = [tempString stringByAppendingString:morseCode[22]];
                tempString = [tempString stringByAppendingString:@"/"];
                //NSLog(@"the string is %@",tempString);
                break;
            case 88:
                tempString = [tempString stringByAppendingString:morseCode[23]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 89:
                tempString = [tempString stringByAppendingString:morseCode[24]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 90:
                tempString = [tempString stringByAppendingString:morseCode[25]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 97:
                tempString = [tempString stringByAppendingString:morseCode[0]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 98:
                tempString = [tempString stringByAppendingString:morseCode[1]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 99:
                tempString = [tempString stringByAppendingString:morseCode[2]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 100:
                tempString = [tempString stringByAppendingString:morseCode[3]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 101:
                tempString = [tempString stringByAppendingString:morseCode[4]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 102:
                tempString = [tempString stringByAppendingString:morseCode[5]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 103:
                tempString = [tempString stringByAppendingString:morseCode[6]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 104:
                tempString = [tempString stringByAppendingString:morseCode[7]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 105:
                tempString = [tempString stringByAppendingString:morseCode[8]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 106:
                tempString = [tempString stringByAppendingString:morseCode[9]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 107:
                tempString = [tempString stringByAppendingString:morseCode[10]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 108:
                tempString = [tempString stringByAppendingString:morseCode[11]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 109:
                tempString = [tempString stringByAppendingString:morseCode[12]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 110:
                tempString = [tempString stringByAppendingString:morseCode[13]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 111:
                tempString = [tempString stringByAppendingString:morseCode[14]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 112:
                tempString = [tempString stringByAppendingString:morseCode[15]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 113:
                tempString = [tempString stringByAppendingString:morseCode[16]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 114:
                tempString = [tempString stringByAppendingString:morseCode[17]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 115:
                tempString = [tempString stringByAppendingString:morseCode[18]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 116:
                tempString = [tempString stringByAppendingString:morseCode[19]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 117:
                tempString = [tempString stringByAppendingString:morseCode[20]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 118:
                tempString = [tempString stringByAppendingString:morseCode[21]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 119:
                tempString = [tempString stringByAppendingString:morseCode[22]];
                tempString = [tempString stringByAppendingString:@"/"];
                //NSLog(@"the string is %@",tempString);
                break;
            case 120:
                tempString = [tempString stringByAppendingString:morseCode[23]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 121:
                tempString = [tempString stringByAppendingString:morseCode[24]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            case 122:
                tempString = [tempString stringByAppendingString:morseCode[25]];
                tempString = [tempString stringByAppendingString:@"/"];
                break;
            default:
                break;
        }
    }
    encryptText = tempString;
    NSLog(@"the string is %@",encryptText);
    return encryptText;
}

@end
