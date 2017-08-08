//
// Created by kai on 2017/8/8.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "ArtistData.h"
#import "TextTableViewCell.h"
#import "WorkTableViewCell.h"

@interface ArtistDetailViewController ()


@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.title = self.artist.name;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;

    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

//    NSLog(@"viewDidLoad iOS8 table view 使用自动布局, 得tableView.estimatedRowHeight != 0, tableView.rowHeight = UITableViewAutomaticDimension 无需重载heightForRowAtIndexPath， 同时还可以通过constraints更新cell子view的高度");
//    self.view.backgroundColor = [UIColor redColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"WorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkTableViewCell"];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artist.workList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkTableViewCell"];
    Work *work = self.artist.workList[indexPath.row];

    cell.workTitleLabel.text = work.title;
    cell.workImageView.image = [UIImage imageNamed:work.image];
    cell.workTitleLabel.backgroundColor = [UIColor colorWithWhite:204.f/255 alpha:1.f];
    cell.workTitleLabel.textAlignment = NSTextAlignmentCenter;
    cell.moreInfoTextView.textColor = [UIColor colorWithWhite:114.f/255 alpha:1.f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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

    Work *work = self.artist.workList[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end