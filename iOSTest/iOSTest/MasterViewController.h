//
//  MasterViewController.h
//  iOSTest
//
//  Created by kai on 17/2/6.
//  Copyright © 2017年 njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (nonatomic, weak) DetailViewController *detailViewController;

@end

