//
//  KaiLinearRegressionViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2018/5/3.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "KaiLinearRegressionViewController.h"
#import "KaiLlinearOnlyMul.h"

@interface KaiLinearRegressionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property(nonatomic, strong) KaiLlinearOnlyMul *kaiLinear;

@end

@implementation KaiLinearRegressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.kaiLinear = [KaiLlinearOnlyMul new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRunButtonClicked:(id)sender {
    CGFloat floatInput = 0.f;
    @try {
        NSString *inputText = _inputTextField.text;
        floatInput = inputText.floatValue;
    } @catch(NSException *exception) {
        self.resultLabel.text = exception.description;
        return;
    }
    MLMultiArray *inputMultiArray = [[MLMultiArray alloc] init];
    KaiLlinearOnlyMulInput *input = [[KaiLlinearOnlyMulInput alloc] initWithInput__0:inputMultiArray];
    NSError *error = nil;
    KaiLlinearOnlyMulOutput *output = [self.kaiLinear predictionFromFeatures:input error:&error];
    MLMultiArray *calcMutiArray = output.calcY__0;
    if (error) {
        self.resultLabel.text = error.description;
    } else {
        self.resultLabel.text = calcMutiArray.description;
    }
    
}

@end
