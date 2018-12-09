//
//  AnchorPointViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/12/8.
//  Copyright © 2018 Njnu. All rights reserved.
//

#import "AnchorPointViewController.h"

@interface AnchorPointViewController ()

@property (strong, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIView *yellowView;

@property (strong, nonatomic) IBOutlet UIView *blueView;


@property (weak, nonatomic) IBOutlet UIImageView *hourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *minuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

//@property (weak, nonatomic) NSTimer *timer;

@property (strong, nonatomic) dispatch_source_t timer;

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
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.yellowView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"pet"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    _yellowView.layer.mask = maskLayer;
//    _yellowView.layer.shadowOpacity = 1.f;

    
//    _yellowView.layer.anchorPoint = CGPointMake(0, 0);
    
    self.hourImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    self.minuteImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    self.secondImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    
    
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
}


- (void)dealloc {
    NSLog(@"lookKai dealloc %@", self.class);
//    [self.timer invalidate];
//    self.timer = nil;
    dispatch_cancel(_timer);
}

@end
