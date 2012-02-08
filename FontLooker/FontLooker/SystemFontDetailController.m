//
//  SystemFontDetailController.m
//  FontLooker
//
//  Created by HJC on 11-5-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SystemFontDetailController.h"


@implementation SystemFontDetailController
@synthesize segmentedControl = m_segmentedControl;


- (void) dealloc
{
    [m_segmentedControl release];
    [super dealloc];
}


- (id) initWithFont:(UIFont *)font
{
    self = [super initWithFont:font];
    if (self)
    {
        self.title = NSLocalizedString(@"System Font", @"");
    }
    return self;
}


- (UISegmentedControl*) segmentedControl
{
    if (m_segmentedControl == nil)
    {
        NSArray* array = [NSArray arrayWithObjects:
                          NSLocalizedString(@"Normal", @""),
                          NSLocalizedString(@"Bold", @""),
                          NSLocalizedString(@"Italic", @""), nil];
        m_segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
        m_segmentedControl.selectedSegmentIndex = 0;
        [m_segmentedControl addTarget:self
                               action:@selector(segmentedControlValueChanged:)
                     forControlEvents:UIControlEventValueChanged];
    }
    return m_segmentedControl;
}


- (NSInteger) sectionIndexOfDetail
{
    return 1;
}

- (NSInteger) sectionIndexOfText
{
    return 2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:nil] autorelease];
        cell.backgroundView = [[[UIView alloc] init] autorelease];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        [self.segmentedControl removeFromSuperview];
        
        self.segmentedControl.frame = cell.contentView.bounds;
        [cell.contentView addSubview:self.segmentedControl];
        self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (void) segmentedControlValueChanged:(UISegmentedControl*)segmentedControl
{
    CGFloat pointSize = self.font.pointSize;
    if (segmentedControl.selectedSegmentIndex == 0)
    {
        self.font = [UIFont systemFontOfSize:pointSize];
    }
    else if (segmentedControl.selectedSegmentIndex == 1)
    {
        self.font = [UIFont boldSystemFontOfSize:pointSize];
    }
    else if (segmentedControl.selectedSegmentIndex == 2)
    {
        self.font = [UIFont italicSystemFontOfSize:pointSize];
    }
    NSRange range = { 1, 2 };
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:range]
                  withRowAnimation:UITableViewRowAnimationNone];
}



@end
