//
//  PhotoManager.h
//  WhoUseMyDevice
//
//  Created by kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>

@interface PhotoManager : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate>
{
	AVCaptureSession *_captureSession;
	
	BOOL needCapture;
}

- (void)beginCapture;
- (void)stopCapture;

@end
