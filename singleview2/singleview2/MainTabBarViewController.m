//
//  MainTabBarViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/19.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NormalTableViewController.h"
#import "PickerViewController.h"
#import "SectionTableViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *testViewController = [[NormalTableViewController alloc] init];
//    testViewController.view.frame = [self getContentViewFrame];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Normal" image:[UIImage imageNamed:@"hotel"] tag:0];
    testViewController.tabBarItem = item;
    
    UIViewController * blueViewController= [[PickerViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
//    blueViewController.view.frame = [self getContentViewFrame];
    item = [[UITabBarItem alloc] initWithTitle:@"Picker" image:[UIImage imageNamed:@"scenic"] tag:1];
    blueViewController.tabBarItem = item;

    UIViewController * sectionTableViewController= [[SectionTableViewController alloc] initWithStyle:UITableViewStylePlain];
    sectionTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Section" image:[UIImage imageNamed:@"hotel"] tag:2];
    
    self.viewControllers = @[testViewController, blueViewController, sectionTableViewController];
    
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

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 100, originFrame.size.width, originFrame.size.height - 20 - 44);
}

@end
