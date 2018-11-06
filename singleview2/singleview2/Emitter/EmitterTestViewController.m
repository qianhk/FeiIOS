//
//  EmitterTestViewController.m
//  singleview2
//
//  Created by qianhk on 2018/10/29.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "FireView.h"
#import "EmitterTestViewController.h"
#import "AppGlobalUI.h"

@interface EmitterTestViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@property (nonatomic, strong) UIView *emitterView;
@property (nonatomic, strong) FireView *fireView;

@property (nonatomic, strong) NSString *imageName;

@property(nonatomic, strong) UIImageView *testImageView;
@property(nonatomic, strong) UIImageView *testImageView2;

@end

@implementation EmitterTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = @"cake";

    [self initSky];
    [self initEmitterLayer];
    [self initView];

    [self reLayoutView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doRotateAction:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    UIImage *tmpImage = [UIImage imageNamed:@"car2"]; //24 @2 3
    UIImage *cakeImage = [UIImage imageNamed:@"cake"]; //120 @1
    self.testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, 200, 200)];
    self.testImageView.contentMode = UIViewContentModeCenter;
    self.testImageView.backgroundColor = [UIColor lightGrayColor];
    self.testImageView.image = tmpImage;
    [self.view addSubview:self.testImageView];
    
    UIImage *tmpImage2 = [UIImage imageWithCGImage:cakeImage.CGImage scale:2.0f orientation:UIImageOrientationUp];
    self.testImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, 200, 200)];
    self.testImageView2.contentMode = UIViewContentModeCenter;
    self.testImageView2.backgroundColor = [UIColor lightGrayColor];
    self.testImageView2.image = tmpImage2;
    [self.view addSubview:self.testImageView2];
}

- (void)initView {
    
    _fireView = [[FireView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    _fireView.center = self.view.center;
    _fireView.tag = 300;
    [self.view addSubview:_fireView];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(10, kTopHeight + 20, 100, 40)];
    clickButton.backgroundColor = [UIColor blueColor];
    [clickButton setTitle:@"暂停" forState:UIControlStateNormal];
    [clickButton setTitle:@"开始" forState:UIControlStateSelected];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];

    UIButton *fireButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 110, kTopHeight + 20, 100, 40)];
    fireButton.backgroundColor = [UIColor blueColor];
    [fireButton setTitle:@"烟花" forState:UIControlStateNormal];
    [fireButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fireButton addTarget:self action:@selector(fireAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fireButton];

//    clickButton.hidden = YES;
//    fireButton.hidden = YES;

}

#pragma mark - 天空的颜色

- (void)initSky {
    //天空渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    CGRect bounds = self.view.bounds;
    bounds.origin.y = kTopHeight;
    bounds.size.height -= kTopHeight;
    gradientLayer.frame = bounds;
    [self.view.layer addSublayer:gradientLayer];
    self.view.tag = 100;
    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];

    UIColor *whiteColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    gradientLayer.colors = @[(__bridge id) lightColor.CGColor, (__bridge id) whiteColor.CGColor];
    //45度变色(由lightColor－>white)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

//粒子发射器
- (void)initEmitterLayer {

    _emitterView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight - 100)];
    _emitterView.backgroundColor = [UIColor clearColor];
    _emitterView.clipsToBounds = YES;
    _emitterView.tag = 200;
    [self.view addSubview:_emitterView];


    CAEmitterCell *cell = [self getCell:self.imageName];

//X方向加速度
    //    cell.xAcceleration = 20.0;

    _emitterLayer = [CAEmitterLayer layer];

    //粒子产生系数，默认为1
    _emitterLayer.birthRate = 1;
    //发射的形状
    _emitterLayer.emitterShape = kCAEmitterLayerLine;
    //发射的模式
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;

    _emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    [self.emitterView.layer addSublayer:_emitterLayer];
}

- (CAEmitterCell *)getCell:(NSString *)imageName {
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    UIImage *image = [UIImage imageNamed:self.imageName];
    cell.contents = (__bridge id _Nullable) (image.CGImage);
    cell.contentsScale = 2;
    cell.scale = 0.6;
    cell.scaleRange = 0.4;

//    cell.contents = (__bridge id _Nullable) ([UIImage imageNamed:@"white"].CGImage);
//    cell.scale = 0.5;
//    cell.scaleRange = 0.1;

    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
    cell.birthRate = 5;
    //每个粒子存活时长
    cell.lifetime = 4.0;
    //粒子生命周期范围
//    cell.lifetimeRange = 0.5;
//粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.3;
    cell.alphaRange = 0.3;

    //粒子的速度
    cell.velocity = 260;
    //粒子的速度范围
    cell.velocityRange = 20;
    //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
//    cell.emissionRange = M_PI*2;
//粒子内容的颜色
//    cell.color = [[UIColor whiteColor] CGColor];

//    cell.redRange = 0.5;
//    cell.blueRange = 0.5;
//    cell.greenRange = 0.5;

    cell.spin = 0;
    cell.spinRange = M_PI / 8;

    //粒子的初始发射方向
    cell.emissionLongitude = M_PI;
    cell.emissionRange = M_PI_4 / 4;
    //Y方向的加速度
    cell.yAcceleration = 70.0;
    return cell;
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
- (void)fireAction:(UIButton *)btn {
    [_fireView startAnimation];
    if ([@"cake" isEqualToString:self.imageName]) {
        self.imageName = @"heart";
    } else {
        self.imageName = @"cake";
    }
    CAEmitterCell *cell = [self getCell:self.imageName];
    _emitterLayer.emitterCells = @[cell];
}

- (void)doRotateAction:(NSNotification *)notification {
    [self reLayoutView];
}

- (void)reLayoutView {
    CGRect bounds = self.view.bounds;
    BOOL portraitMode = [AppGlobalUI isInPortrait];
    [self.navigationController setNavigationBarHidden:!portraitMode animated:NO];
    CGFloat width = bounds.size.width;
    CGFloat topOffset = kTopHeight;
    NSArray<CALayer *> *sublayers = self.view.layer.sublayers;
    CAGradientLayer *gradientLayer = nil;
    for (int idx = sublayers.count - 1; idx >= 0; --idx) {
        if ([sublayers[idx] isKindOfClass:CAGradientLayer.class]) {
            gradientLayer = (CAGradientLayer *) sublayers[idx];
            break;
        }
    }
    if (portraitMode) {
        bounds.origin.y = kTopHeight;
        bounds.size.height -= kTopHeight;
        gradientLayer.frame = bounds;
        _emitterView.frame = CGRectMake(0, 100, bounds.size.width, kScreenHeight - 100);

    } else {
        gradientLayer.frame = bounds;
        _emitterView.frame = bounds;
    }
    _emitterLayer.emitterPosition = CGPointMake(bounds.size.width / 2.0, -150);
    _emitterLayer.emitterSize = CGSizeMake(bounds.size.width * 0.7, 0);
    _fireView.center = self.view.center;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (id)init {
    self = [super init];
    if (self) {
        CGRect bounds = self.view.bounds;
        bounds = CGRectZero;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"lookKai dealloc %@", NSStringFromClass([self class]));
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
