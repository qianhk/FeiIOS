//
//  AnchorPointViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/12/8.
//  Copyright © 2018 Njnu. All rights reserved.
//

#import "AnchorPointViewController.h"
#include <pthread.h>

@interface AnchorPointViewController ()

@property (strong, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIView *yellowView;

@property (strong, nonatomic) IBOutlet UIView *blueView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitViews;

@property (weak, nonatomic) IBOutlet UIImageView *hourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *minuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (strong, nonatomic) IBOutlet UIView *layerView;

//@property (weak, nonatomic) NSTimer *timer;

@property (strong, nonatomic) dispatch_source_t timer;

@property (strong, nonatomic) NSMutableData *testData;

@end

@implementation AnchorPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _yellowView.layer.zPosition = 100.f;
//    _greenView.layer.zPosition = 1.f;
//    _greenView.layer.delegate = self;
    NSLog(@"lookKai layer.deletate=%@ shadowRadius=%.2f offset=%@ geometryFlipped=%ld", _greenView.layer.delegate
          , _blueView.layer.shadowRadius, NSStringFromCGSize(_blueView.layer.shadowOffset), _blueView.layer.geometryFlipped);
    
    _yellowView.layer.cornerRadius = 10;
    _yellowView.layer.borderColor = [UIColor blueColor].CGColor;
    _yellowView.layer.borderWidth = 5.f;
    
    _greenView.layer.shadowOpacity = 1.f;
    _greenView.layer.shadowRadius = 6.f;
    _greenView.layer.shadowColor = [UIColor redColor].CGColor;
    _greenView.layer.shadowOffset = CGSizeMake(0, 0);
//    _greenView.layer.geometryFlipped = YES;
//    _greenView.clipsToBounds = YES;
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, CGRectInset(_greenView.bounds, -10, -10));
    _greenView.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = self.yellowView.bounds;
//    UIImage *maskImage = [UIImage imageNamed:@"pet"];
//    maskLayer.contents = (__bridge id)maskImage.CGImage;
//    _yellowView.layer.mask = maskLayer;
//    _yellowView.layer.shadowOpacity = 1.f;

    circlePath = CGPathCreateMutable();
    CGPathAddRect(circlePath, NULL, _yellowView.bounds);
    CGPathAddEllipseInRect(circlePath, NULL, CGRectInset(_yellowView.bounds, 20, 20));

//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_yellowView.bounds];
////    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
////    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 400, SCREEN_WIDTH - 2 * 20, 100) cornerRadius:15] bezierPathByReversingPath]];
//    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectInset(_yellowView.bounds, 20, 20) cornerRadius:10]];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.path = circlePath;
    CGPathRelease(circlePath);
    _yellowView.layer.mask = maskLayer;
    
//    _yellowView.layer.anchorPoint = CGPointMake(0, 0);
    
    self.hourImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    self.minuteImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    self.secondImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    
    
    UIImage *digits = [UIImage imageNamed:@"numbers"];
    
    for (UIView *view in self.digitViews) {
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        view.layer.magnificationFilter = kCAFilterNearest;
    }

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.blueView.bounds;
    [self.blueView.layer addSublayer:gradientLayer];
//    self.blueView.backgroundColor = [UIColor whiteColor];
//    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
//    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    self.blueView.backgroundColor = [UIColor clearColor];
    self.blueView.clipsToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.5];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);

    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectInset(self.layerView.bounds, 30, 10);
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:colorLayer];
//    self.layerView.clipsToBounds = YES;
    self.layerView.userInteractionEnabled = YES;
    [self.layerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLayerView:)]];
    
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    colorLayer.actions = @{@"backgroundColor": transition};
    
    NSLog(@"Outside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    //begin animation block
    [UIView beginAnimations:nil context:nil];
    //test layer action when inside of animation block
    NSLog(@"Inside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    //end animation block
    [UIView commitAnimations];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeTick) userInfo:nil repeats:YES];
//    [self timeTick];
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    __weak typeof(self) weakself = self;
    dispatch_source_set_event_handler(_timer, ^{
        __strong typeof(self) strongSelf = weakself;
        [strongSelf timeTick];
    });
    dispatch_resume(_timer);
    
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            self.testData = [[NSMutableData alloc] init];
//        });
//    }
    
    NSString *kaiTestStr = @"kaiTestStr";
    NSLog(@"lookTest 1 %p %@ 0x%x", kaiTestStr, kaiTestStr, &kaiTestStr);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        mach_port_t machTID = pthread_mach_thread_np(pthread_self());
        NSLog(@"global queue: current thread: %ld tId=%ld  %@", machTID, [AnchorPointViewController getCurrentThreadId], [AnchorPointViewController getPrettyCurrentThreadDescription]);
        NSLog(@"lookTest 3 %p %@ 0x%x", kaiTestStr, kaiTestStr, &kaiTestStr); //lookTest kaiTestStr
    });
    kaiTestStr = @"222222";
    NSLog(@"lookTest 2 %p %@ 0x%x", kaiTestStr, kaiTestStr, &kaiTestStr);
    
    mach_port_t machTID = pthread_mach_thread_np(pthread_self()); //mach_port_t 不等于线程id
    NSLog(@"current thread: %ld tId=%ld  %@", machTID, [AnchorPointViewController getCurrentThreadId], [AnchorPointViewController getPrettyCurrentThreadDescription]);
}

