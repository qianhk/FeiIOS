//
//  UikitTestViewController.m
//  singleview2
//
//  Created by kai on 17/4/26.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/UIControl+RACSignalSupport.h>
#import <objc/runtime.h>
#import <RegexKitLite/RegexKitLite.h>

#import "UIView+Toast.h"

#import "UikitTestViewController.h"
#import "NSObject+Calculator.h"
#import "CalculatorMaker.h"
#import "Calculator.h"
#import "ArtistData.h"
#import "AnimationView.h"

@interface UikitTestViewController ()

@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, strong) AnimationView *translateView;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) BOOL animationPaused;

@end

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation UikitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
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

    NSLog(@"\nmain thread mainT=%d tip=%p", [NSThread currentThread].isMainThread, [NSThread currentThread]);

    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

        // block调用时刻：每当有订阅者订阅信号，就会调用block。

        NSLog(@"createSignal %p tid=%p", subscriber, [NSThread currentThread]);
        // 2.发送信号
        [subscriber sendNext:@66];

        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];

        return [RACDisposable disposableWithBlock:^{

            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。

            // 执行完Block后，当前信号就不在被订阅了。

            NSLog(@"信号被销毁ori tid=%p", [NSThread currentThread]);

        }];
    }];

//    RACSignal *signal2 = [signal doNext:^(id x) {
//        NSLog(@"信号doNext x=%@", x);
//    }];

    RACSignal *signal2 = [[signal map:^id(id value) {
        NSLog(@"map里的数据:%@ tid=%p", value, [NSThread currentThread]);
        int intValue = [value intValue];
        return @(intValue + 1);
    }] deliverOnMainThread];

//     3.订阅信号,才会激活信号.
//    [[[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
//        // block调用时刻：每当有信号发出数据，就会调用block.
//        NSLog(@"接收到数据:%@ tid=%p", x, [NSThread currentThread]);
//    }];

    [[[signal2 deliverOn:[RACScheduler mainThreadScheduler]] subscribeOn:[RACScheduler scheduler]] subscribeNext:^(id x) {
        NSLog(@"接收到数据2:%@ tid=%p", x, [NSThread currentThread]);
    }];





//    // 1.创建信号
//    RACSubject *subject = [RACSubject subject];
//
//    // 2.订阅信号
//    [[subject flattenMap:^RACStream *(id value) {
//        return signal;
//    }] subscribeNext:^(id x) {
//        // block调用时刻：当信号发出新值，就会调用.
//        NSLog(@"第一个订阅者%@", x);
//    }];
//    [[subject map:^id(id value) {
//        return [NSString stringWithFormat:@"map %@", value];
//    }] subscribeNext:^(id x) {
//        // block调用时刻：当信号发出新值，就会调用.
//        NSLog(@"第二个订阅者%@", x);
//    }];
//
//    // 3.发送信号
//    [subject sendNext:@"1"];
//
//
//
//    // 1.创建信号
//    RACReplaySubject *replaySubject = [RACReplaySubject subject];
//
//    // 2.发送信号
//    [replaySubject sendNext:@1];
//    [replaySubject sendNext:@2];
//
//    // 3.订阅信号
//    [replaySubject subscribeNext:^(id x) {
//        NSLog(@"第一个订阅者接收到的数据%@", x);
//    }];
//
//    // 订阅信号
//    [replaySubject subscribeNext:^(id x) {
//        NSLog(@"第二个订阅者接收到的数据%@", x);
//    }];
//
//    NSLog(@"Test step....");
//
//    NSArray *numbers = @[@1, @2, @3, @4];
//    [numbers.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"rac_sequence.signal %@ %@", x, NSStringFromClass([x class]));
//    }];
//
//    RACSignal *mapResult = [numbers.rac_sequence.signal map:^id(id value) {
//        NSLog(@"rac_sequence.signal map %@ ", value);
//        return value;
//    }]; //mapResult is RACDynamicSignal
//
//    NSArray *array = [mapResult toArray]; //没有这一句不会真的执行map操作
//    NSLog(@"mapResult %@ %@ %@", mapResult, NSStringFromClass([mapResult class]), array);
//
//
//    NSDictionary *dict = @{@"name": @"meizi", @"age": @18};
//    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
//        RACTupleUnpack(NSString *key, NSString *value) = x;
//        NSLog(@"rac_sequence.signal %@ %@", key, value);
//
//    }];



    NSLog(@"\n");

    // 1.创建命令 // 强引用命令，不要被销毁，否则接收不到数据
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        NSLog(@"RACCommand initWithSignalBlock input=%@", input);

        // 创建空信号,必须返回信号
        // return [RACSignal empty];

        // 2.创建信号,用来传递数据
        RACSignal *racSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

            [subscriber sendNext:[NSString stringWithFormat:@"数据(param=%@)", input]];
            [subscriber sendNext:[NSString stringWithFormat:@"数据2(param=%@)", input]];
            [subscriber sendCompleted];
            return nil;
        }];
        racSignal.name = @"OriginSignal";
        NSLog(@"RACCommand initWithSignalBlock signal=%@", racSignal);
        return racSignal;

    }];


    // 3.订阅RACCommand中的信号
    [_command.executionSignals subscribeNext:^(id signal) {

        //此signal不是上面创建的那个racSignal
        NSLog(@"RACCommand executionSignals subscribeNext %@", signal);

        [signal subscribeNext:^(id data) {
            NSLog(@"RACCommand executionSignals subscribeNext subscribeNext %@", data);
        }];

    }];

    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [_command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"RACCommand executionSignals switchToLatest subscribeNext %@", x);
    }];

