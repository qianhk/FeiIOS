//
//  LocationManager.h
//  WhoUseMyDevice
//
//  Created by kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
	CLLocationManager* _locationManager;
	NSString* curLocationDescription;
}

@property (nonatomic, readonly) NSString* curLocationDescription;

- (void)start;
- (void)stop;

@end
