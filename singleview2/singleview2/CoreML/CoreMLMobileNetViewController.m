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
#import "UIImage+Utils.h"
#import "UIView+Toast.h"
#import <AVFoundation/AVFoundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "AppGlobalUI.h"
#import "UIColor+String.h"

@interface CoreMLMobileNetViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, strong) UIView *realTimeView;   //实时显示的区域容器
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer; //实时显示摄像的区域
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoDataOutput *videoOutPut;
@property(nonatomic, strong) AVCaptureConnection *videoConnection;
@property(nonatomic, strong) dispatch_queue_t videoQueue;
@property(nonatomic, strong) dispatch_queue_t sampleBufferQueue;
@property(nonatomic, strong) UILabel *resultLabel;
@property(nonatomic, strong) UIImageView *captureImageView;
@property(nonatomic, assign) BOOL firstDisAppear;
@property(nonatomic, assign) long long didOutputSampleCount;
@property(nonatomic, strong) MobileNet *mobileNet;

@end

@implementation CoreMLMobileNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MobileNet";
    self.view.backgroundColor = [UIColor whiteColor];

    self.mobileNet = [[MobileNet alloc] init]; //90ms
    NSString *text = [self imageRecognitionByImage:[UIImage imageNamed:@"desk"]];
    NSLog(@"output: label=%@", text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.firstDisAppear) {
        self.firstDisAppear = YES;
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusAuthorized) {
//            [self.view makeToast:@"Camera Capture Video authorized."];
            [self initAVCapturWritterConfig];
            [self setUpSubviews];
        } else if (authorizationStatus == AVAuthorizationStatusNotDetermined) {
//            [self.view makeToast:@"Camera Capture Video authorized."];
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                NSLog(@"requestAccessForMediaType granted=%@ mainThread=%@", granted ? @"YES" : @"NO", [NSThread isMainThread] ? @"YES" : @"NO");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        [self.view makeToast:@"Camera Capture Video authorized."];
                        [self initAVCapturWritterConfig];
                        [self setUpSubviews];
                        [self startVideoCapture];
                        return;
                    } else {
                        [self.view makeToast:@"Camera Capture Video Denied."];
                        return;
                    }
                });
            }];
        } else {
            [self.view makeToast:@"Camera Capture Video Denied."];
            return;
        }
    }
    [self startVideoCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopVideoCapture];
}

- (void)initAVCapturWritterConfig {
    self.session = [[AVCaptureSession alloc] init];

    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (videoDevice.isFocusPointOfInterestSupported && [videoDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        [videoDevice lockForConfiguration:nil];
        [videoDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [videoDevice unlockForConfiguration];
    }

    AVCaptureDeviceInput *cameraDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:nil];


    if ([self.session canAddInput:cameraDeviceInput]) {
        [self.session addInput:cameraDeviceInput];
    }

    //视频
    self.videoOutPut = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary *outputSettings = @{(id) kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
    [self.videoOutPut setVideoSettings:outputSettings];
    if ([self.session canAddOutput:self.videoOutPut]) {
        [self.session addOutput:self.videoOutPut];
    }
    self.videoConnection = [self.videoOutPut connectionWithMediaType:AVMediaTypeVideo];
    self.videoConnection.enabled = NO;
    [self.videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];

    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)setUpSubviews {
    //容器
    CGRect viewBounds = self.view.bounds;

    UIEdgeInsets safeInsets = kViewSafeAreaInsets(self.view);

    UIView *resultBkgView = [[UIView alloc] initWithFrame:CGRectMake(0, viewBounds.size.height - safeInsets.bottom - 40, viewBounds.size.width, 40 + safeInsets.bottom)];
    resultBkgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:resultBkgView];

    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewBounds.size.height - safeInsets.bottom - 40, viewBounds.size.width, 40)];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.font = [UIFont systemFontOfSize:20];
    self.resultLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.resultLabel];

    CGFloat previewWidth = 88;
    CGFloat previewHeight = previewWidth; //previewWidth * viewBounds.size.height / viewBounds.size.width;
    self.captureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, resultBkgView.frame.origin.y - previewHeight, previewWidth, previewHeight)];
    self.captureImageView.contentMode = UIViewContentModeScaleToFill;
    self.captureImageView.backgroundColor = [UIColor colorWithHexString:@"#4000"];
    [self.view addSubview:self.captureImageView];

    self.realTimeView = [[UIView alloc] initWithFrame:viewBounds];
    self.realTimeView.tag = 100;
    self.realTimeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.realTimeView];
    [self.realTimeView.superview sendSubviewToBack:self.realTimeView];

    //实时图像预览
    CGRect realBounds = self.realTimeView.bounds;
    self.previewLayer.frame = realBounds;
    [self.realTimeView.layer addSublayer:self.previewLayer];

