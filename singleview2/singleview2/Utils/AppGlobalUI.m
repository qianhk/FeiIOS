//
// Created by kai on 2018/2/4.
// Copyright (c) 2018 njnu. All rights reserved.
//

#import "AppGlobalUI.h"

@interface AppGlobalUI ()


@end

@implementation AppGlobalUI

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController {
    return viewController.isViewLoaded && viewController.view.window;
}

+ (void)setOrientation:(UIInterfaceOrientation)orientation {

    //  setOrientation 在iOS3以后变为私有方法了，不能直接去调用此方法，否则后果就是被打回。
//  首先设置UIInterfaceOrientationUnknown欺骗系统，避免可能出现直接设置无效的情况

    UIDevice *device = [UIDevice currentDevice];
    NSNumber *oriValue = [device valueForKey:@"orientation"];

    NSNumber *targetValue = @(orientation);

    if (![oriValue isEqualToNumber:targetValue]) {
//        NSNumber *orientationUnknown = @(UIInterfaceOrientationUnknown);
//        [device setValue:orientationUnknown forKey:@"orientation"];

        [device setValue:targetValue forKey:@"orientation"];
    }
}

@end
