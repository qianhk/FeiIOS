//
//  AppDelegate.h
//  singleViewDemo
//
//  Created by qianhk on 13-10-5.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rootViewController;
@property (strong, nonatomic) UINavigationController * navigationController;

@end
