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

@end