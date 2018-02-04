//
// Created by kai on 2018/2/4.
// Copyright (c) 2018 njnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppGlobalUI.h"
#import "UIImage+Utils.h"

@interface BaseImageRecognitionViewController : UIViewController

- (void)didCaptureImage:(UIImage *)captureImage;

- (void)flushResult:(NSString *)result withImage:(UIImage *)image;

@end
