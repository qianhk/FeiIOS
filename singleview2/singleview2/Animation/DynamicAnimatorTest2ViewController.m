//
// Created by kai on 2019-01-31.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import "DynamicAnimatorTest2ViewController.h"

@interface DynamicAnimatorTest2ViewController () {
    UIDynamicAnimator *_animator;
    UIView *_roundV;
    UISnapBehavior *_snapBehavior;
}

@end

@implementation DynamicAnimatorTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat WIDTH = 20;

    UIView *roundV = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 2, 0, 40, 40)];

    [self.view addSubview:roundV];
    _roundV = roundV;

    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 40, 0, 30, 30)];
    [self.view addSubview:subView];
    subView.backgroundColor = [UIColor greenColor];
    subView.layer.cornerRadius = 15.0f;
    roundV.backgroundColor = [UIColor redColor];
    roundV.layer.cornerRadius = 20;
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //一定要生成实例变量或者属性，否则不会访问setter方法，使视图无法实现动力效果
    _animator = animator;
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];

    // Do any additional setup after loading the view.
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
//获取手势的位置坐标
    CGPoint local = [pan locationInView:self.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:_roundV snapToPoint:local];
        //阻尼系数
        _snapBehavior.damping = 0.7;
        [_animator addBehavior:_snapBehavior];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        _snapBehavior.snapPoint = local;
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_snapBehavior];
    }
}

@end
