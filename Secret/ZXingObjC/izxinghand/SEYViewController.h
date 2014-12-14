//
//  SEYViewController.h
//  izxinghand
//
//  Created by omg on 14-3-26.
//  Copyright (c) 2014年 lsq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXCaptureDelegate.h"

@interface SEYViewController : UIViewController<UITextFieldDelegate, ZXCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIButton *captureBt;

@end
