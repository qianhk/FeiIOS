//
//  SwitchViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/18.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "SwitchViewController.h"
#import "NormalTableViewController.h"
#import "PickerViewController.h"

@interface SwitchViewController ()

@property(strong, nonatomic) NormalTableViewController *testTableViewController;

@property(strong, nonatomic) PickerViewController *blueViewController;

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blueViewController = [[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil];
    _blueViewController.view.frame = [self getContentViewFrame];
    [self switchViewFromViewController:nil toViewController:self.blueViewController];

//    self.testTableViewController = [[NormalTableViewController alloc] init];
//    _testTableViewController.view.frame = [self getContentViewFrame];
//    [self switchViewFromViewController:nil toViewController:_testTableViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (_testTableViewController.view.superview) {
        self.blueViewController = nil;
    } else {
        self.testTableViewController = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)switchViews:(id)sender {
    if (!self.testTableViewController.view.superview) {
        if (!self.testTableViewController) {
            self.testTableViewController = [[NormalTableViewController alloc] init];
            _testTableViewController.view.frame = [self getContentViewFrame];
        }
    } else {
        if (!self.blueViewController) {
            self.blueViewController = [[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil];
            _blueViewController.view.frame = [self getContentViewFrame];
        }
    }
    
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (!_testTableViewController.view.superview) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self switchViewFromViewController:_blueViewController toViewController:_testTableViewController];
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self switchViewFromViewController:_testTableViewController toViewController:_blueViewController];
    }
    
    [UIView commitAnimations];
}

#pragma mark - 转换控制器

- (void)switchViewFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    // 把当前控制器移除
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    // 把转换的控制器加进来
    if (toVC != nil) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
//        [self.view bringSubviewToFront:toVC.view];
        [toVC didMoveToParentViewController:self];
    }
}

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20 - 44);
}

@end
