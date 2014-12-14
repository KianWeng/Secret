//
//  SEYViewController.m
//  izxinghand
//
//  Created by omg on 14-3-26.
//  Copyright (c) 2014年 lsq. All rights reserved.
//

#import "SEYViewController.h"
#import "ZXingObjC.h"

@interface SEYViewController ()
@property (nonatomic, retain) CALayer *imageLayer;
@property(nonatomic ,retain) NSArray *imageNames;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak ,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UITextField *txt;
- (IBAction)captureTouch:(id)sender;

@property (nonatomic, strong) ZXCapture *capture;
- (IBAction)sweep:(id)sender;
- (IBAction)make:(id)sender;


- (IBAction)see:(id)sender;
@end


@implementation SEYViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.txt.delegate = self;
    self.txt.text = @"漂亮的中文二维码";
    self.imageNames = @[@"1.png",
                        @"2.png",
                        @"3.png",
                        @"1.jpg",
                        @"1.gif",
                        @"2.jpg"];
    
    self.image = [UIImage imageNamed:self.imageNames[0]];
    self.img.image = self.image;
    self.img.contentMode = UIViewContentModeScaleToFill;
    
    
    
   //摄像头去扫
   
    self.capture = [[ZXCapture alloc]init];
    [self.capture setCamera:1];
    [self.capture setRotation:90];
    [self.capture setDelegate: self];
    [self.capture setLuminance:YES];

   // [self.capture  setFocusMode:];
 CALayer *layer = self.capture.luminance;//显示彩色照片
    layer.frame = CGRectMake(80, 200, 150, 150);
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 3.0f;

  //  [self.capture setBinary:YES];  //显示黑白照片
    
    [self.view.layer addSublayer:self.capture.luminance];
   //
    
    NSLog(@"%d,%d,%d",[self.capture hasBack],[self.capture hasFront],[self.capture hasTorch]);
    
    self.capture.delegate = self;
    
   /*   ZXCaptureView *view1 = [ [ZXCaptureView alloc] initWithFrame:CGRectMake(50, 200, 200, 200)] ;
    view1.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view1];
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sweep:(id)sender {  //从二维码图像得到信息
    
    CGImageRef imageToDecode = self.img.image.CGImage;
    //CGImself.img.image;  // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource* source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode] ;
    ZXBinaryBitmap* bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError* error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints* hints = [ZXDecodeHints hints];
    hints.encoding = NSUTF8StringEncoding;// StringEncoding;
    
    ZXMultiFormatReader* reader = [ZXMultiFormatReader reader];
   /* ZXResult* result = [reader decode:bitmap
                                hints:hints
                                error:&error];
*/
    ZXResult* result = [reader decode:bitmap
                                hints:nil
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString* contents = result.text;
        
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
    
      self.message.text = contents;
        
    } else {
        self.message.text = @"没扫到";
        NSLog(@"没扫到");
    }
    

    
}

- (IBAction)make:(id)sender {// 生成txt.text的二维码
    NSError* error = nil;
    ZXMultiFormatWriter* writer = [ZXMultiFormatWriter writer];
  
    ZXEncodeHints* hints = [ZXEncodeHints hints];
    hints.errorCorrectionLevel = [ZXErrorCorrectionLevel errorCorrectionLevelH];//容错性设成最高，二维码里添加图片
    hints.encoding =  NSUTF8StringEncoding;// 加上这两句，可以用中文了
    
    
      ZXBitMatrix* result = [writer encode:self.txt.text
                                    format:kBarcodeFormatQRCode width:800 height:800 hints:hints error:&error];
   /* ZXBitMatrix* result = [writer encode:self.txt.text
                                  format:kBarcodeFormatQRCode    //编码
                                   width:500  //图片大小
                                  height:500
                                 error:&error];
    */
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
       
        UIImage *image1 =   [UIImage imageWithCGImage:image];//二维码原图
        UIImage *subIamge = [UIImage imageNamed:@"icon3.jpg"];
        
        UIImage *image2 =[self addSubImage:image1 sub:subIamge];//二维码里加图标，长宽最好为原图的1/4一下 放在图像中间，这样不妨碍二维码识别

        
        self.img.image = image2;
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString* errorMessage = [error localizedDescription];
        self.txt.text = errorMessage;
    }

}

- (IBAction)see:(id)sender { //内置图片 —— 循环测试
    static int i = 1;
    
    self.image = [UIImage imageNamed:self.imageNames[i]];
    self.img.image  = self.image;
    self.txt.text = self.imageNames[i];
    
    i++;
    if(i == [self.imageNames count])
        i = 0;
        //内置图片
}

- (IBAction)captureTouch:(id)sender {//    摄像头扫描
    UIButton * bt = (UIButton *) sender;
    if(self.capture.running){
        
        [self.capture stop];
        [bt setTitle:@"扫一扫" forState:UIControlStateNormal];
       
        
        
    }else{
        
        [self.capture start];
        [bt setTitle:@"停止" forState:UIControlStateNormal];
    }
    
   
}


# pragma mark ZXcapture 代理方法
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result{
    NSLog(@"%s",__func__);
    if (result) {
                NSString* contents = result.text;
        
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
        NSLog(@"%d ,s",contents.length,contents.UTF8String);
        
        self.message.text = contents;
        [capture stop];
         NSLog(@"%@",contents);
        [self.captureBt setTitle:@"扫一扫" forState:UIControlStateNormal];
    } else {
        NSLog(@"中文出错");
    }
    

}

-(UIImage *)addSubImage:(UIImage *)img sub:(UIImage *) subImage
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int subWidth = subImage.size.width;
    int subHeight = subImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake( (w-subWidth)/2, (h - subHeight)/2, subWidth, subHeight), [subImage CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}

- (void)captureSize:(ZXCapture *)capture
              width:(NSNumber *)width
             height:(NSNumber *)height{
    NSLog(@"%s",__func__);
}

- (void)captureCameraIsReady:(ZXCapture *)capture{
    NSLog(@"%s",__func__);
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.txt) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

@end
