//
//  SlidePanelViewController.h
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidePanelViewController : UIViewController

@property (weak, nonatomic) UIView *dragView;
@property float expandHeight;
@property float collapseHeight;
@property float parentHeight;

@property (weak, nonatomic) IBOutlet UIView *topGrayView;

@end
