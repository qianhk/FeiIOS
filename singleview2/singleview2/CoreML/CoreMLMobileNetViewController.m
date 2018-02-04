//
//  CoreMLMobileNetViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/2/2.
//  Copyright © 2018年 Njnu. All rights reserved.
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

@end

@implementation CoreMLMobileNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MobileNet";
    self.view.backgroundColor = [UIColor whiteColor];

    NSString *text = [self predictImageScene:[UIImage imageNamed:@"desk"]];
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

    //视频
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

    CGFloat previewWidth = 150;
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

    CGRect middleRect = CGRectMake(0, safeInsets.top, viewBounds.size.width, viewBounds.size.height - safeInsets.top - resultBkgView.frame.size.height);
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

- (NSString *)predictImageScene:(UIImage *)image {
    MobileNet *model = [[MobileNet alloc] init];
    UIImage *scaledImage = [image scaleToSize:CGSizeMake(224, 224)];
    CVPixelBufferRef buffer = [image pixelBufferFromCGImage:scaledImage];
    MobileNetInput *input = [[MobileNetInput alloc] initWithImage:buffer];
    NSError *error = nil;
    MobileNetOutput *output = [model predictionFromFeatures:input error:&error];
//    NSLog(@"output: error=%@ label=%@ dic=%@", error, output.classLabel, output.classLabelProbs);
    CVPixelBufferRelease(buffer);
    return output.classLabel;
}

- (UIImage *)predictImageSceneTo224:(UIImage *)image {
    CGSize size = image.size;
    CGFloat shortSize = fminf(size.width, size.height);
    CGFloat halfSize = shortSize / 2;
    CGPoint middle = CGPointMake(size.width / 2, size.height / 2);
//    UIImage *scaledImage = [image cutImageWithTargetSize:CGSizeMake(224, 224) clipRect:CGRectMake(middle.x - halfSize, middle.y - halfSize, shortSize, shortSize)];
    UIImage *scaledImage = [image scaleWithScale:0.5f];
    return scaledImage;
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
        CGImageRef cgImage = [UIImage imageFromSampleBuffer:sampleBuffer];
        UIImage *captureImage = [UIImage imageWithCGImage:cgImage];
        captureImage = [self predictImageSceneTo224:captureImage];
        CGImageRelease(cgImage);
//        NSString *text = [NSString stringWithFormat:@"calc %d", _didOutputSampleCount];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.resultLabel.text = [captureImage description];
            self.captureImageView.image = captureImage;
        });
    });
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

}

- (void)dealloc {
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

@end
