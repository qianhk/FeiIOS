//
//  CoreMLMobileNetViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/2/2.
//  Copyright © 2018年 Njnu. All rights reserved.
// 函数执行耗时 iPhone7上, debug模式, 输入特征向量224*224
//

#import "CoreMLMobileNetViewController.h"
#import "MobileNet.h"

@interface CoreMLMobileNetViewController ()

@property(nonatomic, strong) MobileNet *mobileNet;

@end

@implementation CoreMLMobileNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MobileNet";

    self.mobileNet = [[MobileNet alloc] init]; //90ms
    NSString *text = [self imageRecognitionByImage:[UIImage imageNamed:@"desk"]];
    NSLog(@"output: label=%@", text);
}

- (NSString *)imageRecognitionByImage:(UIImage *)image {
    UIImage *scaledImage = [image imageByClipToSize:CGSizeMake(224, 224) usingScreenScale:NO]; //75ms 图片1080*1920
    return [self imageRecognitionByScaledImage:scaledImage];
}

- (NSString *)imageRecognitionByScaledImage:(UIImage *)scaledImage {
    if (scaledImage) {
        CVPixelBufferRef buffer = [UIImage pixelBufferFromCGImage:scaledImage.CGImage]; //0ms
        MobileNetInput *input = [[MobileNetInput alloc] initWithImage:buffer]; //0ms
        NSError *error = nil;
        MobileNetOutput *output = [self.mobileNet predictionFromFeatures:input error:&error]; //35ms
//      NSLog(@"output: error=%@ label=%@ dic=%@", error, output.classLabel, output.classLabelProbs);
        CVPixelBufferRelease(buffer);
        if (error) {
            return error.localizedDescription;
        } else {
            return output.classLabel;
        }
    } else {
        return @"make image error";
    }
}

- (void)didCaptureImage:(UIImage *)captureImage {
    UIImage *scaledImage = [captureImage imageByClipToSize:CGSizeMake(224, 224) usingScreenScale:NO]; //75ms 图片1080*1920
    NSString *result = [self imageRecognitionByScaledImage:scaledImage];
    [self flushResult:result withImage:scaledImage];
}

- (UIImage *)dealOriginalImage:(UIImage *)oriImage toSize:(CGSize)size {
    return [oriImage imageByMiddleSquareSideToShortSizeSide:size];
}


@end
