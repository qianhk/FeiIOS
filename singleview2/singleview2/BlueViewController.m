//
//  BlueViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/18.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray<NSString *> *mCharacterNames;
}

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation BlueViewController

- (IBAction)onButtonClicked:(UIButton *)sender {
    NSInteger row = [_picker selectedRowInComponent:0];
    _resultLabel.text = [NSString stringWithFormat:@"%@ %@", _datePicker.date.description, mCharacterNames[row]];
}


- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    _resultLabel.text = sender.date.description;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    CGRect originFrame = self.view.frame;
//    self.view.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20);
    
//    self.view.backgroundColor = [UIColor blueColor];
    
//    self.view.bounds = [self getContentViewFrame];
//    _datePicker change
//    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *date = [NSDate date];
    [_datePicker setDate:date animated:NO];
    
    mCharacterNames = @[@"BaoShan", @"FengZhen", @"HongKai", @"TianChun", @"YiYang", @"NaShei", @"SonShei"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return mCharacterNames.count;
}

#pragma mark -

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return mCharacterNames[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _resultLabel.text = mCharacterNames[row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20 - 44);
}

@end
