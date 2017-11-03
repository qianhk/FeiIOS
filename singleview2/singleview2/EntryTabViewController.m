//
// Created by kai on 2017/8/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "EntryTabViewController.h"

#import "TextTableViewCell.h"

@interface EntryTabViewController () {

    NSArray *mEntryArray;
}
@end

@implementation EntryTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }

//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.tableFooterView = [UIView new];

    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;

//    NSLog(@"viewDidLoad iOS8 table view 使用自动布局, 得tableView.estimatedRowHeight != 0, tableView.rowHeight = UITableViewAutomaticDimension 无需重载heightForRowAtIndexPath， 同时还可以通过constraints更新cell子view的高度");
//    self.view.backgroundColor = [UIColor redColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];

    mEntryArray = @[
            @{@"Name": @"LinearLayoutViewController", @"Vc": @"TestLinearLayoutViewController"}
            , @{@"Name": @"StickyCollectionViewController", @"Vc": @"StickyCollectionViewController"}
            , @{@"Name": @"PickerViewController", @"Vc": @"PickerViewController", @"Nib": @"PickerViewController"}
            , @{@"Name": @"UikitTestViewController", @"Vc": @"UikitTestViewController"}
            , @{@"Name": @"UserDefaultsViewController", @"Vc": @"UserDefaultsViewController", @"Nib": @"UserDefaultsViewController"}
            , @{@"Name": @"CustomCollectionViewController", @"Vc": @"CustomCollectionViewController"}
            , @{@"Name": @"MasonryTestViewController", @"Vc": @"MasonryTestViewController"}
            , @{@"Name": @"TestCollectionViewController", @"Vc": @"TestCollectionViewController"}
            , @{@"Name": @"ArtistListViewController", @"Vc": @"ArtistListViewController"}
            , @{@"Name": @"PostTableViewController", @"Vc": @"PostTableViewController"}
            , @{@"Name": @"CoordinatorLayoutTest", @"Vc": @"CoordinatorLayoutTestViewController"}
            , @{@"Name": @"CoordinatorLayoutTestTab", @"Vc": @"CoordinatorLayoutTestTabViewController"}
    ];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mEntryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
    NSDictionary *rowData = mEntryArray[indexPath.row];
    cell.textLabel.text = rowData[@"Name"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath row=%ld %.2f", (long) indexPath.row, UITableViewAutomaticDimension);
//    [tableView deselectRowAtIndexPath:indexPath animated:indexPath.row % 2 == 0];

    NSDictionary *item = mEntryArray[indexPath.row];
    Class clazz = NSClassFromString(item[@"Vc"]);
    UIViewController *vc = [clazz alloc];
    if (vc) {
        NSString *nib = item[@"Nib"];
        if (nib) {
            vc = [vc initWithNibName:nib bundle:nil];
        } else {
            vc = [vc init];
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSString *msgStr = [NSString stringWithFormat:@"名字是: %@", item[@"Vc"]];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示缺失vc" message:msgStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
