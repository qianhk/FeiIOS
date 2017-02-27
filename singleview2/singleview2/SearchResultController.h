//
// Created by kai on 17/2/22.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResultController : UITableViewController <UISearchResultsUpdating>

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys;


@end