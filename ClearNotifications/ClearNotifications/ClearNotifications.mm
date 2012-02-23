#line 1 "/OnGitHub/FeiIOS/ClearNotifications/ClearNotifications/ClearNotifications.xm"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CaptainHook/CaptainHook.h>
#import <BulletinBoard/BulletinBoard.h>
#import "SpringBoard.h"




#include <objc/message.h>
@class SBBulletinLockBar; @class SBAwayController; @class SBAwayBulletinListItem; @class SBAwayBulletinCell; @class SBBulletinCellContentViewBase; @class SBAwayListUnlockActionContext; @class BBBulletinRequest; @class SBAwayBulletinListController; @class BBAction; 
static Class _logos_superclass$_ungrouped$SBAwayBulletinListController; static void (*_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$)(SBAwayBulletinListController*, SEL, SBAwayBulletinListItem *);static void (*_logos_orig$_ungrouped$SBAwayBulletinListController$_sortListItems)(SBAwayBulletinListController*, SEL);static void (*_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$)(SBAwayBulletinListController*, SEL, id, CGFloat);static UITableViewCell * (*_logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$)(SBAwayBulletinListController*, SEL, UITableView *, NSIndexPath *);static void (*_logos_orig$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$)(SBAwayBulletinListController*, SEL, SBAwayListUnlockActionContext *);static Class _logos_superclass$_ungrouped$SBAwayBulletinListItem; static UIImage * (*_logos_orig$_ungrouped$SBAwayBulletinListItem$iconImage)(SBAwayBulletinListItem*, SEL);static Class _logos_superclass$_ungrouped$SBAwayBulletinCell; static void (*_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$)(SBAwayBulletinCell*, SEL, id);static void (*_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$)(SBAwayBulletinCell*, SEL, id);static void (*_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$)(SBAwayBulletinCell*, SEL, id);static Class _logos_superclass$_ungrouped$SBBulletinLockBar; static void (*_logos_orig$_ungrouped$SBBulletinLockBar$knobDragged$)(SBBulletinLockBar*, SEL, CGFloat);
static Class _logos_static_class$SBAwayListUnlockActionContext; static Class _logos_static_class$SBAwayController; static Class _logos_static_class$BBBulletinRequest; static Class _logos_static_class$BBAction; static Class _logos_static_class$SBBulletinCellContentViewBase; 
#line 10 "/OnGitHub/FeiIOS/ClearNotifications/ClearNotifications/ClearNotifications.xm"


static BBBulletinRequest *bulletin;



static void _logos_super$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$(SBAwayBulletinListController* self, SEL _cmd, SBAwayBulletinListItem * listItem) {return ((void (*)(SBAwayBulletinListController*, SEL, SBAwayBulletinListItem *))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListController, @selector(_updateModelAndTableViewForAddition:)))(self, _cmd, listItem);}static void _logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$(SBAwayBulletinListController* self, SEL _cmd, SBAwayBulletinListItem * listItem) {
	_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$(self, _cmd, listItem);
	NSMutableArray *_listItems = CHIvar(self, _listItems, NSMutableArray *);
	if ([_listItems count] == 1) {
		if (!bulletin) {
			bulletin = [[_logos_static_class$BBBulletinRequest alloc] init];
			bulletin.title = @"Clear Notifications";
			
			bulletin.sectionID = @"com.apple.preferences";
			bulletin.defaultAction = [_logos_static_class$BBAction actionWithLaunchURL:[NSURL URLWithString:@"http://rpetri.ch/null"] callblock:nil];
			bulletin.bulletinID = @"ClearAllBulletin";
			bulletin.unlockActionLabelOverride = @"clear all";
			bulletin.date = [NSDate distantPast];
			bulletin.lastInterruptDate = [NSDate date];
		}
		[self observer:CHIvar(self, _observer, BBObserver *) addBulletin:bulletin forFeed:0];
	}
}



