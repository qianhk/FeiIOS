//
// Created by kai on 2019/10/21.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import "CoreTextTestViewController.h"
#import "TestCoreTextView1.h"
#import "AppGlobalUI.h"

@interface CoreTextTestViewController ()

@property (nonatomic, strong) TestCoreTextView1 *testView1;

@end

@implementation CoreTextTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = self.view.bounds.size;
    NSLog(@"lookKai viewDidLoad viewSize=%@", NSStringFromCGSize(size));
    _testView1 = [TestCoreTextView1 new];
    _testView1.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.1];
    _testView1.frame = CGRectMake(0, kTopHeight, size.width, size.height);
    [self.view addSubview:_testView1];
}


@end
