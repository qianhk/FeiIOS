//
// Created by kai on 2018/2/4.
// Copyright (c) 2018 njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kIsIphoneX (([[UIScreen mainScreen] bounds].size.height - 812) ? NO : YES)

#define kViewSafeAreaInsets(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

@interface AppGlobalUI : NSObject

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

@end