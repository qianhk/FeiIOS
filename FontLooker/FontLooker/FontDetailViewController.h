//
//  FontDetailViewController.h
//  FontLooker
//
//  Created by HJC on 11-5-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontDetailViewController : UITableViewController 
{
@private
    UIFont*     m_font;
    NSString*   m_text;
    UISlider*   m_fontSizeSlider;
}
@property (nonatomic, retain)   UIFont*     font;
@property (nonatomic, retain)   NSString*   text;
@property (nonatomic, readonly)   UISlider*   fontSizeSlider;

- (id) initWithFont:(UIFont*)font;

- (NSInteger) sectionIndexOfDetail; // override point
- (NSInteger) sectionIndexOfText;   // override point

@end
