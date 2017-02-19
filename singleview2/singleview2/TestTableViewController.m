//
//  ViewController.m
//  singleview2
//
//  Created by hongkai.qian on 12-2-27.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import "TestTableViewController.h"
#import "NameAndColorCell.h"

#define KTTMessagePort "com.ttpod.ttdesktop.port2"

//static CFMessagePortRef messagePort = NULL;
//static int callbacktimes = 0;
//static ViewController * pView = nil;

@interface TestTableViewController () {
    NSArray *mDataArray;
    NSArray *mColorDataArray;
//    UILabel *lblStatus;
}

@end;

@implementation TestTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//- (void)dealloc
//{
////	[lblStatus release];
////	CFMessagePortInvalidate(messagePort);
////	CFRelease(messagePort);
//
////    [_tableView release];
////	[super dealloc];
//}

#pragma mark - View lifecycle



//static CFDataRef messagePortCallBack(CFMessagePortRef local, SInt32 msgid, CFDataRef data, void *info)
//{
//	++callbacktimes;
//	int datalen = CFDataGetLength(data);
//	NSMutableString* str = [NSMutableString stringWithFormat:@"%d msgid=%d, data=%08X len=%d str=", callbacktimes, msgid, data, datalen];
//	const UInt8* pData = CFDataGetBytePtr(data);
//	for (int idx = 0; idx < datalen && idx < 100; ++idx)
//	{
//		[str appendFormat:@"%c", pData[idx]];
//	}
//	[pView setLabel:str];
//
//	return NULL;
//}

//- (void)setLabel:(NSString *)text {
//    lblStatus.text = text;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    lblStatus = [[UILabel alloc] initWithFrame:self.view.frame];
//    lblStatus.backgroundColor = [UIColor clearColor];
//    lblStatus.textColor = [UIColor blackColor];
//    lblStatus.font = [UIFont systemFontOfSize:12.0f];
//    lblStatus.numberOfLines = 0;
//
//    [self.view addSubview:lblStatus];

//	pView = self;
//	messagePort = CFMessagePortCreateLocal(kCFAllocatorDefault, CFSTR(KTTMessagePort), messagePortCallBack, NULL, NULL);
//	if (messagePort == NULL)
//	{
//		NSLog(@"qhk: singleview2 CFMessagePortCreateLocal failed");
//		return;
//	}
//	CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, messagePort, 0);
//	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);

    mDataArray = @[@"Kai1", @"Kai2", @"Kai3", @"Kai4"];
    
    mColorDataArray = @[@{@"Name" : @"Kai1", @"Color": @"Orange"}
                        , @{@"Name" : @"Kai2", @"Color": @"Red"}
                        , @{@"Name" : @"Kai3", @"Color": @"Green"}
                        , @{@"Name" : @"Kai4", @"Color": @"Blue"}];
    
//    [self.tableView registerClass:[NameAndColorCell class] forCellReuseIdentifier:@"CellTableIdentifier"];
    UINib *nameAndColorCellNib = [UINib nibWithNibName:@"NameAndColorCell2" bundle:nil];
    [self.tableView registerNib:nameAndColorCellNib forCellReuseIdentifier:@"CellTableIdentifier"];

//    self.tableView.delegate = self; //基类是uitableview则无需设置delete、datasource
//    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor magentaColor];

//    self.tableView.rowHeight = 80;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    CGRect originFrame = self.view.frame;
//    self.view.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20);
    
//    NSLog(@"viewDidLoad iOS8 table view 使用自动布局, 得tableView.estimatedRowHeight != 0, tableView.rowHeight = UITableViewAutomaticDimension 无需重载heightForRowAtIndexPath， 同时还可以通过constraints更新cell子view的高度");
    self.view.backgroundColor = [UIColor redColor];
    
//    self.view.bounds = [self getContentViewFrame];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mColorDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    cell.textLabel.text = mDataArray[indexPath.row];
//    return cell;
    
    NameAndColorCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier"];
    NSDictionary *rowData = mColorDataArray[indexPath.row];
    cell.name = rowData[@"Name"];

    NSString *colorStr = rowData[@"Color"];
    cell.color = colorStr;

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    NSInteger row = indexPath.row;
////    if (row == 0) {
////        return 60.f;
////    } else {
////        return 30.f;
////    }
//    
//    return UITableViewAutomaticDimension;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20 - 44);
}

@end
