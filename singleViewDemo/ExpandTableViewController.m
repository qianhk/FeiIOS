//
//  ExpandTableViewController.m
//  singleViewDemo
//
//  Created by TTKai on 13-10-9.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "ExpandTableViewController.h"

@interface ExpandTableViewController ()
{
	NSMutableArray *_dataList;
}

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)UITableView *expansionTableView;

@end

@implementation ExpandTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.expansionTableView = self.tableView;
	
	NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData" ofType:@"plist"];
    _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@",path);
    
    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
}

@synthesize isOpen,selectIndex;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 0;
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[_dataList objectAtIndex:section] objectForKey:@"list"] count]+1;;
        }
    }
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
//        static NSString *CellIdentifier = @"Cell2";
//        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//        }
//        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
//        cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
//        return cell;
//    }else
//    {
//        static NSString *CellIdentifier = @"Cell1";
//        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//        }
//        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"name"];
//        cell.titleLabel.text = name;
//        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
//        return cell;
//    }
	return nil;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else
    {
//        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
//        NSArray *list = [dic objectForKey:@"list"];
//        NSString *item = [list objectAtIndex:indexPath.row-1];
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil] autorelease];
//        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
//    self.isOpen = firstDoInsert;
//    
//    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
//    [cell changeArrowWithUp:firstDoInsert];
//    
//    [self.expansionTableView beginUpdates];
//    
//    int section = self.selectIndex.section;
//    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
//	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
//	for (NSUInteger i = 1; i < contentCount + 1; i++) {
//		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
//		[rowToInsert addObject:indexPathToInsert];
//	}
//	
//	if (firstDoInsert)
//    {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//	else
//    {
//        [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
//    }
//    
//	[rowToInsert release];
//	
//	[self.expansionTableView endUpdates];
//    if (nextDoInsert) {
//        self.isOpen = YES;
//        self.selectIndex = [self.expansionTableView indexPathForSelectedRow];
//        [self didSelectCellRowFirstDo:YES nextDo:NO];
//    }
//    if (self.isOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
