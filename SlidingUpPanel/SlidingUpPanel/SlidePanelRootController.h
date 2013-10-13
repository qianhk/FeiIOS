//
//  SlidePanelViewController.h
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidePanelViewController.h"

@interface SlidePanelRootController : UIViewController

@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic) SlidePanelViewController *panelViewController;

- (void)setMidViewAlpha:(float)alpha;

@end
