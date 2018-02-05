//
// Created by kai on 2018/2/5.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "AppUINavigationController.h"

@interface AppUINavigationController ()


@end

@implementation AppUINavigationController

- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
