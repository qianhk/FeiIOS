//
//  MasonryTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2017/5/16.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <ReactiveObjC/UIControl+RACSignalSupport.h>
#import <ReactiveObjC/RACSignal+Operations.h>
#import "MasonryTestViewController.h"

@interface MasonryTestViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *aboveMiddleView;

@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UIButton *changeButton2;

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
        _middleView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_middleView];
    }
    return _middleView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, 16, 16);
        _bottomView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIView *)aboveMiddleView {
    if (!_aboveMiddleView) {
        _aboveMiddleView = [[UIView alloc] init];
        _aboveMiddleView.frame = CGRectMake(0, 0, 0, 0);
        _aboveMiddleView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_aboveMiddleView];
    }
    return _aboveMiddleView;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [[UIButton alloc] init];
        _changeButton.frame = CGRectMake(0, 0, 16, 16);
        _changeButton.backgroundColor = [UIColor magentaColor];
        [_changeButton setTitle:@"Changed" forState:UIControlStateNormal];
        [self.view addSubview:_changeButton];
    }
    return _changeButton;
}

- (UIButton *)changeButton2 {
    if (!_changeButton2) {
        _changeButton2 = [[UIButton alloc] init];
        _changeButton2.frame = CGRectMake(0, 0, 16, 16);
        _changeButton2.backgroundColor = [UIColor magentaColor];
        [_changeButton2 setTitle:@"Changed2" forState:UIControlStateNormal];
        [self.view addSubview:_changeButton2];
    }
    return _changeButton2;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = YES;

//    CGFloat navigationBarHeight = 64.f;

//    CGRect oldFrame = self.view.frame;
//    CGRect rect = CGRectMake(0, navigationBarHeight, oldFrame.size.width, oldFrame.size.height - navigationBarHeight);
//    self.view.bounds = rect;

//    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.view.backgroundColor = [UIColor whiteColor];


    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
//        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];

    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-4.f);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
        make.centerX.equalTo(self.view);
    }];

    [self.aboveMiddleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset(32.f);
//        make.centerX.equalTo(self.view);
        make.leading.equalTo(self.middleView);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);

    }];

    [self.changeButton sizeToFit];
    [self.changeButton2 sizeToFit];

    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-100.f);
//        make.centerX.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(8);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
    }];

    [self.changeButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.changeButton.mas_bottom).offset(8);
    }];

    [[self.changeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self updateWithAnimation];
        [self.view setNeedsUpdateConstraints];
    }];

//    [[self.changeButton2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [self.view setNeedsUpdateConstraints];
//    }];
//    [self.view setNeedsUpdateConstraints];
}

- (void)updateWithAnimation {
    [UIView animateWithDuration:1.f animations:^{
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.topView.frame.size.width + 20);
        }];
        [self.view layoutIfNeeded];   // 这行不能少
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];

    if (_aboveMiddleView.frame.size.width > 0) {
        [self.aboveMiddleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_aboveMiddleView.frame.size.width + 2);
        }];

        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_bottomView.frame.size.width + 2);
        }];
    }
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
