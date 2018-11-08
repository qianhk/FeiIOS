//
//  FireView.m
//  singleview2
//
//  Created by qianhk on 2018/10/29.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "FireView.h"

@interface FireView ()
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;
@end

@implementation FireView

// 普通自定义view，如果new init 或者initWithFrame均走到initWithFrame里
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
//        [self setupExplosion];
    }
    return self;
}

//如果从xib nib加载则走到initWithCoder里，不会走到init里
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self setupExplosion];
}

- (void)setupExplosion {
    CAEmitterCell *explosionCell = [[CAEmitterCell alloc] init];
    //设置粒子颜色alpha能改变的范围
    explosionCell.alphaRange = 0.10;
    //粒子alpha的改变速度
    explosionCell.alphaSpeed = -0.2;
    //粒子的生命周期
    explosionCell.lifetime = 1.5;
    //粒子生命周期的范围
    explosionCell.lifetimeRange = 0.3;
    //粒子每秒产生的数目
    explosionCell.birthRate = 1000;
    //粒子的速度
    explosionCell.velocity = 40.00;
    //粒子的速度范围
    explosionCell.velocityRange = 10.00;
    //粒子的缩放比例
    explosionCell.scale = 0.2;
    //缩放比例范围
    explosionCell.scaleRange = 0.02;
    //发射范围（设置后是散状，不设置会从中间一个圆圈出去）
    //    explosionCell.emissionRange = M_PI*2;
    //粒子要展示的图片（会展示图片颜色的粒子）
    explosionCell.contents = (__bridge id _Nullable) ([UIImage imageNamed:@"white"].CGImage);

    explosionCell.redRange = 1.;
    explosionCell.blueRange = 1.;
    explosionCell.greenRange = 1.;
    
    explosionCell.redSpeed = 0.2;
    explosionCell.blueSpeed = 0.2;
    explosionCell.greenSpeed = 0.2;

    //发射源包含的粒子
    self.explosionLayer.emitterCells = @[explosionCell];
    [self.layer addSublayer:self.explosionLayer];
}

- (CAEmitterLayer *)explosionLayer {
    if (_explosionLayer == nil) {
        _explosionLayer = [[CAEmitterLayer alloc] init];
        //发射的形状
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        //发射模式
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;
        //发射源大小
        _explosionLayer.emitterSize = CGSizeMake(self.frame.size.width / 2, 0);
        //渲染模式
        _explosionLayer.renderMode = kCAEmitterLayerUnordered;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.birthRate = 0;
        //发射位置
        _explosionLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);

        _explosionLayer.zPosition = -1;
    }
    return _explosionLayer;
}

- (void)startAnimation {
    CGFloat animationDuration = 2.f;
//    _explosionLayer.emitterSize = CGSizeMake(self.frame.size.width * 0.8, 0);
    self.explosionLayer.beginTime = CACurrentMediaTime();
    self.explosionLayer.birthRate = 1;

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"emitterSize";
    NSValue *endValue = [NSValue valueWithCGSize:CGSizeMake(self.frame.size.width * 0.1f, 0)];
    animation.values = @[[NSValue valueWithCGSize:CGSizeMake(self.frame.size.width * 0.8f, 0)], endValue, endValue];
    animation.duration = animationDuration;
//    animation.calculationMode = kCAAnimationCubic;
    [_explosionLayer addAnimation:animation forKey:nil];

//    [self performSelector:@selector(changeProperty) withObject:nil afterDelay:animationDuration];
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:animationDuration];
}

- (void)changeProperty {
    _explosionLayer.emitterSize = CGSizeMake(self.frame.size.width / 4, 0);
}

- (void)stopAnimation {
    self.explosionLayer.birthRate = 0;
    [_explosionLayer removeAllAnimations];
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    } else {
        return view;
    }
}


@end
