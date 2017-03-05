//
//  UserDefaultsViewController.m
//  singleview2
//
//  Created by KaiKai on 17/3/5.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "UserDefaultsViewController.h"

@interface UserDefaultsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation UserDefaultsViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUserDefaults];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self refreshUserDefaults];
//}

- (void)refreshUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id nameStr = [defaults objectForKey:@"name_preference"];
    _resultLabel.text = nameStr;
}

@end
