//
// Created by kai on 17/3/2.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LanguageListController : UITableViewController

@property (nonatomic, weak) DetailViewController *detailViewController;

@property (nonatomic, copy) NSString *selectedStr;

@end