- (void)onTapLayerView:(id)recognizer {
    CALayer *layer = self.layerView.layer.sublayers[0];
    if (false) {
        [CATransaction setAnimationDuration:2];
//    [CATransaction setDisableActions:YES];
        CGFloat red = arc4random() / (CGFloat) INT_MAX;
        CGFloat green = arc4random() / (CGFloat) INT_MAX;
        CGFloat blue = arc4random() / (CGFloat) INT_MAX;

        layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;

        red = arc4random() / (CGFloat) INT_MAX;
        green = arc4random() / (CGFloat) INT_MAX;
        blue = arc4random() / (CGFloat) INT_MAX;
        self.layerView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

        [CATransaction setCompletionBlock:^{
//        [CATransaction setAnimationDuration:2];
//        [CATransaction setDisableActions:YES];
            CGAffineTransform transform = layer.affineTransform;
            transform = CGAffineTransformRotate(transform, M_PI / 6);
            layer.affineTransform = transform;
        }];
    } else {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"backgroundColor";
        animation.duration = 2.0;
        animation.values = @[
                (__bridge id)[UIColor blueColor].CGColor,
                (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)[UIColor greenColor].CGColor,
                (__bridge id)[UIColor blueColor].CGColor ];
        CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        animation.timingFunctions = @[fn, fn, fn];
//        animation.timingFunction = fn;
        //apply animation to layer
        [layer addAnimation:animation forKey:nil];
    }
}

- (void)timeTick {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hour = components.hour / 12.0 + (1.0 / 12) * components.minute / 60.0 + (1.0 / 3600) * components.second / 60.0;
    CGFloat hourAngle = (hour) * M_PI * 2.0;
    
    CGFloat minute = components.minute / 60.0 + (1.0 / 60) * components.second / 60.0;
    CGFloat minuteAngle = minute * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    self.hourImageView.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minuteImageView.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondImageView.transform = CGAffineTransformMakeRotation(secondAngle);
    
//    NSLog(@"second frame=%@ bounds=%@", NSStringFromCGRect(_secondImageView.frame), NSStringFromCGRect(_secondImageView.bounds));
    

    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];

    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];

    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

- (void)dealloc {
    NSLog(@"lookKai dealloc %@", self.class);
//    [self.timer invalidate];
//    self.timer = nil;
    dispatch_cancel(_timer);
    
//    __weak typeof(self) weakSef = self; // dealloc里不能使用弱引用，会crash
}

+ (NSInteger)getCurrentThreadId {
    static NSRegularExpression *regex = nil;
    if (regex == nil) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"number = (?<tid>\\d+)" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    NSString *raw = [[NSThread currentThread] description]; //<NSThread: 0x600003d728c0>{number = 1, name = main}; // one match
//    NSString *raw = @"<NSThread: 0x6000002d6840>{number = 3, name = (null)} <NSThread: 0x6000002d6840>{number = 666, name = (null)}"; // multi match
//    NSString *raw = [self description]; // no match
    NSLog(@"lookRaw %@", raw);
//    NSString *raw2 = [[NSThread currentThread] debugDescription];
    NSArray *matches = [regex matchesInString:raw options:0 range:NSMakeRange(0, [raw length])];
//
//    [regex enumerateMatchesInString:raw options:0 range:NSMakeRange(0, [raw length]) usingBlock:^(NSTextCheckingResult * _Nullable obj, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        NSLog(@"enum1 range=%@ %@", NSStringFromRange(obj.range), [raw substringWithRange:obj.range]);
//    }];
//
//    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"enum2 range=%@ %@", NSStringFromRange(obj.range), [raw substringWithRange:obj.range]);
//    }];
    
    NSTextCheckingResult *result = [regex firstMatchInString:raw options:0 range:NSMakeRange(0, [raw length])];
    NSLog(@"matches count=%ld, result_type=0x%X range=%@ nOfRange=%ld", matches.count, result.resultType, NSStringFromRange(result.range), result.numberOfRanges);
    NSInteger tId = 0;
    if (result != nil && result.numberOfRanges > 1) {
        NSRange r1 = [result rangeAtIndex:1];
//        NSRange r2 = [result rangeWithName:@"tid"]; //ios 11
        NSLog(@"lookMatch r0=%@ r1=%@ str=%@", NSStringFromRange([result rangeAtIndex:0]), NSStringFromRange(r1), [raw substringWithRange:r1]);
        return [[raw substringWithRange:r1] integerValue];
    }
    return tId;
}

+ (NSString *)getPrettyCurrentThreadDescription {
    NSString *raw = [NSString stringWithFormat:@"%@", [NSThread currentThread]];
    
    NSArray *splits = [raw componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{}"]];
    if (splits.count == 3) {
        return splits[1];
    }
    return raw;
    
//    NSArray *firstSplit = [raw componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{"]];
//    if ([firstSplit count] > 1) {
//        NSArray *secondSplit     = [firstSplit[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"}"]];
//        if ([secondSplit count] > 0) {
//            NSString *numberAndName = secondSplit[0];
//            return numberAndName;
//        }
//    }
//
//    return raw;
}

@end
