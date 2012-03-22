//
//  LocationManager.m
//  WhoUseMyDevice
//
//  Created by kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize curLocationDescription;

- (void)dealloc
{
	[self stop];
	[curLocationDescription release];
	
	[super dealloc];
}

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		
	}
	
	return self;
}

- (void)start
{
	if (_locationManager == nil)
	{
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		_locationManager.distanceFilter = kCLDistanceFilterNone;
		[_locationManager startUpdatingLocation];
	}
	[curLocationDescription release];
	curLocationDescription = @"Begin get location.";
	NSLog(@"qhk who use my device: begin get location.");
}

- (void)stop
{
	if (_locationManager != nil)
	{
		[_locationManager stopUpdatingLocation];
		[_locationManager release];
		_locationManager = nil;
	}
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	CLLocationDegrees latitude = newLocation.coordinate.latitude; //纬度
	CLLocationDegrees longitude = newLocation.coordinate.longitude; //经度
	CLLocationAccuracy accuracy = newLocation.horizontalAccuracy; //精确度，负数表示数值即不可靠
	[curLocationDescription release];
	curLocationDescription = [[NSString stringWithFormat:@"latitude=%.5f longitude=%.5f accuracy=%.2f", latitude, longitude, accuracy] retain];
	NSLog(@"qhk who use my device: %@.", curLocationDescription);
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	[curLocationDescription release];
	curLocationDescription = [[NSString stringWithFormat:@"Get location error: locationManager:didFailWithError:%@", error] retain];
	NSLog(@"qhk who use my device: %@", curLocationDescription);
}

@end
