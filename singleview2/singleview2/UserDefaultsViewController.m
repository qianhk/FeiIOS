//
//  UserDefaultsViewController.m
//  singleview2
//
//  Created by KaiKai on 17/3/5.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "UserDefaultsViewController.h"
#import "KVCModel.h"

@interface UserDefaultsViewController () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLLocation *previousPoint;
@property(nonatomic, assign) CLLocationDistance totalMovementDisance;

@property(nonatomic, strong) KVCModel *kvcModel;

@property(strong, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation UserDefaultsViewController

- (void)dealloc {
    NSLog(@"UserDefaultsViewController dealloc");
    [self.kvcModel removeObserver:self forKeyPath:@"name"];
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


    self.kvcModel = [KVCModel new];
    _kvcModel.name = @"KaiName";
    id value1ForName = [_kvcModel valueForKey:@"name"];
    [_kvcModel setValue:@"KaiSetName" forKey:@"name"];
    id value2ForName = [_kvcModel valueForKey:@"name"];

    id value1ForName2 = [_kvcModel valueForKey:@"name2"];
    [_kvcModel setValue:@"KaiSetName2" forKey:@"name2"];
    id value2ForName2 = [_kvcModel valueForKey:@"name2"];

    id value1ForName3 = [_kvcModel valueForKey:@"name3"];
    [_kvcModel setValue:@"KaiSetName3" forKey:@"name3"];
    id value2ForName3 = [_kvcModel valueForKey:@"name3"];


    NSLog(@"%@ %@, %@ %@, %@ %@", value1ForName, value2ForName, value1ForName2, value2ForName2, value1ForName3, value2ForName3);

    id value1ForAge = [_kvcModel valueForKey:@"age"];
    [_kvcModel setValue:@32 forKey:@"age"];
    id value2ForAge = [_kvcModel valueForKey:@"age"];
    [_kvcModel setValue:nil forKey:@"age"];
    id value3ForAge = [_kvcModel valueForKey:@"age"];
//    [kvcModel setValue:@"AgeValue" forKey:@"age"];

    NSLog(@"age: %@ %@ %@", value1ForAge, value2ForAge, value3ForAge);

    _kvcModel.age = 100;

    KVCModel *kvcModel2 = [KVCModel new];
    kvcModel2.age = 120;
    KVCModel *kvcModel3 = [KVCModel new];
    kvcModel3.age = 80;

    NSArray *a = @[@4, @84, @2, @56];
    NSLog(@"max a = %@", [a valueForKeyPath:@"@max.self"]);

    NSArray *ages = @[_kvcModel, kvcModel2, kvcModel3];
    NSLog(@"max age = %@", [ages valueForKeyPath:@"@max.age"]); //KVC 的苹果官方文档有一个章节 Collection Operators 详细的讲述了类似的用法

    [self.kvcModel addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    NSLog(@"after kvcModel addObserver");
    self.kvcModel.name = @"kai58";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //'NSInternalInconsistencyException', reason: '<UserDefaultsViewController: 0x100403580>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.
    
    
    NSLog(@"kvcModel observeValueForKeyPath key=%@ new=%@ old=%@", keyPath, [change valueForKey:NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
    if ([keyPath isEqualToString:@"name"]) {
    }
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
//    NSLog(string);
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
    NSLog(@"lookLifecycle UserDefaultsViewController viewWillDisappear");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id nameStr = [defaults objectForKey:@"name_preference"];
    NSLog(@"refreshUserDefaults %@ %@", nameStr, [nameStr class]);
    _resultLabel.text = nameStr;
}

@end
