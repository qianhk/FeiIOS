//
//  CAAnimationViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/12/16.
//  Copyright © 2018 Njnu. All rights reserved.
//

#import "CAAnimationViewController.h"

@interface CAAnimationViewController ()

@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation CAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(50, 150)];
    [bezierPath addCurveToPoint:CGPointMake(350, 600) controlPoint1:CGPointMake(500, 300) controlPoint2:CGPointMake(-200, 450)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 102, 36);
    shipLayer.position = CGPointMake(100, 550);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"airplane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;
    
//    [self movePositon:bezierPath];
//    [self performSelector:@selector(movePositon:) withObject:bezierPath afterDelay:1.0];
    [self performSelector:@selector(rotation) withObject:nil afterDelay:1.0];
    
}

- (void)rotation {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 2.0;
//    animation.keyPath = @"transform";
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation.keyPath = @"transform.rotation";
    animation.byValue = @(M_PI * 2);
    [_shipLayer addAnimation:animation forKey:nil];
}

- (void)movePositon:(UIBezierPath *)path {
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [_shipLayer addAnimation:animation forKey:nil];
}

@end
