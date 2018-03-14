//
//  ArtistTableViewCell.h
//  singleview2
//
//  Created by kai on 2017/8/8.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *bioLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *artistImageView;

@end
