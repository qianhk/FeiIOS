//
//  FeiPhoneInfoAppDelegate.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchViewController;

@interface FeiPhoneInfoAppDelegate : NSObject <UIApplicationDelegate>
{
	SwitchViewController* switchController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
