//
// Created by kai on 2018/12/10.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0f
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kIsIphoneX ((kScreenH == 812.f || kScreenH )== 896.f ? YES : NO)

#define kViewSafeAreaInsets(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

@interface AppGlobalUI : NSObject

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

+ (void)setOrientation:(UIInterfaceOrientation)orientation;

+ (BOOL)isInPortrait;

@end
