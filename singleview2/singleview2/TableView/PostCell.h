//
//  PostCell.h
//  singleview2
//
//  Created by kai on 2017/8/15.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (void)configWithModel:(Post *)post;
@end
