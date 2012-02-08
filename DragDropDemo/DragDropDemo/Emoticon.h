//
//  Emoticon.h
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Emoticon : UIButton
{
    NSInteger       iconIndex;
    Emoticon        *clone;
    BOOL            isDraging;
}
@property (assign, nonatomic)   NSInteger       iconIndex;
@property (assign, nonatomic)   UIScrollView    *scrollView;
@property (assign, nonatomic)   UIView          *parentView;
@property (retain, nonatomic)   Emoticon        *clone;

- (void)cleanClone;
- (void)postNotification: (BOOL)drag;
- (void)onEmotionPressed: (id)sender;

+ (Emoticon *)getEmoticonFromIndex: (int)index;

@end
