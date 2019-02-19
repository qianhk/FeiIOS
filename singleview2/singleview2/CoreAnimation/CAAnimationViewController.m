//
//  CAAnimationViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/12/16.
//  Copyright © 2018 Njnu. All rights reserved.
//

#import "CAAnimationViewController.h"
#import "ArtistData.h"
#import <objc/runtime.h>

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
    shipLayer.contents = (__bridge id) [UIImage imageNamed:@"airplane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;

//    [self performSelector:@selector(movePositon:) withObject:bezierPath afterDelay:1.0];
//    [self performSelector:@selector(rotation) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(changeToNextImage) withObject:bezierPath afterDelay:1.0];

    //https://blog.csdn.net/Hello_Hwc/article/details/49687543

    Class class = [Artist class];//类对象
    Class metaClass = object_getClass(class);//类元对象
    Class metaOfMetaClass = object_getClass(metaClass);//NSObject类元对象
    Class rootMataClass = object_getClass(metaOfMetaClass);//NSObject类元对象的类元对象

    NSLog(@"CustomObject类对象是:%p %@", class, NSStringFromClass(class));
    NSLog(@"CustomObject类元对象是:%p %@", metaClass, NSStringFromClass(metaClass));
    NSLog(@"CustomObject类元对象的父对象是:%p", class_getSuperclass(metaClass));
    NSLog(@"metaClass类元对象:%p %@", metaOfMetaClass, NSStringFromClass(metaOfMetaClass));
    NSLog(@"metaClass类元对象的父对象是:%p", class_getSuperclass(metaOfMetaClass));
    NSLog(@"metaOfMetaClass的类元对象的是:%p %@", rootMataClass, NSStringFromClass(rootMataClass));

    Class objClass = [NSObject class];
    NSLog(@"NSObject类元对象%p %@", object_getClass(objClass), NSStringFromClass(objClass));

    NSLog(@" ---------");

    Class clazz = [Artist class];//类对象
    Class superClass = class_getSuperclass(clazz);//基类对象NSObject
    Class superOfNSObject = class_getSuperclass(superClass);//NSObject类元对象

    NSLog(@"CustomObject类对象是:%p %@", clazz, NSStringFromClass(clazz));
    NSLog(@"CustomObject类superClass是:%p %@", superClass, NSStringFromClass(superClass));
    NSLog(@"CustomObject类superClass的类元对象是:%p", object_getClass(superClass));
    NSLog(@"NSObject的superClass是:%p %@", superOfNSObject, NSStringFromClass(superOfNSObject));

    NSLog(@" ---------");

    id a = [NSMutableArray alloc];
    id b = [a init];
    NSLog(@"NSMutableArray %p %p", a, b); //NSMutableArray 0x283540050 0x28391e8e0

    a = [NSArray alloc];
    b = [a init];
    NSLog(@"NSArray %p %p", a, b); //NSArray 0x283540060 0x283540080
    
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

- (void)changeToNextImage {
    CATransition *transition = [CATransition animation];
    transition.duration = 2.0;

    transition.type = kCATransitionFade;

//    transition.type = kCATransitionMoveIn;
//    transition.startProgress = 0.0;
//    transition.endProgress = 1.0;
//    transition.subtype = kCATransitionFromRight;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [self.shipLayer addAnimation:transition forKey:@"ToNext"];
    self.shipLayer.contents = (__bridge id) [UIImage imageNamed:@"desk"].CGImage;
//    self.imageview.image = nextImage;
}

@end
