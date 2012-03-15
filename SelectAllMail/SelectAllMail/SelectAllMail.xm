#import <UIKit/UIKit.h>

UIBarButtonItem *selectAllButton;
static BOOL selectedAll=NO;

@interface MailboxContentViewController : UIViewController
- (id)currentTableView;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didDeselectRowAtIndexPath:(id)arg2;
@end

%hook MailboxContentViewController

%new(v@:)
-(void)toggleSelectAll
{
    selectedAll = !selectedAll;
    [selectAllButton setTitle:(selectedAll?@"全部取消":@"全部选择")];

	UITableView* tablev = [self currentTableView];
	NSInteger nSection = [tablev numberOfSections];
	id <UITableViewDelegate>   tDelegate = tablev.delegate;
	NSLog(@"qhk SelectALlMail: currentTableView %@ nSection=%d delegate=%@", tablev, nSection, tDelegate);
	[tablev beginUpdates];
	for (NSInteger idxSec = 0; idxSec < nSection; ++idxSec)
	{
		NSInteger nRowInSec = [tablev numberOfRowsInSection:idxSec];
		for (NSInteger idxRow = 0; idxRow < nRowInSec; ++idxRow)
		{
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:idxRow inSection:idxSec];
			if (selectedAll)
			{
				[tablev selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
				[tDelegate tableView:tablev didSelectRowAtIndexPath:indexPath];
			}
			else
			{
				[tablev deselectRowAtIndexPath:indexPath animated:NO];
				[tDelegate tableView:tablev didDeselectRowAtIndexPath:indexPath];
			}
		}
	}
	[tablev endUpdates];
//	[tablev setNeedsDisplay];
//	NSLog(@"qhk SelectAllMail abc");
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
//- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

-(void)_setInEditMode:(BOOL)edit animated:(BOOL)animated
{
    if (edit)
    {
        selectAllButton = [[UIBarButtonItem alloc] initWithTitle:@"全部选择" style:UIBarButtonItemStylePlain target:self action:@selector(toggleSelectAll)];
        [[self navigationItem] setLeftBarButtonItem:selectAllButton animated:NO];
		selectedAll = NO;
    }
	else
	{
        [[self navigationItem] setLeftBarButtonItem:nil animated:NO];
        [selectAllButton release];
    }
    
    %orig(edit,animated);
}

%end