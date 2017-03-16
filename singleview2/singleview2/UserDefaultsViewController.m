//
//  UserDefaultsViewController.m
//  singleview2
//
//  Created by KaiKai on 17/3/5.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "UserDefaultsViewController.h"

@interface UserDefaultsViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *previousPoint;
@property (nonatomic, assign) CLLocationDistance totalMovementDisance;

@property(strong, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation UserDefaultsViewController

- (void)dealloc {
    NSLog(@"UserDefaultsViewController dealloc");
    [self.locationManager stopUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.resultLabel.numberOfLines = 0;

    NSString *recordValue = @"{\"id_11111\":1, \"id_11112\":2, \"id_11113\":3}";
    NSMutableDictionary *recordDic;

    if (recordValue.length > 0) {
        NSData *stringData = [recordValue dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:stringData options:0 error:nil];
        recordDic = [NSMutableDictionary dictionaryWithDictionary:json];
//        NSLog(@"recordValue.length > 0 id=%@", id);
        recordDic[@"id_200"] = @6;
        recordDic[@"id_201"] = @7;
        recordDic[@"id_202"] = @"abc";
    } else {
        recordDic = [NSMutableDictionary new];
        recordDic[@"id_100"] = @4;
        recordDic[@"id_101"] = @5;
//        [NSJSONSerialization dataWithJSONObject:<#(id)obj#> options:<#(NSJSONWritingOptions)opt#> error:<#(NSError **)error#>]
    }
    NSError *error2;
    NSData *newData = [NSJSONSerialization dataWithJSONObject:recordDic options:0 error:&error2];
    NSString *jsonString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
    NSLog(@"viewDidLoad new jsonString=%@", jsonString);

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSingleTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];

    [singleTap requireGestureRecognizerToFail:doubleTap];

    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"Authorization status changed to %d", status);
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;

        default:
            [self.locationManager stopUpdatingLocation];
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorType = error.code == kCLErrorDenied ? @"禁止访问位置信息" : [NSString stringWithFormat:@"Error: %ld", (long) error.code];
    NSLog(@"didFailWithError %@", errorType);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    if (self.previousPoint) {
        self.totalMovementDisance += [location distanceFromLocation:self.previousPoint];
    } else {
        self.totalMovementDisance = 0;
    }
    self.previousPoint = location;
    NSString *string = [NSString stringWithFormat:@"lat=%g\u00B0 lng=%g\u00B0 hAccuracy=%gm vAccuracy=%gm altitude=%gm distance=%gm"
            , location.coordinate.latitude, location.coordinate.longitude
            , location.horizontalAccuracy, location.verticalAccuracy, location.altitude, self.totalMovementDisance];
    NSLog(string);
    _resultLabel.text = string;
}


- (void)doSingleTap {
    NSLog(@"doSingleTap");
}

- (void)doDoubleTap {
    NSLog(@"doDoubleTap");
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

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSLog(@"lookLifecycle UserDefaultsViewController applicationWillEnterForeground");
    [self refreshUserDefaults];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"lookLifecycle UserDefaultsViewController viewWillAppear");
    [self refreshUserDefaults];

    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification object:app];

}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self refreshUserDefaults];
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id nameStr = [defaults objectForKey:@"name_preference"];
    _resultLabel.text = nameStr;
}

@end
