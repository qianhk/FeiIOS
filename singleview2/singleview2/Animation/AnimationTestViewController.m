//
//  AnimationTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2018/5/28.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "AnimationTestViewController.h"
#import "UIView+Utils.h"

@interface AnimationTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivImage1;
@property (weak, nonatomic) IBOutlet UIImageView *ivImage2;
@property (weak, nonatomic) IBOutlet UILabel *tvResult;

@property (nonatomic, assign) NSInteger v1State;
@property (nonatomic, assign) NSInteger v2State;

@end

@implementation AnimationTestViewController

- (NSString *)stateToString:(NSInteger)state {
    NSString *stateStr = @"unknown";
    switch (state) {
        case 0:
            stateStr = @"Idle";
            break;

        case 1:
            stateStr = @"Playing";
            break;

        case 2:
            stateStr = @"Pause";
            break;
    }
    return stateStr;
}

- (void)updateViewState {
    _tvResult.text = [NSString stringWithFormat:@"v1=%@  v2=%@", [self stateToString:_v1State], [self stateToString:_v2State]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewState];
}

- (void)startupAnimation:(UIView *)sender {
    UIView *targetView;
    if (sender.tag == 1) {
        targetView = _ivImage1;
    } else {
        targetView = _ivImage2;
    }
    CGRect frame = targetView.frame;
    frame.origin.x = 0;
    targetView.frame = frame;

    [UIView animateWithDuration:8 animations:^{
        CGFloat containerWidth = self.view.bounds.size.width;
        CGRect frame2 = targetView.frame;
        frame2.origin.x = containerWidth - frame2.size.width;
        targetView.frame = frame2;
    }                completion:^(BOOL finished) {
        if (sender.tag == 1) {
            _v1State = 0;
        } else {
            _v2State = 0;
        }
        [self updateViewState];
    }];
}

- (IBAction)onBtn1Click:(UIView *)sender {
    if (_v1State == 0) {
        _v1State = 1;
        [self startupAnimation:sender];
    } else if (_v1State == 1) {
        _v1State = 2;
        [_ivImage1 pauseAnimation];
    } else if (_v1State == 2) {
        _v1State = 1;
        [_ivImage1 resumeAnimation];
    }
    [self updateViewState];
}

- (IBAction)onBtn2Click:(id)sender {
    if (_v2State == 0) {
        _v2State = 1;
        [self startupAnimation:sender];
    } else if (_v2State == 1) {
        _v2State = 2;
        [_ivImage2 pauseAnimation];
    } else if (_v2State == 2) {
        _v2State = 1;
        [_ivImage2 resumeAnimation];
    }
    [self updateViewState];
}

@end