//     4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。  //为啥上来就有个信号?
//    [[_command.executing skip:0] subscribeNext:^(id x) {
//        if ([x boolValue]) {
//            NSLog(@"RACCommand executing subscribeNext 正在执行 %@ %@", x, NSStringFromClass([x class]));
//        } else {
//            NSLog(@"RACCommand executing subscribeNext 执行完成 %@ %@", x, NSStringFromClass([x class]));
//        }
//
//    }];
    [_command.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"RACCommand executing subscribeNext 正在执行 %@ %@", x, NSStringFromClass([x class]));
        } else {
            NSLog(@"RACCommand executing subscribeNext 执行完成 %@ %@", x, NSStringFromClass([x class]));
        }

    }];

    NSLog(@"RACCommand execute");
    // 5.执行命令
    [_command execute:@666];

    NSLog(@"Test End. rac_sequence.signal 异步的， 他们的log再此log之后\n");

    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        NSLog(@"subscribeNext viewWillAppear");
    }];

    Artist *artist = [Artist new];
    artist.name = @"KaiName Ha Test";

    NSString *numberStr = @"1";
    NSString *numberStr2 = @"1234";
    @try {
        [artist setValue:numberStr forKey:@"boolValue"];
        [artist setValue:numberStr2 forKey:@"boolValue"];
        [artist setValue:numberStr2 forKey:@"longValue"];
    } @catch (NSException *exception) {
        NSLog(@"setValueForKey exception: %@", exception);
    }
//    NSString *str;//is unavailable: not available in arc mode (automatic reference counting)
//    object_getInstanceVariable(artist, "_innerName", (void void *) &str);  //object_getInstanceVariable arc forbidden
//    NSLog(@"Artist _innerName = %@", str);

    UIColor *color = [UIColor redColor];
    CGFloat red = [self redWithColor:color];
    CGFloat green = [self greenWithColor:color];
    CGFloat blue = [self blueWithColor:color];
    NSLog(@"UIColor red: %f,%f,%f", red, green, blue);

//    color = nil;
//    red = [self redWithColor:color]; //will crash
//    green = [self greenWithColor:color];
//    blue = [self blueWithColor:color];
//    NSLog(@"UIColor nil: %f,%f,%f", red, green, blue);

    NSTimeInterval ti = [[NSDate date] timeIntervalSince1970];
    long long ts = ti * 1000; //由于ti是double，可以计算出毫秒来，后面并不是000
    long long tsws = ti * 1000 * 1000;
    long long tsns = ti * 1000 * 1000 * 1000;

    [self viewDidLoad2];
}

- (CGFloat)redWithColor:(UIColor *)color {
    const CGFloat *c = CGColorGetComponents(color.CGColor);
    return c[0];
}

