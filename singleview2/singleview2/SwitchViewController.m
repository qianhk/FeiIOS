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
    // Do any additional setup after loading the view from its nib.
    self.blueViewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
    self.blueViewController.view.frame = self.view.frame;
    [self switchViewFromViewController:nil toViewController:self.blueViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [toVC didMoveToParentViewController:self];
    }

}

@end
