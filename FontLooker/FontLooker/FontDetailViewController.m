//
//  FontDetailViewController.m
//  FontLooker
//
//  Created by HJC on 11-5-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontDetailViewController.h"
#import "FontDetailTableCell.h"
#import "FontEditTextController.h"


@implementation FontDetailViewController
@synthesize font = m_font;
@synthesize text = m_text;
@synthesize fontSizeSlider;

- (void) dealloc
{
    [m_font release];
    [m_text release];
    [m_fontSizeSlider release];
    [super dealloc];
}


- (id) initWithFont:(UIFont *)font
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.font = font;
        self.title = NSLocalizedString(@"Font Detail", @"");
        self.text = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789天天动听中华人民共和国";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (UISlider*) fontSizeSlider
{
    if (m_fontSizeSlider == nil)
    {
        m_fontSizeSlider = [[UISlider alloc] init];
        m_fontSizeSlider.minimumValueImage = [UIImage imageNamed:@"littleA.png"];
        m_fontSizeSlider.maximumValueImage = [UIImage imageNamed:@"bigA.png"];
        m_fontSizeSlider.minimumValue = 10;
        m_fontSizeSlider.maximumValue = 40;
        m_fontSizeSlider.value = self.font.pointSize;
        [m_fontSizeSlider addTarget:self 
                             action:@selector(sliderValueChanged:) 
                   forControlEvents:UIControlEventValueChanged];
    }
    return m_fontSizeSlider;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == [self sectionIndexOfDetail])
    {
        return 3;
    }
    else if (section == [self sectionIndexOfText])
    {
        return 1;
    }
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self sectionIndexOfDetail] && indexPath.row == 1)
    {
        return [FontDetailTableCell suiableHeight];
    }
    else if (indexPath.section == [self sectionIndexOfText])
    {
        CGFloat lableWidth = 280;
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
        {
            lableWidth = 650;
        }
        
        UILabel* label = [[[UILabel alloc] init] autorelease];
        label.font = self.font;
        label.text = self.text;
        CGRect labelRect = [label textRectForBounds:CGRectMake(0, 0, lableWidth, FLT_MAX) 
                             limitedToNumberOfLines:0];
        return MAX(44, labelRect.size.height + 30);
    }
    return 44;
}


- (UITableViewCell*) fontDetailCellForTableView:(UITableView *)tableView
{
    static NSString* identifier = @"FontDetailCellId";
    FontDetailTableCell* cell = (FontDetailTableCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil || ![cell isKindOfClass:[FontDetailTableCell class]])
    {
        cell = [[[FontDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:identifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.font = self.font;
    return cell;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString* identifier = @"CellId";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier] autorelease];
    }
    
    cell.textLabel.text = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.fontSizeSlider.superview == cell.contentView)
    {
        [self.fontSizeSlider removeFromSuperview];
    }
    
    if (indexPath.section == [self sectionIndexOfDetail])
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = self.font.fontName;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        }
        else if (indexPath.row == 1)
        {
            return [self fontDetailCellForTableView:tableView];
        }
        else if (indexPath.row == 2)
        {
            CGRect rect = cell.contentView.bounds;
            rect.origin.x += 10;
            rect.size.width -= 20;
            self.fontSizeSlider.frame = rect;
            self.fontSizeSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [cell.contentView addSubview:self.fontSizeSlider];
        }
    }
    else if (indexPath.section == [self sectionIndexOfText])
    {
        cell.textLabel.text = self.text;
        cell.textLabel.font = self.font;
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self sectionIndexOfText])
    {
        FontEditTextController* aController = [[[FontEditTextController alloc] init] autorelease];
        aController.textView.font = self.font;
        aController.textView.text = self.text;
        
        UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"") 
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(editTextCancelItemPressed:)];
        aController.navigationItem.leftBarButtonItem = cancelItem;
        [cancelItem release];
        
        
        UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"") 
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(editTextDoneItemPressed:)];
        aController.navigationItem.rightBarButtonItem = doneItem;
        [doneItem release];
        
        UINavigationController* navigation = [[[UINavigationController alloc] 
                                               initWithRootViewController:aController] autorelease];
        [self presentModalViewController:navigation animated:YES];        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) editTextCancelItemPressed:(UIBarButtonItem*)buttonItem
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void) editTextDoneItemPressed:(UIBarButtonItem*)buttonItem
{
    if ([self.modalViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigation = (UINavigationController*)self.modalViewController;
        if ([navigation.topViewController isKindOfClass:[FontEditTextController class]])
        {
            FontEditTextController* aController = (FontEditTextController*)navigation.topViewController;
            self.text = aController.textView.text;
            NSArray* array = [NSArray arrayWithObject:
                              [NSIndexPath indexPathForRow:0 inSection:[self sectionIndexOfText]]];
            [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark
#pragma mark 
- (void) sliderValueChanged:(UISlider*)slider
{
    self.font = [self.font fontWithSize:slider.value];
    NSArray* array = [NSArray arrayWithObjects:
                      [NSIndexPath indexPathForRow:1 inSection:[self sectionIndexOfDetail]],
                      [NSIndexPath indexPathForRow:0 inSection:[self sectionIndexOfText]], nil];
    [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
}


- (NSInteger) sectionIndexOfDetail // override point
{
    return 0;
}

- (NSInteger) sectionIndexOfText   // override point
{
    return 1;
}

@end
