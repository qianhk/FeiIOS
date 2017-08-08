//
// Created by kai on 2017/8/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "ArtistListViewController.h"
#import "TextTableViewCell.h"
#import "ArtistData.h"
#import "ArtistDetailViewController.h"
#import "ArtistTableViewCell.h"

@interface ArtistListViewController () {

    NSArray<Artist*> *mArtistList;
}


@end

@implementation ArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor orangeColor];

    UIEdgeInsets oriInsets = self.tableView.separatorInset; //left 15 , other 0
    self.tableView.separatorInset = UIEdgeInsetsZero;

    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

//    NSLog(@"viewDidLoad iOS8 table view 使用自动布局, 得tableView.estimatedRowHeight != 0, tableView.rowHeight = UITableViewAutomaticDimension 无需重载heightForRowAtIndexPath， 同时还可以通过constraints更新cell子view的高度");
//    self.view.backgroundColor = [UIColor redColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"ArtistTableViewCell" bundle:nil] forCellReuseIdentifier:@"ArtistTableViewCell"];

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"artists.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:finalPath];
    if (jsonData == nil) {
        NSLog(@"json data empty \r\n");
        return;
    }
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (dictionary == nil) {
        NSLog(@"json parse failed \r\n");
        return;
    }

    NSMutableArray *mutableArtistList = [NSMutableArray array];
    NSArray* jsonArtistList = dictionary[@"artists"];
    [jsonArtistList enumerateObjectsUsingBlock:^(NSDictionary *artistDic, NSUInteger idx, BOOL *stop) {
        Artist *artist = [Artist new];
        artist.name = artistDic[@"name"];
        artist.bio = artistDic[@"bio"];
        artist.image = artistDic[@"image"];
        artist.image = artistDic[@"image"];
        NSMutableArray *workList = [NSMutableArray array];
        [artistDic[@"works"] enumerateObjectsUsingBlock:^(NSDictionary *workDic, NSUInteger idx, BOOL *stop) {
            Work *work = [Work new];
            work.image = workDic[@"image"];
            work.title = workDic[@"title"];
            work.info = workDic[@"info"];
            [workList addObject:work];
        }];
        artist.workList = [NSArray arrayWithArray:workList];
        [mutableArtistList addObject:artist];
    }];
    mArtistList = [NSArray arrayWithArray:mutableArtistList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mArtistList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArtistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistTableViewCell"];
    Artist *artist = mArtistList[indexPath.row];
    cell.bioLabel.text = artist.bio;

    cell.artistImageView.image = [UIImage imageNamed:artist.image];
    cell.nameLabel.text = artist.name;
    cell.nameLabel.backgroundColor = [UIColor colorWithRed:1 green:152/255 blue:0 alpha:1];
    cell.nameLabel.textColor = [UIColor whiteColor];
    cell.nameLabel.textAlignment = NSTextAlignmentCenter;

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

    Artist *item = mArtistList[indexPath.row];
    ArtistDetailViewController *controller = [[ArtistDetailViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.artist = item;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
