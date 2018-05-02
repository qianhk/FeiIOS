//
// Created by kai on 2018/2/4.
// Copyright (c) 2018 njnu. All rights reserved.
//

#import "BaseImageRecognitionViewController.h"
#import "UIView+Toast.h"
#import <AVFoundation/AVFoundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIColor+String.h"

const static NSTimeInterval SHOW_PICTURE_INFO_TIME = 150.f;

@interface BaseImageRecognitionViewController () <AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) UIImageView *previewImageView;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoDataOutput *videoOutPut;
@property(nonatomic, strong) AVCaptureConnection *videoConnection;
@property(nonatomic, strong) dispatch_queue_t videoSampleQueue;
@property(nonatomic, strong) dispatch_queue_t imageRecognitionQueue;
@property(nonatomic, strong) UILabel *resultLabel;
@property(nonatomic, strong) UIImageView *aiLookImageView;
@property(nonatomic, assign) BOOL firstDidAppear;
@property(nonatomic, assign) long long didOutputSampleCount;
@property(nonatomic, weak) RACDisposable *showPicInfoDisposable;

@property(nonatomic, assign) BOOL showingStaticPictureInfo;

@end

@implementation BaseImageRecognitionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *pickPictureBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"静态图" style:UIBarButtonItemStylePlain target:self action:@selector(doPickPicture:)];
    NSArray *rightBarButtonItemArray = @[pickPictureBarButtonItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItemArray;

    self.videoSampleQueue = dispatch_queue_create("videoSampleQueue", NULL);
    self.imageRecognitionQueue = dispatch_queue_create("imageRecognitionQueue", NULL);
}

- (void)doPickPicture:(id)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(self)
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        @strongify(self)
        [self handlerActionGallery];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        @strongify(self)
        [self handlerActionCamera];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:galleryAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)handlerActionGallery {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)handlerActionCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = NO;
        if ([self checkCamera]) {
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [self.view makeToast:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。"];
        }
    } else {
        [self.view makeToast:@"摄像头当前不可用"];
    }
}

- (BOOL)checkCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return AVAuthorizationStatusRestricted != authStatus && AVAuthorizationStatusDenied != authStatus;
}

//压缩图片质量
- (UIImage *)reduceImage:(UIImage *)image percent:(float)percent {
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    NSString *type = info[UIImagePickerControllerMediaType];

    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        NSString *key = nil;
        if (picker.allowsEditing) {
            key = UIImagePickerControllerEditedImage;
        } else {
            key = UIImagePickerControllerOriginalImage;
        }
        UIImage *captureImage = info[key];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // 固定方向
//            image = [image fixOrientation];//这个方法是UIImage+Extras.h中方法
            //压缩图片质量
//            captureImage = [self reduceImage:captureImage percent:0.1];
//            CGSize imageSize = image.size;
//            imageSize.height = 320;
//            imageSize.width = 320;
        }
        self.showingStaticPictureInfo = YES;
        self.previewImageView.image = [self dealOriginalImage:captureImage toSize:self.previewImageView.frame.size];
        [self.previewLayer removeFromSuperlayer];
        @weakify(self)
        dispatch_sync(self.imageRecognitionQueue, ^{
            @strongify(self)
            [self didCaptureImage:captureImage];
        });
        if (SHOW_PICTURE_INFO_TIME <= 15.001f) {
            self.showPicInfoDisposable = [[[RACSignal return:@"显示静态图片信息时间过了"] delay:SHOW_PICTURE_INFO_TIME] subscribeNext:^(id x) {
                @weakify(self)
                [self resumeVideoCapture];
            }];
        }
    } else {
        [self.view makeToast:@"选择的图片无效"];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning %@", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.firstDidAppear) {
        self.firstDidAppear = YES;
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
                        [self initAVCapturWritterConfig];
                        [self setUpSubviews];
                        [self startVideoCapture];
                        [self.view makeToast:@"Camera Capture Video authorized."];
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
    if (!self.showingStaticPictureInfo) {
        [self startVideoCapture];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.showPicInfoDisposable dispose];
    self.showingStaticPictureInfo = NO;
    [self stopVideoCapture];
}

