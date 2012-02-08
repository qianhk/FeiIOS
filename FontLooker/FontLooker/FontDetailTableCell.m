//
//  FontDetailTableCell.m
//  FontLooker
//
//  Created by HJC on 11-5-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontDetailTableCell.h"


#define kLableHeight    25

static NSString* StringFromFloat(CGFloat value)
{
    NSString* text = [NSString stringWithFormat:@"%0.5lf", value];
    NSArray* array = [text componentsSeparatedByString:@"."];
    if ([array count] >= 2)
    {
        NSString* decimalPart = [array objectAtIndex:1];
        while ([decimalPart hasSuffix:@"0"])
        {
            decimalPart = [decimalPart substringToIndex:[decimalPart length] - 1];
        }
        if ([decimalPart length] == 0)
        {
            return [array objectAtIndex:0];
        }
        return [NSString stringWithFormat:@"%@.%@", [array objectAtIndex:0], decimalPart];
    }
    return text;
}


@implementation FontDetailTableCell
@synthesize font = m_font;

- (void) dealloc
{
    [m_font release];
    [m_familyLabel release];
    [m_pointSizeLabel release];
    [m_ascenderLabel release];
    [m_descenderLabel release];
    [m_capHeightLabel release];
    [m_xHeightLabel release];
    [m_lineHeightLabel release];
    [super dealloc];
}


- (UILabel*) createLabel
{
    UILabel* label = [[[UILabel alloc] init] autorelease];
    label.font = [UIFont systemFontOfSize:13];
    return label;
}


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        m_familyLabel = [[self createLabel] retain];
        
        m_pointSizeLabel = [[self createLabel] retain];
        m_pointSizeLabel.textColor = [UIColor redColor];
        
        m_ascenderLabel = [[self createLabel] retain];
        m_descenderLabel = [[self createLabel] retain];
        
        m_capHeightLabel = [[self createLabel] retain];
        m_xHeightLabel = [[self createLabel] retain];
        m_lineHeightLabel = [[self createLabel] retain];
        
        [self.contentView addSubview:m_familyLabel];
        
          [self.contentView addSubview:m_pointSizeLabel];
         [self.contentView addSubview:m_ascenderLabel];
         [self.contentView addSubview:m_descenderLabel];
     
         [self.contentView addSubview:m_capHeightLabel];
         [self.contentView addSubview:m_xHeightLabel];
         [self.contentView addSubview:m_lineHeightLabel];
    }
    return self;
}


- (void) setFont:(UIFont *)font
{
    if (m_font == font)
    {
        return;
    }
    
    [m_font release];
    m_font = [font retain];
    
    m_familyLabel.text = [NSString stringWithFormat:@"FamilyName: %@", font.familyName];
    
    m_pointSizeLabel.text = [NSString stringWithFormat:@"PointSize: %@", StringFromFloat(font.pointSize)];
    m_ascenderLabel.text = [NSString stringWithFormat:@"Ascender: %@", StringFromFloat(font.ascender)];
    
    m_descenderLabel.text = [NSString stringWithFormat:@"Descender: %@", StringFromFloat(font.descender)];
    m_capHeightLabel.text = [NSString stringWithFormat:@"CapHeight: %@", StringFromFloat(font.capHeight)];
    
    m_xHeightLabel.text = [NSString stringWithFormat:@"xHeight: %@", StringFromFloat(font.xHeight)];
    
    if ([m_font respondsToSelector:@selector(lineHeight)])
    {
        m_lineHeightLabel.text = [NSString stringWithFormat:@"LineHeight: %@", StringFromFloat(font.lineHeight)];
    }
    else
    {
        m_lineHeightLabel.text = [NSString stringWithFormat:@"Leading: %@", StringFromFloat(font.leading)];
    }
    
    [self setNeedsLayout];
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentWidth = CGRectGetWidth(self.contentView.bounds);
    
    CGFloat offsetX = 10;
    CGFloat ypos = 10;
    
    m_familyLabel.frame = CGRectMake(offsetX, ypos, contentWidth - 2 * offsetX, kLableHeight);
    
    CGFloat smallWidth = (contentWidth - 2 * offsetX) / 2;
    ypos += kLableHeight;
    
    m_pointSizeLabel.frame = CGRectMake(offsetX, ypos, smallWidth, kLableHeight);
    m_ascenderLabel.frame = CGRectMake(offsetX + smallWidth, ypos, smallWidth, kLableHeight);
    
    ypos += kLableHeight;
    m_descenderLabel.frame = CGRectMake(offsetX, ypos, smallWidth, kLableHeight);
    m_capHeightLabel.frame = CGRectMake(offsetX + smallWidth, ypos, smallWidth, kLableHeight);
    
    ypos += kLableHeight;
    m_xHeightLabel.frame = CGRectMake(offsetX, ypos, smallWidth, kLableHeight);
    m_lineHeightLabel.frame = CGRectMake(offsetX + smallWidth, ypos, smallWidth, kLableHeight);    
}


+ (CGFloat) suiableHeight
{
    return kLableHeight * 4 + 20;
}


@end
