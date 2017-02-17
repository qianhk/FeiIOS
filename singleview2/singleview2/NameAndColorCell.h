//
//  NameAndColorCellTableViewCell.h
//  singleview2
//
//  Created by 钱红凯 on 17/2/15.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameAndColorCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *color;

@end