- (void)initAVCapturWritterConfig {
    if (TARGET_OS_SIMULATOR) {
        return;
    }
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
    self.aiLookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, resultBkgView.frame.origin.y - previewHeight, previewWidth, previewHeight)];
    self.aiLookImageView.contentMode = UIViewContentModeScaleToFill;
    self.aiLookImageView.backgroundColor = [UIColor colorWithHexString:@"#4000"];
    [self.view addSubview:self.aiLookImageView];

    self.previewImageView = [[UIImageView alloc] initWithFrame:viewBounds];
    self.previewImageView.tag = 100;
    self.previewImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.previewImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.previewImageView];
    [self.previewImageView.superview sendSubviewToBack:self.previewImageView];

    CGRect realBounds = self.previewImageView.bounds;
    self.previewLayer.frame = realBounds;
    [self.previewImageView.layer addSublayer:self.previewLayer];

    CGRect middleRect = viewBounds;
    CGFloat midY = CGRectGetMidY(middleRect);
    middleRect.size.height = middleRect.size.width;
    middleRect.origin.y = midY - middleRect.size.width / 2;
    middleRect.origin.x += 2;
    middleRect.size.width -= 4;
    CALayer *promptLayer = [[CALayer alloc] init];
    promptLayer.frame = middleRect;
    promptLayer.borderColor = [UIColor greenColor].CGColor;
    promptLayer.borderWidth = 1.f;
//    promptLayer.backgroundColor = [UIColor colorWithHexString:@"#4F00"].CGColor;
    [self.previewImageView.layer addSublayer:promptLayer];

    if (TARGET_OS_SIMULATOR) {
        self.resultLabel.text = @"TARGET_OS_SIMULATOR";
    }

    self.aiLookImageView.userInteractionEnabled = YES;
    [self.aiLookImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAiLookImageView:)]];
}

- (void)onTapAiLookImageView:(UIGestureRecognizer *)gestureRecognizer {
    [self resumeVideoCapture];
}

- (void)resumeVideoCapture {
    if (self.showingStaticPictureInfo) {
        self.showingStaticPictureInfo = NO;
        self.previewImageView.image = nil;
        [self.previewImageView.layer insertSublayer:self.previewLayer atIndex:0];
        if ([AppGlobalUI isCurrentViewControllerVisible:self]) {
            [self startVideoCapture];
        }
    }
}

- (void)startVideoCapture {
    [self.session startRunning];
    self.videoConnection.enabled = YES;
    [self.videoOutPut setSampleBufferDelegate:self queue:self.videoSampleQueue];
}

- (void)stopVideoCapture {
    [self.videoOutPut setSampleBufferDelegate:nil queue:nil];
    self.videoConnection.enabled = NO;
    [self.session stopRunning];
}

#pragma mark --AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    ++_didOutputSampleCount;
    if (_didOutputSampleCount % 30 != 0) {
        return;
    }
    @weakify(self)
    dispatch_sync(self.imageRecognitionQueue, ^{
        @strongify(self)
        CGImageRef cgImage = [UIImage imageFromSampleBuffer:sampleBuffer]; //8ms
        UIImage *captureImage = [UIImage imageWithCGImage:cgImage]; //0ms
        CGImageRelease(cgImage);
//      NSDate *beginDate = [NSDate date];
//      NSDate *makeImageDate = [NSDate date];
//      NSDate *recognitionImageDate = [NSDate date];
//      NSLog(@"lookTime total=%d makeImage=%d recog=%d",
//                (int) ([recognitionImageDate timeIntervalSinceDate:beginDate] * 1000),
//                (int) ([makeImageDate timeIntervalSinceDate:beginDate] * 1000),
//                (int) ([recognitionImageDate timeIntervalSinceDate:makeImageDate] * 1000));

        [self didCaptureImage:captureImage];
    });
}

- (void)didCaptureImage:(UIImage *)captureImage {
    [self flushResult:@"Override didCaptureImage" withImage:captureImage];
};

- (void)flushResult:(NSString *)result withImage:(UIImage *)image {
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        self.resultLabel.text = result;
        self.aiLookImageView.image = image;
    });
}

- (UIImage *)dealOriginalImage:(UIImage *)oriImage toSize:(CGSize)size {
    return oriImage;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AppGlobalUI setOrientation:UIInterfaceOrientationPortrait];
}

//- (BOOL)shouldAutorotate {
//    return NO; //不能禁止旋转，不然如果从横屏进来，通过AppGlobalUI setOrientation也无法改变方向
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait; //允许旋转，但只开启这一个方向
}

- (void)dealloc {
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

//- (AVCaptureDevice *)cameraWithPostion:(AVCaptureDevicePosition)position{
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    for (AVCaptureDevice *device in devices) {
//        if ([device position] == position) {
//            return device;
//        }
//    }
//    return nil;
//}
//
//- (AVCaptureDevice *)cameraWithPostion:(AVCaptureDevicePosition)position{
//    AVCaptureDeviceDiscoverySession *devicesIOS10 = [AVCaptureDeviceDiscoverySession  discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position];
//
//    NSArray *devicesIOS  = devicesIOS10.devices;
//    for (AVCaptureDevice *device in devicesIOS) {
//        if ([device position] == position) {
//            return device;
//        }
//    }
//    return nil;
//}

@end
