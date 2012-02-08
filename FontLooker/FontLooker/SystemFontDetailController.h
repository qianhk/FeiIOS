//
//  SystemFontDetailController.h
//  FontLooker
//
//  Created by HJC on 11-5-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontDetailViewController.h"


@interface SystemFontDetailController : FontDetailViewController
{
@private
    UISegmentedControl* m_segmentedControl;
}
@property (nonatomic, readonly) UISegmentedControl* segmentedControl;
@end
