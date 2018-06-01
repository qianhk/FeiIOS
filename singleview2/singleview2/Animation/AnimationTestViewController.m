//
//  AnimationTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2018/5/28.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "AnimationTestViewController.h"
#import "UIView+Utils.h"
#import "AnimationLabel.h"

@interface AnimationTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivImage1;
@property (weak, nonatomic) IBOutlet UIImageView *ivImage2;
@property (weak, nonatomic) IBOutlet UILabel *tvResult;
@property (weak, nonatomic) IBOutlet AnimationLabel *animationLabel;

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
    
//    int abc = 0;
//    NSLog(@"lookKai gu yi error: %d", 100 / 0);
//    [self performSelector:@selector(abcdefg) withObject:nil];

    self.animationLabel.text = @"测试Test文字Text";
}

- (void)startupAnimation1:(UIView *)sender {
    CGRect frame = _ivImage1.frame;
    frame.origin.x = 0;
    _ivImage1.frame = frame;

    [UIView animateWithDuration:6 animations:^{
        CGFloat containerWidth = self.view.bounds.size.width;
        CGRect frame2 = _ivImage1.frame;
        frame2.origin.x = containerWidth - frame2.size.width;
        _ivImage1.frame = frame2;
    } completion:^(BOOL finished) {
            _v1State = 0;
        [self updateViewState];
    }];
}

- (IBAction)onBtn1Click:(UIView *)sender {
    if (_v1State == 0) {
        _v1State = 1;
        [self startupAnimation1:sender];
    } else if (_v1State == 1) {
        _v1State = 2;
        [_ivImage1 pauseAnimation];
    } else if (_v1State == 2) {
        _v1State = 1;
        [_ivImage1 resumeAnimation];
    }
    [self updateViewState];
}

- (void)startupAnimation2:(UIView *)sender {
//    CGRect frame = _ivImage2.frame;
//    frame.origin.x = 0;
//    _ivImage2.frame = frame;
    
    static CGFloat _angle = 0;
    _angle += 120;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:6 animations:^{
//        CGFloat containerWidth = self.view.bounds.size.width;
//        CGRect frame2 = _ivImage2.frame;
//        frame2.origin.x = containerWidth - frame2.size.width;
//        _ivImage2.frame = frame2;
        _ivImage2.transform = endAngle;
//        _ivImage2.window.transform = endAngle;
//        _ivImage2.window.frame = frame2;
    } completion:^(BOOL finished) {
        _v2State = 0;
        [self updateViewState];
    }];
}

- (IBAction)onBtn2Click:(id)sender {
    if (_v2State == 0) {
        _v2State = 1;
        [self startupAnimation2:sender];
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
