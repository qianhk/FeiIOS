//
//  SwitchViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/18.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "SwitchViewController.h"
#import "TestTableViewController.h"
#import "BlueViewController.h"

@interface SwitchViewController ()

@property(strong, nonatomic) TestTableViewController *testTableViewController;

@property(strong, nonatomic) BlueViewController *blueViewController;

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blueViewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
    _blueViewController.view.frame = [self getContentViewFrame];
    [self switchViewFromViewController:nil toViewController:self.blueViewController];

//    self.testTableViewController = [[TestTableViewController alloc] init];
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
            self.testTableViewController = [[TestTableViewController alloc] init];
            _testTableViewController.view.frame = [self getContentViewFrame];
        }
    } else {
        if (!self.blueViewController) {
            self.blueViewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
            _blueViewController.view.frame = [self getContentViewFrame];
        }
    }
    if (!_testTableViewController.view.superview) {
        [self switchViewFromViewController:_blueViewController toViewController:_testTableViewController];
    } else {
        [self switchViewFromViewController:_testTableViewController toViewController:_blueViewController];
    }
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
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20);
}

@end
