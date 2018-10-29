//
//  FireView.m
//  singleview2
//
//  Created by 钱红凯 on 2018/10/29.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "FireView.h"

@interface FireView ()
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;
@end

@implementation FireView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
    explosionCell.alphaSpeed = -1.0;
    //粒子的生命周期
    explosionCell.lifetime = 1.0;
    //粒子生命周期的范围
    explosionCell.lifetimeRange = 0.3;
    //粒子每秒产生的数目
    explosionCell.birthRate = 2500;
    //粒子的速度
    explosionCell.velocity = 40.00;
    //粒子的速度范围
    explosionCell.velocityRange = 10.00;
    //粒子的缩放比例
    explosionCell.scale = 0.1;
    //缩放比例范围
    explosionCell.scaleRange = 0.02;
    //发射范围（设置后是散状，不设置会从中间一个圆圈出去）
    //    explosionCell.emissionRange = M_PI*2;
    //粒子要展示的图片（会展示图片颜色的粒子）
    explosionCell.contents = (__bridge id _Nullable) ([UIImage imageNamed:@"icon_xin"].CGImage);
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
        _explosionLayer.emitterSize = CGSizeMake(10, 0);
        //渲染模式
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.birthRate = 0;
        //发射位置
        _explosionLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);

        _explosionLayer.zPosition = -1;
    }
    return _explosionLayer;
}

- (void)startAnimation {
    self.explosionLayer.beginTime = CACurrentMediaTime();
    self.explosionLayer.birthRate = 1;

    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void)stopAnimation {
    self.explosionLayer.birthRate = 0;
}

@end
