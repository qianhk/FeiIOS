//
//  KaiLinearRegressionViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2018/5/3.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "KaiLinearRegressionViewController.h"
#import "KaiLlinearOnlyMul.h"
#import "SpamMessageClassifier.h"

@interface KaiLinearRegressionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property(nonatomic, strong) KaiLlinearOnlyMul *kaiLinear;

@end

@implementation KaiLinearRegressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChangeNotification:)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
    self.kaiLinear = [KaiLlinearOnlyMul new];
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
    NSError *error = nil;
    NSArray<NSNumber *> *shapeArray = @[@(1), @(1), @(1)];
    MLMultiArray *inputMultiArray = [[MLMultiArray alloc] initWithShape:shapeArray dataType:MLMultiArrayDataTypeDouble error:&error];
    if (error) {
        self.resultLabel.text = error.description;
        return;
    }
//    [inputMultiArray setObject:@(floatInput) atIndexedSubscript:0];
    inputMultiArray[0] = @(floatInput);
//    inputMultiArray[1] = @(2.1f);
//    inputMultiArray[2] = @(3.2f);
    KaiLlinearOnlyMulInput *input = [[KaiLlinearOnlyMulInput alloc] initWithInput__0:inputMultiArray];
    KaiLlinearOnlyMulOutput *output = [self.kaiLinear predictionFromFeatures:input error:&error];
    MLMultiArray *calcMutiArray = output.calcY__0;
    if (error) {
        self.resultLabel.text = error.description;
    } else {
        double resultValue = -1;
        if (calcMutiArray.dataType == MLMultiArrayDataTypeDouble) {
            double *ptr = (double *) calcMutiArray.dataPointer;
//            NSInteger offset = i*stride[0].intValue + j*stride[1].intValue + k*stride[2].intValue;
            NSInteger offset = 0;
            resultValue = ptr[offset];
        }
        NSNumber *resultObj = calcMutiArray[0];
        id tmpResult = [calcMutiArray objectAtIndexedSubscript:0];
        self.resultLabel.text = [NSString stringWithFormat:@"result=%@\n\nshape=%@\ntype=%d count=%d\nstrides=%@"
                                 , resultObj, calcMutiArray.shape.description, calcMutiArray.dataType, calcMutiArray.count, calcMutiArray.strides.description];
    }
}

- (IBAction)onRunClassifierBtnClicked:(id)sender {
    SpamMessageClassifier *classifier = [SpamMessageClassifier new];
    NSError *error = nil;
    NSArray<NSNumber *> *shapeArray = @[@(1)];
    MLMultiArray *inputMultiArray = [[MLMultiArray alloc] initWithShape:shapeArray dataType:MLMultiArrayDataTypeDouble error:&error];
    if (error) {
        self.resultLabel.text = error.description;
        return;
    }
    inputMultiArray[0] = @(123);
    SpamMessageClassifierOutput *classifierOutput = [classifier predictionFromMessage:inputMultiArray error:&error];
    if (error) {
        self.resultLabel.text = error.description;
    } else {
        self.resultLabel.text = [NSString stringWithFormat:@"%@\n%@", classifierOutput.spam_or_not, classifierOutput.classProbability];
    }
}

- (void)textFieldTextDidChangeNotification:(id)notifycation {
    [self onRunButtonClicked:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