static void _logos_super$_ungrouped$SBAwayBulletinListController$_sortListItems(SBAwayBulletinListController* self, SEL _cmd) {return ((void (*)(SBAwayBulletinListController*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListController, @selector(_sortListItems)))(self, _cmd);}static void _logos_method$_ungrouped$SBAwayBulletinListController$_sortListItems(SBAwayBulletinListController* self, SEL _cmd) {
	_logos_orig$_ungrouped$SBAwayBulletinListController$_sortListItems(self, _cmd);
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



static void _logos_super$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$(SBAwayBulletinListController* self, SEL _cmd, id removal, CGFloat originalHeight) {return ((void (*)(SBAwayBulletinListController*, SEL, id, CGFloat))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListController, @selector(_updateModelAndTableViewForRemoval:originalHeight:)))(self, _cmd, removal, originalHeight);}static void _logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$(SBAwayBulletinListController* self, SEL _cmd, id removal, CGFloat originalHeight) {
	_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$(self, _cmd, removal, originalHeight);
	if (bulletin) {
		NSMutableArray *_listItems = CHIvar(self, _listItems, NSMutableArray *);
		if ([_listItems count] == 1) {
			[self observer:CHIvar(self, _observer, BBObserver *) removeBulletin:bulletin];
		}
	}
}



static UITableViewCell * _logos_super$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$(SBAwayBulletinListController* self, SEL _cmd, UITableView * view, NSIndexPath * indexPath) {return ((UITableViewCell * (*)(SBAwayBulletinListController*, SEL, UITableView *, NSIndexPath *))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListController, @selector(tableView:cellForRowAtIndexPath:)))(self, _cmd, view, indexPath);}static UITableViewCell * _logos_method$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$(SBAwayBulletinListController* self, SEL _cmd, UITableView * view, NSIndexPath * indexPath) {
	if ((indexPath.row == 0) && (indexPath.section == 0)) {
		UITableViewCell *cell = _logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$(self, _cmd, view, indexPath);
		for (UIView *view in cell.contentView.subviews) {
			if ([view isKindOfClass:_logos_static_class$SBBulletinCellContentViewBase]) {
				[(SBBulletinCellContentViewBase *)view dateLabel].text = @"";
			}
		}
		return cell;
	}
	return _logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$(self, _cmd, view, indexPath);
}



static void _logos_super$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$(SBAwayBulletinListController* self, SEL _cmd, SBAwayListUnlockActionContext * context) {return ((void (*)(SBAwayBulletinListController*, SEL, SBAwayListUnlockActionContext *))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListController, @selector(setUnlockActionContext:)))(self, _cmd, context);}static void _logos_method$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$(SBAwayBulletinListController* self, SEL _cmd, SBAwayListUnlockActionContext * context) {
	if (bulletin && [context.bulletinID isEqualToString:bulletin.bulletinID]) {
		for (SBAwayBulletinListItem *listItem in CHIvar(self, _listItems, NSMutableArray *)) {
			if ([listItem respondsToSelector:@selector(activeBulletin)]) {
				BBBulletin *b = [listItem activeBulletin];
				if (b != bulletin) {
					context = [_logos_static_class$SBAwayListUnlockActionContext unlockActionContextForBulletin:b];
					break;
				}
			}
		}
	}
	_logos_orig$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$(self, _cmd, context);
}







