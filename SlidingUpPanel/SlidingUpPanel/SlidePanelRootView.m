//
//  SlidePanelRootView.m
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-14.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "SlidePanelRootView.h"

@implementation SlidePanelRootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		NSLog(@"SlidePanelRootView initWithFrame:%@", NSStringFromCGRect(frame));
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
	[super layoutSubviews];
	NSLog(@"layoutSubviews %@", NSStringFromCGRect(self.frame));
}

@end
