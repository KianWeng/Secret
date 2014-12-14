//
//  ViewController.m
//  Secret
//
//  Created by 翁高剑 on 14/12/13.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionAlgorithm.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *cipherText;
@property (weak, nonatomic) IBOutlet UITextView *plainText;
@property (weak, nonatomic) IBOutlet UITextField *secretkey;
- (IBAction)sweep:(id)sender;
- (IBAction)sendWithEncryption:(id)sender;
- (IBAction)hideKeyboard:(id)sender;


@end

@implementation ViewController
{
    EncryptionAlgorithm *myEncryption;
    NSString *originalString;
    NSString *encryptionString;
    NSString *secretKey;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myEncryption = [[EncryptionAlgorithm alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sweep:(id)sender {
}

- (IBAction)sendWithEncryption:(id)sender {
    int number;
    originalString = self.plainText.text;
    encryptionString = self.cipherText.text;
    secretKey = self.secretkey.text;
    number = [secretKey intValue];
    NSLog(@"the number is %i",number);
    NSLog(@"the original string is %@",originalString);
    encryptionString = [myEncryption CaesarShiftsForEnglish: originalString withSecretKey: number];
    NSLog(@"the encryption string is %@",encryptionString);
    self.cipherText.text = encryptionString;
    
}

- (IBAction)hideKeyboard:(id)sender {
    [self.secretkey resignFirstResponder];
    [self.plainText resignFirstResponder];
}
@end