static UIImage * _logos_super$_ungrouped$SBAwayBulletinListItem$iconImage(SBAwayBulletinListItem* self, SEL _cmd) {return ((UIImage * (*)(SBAwayBulletinListItem*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinListItem, @selector(iconImage)))(self, _cmd);}static UIImage * _logos_method$_ungrouped$SBAwayBulletinListItem$iconImage(SBAwayBulletinListItem* self, SEL _cmd) {
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
	return _logos_orig$_ungrouped$SBAwayBulletinListItem$iconImage(self, _cmd);
}





static NSInteger slideBackStatus;



static void _logos_super$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {return ((void (*)(SBAwayBulletinCell*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinCell, @selector(lockBarUnlocked:)))(self, _cmd, lockBar);}static void _logos_method$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {
	SBAwayListUnlockActionContext *actionContext = self.actionContext;
	if (bulletin && [actionContext.bulletinID isEqualToString:bulletin.bulletinID]) {
		SBAwayBulletinListController *controller = [[[_logos_static_class$SBAwayController sharedAwayController] awayView] bulletinController];
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
		_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$(self, _cmd, lockBar);
	}
}


static void _logos_super$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {return ((void (*)(SBAwayBulletinCell*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinCell, @selector(lockBarStartedTracking:)))(self, _cmd, lockBar);}static void _logos_method$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {
	slideBackStatus = 0;
	_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$(self, _cmd, lockBar);
}


static void _logos_super$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {return ((void (*)(SBAwayBulletinCell*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayBulletinCell, @selector(lockBarSlidBackToOrigin:)))(self, _cmd, lockBar);}static void _logos_method$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$(SBAwayBulletinCell* self, SEL _cmd, id lockBar) {
	if (slideBackStatus == 2) {
		NSString *bulletinID = self.actionContext.bulletinID;
		SBAwayBulletinListController *controller = [[[_logos_static_class$SBAwayController sharedAwayController] awayView] bulletinController];
		if (controller) {
			for (SBAwayBulletinListItem *listItem in CHIvar(controller, _listItems, NSMutableArray *)) {
				for (BBBulletin *b in [listItem bulletins]) {
					if ([b.bulletinID isEqualToString:bulletinID] && (b != bulletin)) {
						[controller observer:CHIvar(controller, _observer, BBObserver *) removeBulletin:b];
						_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$(self, _cmd, lockBar);
						return;
					}
				}
			}
		}
	}
	_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$(self, _cmd, lockBar);
}






static void _logos_super$_ungrouped$SBBulletinLockBar$knobDragged$(SBBulletinLockBar* self, SEL _cmd, CGFloat dragged) {return ((void (*)(SBBulletinLockBar*, SEL, CGFloat))class_getMethodImplementation(_logos_superclass$_ungrouped$SBBulletinLockBar, @selector(knobDragged:)))(self, _cmd, dragged);}static void _logos_method$_ungrouped$SBBulletinLockBar$knobDragged$(SBBulletinLockBar* self, SEL _cmd, CGFloat dragged) {
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
	_logos_orig$_ungrouped$SBBulletinLockBar$knobDragged$(self, _cmd, dragged);
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
{Class _logos_class$_ungrouped$SBAwayBulletinListController = objc_getClass("SBAwayBulletinListController"); _logos_superclass$_ungrouped$SBAwayBulletinListController = class_getSuperclass(_logos_class$_ungrouped$SBAwayBulletinListController); { Class _class = _logos_class$_ungrouped$SBAwayBulletinListController;Method _method = class_getInstanceMethod(_class, @selector(_updateModelAndTableViewForAddition:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$ = _logos_super$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$;if (!class_addMethod(_class, @selector(_updateModelAndTableViewForAddition:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$ = (void (*)(SBAwayBulletinListController*, SEL, SBAwayBulletinListItem *))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$ = (void (*)(SBAwayBulletinListController*, SEL, SBAwayBulletinListItem *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForAddition$);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinListController;Method _method = class_getInstanceMethod(_class, @selector(_sortListItems));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListController$_sortListItems = _logos_super$_ungrouped$SBAwayBulletinListController$_sortListItems;if (!class_addMethod(_class, @selector(_sortListItems), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_sortListItems, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListController$_sortListItems = (void (*)(SBAwayBulletinListController*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListController$_sortListItems = (void (*)(SBAwayBulletinListController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_sortListItems);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinListController;Method _method = class_getInstanceMethod(_class, @selector(_updateModelAndTableViewForRemoval:originalHeight:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$ = _logos_super$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$;if (!class_addMethod(_class, @selector(_updateModelAndTableViewForRemoval:originalHeight:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$ = (void (*)(SBAwayBulletinListController*, SEL, id, CGFloat))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$ = (void (*)(SBAwayBulletinListController*, SEL, id, CGFloat))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$_updateModelAndTableViewForRemoval$originalHeight$);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinListController;Method _method = class_getInstanceMethod(_class, @selector(tableView:cellForRowAtIndexPath:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$ = _logos_super$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$;if (!class_addMethod(_class, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$ = (UITableViewCell * (*)(SBAwayBulletinListController*, SEL, UITableView *, NSIndexPath *))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$ = (UITableViewCell * (*)(SBAwayBulletinListController*, SEL, UITableView *, NSIndexPath *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$tableView$cellForRowAtIndexPath$);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinListController;Method _method = class_getInstanceMethod(_class, @selector(setUnlockActionContext:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$ = _logos_super$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$;if (!class_addMethod(_class, @selector(setUnlockActionContext:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$ = (void (*)(SBAwayBulletinListController*, SEL, SBAwayListUnlockActionContext *))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$ = (void (*)(SBAwayBulletinListController*, SEL, SBAwayListUnlockActionContext *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListController$setUnlockActionContext$);}}}Class _logos_class$_ungrouped$SBAwayBulletinListItem = objc_getClass("SBAwayBulletinListItem"); _logos_superclass$_ungrouped$SBAwayBulletinListItem = class_getSuperclass(_logos_class$_ungrouped$SBAwayBulletinListItem); { Class _class = _logos_class$_ungrouped$SBAwayBulletinListItem;Method _method = class_getInstanceMethod(_class, @selector(iconImage));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinListItem$iconImage = _logos_super$_ungrouped$SBAwayBulletinListItem$iconImage;if (!class_addMethod(_class, @selector(iconImage), (IMP)&_logos_method$_ungrouped$SBAwayBulletinListItem$iconImage, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinListItem$iconImage = (UIImage * (*)(SBAwayBulletinListItem*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinListItem$iconImage = (UIImage * (*)(SBAwayBulletinListItem*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinListItem$iconImage);}}}Class _logos_class$_ungrouped$SBAwayBulletinCell = objc_getClass("SBAwayBulletinCell"); _logos_superclass$_ungrouped$SBAwayBulletinCell = class_getSuperclass(_logos_class$_ungrouped$SBAwayBulletinCell); { Class _class = _logos_class$_ungrouped$SBAwayBulletinCell;Method _method = class_getInstanceMethod(_class, @selector(lockBarUnlocked:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$ = _logos_super$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$;if (!class_addMethod(_class, @selector(lockBarUnlocked:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarUnlocked$);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinCell;Method _method = class_getInstanceMethod(_class, @selector(lockBarStartedTracking:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$ = _logos_super$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$;if (!class_addMethod(_class, @selector(lockBarStartedTracking:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarStartedTracking$);}}}{ Class _class = _logos_class$_ungrouped$SBAwayBulletinCell;Method _method = class_getInstanceMethod(_class, @selector(lockBarSlidBackToOrigin:));if (_method) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$ = _logos_super$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$;if (!class_addMethod(_class, @selector(lockBarSlidBackToOrigin:), (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$ = (void (*)(SBAwayBulletinCell*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayBulletinCell$lockBarSlidBackToOrigin$);}}}Class _logos_class$_ungrouped$SBBulletinLockBar = objc_getClass("SBBulletinLockBar"); _logos_superclass$_ungrouped$SBBulletinLockBar = class_getSuperclass(_logos_class$_ungrouped$SBBulletinLockBar); { Class _class = _logos_class$_ungrouped$SBBulletinLockBar;Method _method = class_getInstanceMethod(_class, @selector(knobDragged:));if (_method) {_logos_orig$_ungrouped$SBBulletinLockBar$knobDragged$ = _logos_super$_ungrouped$SBBulletinLockBar$knobDragged$;if (!class_addMethod(_class, @selector(knobDragged:), (IMP)&_logos_method$_ungrouped$SBBulletinLockBar$knobDragged$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBBulletinLockBar$knobDragged$ = (void (*)(SBBulletinLockBar*, SEL, CGFloat))method_getImplementation(_method);_logos_orig$_ungrouped$SBBulletinLockBar$knobDragged$ = (void (*)(SBBulletinLockBar*, SEL, CGFloat))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBBulletinLockBar$knobDragged$);}}}} {_logos_static_class$SBAwayListUnlockActionContext = objc_getClass("SBAwayListUnlockActionContext"); _logos_static_class$SBAwayController = objc_getClass("SBAwayController"); _logos_static_class$BBBulletinRequest = objc_getClass("BBBulletinRequest"); _logos_static_class$SBBulletinCellContentViewBase = objc_getClass("SBBulletinCellContentViewBase"); _logos_static_class$BBAction = objc_getClass("BBAction"); } 
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
#line 199 "/OnGitHub/FeiIOS/ClearNotifications/ClearNotifications/ClearNotifications.xm"
