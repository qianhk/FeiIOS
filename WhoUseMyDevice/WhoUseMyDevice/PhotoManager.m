//
//  PhotoManager.m
//  WhoUseMyDevice
//
//  Created by kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "PhotoManager.h"

@implementation PhotoManager

- (AVCaptureDevice *)getFrontCamera
{
	//获取前置摄像头设备
	NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in cameras)
	{
        if (device.position == AVCaptureDevicePositionFront)
            return device;
    }
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}


- (void)initCapture
{
	AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput 
										  deviceInputWithDevice:[self getFrontCamera] 
										  error:nil];
	AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
	
	captureOutput.alwaysDiscardsLateVideoFrames = YES; 
	
	//captureOutput.minFrameDuration = CMTimeMake(1, 10);
	
	dispatch_queue_t queue = dispatch_queue_create("cameraQueue", NULL);
	[captureOutput setSampleBufferDelegate:self queue:queue];
	dispatch_release(queue);
	
	NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey; 
	NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]; 
	NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key]; 
	[captureOutput setVideoSettings:videoSettings]; 
	
	_captureSession = [[AVCaptureSession alloc] init];
	
	[_captureSession addInput:captureInput];
	[_captureSession addOutput:captureOutput];
    [_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
	[captureOutput release];
}

- (void)dealloc
{
	[self stopCapture];
	
	[super dealloc];
}

- (void)beginCapture
{
	if (!_captureSession.running)
	{
		[self initCapture];
		[_captureSession startRunning];
	}
}

- (void)stopCapture
{
	if (_captureSession.running)
	{
		[_captureSession stopRunning];
		[_captureSession release], _captureSession = nil;
	}
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput 
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
	   fromConnection:(AVCaptureConnection *)connection 
{ 	
	if (needCapture)
	{
		@autoreleasepool
		{
			NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
			
			CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
			CVPixelBufferLockBaseAddress(imageBuffer,0); 
			uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
			size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
			size_t width = CVPixelBufferGetWidth(imageBuffer); 
			size_t height = CVPixelBufferGetHeight(imageBuffer);  
			
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
			CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
			CGImageRef newImage = CGBitmapContextCreateImage(newContext); 
			
			CGContextRelease(newContext); 
			CGColorSpaceRelease(colorSpace);
			
			UIImage *image= [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationRight];
			
			CGImageRelease(newImage);
			
			CVPixelBufferUnlockBaseAddress(imageBuffer,0);
			
			[pool drain];
			needCapture = NO;
		}
	}
}


@end
