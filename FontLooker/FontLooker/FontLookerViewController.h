//
//  FontLookerViewController.h
//  FontLooker
//
//  Created by HJC on 11-5-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontFamilyRecord.h"


@interface FontLookerViewController : UITableViewController<UISearchDisplayDelegate>
{
@private
    NSArray*    m_familyRecords;        // 全部的字体
    NSArray*    m_filterFamilyRecords;  // 搜索结果
}

@property (nonatomic, retain)   NSArray*    familyRecords;
@property (nonatomic, retain)   NSArray*    filterFamilyRecords;

@end
