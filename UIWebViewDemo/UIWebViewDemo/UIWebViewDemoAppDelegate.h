//
//  UIWebViewDemoAppDelegate.h
//  UIWebViewDemo
//
//  Created by skylin zhu on 11-7-28.
//  Copyright 2011年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIWebViewDemoViewController;

@interface UIWebViewDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIWebViewDemoViewController *viewController;

@end
