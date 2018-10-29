//
//  EmitterTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2018/10/29.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "FireView.h"
#import "EmitterTestViewController.h"

#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

@interface EmitterTestViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) UIView *emitterView;
@property (nonatomic, strong) FireView *fireView;

@end

@implementation EmitterTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSky];
    [self initEmitterLayer];
    [self initView];
}

- (void)initView {
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    clickButton.backgroundColor = [UIColor blueColor];
    [clickButton setTitle:@"暂停" forState:UIControlStateNormal];
    [clickButton setTitle:@"开始" forState:UIControlStateSelected];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];

    UIButton *fireButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 20, 100, 40)];
    fireButton.backgroundColor = [UIColor blueColor];
    [fireButton setTitle:@"烟花" forState:UIControlStateNormal];
    [fireButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fireButton addTarget:self action:@selector(fireAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fireButton];

    _fireView = [[FireView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _fireView.center = self.view.center;
    [self.view addSubview:_fireView];
}

#pragma mark - 天空的颜色

- (void)initSky {
    //天空渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];

    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];

    UIColor *whiteColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    gradientLayer.colors = @[(__bridge id) lightColor.CGColor, (__bridge id) whiteColor.CGColor];
    //45度变色(由lightColor－>white)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);

}


//粒子发射器
- (void)initEmitterLayer {

    _emitterView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH - 100)];
    _emitterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_emitterView];


    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    cell.contents = (__bridge id _Nullable) ([UIImage imageNamed:@"white"].CGImage);

    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
    cell.birthRate = 2000;
    //每个粒子存活时长
    cell.lifetime = 5.0;
    //粒子生命周期范围
    cell.lifetimeRange = 0.3;
    //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.2;
    cell.alphaRange = 0.5;
    //粒子的速度
    cell.velocity = 40;
    //粒子的速度范围
    cell.velocityRange = 20;
    //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
    //        cell.emissionRange = M_PI*2;
    //粒子内容的颜色
    //    cell.color = [[UIColor whiteColor] CGColor];

    cell.redRange = 0.5;
    cell.blueRange = 0.5;
    cell.greenRange = 0.5;

    //缩放比例
    cell.scale = 0.2;
    //缩放比例范围
    cell.scaleRange = 0.02;

    //粒子的初始发射方向
    cell.emissionLongitude = M_PI;
    //Y方向的加速度
    cell.yAcceleration = 70.0;
    //X方向加速度
    //    cell.xAcceleration = 20.0;

    _emitterLayer = [CAEmitterLayer layer];

    //发射位置
    _emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH / 2.0, 0);
    //粒子产生系数，默认为1
    _emitterLayer.birthRate = 1;
    //发射器的尺寸
    _emitterLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, 0);
    //发射的形状
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;
    //发射的模式
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;

    _emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    [self.emitterView.layer addSublayer:_emitterLayer];
}

- (void)startAnimation {
    //    self.emitterLayer.beginTime = CACurrentMediaTime();
    self.emitterLayer.birthRate = 1;
    //    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void)stopAnimation {
    self.emitterLayer.birthRate = 0;
}

//下雪
- (void)buttonAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (!btn.selected) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }

}

//烟花
- (void)fireAction {
    [_fireView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