- (CGFloat)greenWithColor:(UIColor *)color {
    const CGFloat *c = CGColorGetComponents(color.CGColor);
    if ([self colorSpaceModelWithCGColor:color.CGColor] == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blueWithColor:(UIColor *)color {
    const CGFloat *c = CGColorGetComponents(color.CGColor);
    if ([self colorSpaceModelWithCGColor:color.CGColor] == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGColorSpaceModel)colorSpaceModelWithCGColor:(CGColorRef)gColor {
    return CGColorSpaceGetModel(CGColorGetColorSpace(gColor));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIDevice *device = [UIDevice currentDevice];
    NSString *schema = [@"http://abc.com?id=123&title=中文字符" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"in viewWillAppear model=%@ schema=%@", [device model], schema);

    NSURL *url1 = [NSURL URLWithString:@"http://abc.com?id=123&title=title1#fragment"]; //参数里不能有中文，否则返回nil
    NSURL *url2 = [NSURL URLWithString:@"http://abc.com/xyz.html?id=123&title=title2"];
    NSString *string = url1.lastPathComponent;
    NSString *string2 = url2.lastPathComponent;
    NSLog(@"type of 1 str = %@ is str:%d %d, len=%d %d", NSStringFromClass(string.class), [string isKindOfClass:NSString.class], [string2 isKindOfClass:NSString.class], string.length, string2.length);
    NSString *fragment1 = url1.fragment;
    NSString *fragment2 = url2.fragment;
    NSArray<NSString *> *array1 = url1.pathComponents;
    NSArray<NSString *> *array2 = url2.pathComponents;
    NSString *parameterString1 = url1.parameterString;
    NSString *parameterString2 = url2.parameterString;
    NSString *query1 = url1.query;
    NSString *query2 = url2.query;


    NSUInteger queryLenght = query1.length;
    NSString *toIndex1 = url1.absoluteString;
    if (queryLenght > 0) {
//        toIndex1 = [toIndex1 substringToIndex:toIndex1.length - queryLenght - 1]; //无法去除fragment
        NSRange range = [toIndex1 rangeOfString:query1];
        if (range.location != NSNotFound) {
            toIndex1 = [toIndex1 substringToIndex:range.location - 1];
        }
    }

    NSString *toIndex2 = url2.absoluteString;
    queryLenght = query2.length;
    if (queryLenght > 0) {
        toIndex2 = [toIndex2 substringToIndex:toIndex2.length - queryLenght - 1];
    }

    NSDictionary *properties = @{@"id": @(123), @"name": @"凯凯啊", @"noNeedKey": @"noNeedValue", @"boolValue": @(YES)};

    NSString *pattern = @"\\$(\\S+?)\\$";

    NSString *modelStr = @"{\"id\":\"$id$\", \"name\":\"$name$\",\"haha\":\"$noKey$ha\", \"boolkey\":$boolValue$}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSArray<NSTextCheckingResult *> *arrayOfAllMatches = [regex matchesInString:modelStr options:0 range:NSMakeRange(0, [modelStr length])];
    @weakify(self)
    if (arrayOfAllMatches && arrayOfAllMatches.count > 0) {
        modelStr = [modelStr stringByReplacingOccurrencesOfRegex:pattern
                                                      usingBlock:^NSString *(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                                                          @strongify(self)
                                                          NSString *placeholder = capturedStrings[1];
                                                          if (placeholder && placeholder.length > 0) {
                                                              id placeValue = properties[placeholder];
                                                              NSString *replacedValue;
                                                              if ([placeValue isKindOfClass:NSNumber.class]) {
                                                                  replacedValue = [placeValue stringValue];
                                                              } else {
                                                                  replacedValue = placeValue;
                                                              }
//                                                              NSString *replacedValue = [placeValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                                              if (replacedValue && replacedValue.length > 0) {
                                                                  return replacedValue;
                                                              }
                                                              return @"";
                                                          }
                                                          return @"";
                                                      }];
    }

    NSData *data = [modelStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *modelDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"new model dic: %@", modelDic);

    NSString *ab = [@"http%3a%2f%2fdotwe.org%2fraw%2fdist%2f844f3bab6125b81324040e2560230969.bundle.wx%3fwh_weex%3dtrue" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *de = [@"好人" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    [button3 setTitle:@"B3" forState:UIControlStateNormal];
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

    [[button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        NSLog(@"\nbutton3 按钮被点击了 use rac_signalForControlEvents");
        button3.frame = CGRectMake(0, TOP + 400, SCREEN_WIDTH, button3.frame.size.height + 4);
        [button3 setTitle:[NSString stringWithFormat:@"%@-", button3.currentTitle] forState:UIControlStateNormal];
    }];


    [RACObserve(button3, frame) subscribeNext:^(id x) {
        //x is NSConcreteValue
        CGRect rect = [x CGRectValue];
        NSLog(@"button3 property changed use RACObserve frame %@ class=%@ rect=%@", x, [x class], NSStringFromCGRect(rect));
    }];

    //同样的属性，后关注的先收到信号
    [[button3 rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        RACTupleUnpack(id value, id value2) = x;
        CGRect rect = [value CGRectValue];
        NSLog(@"button3 property changed use rac_valuesAndChangesForKeyPath frame %@ class=%@ id=%@ id2=%@ rect=%@", x, [x class], value, value2, NSStringFromCGRect(rect));
    }];


    [[button3.titleLabel rac_valuesAndChangesForKeyPath:@"text" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        RACTupleUnpack(id value, id value2, id value3) = x;
        NSLog(@"button3 property changed use rac_valuesAndChangesForKeyPath text %@ class=%@ id=%@ id2=%@ id3=%@", x, [x class], value, value2, value3);
    }];

    //同样的属性，后关注的先收到信号
    [RACObserve(button3.titleLabel, text) subscribeNext:^(id x) {
        //x is NSTaggedPointerString
//        NSString *lable = [x string]; //直接用，不能转 [__NSCFConstantString string]: unrecognized selector sent to instance 0x1000c53b0
        NSLog(@"button3 property changed use RACObserve text %@ class=%@", x, [x class]);
    }];
}

- (void)viewDidLoad2 {

    CGFloat myViewW = 100;
    CGFloat myViewH = 100;
    CGFloat myViewX = (SCREEN_WIDTH - myViewW) / 2;
    CGFloat myViewY = (SCREEN_HEIGHT - myViewH) / 2;
    self.translateView = [[AnimationView alloc] initWithFrame:CGRectMake(myViewX, myViewY, myViewW, myViewH)];
    [self.view addSubview:self.translateView];
    self.translateView.backgroundColor = [UIColor greenColor];
    self.translateView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTranslateView:)];
//    tapGes.numberOfTapsRequired = 1;
//    tapGes.numberOfTouchesRequired = 1;
//    tapGes.cancelsTouchesInView = YES;
//    tapGes.delaysTouchesEnded = NO;
    [self.translateView addGestureRecognizer:tapGes];
}

- (void)onTapTranslateView:(id)sender {
    [self.view makeToast:@"onTap TranslateView" duration:0.5f];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT / 2 - 75)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2 - 75)];
//    animation.duration = 5.0f;
//    //anima.fillMode = kCAFillModeForwards;
//    //anima.removedOnCompletion = NO;
//    [self.translateView.layer addAnimation:animation forKey:@"positionAnimation"];

    if (self.animating) {
        if (self.animationPaused) {
            [self resumeLayer:self.translateView.layer];
        } else {
            [self pauseLayer:self.translateView.layer];
        }
        self.animationPaused = !self.animationPaused;
    } else {
        CGFloat myViewW = 100;
        CGFloat myViewH = 100;
        CGFloat myViewX = (0 - myViewW) / 2;
        CGFloat myViewY = (SCREEN_HEIGHT - myViewH) / 2;
        self.translateView.frame = CGRectMake(myViewX, myViewY, myViewW, myViewH);
        self.animating = YES;
        self.animationPaused = NO;
        
        [UIView animateWithDuration:8.f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             CGFloat myViewXEnd = SCREEN_WIDTH;
                             self.translateView.frame = CGRectMake(myViewXEnd - 50, myViewY, myViewW, myViewH);
                         } completion:^(BOOL finished){
                             self.animating = NO;
                         }];
    }
    

}

- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
