//
//  FontDetailTableCell.h
//  FontLooker
//
//  Created by HJC on 11-5-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontDetailTableCell : UITableViewCell 
{ 
@private
    UIFont*     m_font;
    UILabel*    m_familyLabel;
    UILabel*    m_pointSizeLabel;
    UILabel*    m_ascenderLabel;
    UILabel*    m_descenderLabel;
    UILabel*    m_capHeightLabel;
    UILabel*    m_xHeightLabel;
    UILabel*    m_lineHeightLabel;
}
@property (nonatomic, retain)   UIFont* font;

+ (CGFloat) suiableHeight;
   
@end
