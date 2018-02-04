//
//  MainTabBarViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/19.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SectionTableViewController.h"
#import "EntryTabViewController.h"
#import "AIEntryTabViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];

    UIViewController *entryTabViewController = [[EntryTabViewController alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedStringFromTable(@"NormalTab", @"InfoPlist", @"第一个tab的名称") image:[UIImage imageNamed:@"homepage"] tag:0];
    entryTabViewController.tabBarItem = item;

    UIViewController *aiEntryTabViewController = [[AIEntryTabViewController alloc] init];
    item = [[UITabBarItem alloc] initWithTitle:NSLocalizedStringFromTable(@"AITab", @"InfoPlist", @"第二个AI试验tab") image:[UIImage imageNamed:@"AI"] tag:1];
    aiEntryTabViewController.tabBarItem = item;

    UIViewController *sectionTableViewController = [[SectionTableViewController alloc] initWithStyle:UITableViewStylePlain];
    sectionTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"SectionTab", @"分节的tableview") image:[UIImage imageNamed:@"service"] tag:2];
    self.viewControllers = @[entryTabViewController, aiEntryTabViewController, sectionTableViewController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
