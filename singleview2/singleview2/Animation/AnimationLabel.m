//
// Created by kai on 2018/6/1.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "AnimationLabel.h"

@interface AnimationLabel ()

@property (nonatomic, strong) UILabel *forelLabel;
@property (nonatomic, strong) UILabel *backLabel;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *rightLayer;

@end

@implementation AnimationLabel

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        UIFont *font = [UIFont systemFontOfSize:25];
        self.backLabel = [[UILabel alloc] init];
        self.backLabel.textAlignment = NSTextAlignmentCenter;
        self.backLabel.textColor = [UIColor redColor];
        [self addSubview:self.backLabel];
        self.backLabel.font = font;
        
        self.forelLabel = [[UILabel alloc] init];
        self.forelLabel.textAlignment = NSTextAlignmentCenter;
        self.forelLabel.font = font;
        [self addSubview:self.forelLabel];
        self.forelLabel.textColor = [UIColor blueColor];
        
        self.leftLayer = [CALayer layer];
        self.leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
//
        self.rightLayer = [CALayer layer];
        self.rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
        
        [self.maskLayer addSublayer:self.leftLayer];
        [self.maskLayer addSublayer:self.rightLayer];
//
        self.forelLabel.layer.mask = self.maskLayer;
    }

    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        UIFont *font = [UIFont systemFontOfSize:25];
//        self.backLabel = [[UILabel alloc] initWithFrame:self.bounds];
//        self.backLabel.textAlignment = NSTextAlignmentCenter;
//        self.backLabel.textColor = [UIColor redColor];
//        [self addSubview:self.backLabel];
//        self.backLabel.font = font;
//
//        self.forelLabel = [[UILabel alloc] initWithFrame:self.bounds];
//        self.forelLabel.textAlignment = NSTextAlignmentCenter;
//        self.forelLabel.font = font;
//        [self addSubview:self.forelLabel];
//        self.forelLabel.textColor = [UIColor orangeColor];
//
//        self.leftLayer = [CALayer layer];
//        self.leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width * 0.5, frame.size.height);
//        self.leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
//
//        self.rightLayer = [CALayer layer];
//        self.rightLayer.frame = CGRectMake(frame.size.width * 0.5, 0, self.bounds.size.width * 0.5, frame.size.height);;
//        self.rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
//
//        [self.maskLayer addSublayer:self.leftLayer];
//        [self.maskLayer addSublayer:self.rightLayer];
//
//        self.forelLabel.layer.mask = self.maskLayer;
//
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.bounds;
    self.backLabel.frame = rect;
    self.forelLabel.frame = rect;
    self.leftLayer.frame = CGRectMake(0, 0, rect.size.width * 0.5, rect.size.height);
    self.rightLayer.frame = CGRectMake(rect.size.width * 0.5, 0, rect.size.width * 0.5, rect.size.height);;
}


- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.frame = self.bounds;
    }
    return _maskLayer;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.forelLabel.text = text;
    self.backLabel.text = text;
    [self fadeString:(self.bounds.size.width)];
}


- (void)fadeString:(CGFloat)toValue {
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(-self.frame.size.width * 0.5);
    basicAnimation.duration = 2;
    basicAnimation.repeatCount = HUGE;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [self.leftLayer addAnimation:basicAnimation forKey:nil];

    CABasicAnimation *basicAnimation2 = [CABasicAnimation animation];
    basicAnimation2.keyPath = @"transform.translation.x";
    basicAnimation2.fromValue = @(0);
    basicAnimation2.toValue = @(self.frame.size.width * 0.5);
    basicAnimation2.duration = 2;
    basicAnimation2.repeatCount = HUGE;
    basicAnimation2.removedOnCompletion = NO;
    basicAnimation2.fillMode = kCAFillModeForwards;
    [self.rightLayer addAnimation:basicAnimation2 forKey:nil];

}

@end
