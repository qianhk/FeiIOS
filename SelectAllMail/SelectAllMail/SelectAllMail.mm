#line 1 "/OnGitHub/FeiIOS/SelectAllMail/SelectAllMail/SelectAllMail.xm"
#import <UIKit/UIKit.h>

UIBarButtonItem *selectAllButton;
static BOOL selectedAll=NO;

@interface MailboxContentViewController : UIViewController
- (id)currentTableView;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didDeselectRowAtIndexPath:(id)arg2;
@end

#include <substrate.h>
@class MailboxContentViewController; 
static void _logos_method$_ungrouped$MailboxContentViewController$toggleSelectAll(MailboxContentViewController*, SEL); static void (*_logos_orig$_ungrouped$MailboxContentViewController$_setInEditMode$animated$)(MailboxContentViewController*, SEL, BOOL, BOOL); static void _logos_method$_ungrouped$MailboxContentViewController$_setInEditMode$animated$(MailboxContentViewController*, SEL, BOOL, BOOL); 

#line 12 "/OnGitHub/FeiIOS/SelectAllMail/SelectAllMail/SelectAllMail.xm"




static void _logos_method$_ungrouped$MailboxContentViewController$toggleSelectAll(MailboxContentViewController* self, SEL _cmd) {
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


}







static void _logos_method$_ungrouped$MailboxContentViewController$_setInEditMode$animated$(MailboxContentViewController* self, SEL _cmd, BOOL edit, BOOL animated) {
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
    
    _logos_orig$_ungrouped$MailboxContentViewController$_setInEditMode$animated$(self, _cmd, edit,animated);
}


static __attribute__((constructor)) void _logosLocalInit() {
#ifdef __clang__
#if __has_feature(objc_arc)
@autoreleasepool {
#else
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
#else
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
{Class _logos_class$_ungrouped$MailboxContentViewController = objc_getClass("MailboxContentViewController"); { const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$MailboxContentViewController, @selector(toggleSelectAll), (IMP)&_logos_method$_ungrouped$MailboxContentViewController$toggleSelectAll, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$MailboxContentViewController, @selector(_setInEditMode:animated:), (IMP)&_logos_method$_ungrouped$MailboxContentViewController$_setInEditMode$animated$, (IMP*)&_logos_orig$_ungrouped$MailboxContentViewController$_setInEditMode$animated$);}  
#ifdef __clang__
#if __has_feature(objc_arc)
}
#else
[pool drain];
#endif
#else
[pool drain];
#endif
}
#line 71 "/OnGitHub/FeiIOS/SelectAllMail/SelectAllMail/SelectAllMail.xm"
