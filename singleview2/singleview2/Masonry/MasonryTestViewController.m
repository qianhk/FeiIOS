//
//  MasonryTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2017/5/16.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MasonryTestViewController.h"

@interface MasonryTestViewController ()

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *middleView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UIView *aboveMiddleView;

@end

@implementation MasonryTestViewController

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, 16, 16);
        _topView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
        _middleView.frame = CGRectMake(0, 0, 16, 16);
        _topView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_middleView];
    }
    return _middleView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, 16, 16);
        _topView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIView *)aboveMiddleView {
    if (!_aboveMiddleView) {
        _aboveMiddleView = [[UIView alloc] init];
        _aboveMiddleView.frame = CGRectMake(0, 0, 16, 16);
        _topView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_aboveMiddleView];
    }
    return _aboveMiddleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.mas_equalTo(80);
//        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];

    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottomMargin.mas_equalTo(12);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.centerX.equalTo(self.view);
    }];

    [self.aboveMiddleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.mas_equalTo(12);
        make.top.equalTo(self.middleView.mas_top);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        
    }];
    
//    [self.view setNeedsUpdateConstraints];
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

@end
