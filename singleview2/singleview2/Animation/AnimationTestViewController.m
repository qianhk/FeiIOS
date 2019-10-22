//
//  AnimationTestViewController.m
//  singleview2
//
//  Created by qianhk on 2018/5/28.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "AnimationTestViewController.h"
#import "UIView+Utils.h"
#import "AnimationLabel.h"
#import "PostData.h"

@interface AnimationTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivImage1;
@property (weak, nonatomic) IBOutlet UIImageView *ivImage2;
@property (weak, nonatomic) IBOutlet UILabel *tvResult;
@property (weak, nonatomic) IBOutlet AnimationLabel *animationLabel;

@property (nonatomic, strong) Comment *testObjectComment;

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
    NSString *resultText = [NSString stringWithFormat:@"Label 123 v1=%@  v2=%@", [self stateToString:_v1State], [self stateToString:_v2State]];
    
    NSDictionary *attrDic;
    
    attrDic = @{NSKernAttributeName: @(2),
                NSStrokeColorAttributeName: [UIColor redColor],
                NSFontAttributeName: _tvResult.font,
//                NSExpansionAttributeName: @(1.2f),
                NSStrokeWidthAttributeName: @(8),
                NSForegroundColorAttributeName: [UIColor greenColor]
                };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:resultText attributes:attrDic];
//    _tvResult.text = nil;
    _tvResult.attributedText = attributeStr;
    [_tvResult sizeToFit];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    int abc = 0;
//    NSLog(@"lookKai gu yi error: %d", 100 / 0);
//    [self performSelector:@selector(abcdefg) withObject:nil];

    self.animationLabel.text = @"测试Test文字Text";
    
    _ivImage2.alpha = 0.2f;

    if(([[[UIDevice currentDevice] systemVersion] compare:@"8.2" options:NSNumericSearch] == NSOrderedAscending)) {
        _tvResult.font = [UIFont systemFontOfSize:18];
    } else {
        _tvResult.font = [UIFont systemFontOfSize:18 weight:UIFontWeightHeavy];
    }

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    self.view.layer.mask = maskLayer;
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect selfBounds = CGRectMake(0, 0, 800, 800);
    CGRect cropRect = CGRectMake(40, 90, 100, 50);
    CGPathAddRect(path, nil, selfBounds);
    CGPathAddRect(path, nil, cropRect);
    CGPoint p[6] = {{220, 90}, {170, 130}, {160, 170}, {220, 210}, {270, 170}, {280, 130}};
    CGPathAddLines(path, nil, p, sizeof(p) / sizeof(p[0]));
    [maskLayer setPath:path];
    [maskLayer setFillRule:kCAFillRuleEvenOdd];
    [maskLayer setFillColor:[[UIColor orangeColor] CGColor]];
    
    [self updateViewState];
    
    CGRect testRect = CGRectMake(1, 2, 100, 101);
    NSValue *value = [NSValue valueWithCGRect:testRect];
    NSDictionary *dic = @{@"rect": value};
    NSDictionary *dic2 = @{@"rectArray": @[value, value]};
    NSLog(@"dic=%@\ndic2=%@", dic, dic2);
    
    NSArray * arr = dic2[@"rectArray"];
    for (NSValue *val in arr) {
        CGRect rect = val.CGRectValue;
        NSLog(@"val=%@ rect=%@", val, NSStringFromCGRect(rect));
    }
    
    NSDate *date = [NSDate date];
    NSTimeZone *sys_zone = [NSTimeZone systemTimeZone];
    NSTimeZone *local_zone = [NSTimeZone localTimeZone];
    NSTimeZone *default_zone = [NSTimeZone defaultTimeZone];
    NSArray *names = [NSTimeZone knownTimeZoneNames];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:timeZone];
    
    NSLog(@"date=%@, sys_zone=%@, local=%@, default=%@ zoneName=%@ utc=%@", date, sys_zone, local_zone, default_zone, sys_zone.name, [dateFormatter stringFromDate:date]);

    self.testObjectComment = [Comment new];
    
    int* array = malloc(sizeof(int) * 10);
//    for (int index = 0; index < 20; index ++) {
//        array[index] = index;
//    }
    
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSDictionary<NSString *, NSString *> *environment = [processInfo environment];
    NSArray<NSString *> *arguments = [processInfo arguments];
    NSLog(@"lookKai env=%@ arg=%@", environment, arguments);
    
    _tvResult.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"testXcodeArgument"];
    [[NSUserDefaults standardUserDefaults] setObject:@"modifyValue" forKey:@"testXcodeArgument"];
     _tvResult.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"testXcodeArgument"];
    NSString  *testEnvObj = environment[@"kaikaiTestEnvBool"];
    NSString *testEnv = environment[@"kaikaiTestEnv"];
    if (testEnv) {
        self.animationLabel.text = testEnv;
    }

    CFTimeInterval begin = CACurrentMediaTime();
    int n = 1000;
    NSMutableDictionary *tmpDic = [NSMutableDictionary new];
    for (int i = 0; i < n; i ++) {
        for (int j = 0; j < n; j ++) {
            [tmpDic setObject:@(j) forKey:@(i)];
        }
    }

    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"lookKai end - begin=%.8f", end - begin); //mbp i7 0.06453155s

    NSTimeInterval data1 = 8.;
    CGFloat data2 = data1;
    CGFloat data3 = 0;
    CGFloat minus = data2 - data3;
    NSLog(@"lookKai minus = %.2f", minus);
    
    /*Printing description of mutableDic:
     {
     "key_1" = 1;
     "key_2" = 2;
     }*/
    NSMutableDictionary *mutableDic = [NSMutableDictionary new];
    [mutableDic setValue:@1 forKey:@"key_1"];
    [mutableDic setValue:nil forKey:@"key_nil"];
    [mutableDic setValue:@"2" forKey:@"key_2"];
//    NSLog(mutableDic);
    
    UIScreen *screen = [UIScreen mainScreen];
    id <UICoordinateSpace> space = screen.coordinateSpace;
    id <UICoordinateSpace> fixedSpace = screen.fixedCoordinateSpace;
    UIScreenMode  *perferedMode = screen.preferredMode;
    NSLog(@"lookKai space=%@ fixSpace=%@ bounds=%@ nativeBounds=%@ scale=%.2f nativeScale=%.2f", NSStringFromCGRect(space.bounds), NSStringFromCGRect(fixedSpace.bounds)
          , NSStringFromCGRect(screen.bounds), NSStringFromCGRect(screen.nativeBounds), screen.scale, screen.nativeScale);
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
    }                completion:^(BOOL finished) {
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
    }                completion:^(BOOL finished) {
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

- (void)dealloc {
    NSLog(@"lookKai dealloc %@", NSStringFromClass(self.class));
}

@end
