//
//  ViewController.h
//  CapturePic
//
//  Created by kai on 12-3-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate, CLLocationManagerDelegate>
{
	AVCaptureVideoPreviewLayer *_prevLayer;
	AVCaptureSession *_captureSession;
	
	BOOL needCapture;
	
	CLLocationManager* _locationManager;
	BOOL beginLocation;
}

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;
@property (retain, nonatomic) IBOutlet UILabel *lblStatus;
@property (retain, nonatomic) IBOutlet UIButton *_btnStart;
- (IBAction)btnCaptureClicked:(id)sender;
- (IBAction)btnStartClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *_captureView;
- (IBAction)btnLocateClicked:(id)sender;

@end
