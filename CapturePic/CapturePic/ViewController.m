//
//  ViewController.m
//  CapturePic
//
//  Created by kai on 12-3-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize _captureView;
@synthesize _btnStart;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
	
	_prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
	_prevLayer.frame = CGRectMake(0, 0, 100, 100);
	_prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.view.layer addSublayer:_prevLayer];

//	[_captureSession startRunning];
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self initCapture];
}

- (void)viewDidUnload
{
    [self set_btnStart:nil];
	[self set_captureView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
	[_prevLayer release];
    [_btnStart release];
	[_captureView release];
    [super dealloc];
}
- (IBAction)btnCaptureClicked:(id)sender
{
	needCapture = YES;
}

- (IBAction)btnStartClicked:(id)sender
{
	if(_captureSession.running)
	{
		[_captureSession stopRunning];
		[_btnStart setTitle:@"Start" forState:UIControlStateNormal];
	}
	else
	{
		[_captureSession startRunning];
		[_btnStart setTitle:@"Stop" forState:UIControlStateNormal];
	}
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput 
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
	   fromConnection:(AVCaptureConnection *)connection 
{ 	
	if (needCapture)
	{
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		
		CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
		CVPixelBufferLockBaseAddress(imageBuffer,0); 
		uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer); 
		size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
		size_t width = CVPixelBufferGetWidth(imageBuffer); 
		size_t height = CVPixelBufferGetHeight(imageBuffer);  
		
		/*Create a CGImageRef from the CVImageBufferRef*/
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
		CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
		CGImageRef newImage = CGBitmapContextCreateImage(newContext); 
		
		CGContextRelease(newContext); 
		CGColorSpaceRelease(colorSpace);
		
	//	[self.customLayer performSelectorOnMainThread:@selector(setContents:) withObject: (id) newImage waitUntilDone:YES];
		
		UIImage *image= [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationRight];
		
		/*We relase the CGImageRef*/
		CGImageRelease(newImage);
		
		[_captureView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
		
		/*We unlock the  image buffer*/
		CVPixelBufferUnlockBaseAddress(imageBuffer,0);
		
		[pool drain];
		needCapture = NO;
	}
} 

@end
