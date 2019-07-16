//
//  PickerViewController.m
//  singleview2
//
//  Created by KaiKai on 17/2/18.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "PickerViewController.h"
#import "SectionTableViewController.h"

@interface PickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray<NSString *> *mCharacterNames;
    NSArray<NSArray<NSString *> *> *mCharacterNamesList;
    NSDictionary *mStateDictionary;
    NSArray *mStateList;
    NSArray *mCityList;

    BOOL mUseTwo;
}

@property(strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(strong, nonatomic) IBOutlet UILabel *resultLabel;
@property(strong, nonatomic) IBOutlet UIPickerView *picker;

@property(nonatomic, strong) RACDisposable *disposable;

@end

@implementation PickerViewController

- (void)dealloc {
    [self.disposable dispose];
    NSLog(@"lookEvent PickerViewController dealloc");
}

- (IBAction)onButtonClicked:(UIButton *)sender {
//    NSInteger row0 = [_picker selectedRowInComponent:0];
//    NSInteger row1 = [_picker selectedRowInComponent:1];
//    if (mUseTwo) {
//        _resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _datePicker.date.description, mCharacterNamesList[0][row0], mCharacterNamesList[1][row1]];
//    } else {
//        _resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _datePicker.date.description, mStateList[row0], mCityList[row1]];
//    }
//    SectionTableViewController *controller = [[SectionTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    [self presentViewController:controller animated:YES completion:nil];
    [UIView animateWithDuration:1.f animations:^{
        self.resultLabel.numberOfLines = (self.resultLabel.numberOfLines > 1 || self.resultLabel.numberOfLines <= 0) ? 1 : 0;
        [self.view layoutIfNeeded];   // 这行不能少
    }];
}


- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    _resultLabel.text = sender.date.description;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    self.title = @"Picker Test Page"; //如果设置了标题，底部tab里会用这个

//    CGRect originFrame = self.view.frame;
//    self.view.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20);

//    self.view.backgroundColor = [UIColor blueColor];

//    self.view.bounds = [self getContentViewFrame];
//    _datePicker change
//    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSDate *date = [NSDate date];
    [_datePicker setDate:date animated:NO];

    mCharacterNames = @[@"BaoShan", @"FengZhen", @"HongKai", @"TianChun", @"YiYang", @"NaShei", @"SonShei"];
    mCharacterNamesList = @[@[@"BaoShan", @"FengZhen", @"HongKai", @"TianChun", @"YiYang", @"NaShei", @"SonShei"], @[@"BaoShan2", @"FengZhen2", @"HongKai2", @"TianChun2", @"YiYang2", @"NaShei2", @"SonShei2"]];


    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"statedDictionary" withExtension:@"plist"];
    mStateDictionary = [NSDictionary dictionaryWithContentsOfURL:plistUrl];
    mStateList = [mStateDictionary.allKeys sortedArrayUsingSelector:@selector(compare:)];
    mCityList = mStateDictionary[mStateList[0]];

    mUseTwo = NO;

    self.resultLabel.backgroundColor = [UIColor lightGrayColor];

    self.resultLabel.attributedText = [PickerViewController attributedStringWithTag:@"凯测试效果" tagColor:[UIColor redColor] text:@"这是一个怎么样的精神，调ui效果啊啊, 这是第二行啊"];
    [self.resultLabel sizeToFit];

    [self testRacSignal];
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    NSObject *nilObj = nil;
    mutableDic[@"testHaha"] = @(666);
    mutableDic[@"NullKey"] = nil;
    mutableDic[@"NullKey2"] = nilObj;
    [mutableDic setValue:nilObj forKey:@"NullKey3"];
    //    [mutableDic setObject:nilObj forKey:@"NullKey4"]; //-[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: testNN)'
    
    //    NSDictionary *constDic = @{@"NullKey5": nilObj}; //crash
    
    NSInteger abc = -100;
    NSUInteger uAbc0 = abc; //很大的正数
    NSUInteger uAbc1 = (NSUInteger)(-100/20); //很大的正数
    NSUInteger uAbc2 = (NSUInteger)(-100.f/20); //0
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


+ (NSAttributedString *)attributedStringWithTag:(NSString *)tag tagColor:(UIColor *)tagColor text:(NSString *)text {

    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];

    if ([tag length] > 0) {
        UIView *tagView = [self tagLabelCellWithColor:tagColor withText:tag];
        UIImage *tagImage = [self imageByRenderingViewForRetina:tagView];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = tagImage;
//        textAttachment.bounds = CGRectMake(0, 0, tagView.frame.size.width, tagView.frame.size.height);
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedString appendAttributedString:attrStringWithImage];
    }

    NSDictionary *contentAttributedStringAttributes = @{
            NSForegroundColorAttributeName: [UIColor blackColor],
//            NSBaselineOffsetAttributeName:@(3),
            NSFontAttributeName: [UIFont boldSystemFontOfSize:16.f]
    };
    NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:text
                                                                        attributes:contentAttributedStringAttributes];

    int len = attributedString.length;
    [attributedString appendAttributedString:contentString];
    [attributedString setAttributes:
            @{
                    NSBaselineOffsetAttributeName: @(3),
                    NSForegroundColorAttributeName: [UIColor blueColor]
            }                 range:NSMakeRange(len, contentString.length)];

    return attributedString;
}


