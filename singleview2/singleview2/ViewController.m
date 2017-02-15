//
//  ViewController.m
//  singleview2
//
//  Created by hongkai.qian on 12-2-27.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import "ViewController.h"

#define KTTMessagePort "com.ttpod.ttdesktop.port2"

//static CFMessagePortRef messagePort = NULL;
//static int callbacktimes = 0;
//static ViewController * pView = nil;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *mDataArray;
//    UILabel *lblStatus;
}

@end;

@implementation ViewController

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

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor magentaColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = mDataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        return 60.f;
    } else {
        return 30.f;
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
