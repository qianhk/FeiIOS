//
//  CoreMLMobileNetViewController.m
//  singleview2
//
//  Created by KaiKai on 2018/2/2.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "CoreMLMobileNetViewController.h"
#import "MobileNet.h"
#import "UIImage+Utils.h"

@interface CoreMLMobileNetViewController ()

@end

@implementation CoreMLMobileNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MobileNet *model = [[MobileNet alloc] init];
    UIImage *image = [UIImage imageNamed:@"desk"];
    UIImage *scaledImage = [image scaleToSize:CGSizeMake(224, 224)];
    CVPixelBufferRef buffer = [image pixelBufferFromCGImage:scaledImage];
    MobileNetInput *input = [[MobileNetInput alloc] initWithImage:buffer];
    NSError *error = nil;
    MobileNetOutput *output = [model predictionFromFeatures:input error:&error];
    NSLog(@"output: error=%@ label=%@ dic=%@", error, output.classLabel, output.classLabelProbs);
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

@end
