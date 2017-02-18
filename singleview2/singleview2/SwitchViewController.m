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

@property (strong, nonatomic) TestTableViewController *testTableViewController;

@property (strong, nonatomic) BlueViewController *blueViewController;

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void)switchViews: (id)sender {
    
}

@end