//    CGRect middleRect = CGRectMake(0, safeInsets.top, viewBounds.size.width, viewBounds.size.height - safeInsets.top - resultBkgView.frame.size.height);
    CGRect middleRect = viewBounds;
    CGFloat midY = CGRectGetMidY(middleRect);
    middleRect.size.height = middleRect.size.width;
    middleRect.origin.y = midY - middleRect.size.width / 2;
    CALayer *promptLayer = [[CALayer alloc] init];
    promptLayer.frame = middleRect;
    promptLayer.borderColor = [UIColor greenColor].CGColor;
    promptLayer.borderWidth = 0.5f;
//    promptLayer.backgroundColor = [UIColor colorWithHexString:@"#4F00"].CGColor;
    [self.realTimeView.layer addSublayer:promptLayer];
}

- (void)startVideoCapture {
    [self.session startRunning];
    self.videoConnection.enabled = YES;
    self.videoQueue = dispatch_queue_create("videoQueue", NULL);
    self.sampleBufferQueue = dispatch_queue_create("sampleBufferQueue", NULL);
    [self.videoOutPut setSampleBufferDelegate:self queue:self.videoQueue];
}

- (void)stopVideoCapture {
    [self.videoOutPut setSampleBufferDelegate:nil queue:nil];
    self.videoConnection.enabled = NO;
    self.videoQueue = nil;
    self.sampleBufferQueue = nil;
    [self.session stopRunning];
}

- (NSString *)imageRecognitionByImage:(UIImage *)image {
    UIImage *scaledImage = [image imageByClipToSize:CGSizeMake(224, 224)]; //75ms 图片1080*1920
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

#pragma mark --AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    ++_didOutputSampleCount;
    if (_didOutputSampleCount % 30 != 0) {
        return;
    }
    @weakify(self)
    dispatch_sync(self.sampleBufferQueue, ^{
        @strongify(self)
        CGImageRef cgImage = [UIImage imageFromSampleBuffer:sampleBuffer]; //8ms
        UIImage *captureImage = [UIImage imageWithCGImage:cgImage]; //0ms
        CGImageRelease(cgImage);

        UIImage *scaledImage = [captureImage imageByClipToSize:CGSizeMake(224, 224)]; //75ms 图片1080*1920
        NSString *result = [self imageRecognitionByScaledImage:scaledImage];

//        NSDate *beginDate = [NSDate date];
//        NSDate *makeImageDate = [NSDate date];
//        NSDate *recognitionImageDate = [NSDate date];
//        NSLog(@"lookTime total=%d makeImage=%d recog=%d",
//                (int) ([recognitionImageDate timeIntervalSinceDate:beginDate] * 1000),
//                (int) ([makeImageDate timeIntervalSinceDate:beginDate] * 1000),
//                (int) ([recognitionImageDate timeIntervalSinceDate:makeImageDate] * 1000));
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.resultLabel.text = result;
            self.captureImageView.image = scaledImage;
        });
    });
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

}

- (void)dealloc {
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

@end
