//
//  FontLookerViewController.m
//  FontLooker
//
//  Created by HJC on 11-5-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontLookerViewController.h"
#import "FontDetailViewController.h"
#import "SystemFontDetailController.h"

@implementation FontLookerViewController
@synthesize familyRecords = m_familyRecords;
@synthesize filterFamilyRecords = m_filterFamilyRecords;


- (void) dealloc
{
    [m_familyRecords release];
    [m_filterFamilyRecords release];
    [super dealloc];
}


- (id) init
{
    return [super initWithNibName:@"FontLookerViewController" bundle:nil];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.familyRecords = [FontFamilyRecord listAllFamilyRecords];
    self.tableView.rowHeight = 60;
    self.title = NSLocalizedString(@"All Font", @"");
    
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"Family Name", @"");
    self.searchDisplayController.searchResultsTableView.rowHeight = 60;
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"System", @"") 
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(systemButtonItemPressed:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
}


- (NSArray*) suiableFamilyForTable:(UITableView*)tableView
{
    if (self.tableView == tableView)
    {
        return self.familyRecords;
    }
    return self.filterFamilyRecords;
}


#pragma mark
#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView != self.tableView)
    {
        return nil;
    }
    
    NSString* lastString = @"";
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:27];
    [array addObject:UITableViewIndexSearch];
    
    for (FontFamilyRecord* record in self.familyRecords)
    {
        NSString* tmpString = [[record.name substringToIndex:1] uppercaseString];
        if (![tmpString isEqualToString:lastString])
        {
            if ([array count] >= 27)
            {
                [array addObject:@"#"];
                break;
            }
            lastString = tmpString;
            [array addObject:lastString];
        }
    }
    
    return array;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{    
    if (index == 0) 
	{
		[tableView scrollRectToVisible:[[tableView tableHeaderView] bounds] animated:NO];
		return -1;
	}
    
    NSInteger section = 0;
    for (FontFamilyRecord* record in self.familyRecords)
    {
        NSString* tmpString = [[record.name substringToIndex:1] uppercaseString];
        if ([tmpString isEqualToString:title])
        {
            return section;
        }
        section++;
    }
    return [self.familyRecords count] - 1;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self suiableFamilyForTable:tableView] count];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    FontFamilyRecord* record = [[self suiableFamilyForTable:tableView] objectAtIndex:section];
    return record.name;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FontFamilyRecord* record = [[self suiableFamilyForTable:tableView] objectAtIndex:section];
    return [record.fontNames count];
}

NSString* const TestText = @"abc&ABC123@天天动听凯!";

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"CellId";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier] autorelease];
		UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, cell.bounds.size.width - 40, 35)];
		label1.tag = 666;
		label1.backgroundColor = [UIColor clearColor];
		label1.adjustsFontSizeToFitWidth = YES;
		label1.minimumFontSize = 18;
		
		UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, cell.bounds.size.width - 40, 20)];
		label2.tag = 667;
		label2.backgroundColor = [UIColor clearColor];
		label2.font = [UIFont systemFontOfSize:14];
		label2.adjustsFontSizeToFitWidth = YES;
		label2.textColor = [UIColor lightGrayColor];
		label2.minimumFontSize = 10;
		
		[cell addSubview:label1];
		[cell addSubview:label2];
    }
    
    FontFamilyRecord* record = [[self suiableFamilyForTable:tableView] objectAtIndex:indexPath.section];
    NSString* fontName = [record.fontNames objectAtIndex:indexPath.row];
    
	UILabel* label1 = (UILabel *)[cell viewWithTag:666];
    label1.font = [UIFont fontWithName:fontName size:20];
    label1.text = TestText;
	
	UILabel* label2 = (UILabel *)[cell viewWithTag:667];
    label2.text = fontName;
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FontFamilyRecord* record = [[self suiableFamilyForTable:tableView] objectAtIndex:indexPath.section];
    NSString* fontName = [record.fontNames objectAtIndex:indexPath.row];
    UIFont* font = [UIFont fontWithName:fontName size:20];
    
    FontDetailViewController* aController = [[FontDetailViewController alloc] initWithFont:font];
    [self.navigationController pushViewController:aController animated:YES];
    [aController release];
}


#pragma mark
#pragma mark UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
    shouldReloadTableForSearchString:(NSString *)searchString
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
    searchString = [searchString lowercaseString];
    
    for (FontFamilyRecord* record in self.familyRecords)
    {
        NSString* name = record.name;
        name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
        name = [name lowercaseString];
        if ([name rangeOfString:searchString].location != NSNotFound)
        {
            [array addObject:record];
        }
    }
    self.filterFamilyRecords = array;
    
    return YES;
}


- (void) systemButtonItemPressed:(UIBarButtonItem*)buttonItem
{
    UIFont* font = [UIFont systemFontOfSize:20];
    SystemFontDetailController* aController = [[SystemFontDetailController alloc] initWithFont:font];
    [self.navigationController pushViewController:aController animated:YES];
    [aController release];
}


@end