+ (UIImage *)imageByRenderingViewForRetina:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIView *)tagLabelCellWithColor:(UIColor *)color withText:(NSString *)text {

    NSInteger kMargin = 3;
    UIFont *font = [UIFont systemFontOfSize:11.f];
    CGSize textSize = [text sizeWithAttributes:@{
            NSFontAttributeName: font,
    }];

    UILabel *cellLabel = [UILabel new];
    cellLabel.font = font;
    cellLabel.textAlignment = NSTextAlignmentCenter;
    cellLabel.textColor = [UIColor whiteColor];
    cellLabel.layer.cornerRadius = 2;
    cellLabel.backgroundColor = color;
    cellLabel.text = text;
    cellLabel.frame = CGRectMake(0, 1, textSize.width + kMargin * 2, 16);
    cellLabel.layer.masksToBounds = YES;

    UIView *containerView = [UIView new];
    containerView.frame = CGRectMake(0, 0, CGRectGetWidth(cellLabel.frame) + kMargin, 18);
    [containerView addSubview:cellLabel];
//    containerView.backgroundColor = [UIColor greenColor];

    return containerView;
}

- (void)testPackUnpack {
    NSNull *null = [NSNull null];
    RACTuple *pack1 = RACTuplePack(@"abc", @123, null, nil); //nil会变成RACTupleNil
    id pack2 = [RACTuple tupleWithObjects:@"abc", @123, null, nil]; //最后的nil仅表示结束，不会变成RACTupleNil，必须有，不然crash
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"abc"];
    [array addObject:@123];
    [array addObject:null];
    id pack3 = [RACTuple tupleWithObjectsFromArray:array];
    id pack4 = [RACTuple tupleWithObjectsFromArray:array convertNullsToNils:YES];
    
    RACTupleUnpack(id obj11, id obj12, id obj13, id obj14) = pack1;
    RACTupleUnpack(id obj21, id obj22, id obj23, id obj24) = pack2;
    RACTupleUnpack(id obj31, id obj32, id obj33, id obj34) = pack3;
    RACTupleUnpack(id obj41, id obj42, id obj43, id obj44) = pack4;
    
    id packAppend = [pack1 tupleByAddingObject:@"Append"];
    
    int count = pack1.count;
    id p41 = pack1.first;
    id p42 = pack4[2];
    id p43 = pack4[3];
    id p422 = [pack4 objectAtIndex:2]; //对于RACTupleNil,貌似不同版本的RAC库直接用index取值行为不一样，有的返回nil，有的还是RACTupleNil，unpack都能转成nil
    id p420 = [pack4 objectAtIndex:20];
    
}

- (void)testRacSignal {
    
    [self testPackUnpack];
    
    NSLog(@"lookSignal main thread mainT=%d tip=%p", [NSThread currentThread].isMainThread, [NSThread currentThread]);

    RACSignal *signal1 = [[[[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"lookSignal createSignal1 before %p tid=%p", subscriber, [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"lookSignal createSignal1 after %p tid=%p", subscriber, [NSThread currentThread]);
        [subscriber sendNext:@11];

        [NSThread sleepForTimeInterval:2.0];
        [subscriber sendNext:@12];

//        [NSThread sleepForTimeInterval:2.0];
//        [subscriber sendError:[NSError errorWithDomain:@"KaiError1" code:6 userInfo:(@{@"kaiTestKey": @"ha", @"kaiKey": @88})]];
        [subscriber sendCompleted];
        
//        return nil;
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"lookSignal createSignal1 disposable tid=%p", [NSThread currentThread]);
        }];
        
    }] subscribeOn:[RACScheduler scheduler]] catch:^RACSignal *(NSError *error) {
        NSLog(@"lookSignal createSignal1 catch error=%@ tip=%p", error, [NSThread currentThread]);
        return [RACSignal return:@1];
    }] finally:^{
        //貌似不会触发
        NSLog(@"lookSignal createSignal1 finally tip=%p", [NSThread currentThread]);
    }];

    RACSignal *signal2 = [[[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"lookSignal createSignal2 before %p tid=%p", subscriber, [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"lookSignal createSignal2 after %p tid=%p", subscriber, [NSThread currentThread]);
        [subscriber sendNext:@44];

        [NSThread sleepForTimeInterval:2.0];
        [subscriber sendNext:@45];

//        [NSThread sleepForTimeInterval:2.0];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:[RACScheduler scheduler]] map:^id(id value) {
        NSLog(@"lookSignal createSignal2 map data=%@ tid=%p", value, [NSThread currentThread]);
        return @([value intValue] + 1);
    }];

    RACSignal *signalError = [RACSignal error:[NSError errorWithDomain:@"KaiError" code:666 userInfo:(@{@"kaiTestKey": @"haha", @"kaiKey": @888})]];

    RACSignal *zipSignal = [[[RACSignal zip:@[signal1, signal2, signalError]] subscribeOn:[RACScheduler scheduler]] deliverOnMainThread];

    zipSignal = [zipSignal finally:^{
        NSLog(@"lookSignal zipSignal finally tip=%p", [NSThread currentThread]);
    }];

    zipSignal = [zipSignal catch:^RACSignal *(NSError *error) {
        NSLog(@"lookSignal zipSignal catch error=%@ tip=%p", error, [NSThread currentThread]);
//        return [RACSignal return:@666];
        return [RACSignal error:error];
    }];

    self.disposable = [zipSignal subscribeNext:^(id x) {
//        RACTupleUnpack(id one, id two) = x;
//        NSLog(@"lookSignal zipSignal subscribeNext tid=%p %@ %@", [NSThread currentThread], one, two);
        NSLog(@"lookSignal zipSignal subscribeNext tid=%p %@", [NSThread currentThread], x);
    }];

//    [self.disposable dispose];
}

@end
