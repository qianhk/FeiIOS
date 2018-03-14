//
//  WorkTableViewCell.h
//  singleview2
//
//  Created by kai on 2017/8/8.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *workTitleLabel;
@property (nonatomic, weak) IBOutlet UITextView *moreInfoTextView;
@property (nonatomic, weak) IBOutlet UIImageView *workImageView;

@end
