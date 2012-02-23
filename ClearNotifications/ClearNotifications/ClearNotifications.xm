#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>
#import "SpringBoard.h"

%config(generator=internal)

%hook SBAwayBulletinListController

static BBBulletinRequest *bulletin;

// Add our bulletin when the first real bulletin comes in
- (void)_updateModelAndTableViewForAddition:(SBAwayBulletinListItem *)listItem
{
	%orig;
	NSMutableArray *_listItems = CHIvar(self, _listItems, NSMutableArray *);
	if ([_listItems count] == 1) {
		if (!bulletin) {
			bulletin = [[%c(BBBulletinRequest) alloc] init];
			bulletin.title = @"Clear Notifications";
			//bulletin.message = @"message";
			bulletin.sectionID = @"com.apple.preferences";
			bulletin.defaultAction = [%c(BBAction) actionWithLaunchURL:[NSURL URLWithString:@"http://rpetri.ch/null"] callblock:nil];
			bulletin.bulletinID = @"ClearAllBulletin";
			bulletin.unlockActionLabelOverride = @"clear all";
			bulletin.date = [NSDate distantPast];
			bulletin.lastInterruptDate = [NSDate date];
		}
		[self observer:CHIvar(self, _observer, BBObserver *) addBulletin:bulletin forFeed:0];
	}
}

// Sort so we're always on top
- (void)_sortListItems
{
	%orig;
	if (bulletin) {
		SBAwayBulletinListItem *listItem = [self _listItemContainingBulletinID:bulletin.bulletinID];
		if (listItem) {
			NSMutableArray *_listItems = CHIvar(self, _listItems, NSMutableArray *);
			NSUInteger index = [_listItems indexOfObjectIdenticalTo:listItem];
			if ((index != NSNotFound) && (index != 0)) {
				listItem = [listItem retain];
				[_listItems removeObjectAtIndex:index];
				[_listItems insertObject:listItem atIndex:0];
				[listItem release];
			}
		}
	}
}

// Remove our clear all bulletin when it's the last one left
- (void)_updateModelAndTableViewForRemoval:(id)removal originalHeight:(CGFloat)originalHeight
{
	%orig;
	if (bulletin) {
		NSMutableArray *_listItems = CHIvar(self, _listItems, NSMutableArray *);
		if ([_listItems count] == 1) {
			[self observer:CHIvar(self, _observer, BBObserver *) removeBulletin:bulletin];
		}
	}
}

// Force the date label to be empty
- (UITableViewCell *)tableView:(UITableView *)view cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ((indexPath.row == 0) && (indexPath.section == 0)) {
		UITableViewCell *cell = %orig;
		for (UIView *view in cell.contentView.subviews) {
			if ([view isKindOfClass:%c(SBBulletinCellContentViewBase)]) {
				[(SBBulletinCellContentViewBase *)view dateLabel].text = @"";
			}
		}
		return cell;
	}
	return %orig;
}

// Don't allow our custom bulletin to be the unlock context
- (void)setUnlockActionContext:(SBAwayListUnlockActionContext *)context
{
	if (bulletin && [context.bulletinID isEqualToString:bulletin.bulletinID]) {
		for (SBAwayBulletinListItem *listItem in CHIvar(self, _listItems, NSMutableArray *)) {
			if ([listItem respondsToSelector:@selector(activeBulletin)]) {
				BBBulletin *b = [listItem activeBulletin];
				if (b != bulletin) {
					context = [%c(SBAwayListUnlockActionContext) unlockActionContextForBulletin:b];
					break;
				}
			}
		}
	}
	%orig;
}

%end

%hook SBAwayBulletinListItem

// Force our custom image
- (UIImage *)iconImage
{
	if (bulletin && ([self activeBulletin] == bulletin)) {
		static UIImage *image;
		if (!image) {
			if ([UIScreen mainScreen].scale != 1.0f)
				image = [[UIImage alloc] initWithContentsOfFile:@"/Applications/Preferences.app/notifications_icon@2x.png"];
			else
				image = [[UIImage alloc] initWithContentsOfFile:@"/Applications/Preferences.app/notifications_icon.png"];
		}
		if (image) {
			UIImage **_listItemImage = CHIvarRef(self, _listItemImage, UIImage *);
			if (*_listItemImage != image) {
				[*_listItemImage release];
				*_listItemImage = [image retain];
			}
		}
	}
	return %orig;
}

%end

%hook SBAwayBulletinCell

static NSInteger slideBackStatus;

// Force clear all notifications
- (void)lockBarUnlocked:(id)lockBar
{
	SBAwayListUnlockActionContext *actionContext = self.actionContext;
	if (bulletin && [actionContext.bulletinID isEqualToString:bulletin.bulletinID]) {
		SBAwayBulletinListController *controller = [[[%c(SBAwayController) sharedAwayController] awayView] bulletinController];
		if (controller) {
			BBObserver *observer = CHIvar(controller, _observer, BBObserver *);
			NSArray *listItems = [CHIvar(controller, _listItems, NSMutableArray *) copy];
			for (SBAwayBulletinListItem *listItem in listItems) {
				NSArray *bulletins = [[listItem bulletins] copy];
				for (BBBulletin *b in bulletins)
					if (b != bulletin)
						[controller observer:observer removeBulletin:b];
				[bulletins release];
			}
			[listItems release];
		}
	} else {
		%orig;
	}
}

- (void)lockBarStartedTracking:(id)lockBar
{
	slideBackStatus = 0;
	%orig;
}

- (void)lockBarSlidBackToOrigin:(id)lockBar
{
	if (slideBackStatus == 2) {
		NSString *bulletinID = self.actionContext.bulletinID;
		SBAwayBulletinListController *controller = [[[%c(SBAwayController) sharedAwayController] awayView] bulletinController];
		if (controller) {
			for (SBAwayBulletinListItem *listItem in CHIvar(controller, _listItems, NSMutableArray *)) {
				for (BBBulletin *b in [listItem bulletins]) {
					if ([b.bulletinID isEqualToString:bulletinID] && (b != bulletin)) {
						[controller observer:CHIvar(controller, _observer, BBObserver *) removeBulletin:b];
						%orig;
						return;
					}
				}
			}
		}
	}
	%orig;
}

%end

%hook SBBulletinLockBar

- (void)knobDragged:(CGFloat)dragged
{
	switch (slideBackStatus) {
		case 0:
			if (dragged == 1.0f)
				slideBackStatus = 1;
			break;
		case 1:
			if (dragged == 0.0f)
				slideBackStatus = 2;
			break;
	}
	%orig;
}

%end
