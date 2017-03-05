//
//  ViewController.m
//  singleview2
//
//  Created by hongkai.qian on 12-2-27.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#import "NormalTableViewController.h"
#import "NameAndColorCell.h"
#import "PickerViewController.h"
#import "TestCollectionViewController.h"
#import "UserDefaultsViewController.h"

#define KTTMessagePort "com.ttpod.ttdesktop.port2"

//static CFMessagePortRef messagePort = NULL;
//static int callbacktimes = 0;
//static ViewController * pView = nil;

@interface NormalTableViewController () {
//    NSArray *mDataArray;
    NSMutableArray *mColorDataArray;
//    UILabel *lblStatus;
}

@end;

@implementation NormalTableViewController

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

//    mDataArray = @[@"Kai1", @"Navigation Test", @"Kai3", @"Kai4"];

    mColorDataArray = [[NSMutableArray alloc] initWithArray:
                       @[@{@"Name": @"Kai1", @"Color": @"Orange"}, @{@"Name": @"Kai2", @"Color": @"Red"}, @{@"Name": @"Kai3", @"Color": @"Green"}, @{@"Name": @"Kai4", @"Color": @"Blue"}, @{@"Name": @"User Defaults", @"Color": @"Yellow"}]];

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

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    NameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier"];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView commitEditingStyle %d row=%d", editingStyle, indexPath.row);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [mColorDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return nil;
//    } else if (indexPath.row == 2) {
//        return [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
    } else {
        return indexPath;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"moveRowAtIndexPath sourceRow=%ld destRow=%ld", (long)sourceIndexPath.row, (long)destinationIndexPath.row);
    id obj = mColorDataArray[sourceIndexPath.row];
    [mColorDataArray removeObjectAtIndex:sourceIndexPath.row];
    [mColorDataArray insertObject:obj atIndex:destinationIndexPath.row];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (CGRect)getContentViewFrame {
    CGRect originFrame = self.view.frame;
    return CGRectMake(originFrame.origin.x, originFrame.origin.y + 20, originFrame.size.width, originFrame.size.height - 20 - 44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath row=%ld %.2f", (long)indexPath.row, UITableViewAutomaticDimension);
    [tableView deselectRowAtIndexPath:indexPath animated:indexPath.row % 2 == 0];

    switch (indexPath.row) {
        case 1:
            [self.navigationController pushViewController:[[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil] animated:YES];
            break;

        case 2:
            [self.navigationController pushViewController:[[NormalTableViewController alloc] init] animated:YES];
            break;

        case 3:
            [self.navigationController pushViewController:[[TestCollectionViewController alloc] init] animated:YES];
            break;
            
        case 4:
            [self.navigationController pushViewController:[[UserDefaultsViewController alloc] init] animated:YES];
            break;
    }
}


@end
