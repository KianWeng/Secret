//
//  ViewController.m
//  Secret
//
//  Created by 翁高剑 on 14/12/13.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionAlgorithm.h"
#import "AlgorithmChooseViewController.h"
#import "DecryptionAlgorithm.h"

@interface ViewController ()
@property (weak,nonatomic) NSString *currentIndex;
@property (weak, nonatomic) IBOutlet UITextField *secretkey;
@property (weak, nonatomic) IBOutlet UITextField *algorithmDisplay;
@property (weak, nonatomic) IBOutlet UITextView *cipherText;
@property (weak, nonatomic) IBOutlet UITextView *plainText;

- (IBAction)sweep:(id)sender;
- (IBAction)sendWithEncryption:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)AlgorithmChoose:(id)sender;


@end

@implementation ViewController

{
    EncryptionAlgorithm *myEncryption;
    DecryptionAlgorithm *myDecryption;
    NSString *originalString;
    NSString *encryptionString;
    NSString *secretKey;
    NSString *currentIndexTemp;
    int encryptionNumber;
    int keyboardHeight;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     //self.algorithmArray = @[@"凯撒密码（英文版）",@"凯撒密码（中文版）", @"栅栏密码", @"维吉尼亚密码",@"波利比奥斯密码",@"乘法密码",@"摩斯电码"];
    
    self.algorithmDisplay.delegate=self;
    self.secretkey.delegate=self;
    self.cipherText.delegate = self;
    self.plainText.delegate = self;
    myEncryption = [[EncryptionAlgorithm alloc] init];
    //NSLog(@"the currentIndex is %@",_currentIndex);
    currentIndexTemp = _currentIndex;
    if ([_algorithmText  isEqual: @"algorithm0"])
    {
        _algorithmDisplay.text = @"凯撒密码（英文版）";
        encryptionNumber = 0;
    }
    else if ([_algorithmText isEqual: @"algorithm1"])
    {
        _algorithmDisplay.text = @"凯撒密码（中文版）";
        encryptionNumber = 1;
    }
    else if ([_algorithmText isEqual: @"algorithm2"])
    {
        _algorithmDisplay.text = @"栅栏密码";
        encryptionNumber = 2;
    }
    else if ([_algorithmText isEqual: @"algorithm3"])
    {
        _algorithmDisplay.text = @"维吉尼亚密码";
        encryptionNumber = 3;
    }
    else if ([_algorithmText isEqual: @"algorithm4"])
    {
        _algorithmDisplay.text = @"波利比奥斯密码";
        encryptionNumber = 4;
    }
    else if ([_algorithmText isEqual: @"algorithm5"])
    {
        _algorithmDisplay.text = @"乘法密码";
        encryptionNumber = 5;
    }
    else if ([_algorithmText isEqual: @"algorithm6"])
    {
       _algorithmDisplay.text = @"摩斯电码";
        encryptionNumber = 6;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    //[[NSNotificationCenter defaultCenter] addObserver:self
    //                                         selector:@selector(keyboardWillHide:)
     //                                            name:UIKeyboardWillHideNotification
       //                                        object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sweep:(id)sender {
}

- (IBAction)sendWithEncryption:(id)sender {
    int key;
    originalString = self.plainText.text;
    encryptionString = self.cipherText.text;
    secretKey = self.secretkey.text;
    key = [secretKey intValue];
    //NSLog(@"the number is %i",key);
    //NSLog(@"the original string is %@",originalString);
    //encryptionString = [myEncryption CaesarShiftsForEnglish: originalString withSecretKey: key];
    //encryptionString = [myEncryption MorseCode:originalString];
    NSLog(@"the number is %i",encryptionNumber);
    switch (encryptionNumber) {
        case 0:
            encryptionString = [myEncryption CaesarShiftsForEnglish: originalString withSecretKey: key];
            break;
        case 1:
            encryptionString = [myEncryption CaesarShiftsForChinese: originalString withSecretKey: key];
            break;
        case 2:
            encryptionString = [myEncryption TheRailFenceCipher: originalString];
            break;
        case 3:
            encryptionString = [myEncryption VigenereCipher:originalString withSecreKey: secretKey];
            break;
        case 4:
            encryptionString = [myEncryption PolybiusCipher: originalString];
            break;
        case 5:
            encryptionString = [myEncryption MultiplicationCipher: originalString withSecretKey: key];
            break;
        case 6:
            encryptionString = [myEncryption MorseCode: originalString];
            break;
        default:
            break;
    }
    //encryptionString = [myEncryption TheRailFenceCipher:originalString];
    //NSLog(@"the encryption string is %@",encryptionString);
    self.cipherText.text = encryptionString;
    
}

- (IBAction)hideKeyboard:(id)sender {
    [self.secretkey resignFirstResponder];
    [self.plainText resignFirstResponder];
    [self.cipherText resignFirstResponder];
    [self.algorithmDisplay resignFirstResponder];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
}

- (IBAction)AlgorithmChoose:(id)sender {
    [self performSegueWithIdentifier:@"AlgorithmChooseViewController" sender: self];
   // NSLog(@"Did it end");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"the currentIndex00 is %@",currentIndexTemp);
    UIViewController *send1 = segue.destinationViewController;
    [send1 setValue: currentIndexTemp forKey:@"currentIndexString"];
}

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //获取键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    //NSLog(@"the fram textView Y is %d",keyboardHeight);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    //NSLog(@"the keyboard will show");
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //NSLog(@"the keyboard will show");
    CGRect frame = textView.frame;
    //NSLog(@"the fram textView Y is %f",frame.origin.y);
    //NSLog(@"the fram textView Y is %f",self.view.frame.size.height);
    int offset = frame.origin.y + 180 - (self.view.frame.size.height - keyboardHeight);//键盘高度216
    //NSLog(@"the fram textView Y is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"the keyboard will show");
    CGRect frame = textField.frame;
    //NSLog(@"the fram textView Y is %f",frame.origin.y);
    //NSLog(@"the fram textView Y is %f",self.view.frame.size.height);
    int offset = frame.origin.y + 40 - (self.view.frame.size.height - keyboardHeight);//键盘高度216
    //NSLog(@"the fram textView Y is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
#pragma mark -

@end
