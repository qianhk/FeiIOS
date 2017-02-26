//
//  PickerViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/18.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "PickerViewController.h"
#import "SectionTableViewController.h"

@interface PickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray<NSString *> *mCharacterNames;
    NSArray< NSArray<NSString *> *> *mCharacterNamesList;
    NSDictionary *mStateDictionary;
    NSArray *mStateList;
    NSArray *mCityList;

    BOOL mUseTwo;
}

@property(strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(strong, nonatomic) IBOutlet UILabel *resultLabel;
@property(strong, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation PickerViewController

- (void)dealloc {
    NSLog(@"lookEvent PickerViewController dealloc");
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    NSInteger row0 = [_picker selectedRowInComponent:0];
    NSInteger row1 = [_picker selectedRowInComponent:1];
    if (mUseTwo) {
        _resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _datePicker.date.description, mCharacterNamesList[0][row0], mCharacterNamesList[1][row1]];
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _datePicker.date.description, mStateList[row0], mCityList[row1]];
    }
    SectionTableViewController *controller = [[SectionTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    _resultLabel.text = sender.date.description;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"Picker Test Page";

//    CGRect originFrame = self.view.frame;
//    self.view.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20);

//    self.view.backgroundColor = [UIColor blueColor];

//    self.view.bounds = [self getContentViewFrame];
//    _datePicker change
//    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

    NSDate *date = [NSDate date];
    [_datePicker setDate:date animated:NO];

    mCharacterNames = @[@"BaoShan", @"FengZhen", @"HongKai", @"TianChun", @"YiYang", @"NaShei", @"SonShei"];
    mCharacterNamesList = @[@[@"BaoShan", @"FengZhen", @"HongKai", @"TianChun", @"YiYang", @"NaShei", @"SonShei"], @[@"BaoShan2", @"FengZhen2", @"HongKai2", @"TianChun2", @"YiYang2", @"NaShei2", @"SonShei2"]];


    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"statedDictionary" withExtension:@"plist"];
    mStateDictionary = [NSDictionary dictionaryWithContentsOfURL:plistUrl];
    mStateList = [mStateDictionary.allKeys sortedArrayUsingSelector:@selector(compare:)];
    mCityList = mStateDictionary[mStateList[0]];

    mUseTwo = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (mUseTwo) {
        return mCharacterNamesList.count;
    } else {
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (mUseTwo) {
        return [mCharacterNamesList objectAtIndex:component].count;
    } else {
        if (component == 0) {
            return mStateList.count;
        } else {
            return mCityList.count;
        }
    }
}

#pragma mark -

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (mUseTwo) {
        return mCharacterNamesList[component][row];
    } else {
        if (component == 0) {
            return mStateList[row];
        } else {
            return mCityList[row];
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (mUseTwo) {
        _resultLabel.text = mCharacterNamesList[component][row];
    } else {
        if (component == 0) {
            mCityList = mStateDictionary[mStateList[row]];
            [_picker reloadComponent:1];
            [_picker selectRow:0 inComponent:1 animated:YES];
        }
    }
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    CGFloat pickerWidth = pickerView.bounds.size.width;
//    if (component == 0) {
//        return pickerWidth / 5;
//    } else {
//        return pickerWidth / 5 * 4;
//    }
//}


#pragma mark -

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20 - 44);
}

@end
