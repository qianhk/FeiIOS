//
//  UikitTestViewController.m
//  singleview2
//
//  Created by 钱红凯 on 17/4/26.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <ReactiveObjC/RACSignal.h>
#import <ReactiveObjC/RACSubscriber.h>
#import <ReactiveObjC/RACDisposable.h>
#import <ReactiveObjC/RACSubject.h>
#import <ReactiveObjC/RACReplaySubject.h>
#import "UikitTestViewController.h"
#import "NSObject+Calculator.h"
#import "CalculatorMaker.h"
#import "Calculator.h"

@interface UikitTestViewController ()

@end

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation UikitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
//    [self addMask];
    [self addMask2];

    CGRect rect = CGRectMake(10, 20, 100, 200);
    NSLog(@"CGRectGetHeight--%f", CGRectGetHeight(rect));
    NSLog(@"CGRectGetMaxX--%f", CGRectGetMaxX(rect));
    NSLog(@"CGRectGetMaxY--%f", CGRectGetMaxY(rect));
    NSLog(@"CGRectGetMidX--%f", CGRectGetMidX(rect));
    NSLog(@"CGRectGetMidY--%f", CGRectGetMidY(rect));
    NSLog(@"CGRectGetMinX--%f", CGRectGetMinX(rect));
    NSLog(@"CGRectGetMinY--%f", CGRectGetMinY(rect));

    int result1 = [NSObject makeCalculator:^(CalculatorMaker *make) {
        make.add(1).add(2).add(3).add(4).divide(5);
    }];
    NSLog(@"chained makeCalculator result=%d", result1);


    Calculator *c = [Calculator new];
    c.result = 3;
    [[c calculator:^int(int result) {
        result += 2;
        result *= 5;
        return result;
    }] equal:^BOOL(int result) {
        return result == 10;
    }];
    NSLog(@"functional calculator result=%d equal=%@", c.result, c.isEqual ? @"YES" : @"NO");

    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@66];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];





    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];

    // 3.发送信号
    [subject sendNext:@"1"];



    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];

    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];

    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {

        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];

    // 订阅信号
    [replaySubject subscribeNext:^(id x) {

        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

static int TOP = 64;

- (void)addMask {
    UIButton *_maskButton = [[UIButton alloc] init];
    [_maskButton setFrame:CGRectMake(0, TOP, SCREEN_WIDTH, 81)];
//    [_maskButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [_maskButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_maskButton];

    //create path
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIBezierPath *path = [UIBezierPath bezierPath];

//    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, TOP, SCREEN_WIDTH, 73)]];
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH / 2, TOP + 140) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];

//    // MARK: roundRectanglePath
//    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 400, SCREEN_WIDTH - 2 * 20, 100) cornerRadius:15] bezierPathByReversingPath]];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.path = path.CGPath;

    [_maskButton.layer setMask:shapeLayer];
}

- (void)addMask2 {

    UIImageView *maskView = [[UIImageView alloc] init];
    [maskView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 81)];
    [maskView setImage:[UIImage imageNamed:@"circle_mask"]];
//    [self.view addSubview:maskView];

    UIImageView *button = [[UIImageView alloc] init];
    [button setFrame:CGRectMake(0, TOP, SCREEN_WIDTH, 81)];
    //    [button setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    button.backgroundColor = [UIColor blueColor];
//    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];


    button.layer.mask = maskView.layer;


    UIButton *button2 = [[UIButton alloc] init];
    [button2 setFrame:CGRectMake(0, TOP + 200, SCREEN_WIDTH, 81)];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button2];

    UIImageView *maskView2 = [[UIImageView alloc] init];
    [maskView2 setFrame:CGRectMake(0, TOP + 300, SCREEN_WIDTH, 81)];
    [maskView2 setImage:[UIImage imageNamed:@"circle_mask"]];
    [self.view addSubview:maskView2];

    UIButton *button3 = [[UIButton alloc] init];
    [button3 setFrame:CGRectMake(0, TOP + 400, SCREEN_WIDTH, 81)];
    [button3 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button3];

    UIImageView *maskView3 = [[UIImageView alloc] init];
    [maskView3 setFrame:CGRectMake(0, TOP + 400, SCREEN_WIDTH, 81)];
    [maskView3 setImage:[UIImage imageNamed:@"circle_mask"]];
    [self.view addSubview:maskView3];


//    UIImageView * maskView3 = [[UIImageView alloc] init];
//    [maskView3 setFrame:CGRectMake(0, TOP + 400, SCREEN_WIDTH, 8)];
//    [maskView3 setImage:[UIImage imageNamed:@"bottom_mask"]];
//    [self.view addSubview:maskView3];



//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    CGRect maskRect = CGRectMake(20, 10, 50, 20);
//    CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
//    maskLayer.path = path;
//    CGPathRelease(path);
//    button.layer.mask = maskLayer;
}

@end
