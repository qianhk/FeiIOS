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

@interface CoreMLMobileNetViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, strong) UIView *realTimeView;   //实时显示的区域容器
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer; //实时显示摄像的区域
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoDataOutput *videoOutPut;
@property(nonatomic, strong) AVCaptureConnection *videoConnection;
@property(nonatomic, strong) dispatch_queue_t videoQueue;
@property(nonatomic, strong) dispatch_queue_t sampleBufferQueue;
@property(nonatomic, strong) UILabel *resultLabel;
@property(nonatomic, assign) BOOL firstDisAppear;
@property(nonatomic, assign) long long didOutputSampleCount;

@end

@implementation CoreMLMobileNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MobileNet";
    self.view.backgroundColor = [UIColor whiteColor];
    MobileNet *model = [[MobileNet alloc] init];

    UIImage *image = [UIImage imageNamed:@"desk"];
    UIImage *scaledImage = [image scaleToSize:CGSizeMake(224, 224)];
    CVPixelBufferRef buffer = [image pixelBufferFromCGImage:scaledImage];
    MobileNetInput *input = [[MobileNetInput alloc] initWithImage:buffer];
    NSError *error = nil;
    MobileNetOutput *output = [model predictionFromFeatures:input error:&error];
    CVPixelBufferRelease(buffer);
    NSLog(@"output: error=%@ label=%@", error, output.classLabel);
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
            [self.view makeToast:@"Camera Capture Video authorized."];
            [self initAVCapturWritterConfig];
            [self setUpSubviews];
        } else if (authorizationStatus == AVAuthorizationStatusNotDetermined) {
            [self.view makeToast:@"Camera Capture Video authorized."];
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
    self.realTimeView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.realTimeView];

    //实时图像预览
    self.previewLayer.frame = self.realTimeView.frame;
    [self.realTimeView.layer addSublayer:self.previewLayer];

    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.font = [UIFont systemFontOfSize:20];
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.resultLabel];

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
        NSString *text = [self predictImageScene:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
//        NSString *text = [NSString stringWithFormat:@"calc %d", _didOutputSampleCount];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.resultLabel.text = text;
        });
    });
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

}

- (void)dealloc {
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

@end
