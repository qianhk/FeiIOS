#line 1 "/OnGitHub/FeiIOS/SelectAllMail/SelectAllMail/SelectAllMail.xm"
#import <UIKit/UIKit.h>

struct sqlite3_stmt;
struct sqlite3;

UIBarButtonItem *selectAllButton;
static BOOL selectedAll=NO;

@interface MailboxContentViewController : UIViewController
- (id)currentTableView;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didDeselectRowAtIndexPath:(id)arg2;
@end

#include <substrate.h>
@class MessageLibrary; @class OutgoingMessageDelivery; @class MailMessageLibrary; @class DeliveryQueue; @class ComposeViewController; @class MailComposeController; @class MailDelivery; @class MailboxContentViewController; 
static void _logos_method$_ungrouped$MailboxContentViewController$toggleSelectAll(MailboxContentViewController*, SEL); static void (*_logos_orig$_ungrouped$MailboxContentViewController$_setInEditMode$animated$)(MailboxContentViewController*, SEL, BOOL, BOOL); static void _logos_method$_ungrouped$MailboxContentViewController$_setInEditMode$animated$(MailboxContentViewController*, SEL, BOOL, BOOL); static id (*_logos_meta_orig$_ungrouped$MailDelivery$newWithMessage$)(Class, SEL, id); static id _logos_meta_method$_ungrouped$MailDelivery$newWithMessage$(Class, SEL, id); static id (*_logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$)(Class, SEL, id, id, BOOL); static id _logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$(Class, SEL, id, id, BOOL); static id (*_logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$)(Class, SEL, id, id, id, id); static id _logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$(Class, SEL, id, id, id, id); static BOOL (*_logos_meta_orig$_ungrouped$MailDelivery$deliverMessage$)(Class, SEL, id); static BOOL _logos_meta_method$_ungrouped$MailDelivery$deliverMessage$(Class, SEL, id); static id (*_logos_orig$_ungrouped$MailDelivery$initWithMessage$)(MailDelivery*, SEL, id); static id _logos_method$_ungrouped$MailDelivery$initWithMessage$(MailDelivery*, SEL, id); static id (*_logos_orig$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$)(MailDelivery*, SEL, id, id, BOOL); static id _logos_method$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$(MailDelivery*, SEL, id, id, BOOL); static id (*_logos_orig$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$)(MailDelivery*, SEL, id, id, id, id); static id _logos_method$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$(MailDelivery*, SEL, id, id, id, id); static void (*_logos_orig$_ungrouped$MailDelivery$deliverAsynchronously)(MailDelivery*, SEL); static void _logos_method$_ungrouped$MailDelivery$deliverAsynchronously(MailDelivery*, SEL); static int (*_logos_orig$_ungrouped$MailDelivery$deliverSynchronously)(MailDelivery*, SEL); static int _logos_method$_ungrouped$MailDelivery$deliverSynchronously(MailDelivery*, SEL); static int (*_logos_orig$_ungrouped$MailDelivery$deliverMessageData$toRecipients$)(MailDelivery*, SEL, id, id); static int _logos_method$_ungrouped$MailDelivery$deliverMessageData$toRecipients$(MailDelivery*, SEL, id, id); static void (*_logos_orig$_ungrouped$MailComposeController$send$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$send$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$sendMessage)(MailComposeController*, SEL); static void _logos_method$_ungrouped$MailComposeController$sendMessage(MailComposeController*, SEL); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForNewMessage)(MailComposeController*, SEL); static void _logos_method$_ungrouped$MailComposeController$_setupForNewMessage(MailComposeController*, SEL); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForDraft$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_setupForDraft$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForReplyToMessage$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_setupForReplyToMessage$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForReplyAllToMessage$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_setupForReplyAllToMessage$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForForwardOfMessage$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_setupForForwardOfMessage$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForAutosavedMessage$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_setupForAutosavedMessage$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$)(MailComposeController*, SEL, id, id); static void _logos_method$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$(MailComposeController*, SEL, id, id); static void (*_logos_orig$_ungrouped$MailComposeController$_quoteReplyMessage$content$)(MailComposeController*, SEL, id, id); static void _logos_method$_ungrouped$MailComposeController$_quoteReplyMessage$content$(MailComposeController*, SEL, id, id); static void (*_logos_orig$_ungrouped$MailComposeController$_quoteForwardedMessage$content$)(MailComposeController*, SEL, id, id); static void _logos_method$_ungrouped$MailComposeController$_quoteForwardedMessage$content$(MailComposeController*, SEL, id, id); static void (*_logos_orig$_ungrouped$MailComposeController$_quoteBody$)(MailComposeController*, SEL, id); static void _logos_method$_ungrouped$MailComposeController$_quoteBody$(MailComposeController*, SEL, id); static void (*_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$)(ComposeViewController*, SEL, id); static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$(ComposeViewController*, SEL, id); static void (*_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$)(ComposeViewController*, SEL, id); static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$(ComposeViewController*, SEL, id); static void (*_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$)(ComposeViewController*, SEL, id, id); static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$(ComposeViewController*, SEL, id, id); static void (*_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$)(ComposeViewController*, SEL, id, id, int); static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$(ComposeViewController*, SEL, id, id, int); static void (*_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$)(ComposeViewController*, SEL, id); static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$(ComposeViewController*, SEL, id); static void (*_logos_orig$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$)(DeliveryQueue*, SEL, unsigned int); static void _logos_method$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$(DeliveryQueue*, SEL, unsigned int); static void (*_logos_orig$_ungrouped$DeliveryQueue$setPercentDone$)(DeliveryQueue*, SEL, double); static void _logos_method$_ungrouped$DeliveryQueue$setPercentDone$(DeliveryQueue*, SEL, double); static int (*_logos_orig$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$)(DeliveryQueue*, SEL, id, id, id *); static int _logos_method$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$(DeliveryQueue*, SEL, id, id, id *); static void (*_logos_orig$_ungrouped$DeliveryQueue$_deliverQueuedMessages$)(DeliveryQueue*, SEL, id); static void _logos_method$_ungrouped$DeliveryQueue$_deliverQueuedMessages$(DeliveryQueue*, SEL, id); static int (*_logos_orig$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$)(DeliveryQueue*, SEL, id, id); static int _logos_method$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$(DeliveryQueue*, SEL, id, id); static id (*_logos_orig$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts)(DeliveryQueue*, SEL); static id _logos_method$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts(DeliveryQueue*, SEL); static void (*_logos_orig$_ungrouped$MailMessageLibrary$setBusyHandler$context$)(MailMessageLibrary*, SEL,  void*, void*); static void _logos_method$_ungrouped$MailMessageLibrary$setBusyHandler$context$(MailMessageLibrary*, SEL,  void*, void*); static void (*_logos_orig$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$)(MailMessageLibrary*, SEL, sqlite3_stmt*, sqlite3*, id,  void*, void*); static void _logos_method$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$(MailMessageLibrary*, SEL, sqlite3_stmt*, sqlite3*, id,  void*, void*); static void (*_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$)(MailMessageLibrary*, SEL, sqlite3_stmt*, sqlite3*, id, unsigned, double); static void _logos_method$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$(MailMessageLibrary*, SEL, sqlite3_stmt*, sqlite3*, id, unsigned, double); static void (*_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$)(MailMessageLibrary*, SEL, const char*, id, unsigned); static void _logos_method$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$(MailMessageLibrary*, SEL, const char*, id, unsigned); static id (*_logos_orig$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$)(MailMessageLibrary*, SEL, const char*, unsigned); static id _logos_method$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$(MailMessageLibrary*, SEL, const char*, unsigned); static unsigned (*_logos_orig$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$)(MailMessageLibrary*, SEL, long long, id); static unsigned _logos_method$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$(MailMessageLibrary*, SEL, long long, id); static id (*_logos_orig$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$)(MessageLibrary*, SEL, id, id, id, unsigned long long, unsigned long long, id, BOOL); static id _logos_method$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$(MessageLibrary*, SEL, id, id, id, unsigned long long, unsigned long long, id, BOOL); static id (*_logos_orig$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$)(MessageLibrary*, SEL, id, int); static id _logos_method$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$(MessageLibrary*, SEL, id, int); static id (*_logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$)(MessageLibrary*, SEL, id, unsigned, id); static id _logos_method$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$(MessageLibrary*, SEL, id, unsigned, id); static id (*_logos_orig$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$)(MessageLibrary*, SEL, id); static id _logos_method$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$(MessageLibrary*, SEL, id); static id (*_logos_orig$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$)(MessageLibrary*, SEL, unsigned, unsigned, id); static id _logos_method$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$(MessageLibrary*, SEL, unsigned, unsigned, id); static unsigned (*_logos_orig$_ungrouped$MessageLibrary$unreadCountForMailbox$)(MessageLibrary*, SEL, id); static unsigned _logos_method$_ungrouped$MessageLibrary$unreadCountForMailbox$(MessageLibrary*, SEL, id); static unsigned (*_logos_orig$_ungrouped$MessageLibrary$deletedCountForMailbox$)(MessageLibrary*, SEL, id); static unsigned _logos_method$_ungrouped$MessageLibrary$deletedCountForMailbox$(MessageLibrary*, SEL, id); static unsigned (*_logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$)(MessageLibrary*, SEL, id); static unsigned _logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$(MessageLibrary*, SEL, id); static unsigned (*_logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$)(MessageLibrary*, SEL, id, BOOL, BOOL); static unsigned _logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$(MessageLibrary*, SEL, id, BOOL, BOOL); static unsigned (*_logos_orig$_ungrouped$MessageLibrary$totalCountForMailbox$)(MessageLibrary*, SEL, id); static unsigned _logos_method$_ungrouped$MessageLibrary$totalCountForMailbox$(MessageLibrary*, SEL, id); static id (*_logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$)(MessageLibrary*, SEL, id, id); static id _logos_method$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$(MessageLibrary*, SEL, id, id); static id (*_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$)(MessageLibrary*, SEL, id, id); static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$(MessageLibrary*, SEL, id, id); static id (*_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$)(MessageLibrary*, SEL, id, id, BOOL); static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$(MessageLibrary*, SEL, id, id, BOOL); static id (*_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$)(MessageLibrary*, SEL, id, BOOL); static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$(MessageLibrary*, SEL, id, BOOL); static id (*_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$)(MessageLibrary*, SEL, id); static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$(MessageLibrary*, SEL, id); static void (*_logos_orig$_ungrouped$MessageLibrary$setMessage$isPartial$)(MessageLibrary*, SEL, id, BOOL); static void _logos_method$_ungrouped$MessageLibrary$setMessage$isPartial$(MessageLibrary*, SEL, id, BOOL); static void (*_logos_orig$_ungrouped$MessageLibrary$setFlags$forMessage$)(MessageLibrary*, SEL, unsigned long long, id); static void _logos_method$_ungrouped$MessageLibrary$setFlags$forMessage$(MessageLibrary*, SEL, unsigned long long, id); static id (*_logos_orig$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$)(MessageLibrary*, SEL, id, id, BOOL, id); static id _logos_method$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$(MessageLibrary*, SEL, id, id, BOOL, id); 

#line 15 "/OnGitHub/FeiIOS/SelectAllMail/SelectAllMail/SelectAllMail.xm"




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







static id _logos_meta_method$_ungrouped$MailDelivery$newWithMessage$(Class self, SEL _cmd, id message) {
	NSLog(@"+[<MailDelivery: %p> newWithMessage:%@]", self, message);
	return _logos_meta_orig$_ungrouped$MailDelivery$newWithMessage$(self, _cmd, message);
}


static id _logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$(Class self, SEL _cmd, id headers, id content, BOOL html) {
	NSLog(@"+[<MailDelivery: %p> newWithHeaders:%@ mixedContent:%@ textPartsAreHTML:%d]", self, headers, content, html);
	return _logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$(self, _cmd, headers, content, html);
}


static id _logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$(Class self, SEL _cmd, id headers, id html, id alternative, id other) {
	NSLog(@"+[<MailDelivery: %p> newWithHeaders:%@ HTML:%@ plainTextAlternative:%@ other:%@]", self, headers, html, alternative, other);
	return _logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$(self, _cmd, headers, html, alternative, other);
}


static BOOL _logos_meta_method$_ungrouped$MailDelivery$deliverMessage$(Class self, SEL _cmd, id message) {
	NSLog(@"+[<MailDelivery: %p> deliverMessage:%@]", self, message);
	return _logos_meta_orig$_ungrouped$MailDelivery$deliverMessage$(self, _cmd, message);
}


static id _logos_method$_ungrouped$MailDelivery$initWithMessage$(MailDelivery* self, SEL _cmd, id message) {
	NSLog(@"-[<MailDelivery: %p> initWithMessage:%@]", self, message);
	return _logos_orig$_ungrouped$MailDelivery$initWithMessage$(self, _cmd, message);
}


static id _logos_method$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$(MailDelivery* self, SEL _cmd, id headers, id content, BOOL html) {
	NSLog(@"-[<MailDelivery: %p> initWithHeaders:%@ mixedContent:%@ textPartsAreHTML:%d]", self, headers, content, html);
	return _logos_orig$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$(self, _cmd, headers, content, html);
}


static id _logos_method$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$(MailDelivery* self, SEL _cmd, id headers, id html, id alternative, id other) {
	NSLog(@"-[<MailDelivery: %p> initWithHeaders:%@ HTML:%@ plainTextAlternative:%@ other:%@]", self, headers, html, alternative, other);
	return _logos_orig$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$(self, _cmd, headers, html, alternative, other);
}



static void _logos_method$_ungrouped$MailDelivery$deliverAsynchronously(MailDelivery* self, SEL _cmd) {
	NSLog(@"-[<MailDelivery: %p> deliverAsynchronously]", self);
	_logos_orig$_ungrouped$MailDelivery$deliverAsynchronously(self, _cmd);
}


static int _logos_method$_ungrouped$MailDelivery$deliverSynchronously(MailDelivery* self, SEL _cmd) {
	NSLog(@"-[<MailDelivery: %p> deliverSynchronously]", self);
	return _logos_orig$_ungrouped$MailDelivery$deliverSynchronously(self, _cmd);
}


static int _logos_method$_ungrouped$MailDelivery$deliverMessageData$toRecipients$(MailDelivery* self, SEL _cmd, id data, id recipients) {
	NSLog(@"-[<MailDelivery: %p> deliverMessageData:%@ toRecipients:%@]", self, data, recipients);
	return _logos_orig$_ungrouped$MailDelivery$deliverMessageData$toRecipients$(self, _cmd, data, recipients);
}














static void _logos_method$_ungrouped$MailComposeController$send$(MailComposeController* self, SEL _cmd, id send) {
	NSLog(@"-[<MailComposeController: %p> send:%@]", self, send);
	_logos_orig$_ungrouped$MailComposeController$send$(self, _cmd, send);
}


static void _logos_method$_ungrouped$MailComposeController$sendMessage(MailComposeController* self, SEL _cmd) {
	NSLog(@"-[<MailComposeController: %p> sendMessage]", self);
	_logos_orig$_ungrouped$MailComposeController$sendMessage(self, _cmd);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForNewMessage(MailComposeController* self, SEL _cmd) {
	NSLog(@"-[<MailComposeController: %p> _setupForNewMessage]", self);
	_logos_orig$_ungrouped$MailComposeController$_setupForNewMessage(self, _cmd);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForDraft$(MailComposeController* self, SEL _cmd, id draft) {
	NSLog(@"-[<MailComposeController: %p> _setupForDraft:%@]", self, draft);
	_logos_orig$_ungrouped$MailComposeController$_setupForDraft$(self, _cmd, draft);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForReplyToMessage$(MailComposeController* self, SEL _cmd, id message) {
	NSLog(@"-[<MailComposeController: %p> _setupForReplyToMessage:%@]", self, message);
	_logos_orig$_ungrouped$MailComposeController$_setupForReplyToMessage$(self, _cmd, message);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForReplyAllToMessage$(MailComposeController* self, SEL _cmd, id message) {
	NSLog(@"-[<MailComposeController: %p> _setupForReplyAllToMessage:%@]", self, message);
	_logos_orig$_ungrouped$MailComposeController$_setupForReplyAllToMessage$(self, _cmd, message);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForForwardOfMessage$(MailComposeController* self, SEL _cmd, id message) {
	NSLog(@"-[<MailComposeController: %p> _setupForForwardOfMessage:%@]", self, message);
	_logos_orig$_ungrouped$MailComposeController$_setupForForwardOfMessage$(self, _cmd, message);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForAutosavedMessage$(MailComposeController* self, SEL _cmd, id autosavedMessage) {
	NSLog(@"-[<MailComposeController: %p> _setupForAutosavedMessage:%@]", self, autosavedMessage);
	_logos_orig$_ungrouped$MailComposeController$_setupForAutosavedMessage$(self, _cmd, autosavedMessage);
}


static void _logos_method$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$(MailComposeController* self, SEL _cmd, id existingNewMessage, id headers) {
	NSLog(@"-[<MailComposeController: %p> _setupForExistingNewMessage:%@ headers:%@]", self, existingNewMessage, headers);
	_logos_orig$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$(self, _cmd, existingNewMessage, headers);
}


static void _logos_method$_ungrouped$MailComposeController$_quoteReplyMessage$content$(MailComposeController* self, SEL _cmd, id message, id content) {
	NSLog(@"-[<MailComposeController: %p> _quoteReplyMessage:%@ content:%@]", self, message, content);
	_logos_orig$_ungrouped$MailComposeController$_quoteReplyMessage$content$(self, _cmd, message, content);
}


static void _logos_method$_ungrouped$MailComposeController$_quoteForwardedMessage$content$(MailComposeController* self, SEL _cmd, id message, id content) {
	NSLog(@"-[<MailComposeController: %p> _quoteForwardedMessage:%@ content:%@]", self, message, content);
	_logos_orig$_ungrouped$MailComposeController$_quoteForwardedMessage$content$(self, _cmd, message, content);
}


static void _logos_method$_ungrouped$MailComposeController$_quoteBody$(MailComposeController* self, SEL _cmd, id body) {
	NSLog(@"-[<MailComposeController: %p> _quoteBody:%@]", self, body);
	_logos_orig$_ungrouped$MailComposeController$_quoteBody$(self, _cmd, body);
}







static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$(ComposeViewController* self, SEL _cmd, id fp8) {
	NSLog(@"-[<ComposeViewController: %p> mailComposeControllerCompositionFinished:%@]", self, fp8);
	_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$(self, _cmd, fp8);
}


static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$(ComposeViewController* self, SEL _cmd, id fp8) {
	NSLog(@"-[<ComposeViewController: %p> mailComposeControllerWillAttemptToSend:%@]", self, fp8);
	_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$(self, _cmd, fp8);
}


static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$(ComposeViewController* self, SEL _cmd, id fp8, id fp12) {
	NSLog(@"-[<ComposeViewController: %p> mailComposeControllerDidAttemptToSend:%@ mailDelivery:%@]", self, fp8, fp12);
	_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$(self, _cmd, fp8, fp12);
}


static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$(ComposeViewController* self, SEL _cmd, id fp8, id fp12, int fp16) {
	NSLog(@"-[<ComposeViewController: %p> mailComposeControllerDidAttemptToSaveDraft:%@ account:%@ result:%d]", self, fp8, fp12, fp16);
	_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$(self, _cmd, fp8, fp12, fp16);
}


static void _logos_method$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$(ComposeViewController* self, SEL _cmd, id fp8) {
	NSLog(@"-[<ComposeViewController: %p> mailComposeControllerFinishedLoadingInitialAttachments:%@]", self, fp8);
	_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$(self, _cmd, fp8);
}








static void _logos_method$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$(DeliveryQueue* self, SEL _cmd, unsigned int fp8) {
	NSLog(@"-[<DeliveryQueue: %p> processDeliveryQueueStartingAtIndex:%u]", self, fp8);
	_logos_orig$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$(self, _cmd, fp8);
}


static void _logos_method$_ungrouped$DeliveryQueue$setPercentDone$(DeliveryQueue* self, SEL _cmd, double fp8) {
	NSLog(@"-[<DeliveryQueue: %p> setPercentDone:%f]", self, fp8);
	_logos_orig$_ungrouped$DeliveryQueue$setPercentDone$(self, _cmd, fp8);
}


static int _logos_method$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$(DeliveryQueue* self, SEL _cmd, id fp8, id fp12, id * fp16) {
	NSLog(@"-[<DeliveryQueue: %p> _performDeliveryOfMessage:%@ usingAccount:%@ accountUsed:%p]", self, fp8, fp12, fp16);
	return _logos_orig$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$(self, _cmd, fp8, fp12, fp16);
}


static void _logos_method$_ungrouped$DeliveryQueue$_deliverQueuedMessages$(DeliveryQueue* self, SEL _cmd, id fp8) {
	NSLog(@"-[<DeliveryQueue: %p> _deliverQueuedMessages:%@]", self, fp8);
	_logos_orig$_ungrouped$DeliveryQueue$_deliverQueuedMessages$(self, _cmd, fp8);
}


static int _logos_method$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$(DeliveryQueue* self, SEL _cmd, id fp8, id fp12) {
	NSLog(@"-[<DeliveryQueue: %p> appendMessageToQueue:%@ replacingOriginalMessage:%@]", self, fp8, fp12);
	return _logos_orig$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$(self, _cmd, fp8, fp12);
}


static id _logos_method$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts(DeliveryQueue* self, SEL _cmd) {
	NSLog(@"-[<DeliveryQueue: %p> potentialAlternateDeliveryAccounts]", self);
	return _logos_orig$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts(self, _cmd);
}














































































static void _logos_method$_ungrouped$MailMessageLibrary$setBusyHandler$context$(MailMessageLibrary* self, SEL _cmd,  void* handler, void* context) {
	NSLog(@"-[<MailMessageLibrary: %p> setBusyHandler:%p context:%p]", self, handler, context);
	_logos_orig$_ungrouped$MailMessageLibrary$setBusyHandler$context$(self, _cmd, handler, context);
}


static void _logos_method$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$(MailMessageLibrary* self, SEL _cmd, sqlite3_stmt* statement, sqlite3* db, id progressMonitor,  void* handler, void* context) {
	NSLog(@"-[<MailMessageLibrary: %p> iterateStatement:%@ db:%@ withProgressMonitor:%@ andRowHandler:%p context:%p]", self, statement, db, progressMonitor, handler, context);
	_logos_orig$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$(self, _cmd, statement, db, progressMonitor, handler, context);
}


static void _logos_method$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$(MailMessageLibrary* self, SEL _cmd, sqlite3_stmt* statement, sqlite3* db, id to, unsigned options, double timestamp) {
	NSLog(@"-[<MailMessageLibrary: %p> sendMessagesForStatement:%@ db:%@ to:%@ options:%u timestamp:%f]", self, statement, db, to, options, timestamp);
	_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$(self, _cmd, statement, db, to, options, timestamp);
}


static void _logos_method$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$(MailMessageLibrary* self, SEL _cmd, const char* query, id to, unsigned options) {
	NSLog(@"-[<MailMessageLibrary: %p> sendMessagesMatchingQuery:%@ to:%@ options:%u]", self, query, to, options);
	_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$(self, _cmd, query, to, options);
}


static id _logos_method$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$(MailMessageLibrary* self, SEL _cmd, const char* query, unsigned options) {
	NSLog(@"-[<MailMessageLibrary: %p> messagesMatchingQuery:%@ options:%u]", self, query, options);
	return _logos_orig$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$(self, _cmd, query, options);
}


static unsigned _logos_method$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$(MailMessageLibrary* self, SEL _cmd, long long messageID, id mailbox) {
	NSLog(@"-[<MailMessageLibrary: %p> locationOfMessageID:%lld inMailbox:%@]", self, messageID, mailbox);
	return _logos_orig$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$(self, _cmd, messageID, mailbox);
}







static id _logos_method$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$(MessageLibrary* self, SEL _cmd, id messages, id ids, id mailbox, unsigned long long flags, unsigned long long flags5, id messages6, BOOL files) {
	NSLog(@"-[<MessageLibrary: %p> duplicateMessages:%@ newRemoteIDs:%@ forMailbox:%@ setFlags:%llu clearFlags:%llu messageFlagsForMessages:%@ createNewCacheFiles:%d]", self, messages, ids, mailbox, flags, flags5, messages6, files);
	return _logos_orig$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$(self, _cmd, messages, ids, mailbox, flags, flags5, messages6, files);
}


static id _logos_method$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$(MessageLibrary* self, SEL _cmd, id mailbox, int days) {
	NSLog(@"-[<MessageLibrary: %p> messagesForMailbox:%@ olderThanNumberOfDays:%d]", self, mailbox, days);
	return _logos_orig$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$(self, _cmd, mailbox, days);
}


static id _logos_method$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$(MessageLibrary* self, SEL _cmd, id messageID, unsigned options, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> messageWithMessageID:%@ options:%u inMailbox:%@]", self, messageID, options, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$(self, _cmd, messageID, options, mailbox);
}


static id _logos_method$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$(MessageLibrary* self, SEL _cmd, id messageIDHeader) {
	NSLog(@"-[<MessageLibrary: %p> messagesWithMessageIDHeader:%@]", self, messageIDHeader);
	return _logos_orig$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$(self, _cmd, messageIDHeader);
}


static id _logos_method$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$(MessageLibrary* self, SEL _cmd, unsigned libraryID, unsigned options, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> messageWithLibraryID:%u options:%u inMailbox:%@]", self, libraryID, options, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$(self, _cmd, libraryID, options, mailbox);
}


static unsigned _logos_method$_ungrouped$MessageLibrary$unreadCountForMailbox$(MessageLibrary* self, SEL _cmd, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> unreadCountForMailbox:%@]", self, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$unreadCountForMailbox$(self, _cmd, mailbox);
}


static unsigned _logos_method$_ungrouped$MessageLibrary$deletedCountForMailbox$(MessageLibrary* self, SEL _cmd, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> deletedCountForMailbox:%@]", self, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$deletedCountForMailbox$(self, _cmd, mailbox);
}


static unsigned _logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$(MessageLibrary* self, SEL _cmd, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> nonDeletedCountForMailbox:%@]", self, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$(self, _cmd, mailbox);
}


static unsigned _logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$(MessageLibrary* self, SEL _cmd, id mailbox, BOOL results, BOOL results3) {
	NSLog(@"-[<MessageLibrary: %p> nonDeletedCountForMailbox:%@ includeServerSearchResults:%d includeThreadSearchResults:%d]", self, mailbox, results, results3);
	return _logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$(self, _cmd, mailbox, results, results3);
}


static unsigned _logos_method$_ungrouped$MessageLibrary$totalCountForMailbox$(MessageLibrary* self, SEL _cmd, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> totalCountForMailbox:%@]", self, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$totalCountForMailbox$(self, _cmd, mailbox);
}


static id _logos_method$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$(MessageLibrary* self, SEL _cmd, id messageID, id mailbox) {
	NSLog(@"-[<MessageLibrary: %p> messageWithMessageID:%@ inMailbox:%@]", self, messageID, mailbox);
	return _logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$(self, _cmd, messageID, mailbox);
}


static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$(MessageLibrary* self, SEL _cmd, id message, id part) {
	NSLog(@"-[<MessageLibrary: %p> dataConsumerForMessage:%@ part:%@]", self, message, part);
	return _logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$(self, _cmd, message, part);
}


static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$(MessageLibrary* self, SEL _cmd, id message, id part, BOOL incomplete) {
	NSLog(@"-[<MessageLibrary: %p> dataConsumerForMessage:%@ part:%@ incomplete:%d]", self, message, part, incomplete);
	return _logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$(self, _cmd, message, part, incomplete);
}


static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$(MessageLibrary* self, SEL _cmd, id message, BOOL partial) {
	NSLog(@"-[<MessageLibrary: %p> dataConsumerForMessage:%@ isPartial:%d]", self, message, partial);
	return _logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$(self, _cmd, message, partial);
}


static id _logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$(MessageLibrary* self, SEL _cmd, id message) {
	NSLog(@"-[<MessageLibrary: %p> dataConsumerForMessage:%@]", self, message);
	return _logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$(self, _cmd, message);
}


static void _logos_method$_ungrouped$MessageLibrary$setMessage$isPartial$(MessageLibrary* self, SEL _cmd, id message, BOOL partial) {
	NSLog(@"-[<MessageLibrary: %p> setMessage:%@ isPartial:%d]", self, message, partial);
	_logos_orig$_ungrouped$MessageLibrary$setMessage$isPartial$(self, _cmd, message, partial);
}


static void _logos_method$_ungrouped$MessageLibrary$setFlags$forMessage$(MessageLibrary* self, SEL _cmd, unsigned long long flags, id message) {
	NSLog(@"-[<MessageLibrary: %p> setFlags:%llu forMessage:%@]", self, flags, message);
	_logos_orig$_ungrouped$MessageLibrary$setFlags$forMessage$(self, _cmd, flags, message);
}


static id _logos_method$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$(MessageLibrary* self, SEL _cmd, id messages, id mailbox, BOOL bodies, id message) {
	NSLog(@"-[<MessageLibrary: %p> addMessages:%@ withMailbox:%@ fetchBodies:%d newMessagesByOldMessage:%@]", self, messages, mailbox, bodies, message);
	return _logos_orig$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$(self, _cmd, messages, mailbox, bodies, message);
}




static __attribute__((constructor)) void _logosLocalCtor_13f320e7()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	{{Class _logos_class$_ungrouped$MailboxContentViewController = objc_getClass("MailboxContentViewController"); { const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$MailboxContentViewController, @selector(toggleSelectAll), (IMP)&_logos_method$_ungrouped$MailboxContentViewController$toggleSelectAll, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$MailboxContentViewController, @selector(_setInEditMode:animated:), (IMP)&_logos_method$_ungrouped$MailboxContentViewController$_setInEditMode$animated$, (IMP*)&_logos_orig$_ungrouped$MailboxContentViewController$_setInEditMode$animated$);Class _logos_class$_ungrouped$MailDelivery = objc_getClass("MailDelivery"); Class _logos_metaclass$_ungrouped$MailDelivery = object_getClass(_logos_class$_ungrouped$MailDelivery); MSHookMessageEx(_logos_metaclass$_ungrouped$MailDelivery, @selector(newWithMessage:), (IMP)&_logos_meta_method$_ungrouped$MailDelivery$newWithMessage$, (IMP*)&_logos_meta_orig$_ungrouped$MailDelivery$newWithMessage$);MSHookMessageEx(_logos_metaclass$_ungrouped$MailDelivery, @selector(newWithHeaders:mixedContent:textPartsAreHTML:), (IMP)&_logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$, (IMP*)&_logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$mixedContent$textPartsAreHTML$);MSHookMessageEx(_logos_metaclass$_ungrouped$MailDelivery, @selector(newWithHeaders:HTML:plainTextAlternative:other:), (IMP)&_logos_meta_method$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$, (IMP*)&_logos_meta_orig$_ungrouped$MailDelivery$newWithHeaders$HTML$plainTextAlternative$other$);MSHookMessageEx(_logos_metaclass$_ungrouped$MailDelivery, @selector(deliverMessage:), (IMP)&_logos_meta_method$_ungrouped$MailDelivery$deliverMessage$, (IMP*)&_logos_meta_orig$_ungrouped$MailDelivery$deliverMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(initWithMessage:), (IMP)&_logos_method$_ungrouped$MailDelivery$initWithMessage$, (IMP*)&_logos_orig$_ungrouped$MailDelivery$initWithMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(initWithHeaders:mixedContent:textPartsAreHTML:), (IMP)&_logos_method$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$, (IMP*)&_logos_orig$_ungrouped$MailDelivery$initWithHeaders$mixedContent$textPartsAreHTML$);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(initWithHeaders:HTML:plainTextAlternative:other:), (IMP)&_logos_method$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$, (IMP*)&_logos_orig$_ungrouped$MailDelivery$initWithHeaders$HTML$plainTextAlternative$other$);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(deliverAsynchronously), (IMP)&_logos_method$_ungrouped$MailDelivery$deliverAsynchronously, (IMP*)&_logos_orig$_ungrouped$MailDelivery$deliverAsynchronously);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(deliverSynchronously), (IMP)&_logos_method$_ungrouped$MailDelivery$deliverSynchronously, (IMP*)&_logos_orig$_ungrouped$MailDelivery$deliverSynchronously);MSHookMessageEx(_logos_class$_ungrouped$MailDelivery, @selector(deliverMessageData:toRecipients:), (IMP)&_logos_method$_ungrouped$MailDelivery$deliverMessageData$toRecipients$, (IMP*)&_logos_orig$_ungrouped$MailDelivery$deliverMessageData$toRecipients$);Class _logos_class$_ungrouped$MailComposeController = objc_getClass("MailComposeController"); MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(send:), (IMP)&_logos_method$_ungrouped$MailComposeController$send$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$send$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(sendMessage), (IMP)&_logos_method$_ungrouped$MailComposeController$sendMessage, (IMP*)&_logos_orig$_ungrouped$MailComposeController$sendMessage);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForNewMessage), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForNewMessage, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForNewMessage);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForDraft:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForDraft$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForDraft$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForReplyToMessage:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForReplyToMessage$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForReplyToMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForReplyAllToMessage:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForReplyAllToMessage$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForReplyAllToMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForForwardOfMessage:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForForwardOfMessage$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForForwardOfMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForAutosavedMessage:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForAutosavedMessage$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForAutosavedMessage$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_setupForExistingNewMessage:headers:), (IMP)&_logos_method$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_setupForExistingNewMessage$headers$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_quoteReplyMessage:content:), (IMP)&_logos_method$_ungrouped$MailComposeController$_quoteReplyMessage$content$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_quoteReplyMessage$content$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_quoteForwardedMessage:content:), (IMP)&_logos_method$_ungrouped$MailComposeController$_quoteForwardedMessage$content$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_quoteForwardedMessage$content$);MSHookMessageEx(_logos_class$_ungrouped$MailComposeController, @selector(_quoteBody:), (IMP)&_logos_method$_ungrouped$MailComposeController$_quoteBody$, (IMP*)&_logos_orig$_ungrouped$MailComposeController$_quoteBody$);Class _logos_class$_ungrouped$ComposeViewController = objc_getClass("ComposeViewController"); MSHookMessageEx(_logos_class$_ungrouped$ComposeViewController, @selector(mailComposeControllerCompositionFinished:), (IMP)&_logos_method$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$, (IMP*)&_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerCompositionFinished$);MSHookMessageEx(_logos_class$_ungrouped$ComposeViewController, @selector(mailComposeControllerWillAttemptToSend:), (IMP)&_logos_method$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$, (IMP*)&_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerWillAttemptToSend$);MSHookMessageEx(_logos_class$_ungrouped$ComposeViewController, @selector(mailComposeControllerDidAttemptToSend:mailDelivery:), (IMP)&_logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$, (IMP*)&_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSend$mailDelivery$);MSHookMessageEx(_logos_class$_ungrouped$ComposeViewController, @selector(mailComposeControllerDidAttemptToSaveDraft:account:result:), (IMP)&_logos_method$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$, (IMP*)&_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerDidAttemptToSaveDraft$account$result$);MSHookMessageEx(_logos_class$_ungrouped$ComposeViewController, @selector(mailComposeControllerFinishedLoadingInitialAttachments:), (IMP)&_logos_method$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$, (IMP*)&_logos_orig$_ungrouped$ComposeViewController$mailComposeControllerFinishedLoadingInitialAttachments$);Class _logos_class$_ungrouped$DeliveryQueue = objc_getClass("DeliveryQueue"); MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(processDeliveryQueueStartingAtIndex:), (IMP)&_logos_method$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$processDeliveryQueueStartingAtIndex$);MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(setPercentDone:), (IMP)&_logos_method$_ungrouped$DeliveryQueue$setPercentDone$, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$setPercentDone$);MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(_performDeliveryOfMessage:usingAccount:accountUsed:), (IMP)&_logos_method$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$_performDeliveryOfMessage$usingAccount$accountUsed$);MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(_deliverQueuedMessages:), (IMP)&_logos_method$_ungrouped$DeliveryQueue$_deliverQueuedMessages$, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$_deliverQueuedMessages$);MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(appendMessageToQueue:replacingOriginalMessage:), (IMP)&_logos_method$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$appendMessageToQueue$replacingOriginalMessage$);MSHookMessageEx(_logos_class$_ungrouped$DeliveryQueue, @selector(potentialAlternateDeliveryAccounts), (IMP)&_logos_method$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts, (IMP*)&_logos_orig$_ungrouped$DeliveryQueue$potentialAlternateDeliveryAccounts);Class _logos_class$_ungrouped$MailMessageLibrary = objc_getClass("MailMessageLibrary"); MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(setBusyHandler:context:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$setBusyHandler$context$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$setBusyHandler$context$);MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(iterateStatement:db:withProgressMonitor:andRowHandler:context:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$iterateStatement$db$withProgressMonitor$andRowHandler$context$);MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(sendMessagesForStatement:db:to:options:timestamp:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesForStatement$db$to$options$timestamp$);MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(sendMessagesMatchingQuery:to:options:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$sendMessagesMatchingQuery$to$options$);MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(messagesMatchingQuery:options:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$messagesMatchingQuery$options$);MSHookMessageEx(_logos_class$_ungrouped$MailMessageLibrary, @selector(locationOfMessageID:inMailbox:), (IMP)&_logos_method$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$, (IMP*)&_logos_orig$_ungrouped$MailMessageLibrary$locationOfMessageID$inMailbox$);Class _logos_class$_ungrouped$MessageLibrary = objc_getClass("MessageLibrary"); MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(duplicateMessages:newRemoteIDs:forMailbox:setFlags:clearFlags:messageFlagsForMessages:createNewCacheFiles:), (IMP)&_logos_method$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$duplicateMessages$newRemoteIDs$forMailbox$setFlags$clearFlags$messageFlagsForMessages$createNewCacheFiles$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(messagesForMailbox:olderThanNumberOfDays:), (IMP)&_logos_method$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$messagesForMailbox$olderThanNumberOfDays$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(messageWithMessageID:options:inMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$options$inMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(messagesWithMessageIDHeader:), (IMP)&_logos_method$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$messagesWithMessageIDHeader$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(messageWithLibraryID:options:inMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$messageWithLibraryID$options$inMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(unreadCountForMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$unreadCountForMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$unreadCountForMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(deletedCountForMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$deletedCountForMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$deletedCountForMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(nonDeletedCountForMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(nonDeletedCountForMailbox:includeServerSearchResults:includeThreadSearchResults:), (IMP)&_logos_method$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$nonDeletedCountForMailbox$includeServerSearchResults$includeThreadSearchResults$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(totalCountForMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$totalCountForMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$totalCountForMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(messageWithMessageID:inMailbox:), (IMP)&_logos_method$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$messageWithMessageID$inMailbox$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(dataConsumerForMessage:part:), (IMP)&_logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(dataConsumerForMessage:part:incomplete:), (IMP)&_logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$part$incomplete$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(dataConsumerForMessage:isPartial:), (IMP)&_logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$isPartial$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(dataConsumerForMessage:), (IMP)&_logos_method$_ungrouped$MessageLibrary$dataConsumerForMessage$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$dataConsumerForMessage$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(setMessage:isPartial:), (IMP)&_logos_method$_ungrouped$MessageLibrary$setMessage$isPartial$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$setMessage$isPartial$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(setFlags:forMessage:), (IMP)&_logos_method$_ungrouped$MessageLibrary$setFlags$forMessage$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$setFlags$forMessage$);MSHookMessageEx(_logos_class$_ungrouped$MessageLibrary, @selector(addMessages:withMailbox:fetchBodies:newMessagesByOldMessage:), (IMP)&_logos_method$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$, (IMP*)&_logos_orig$_ungrouped$MessageLibrary$addMessages$withMailbox$fetchBodies$newMessagesByOldMessage$);}}
	NSLog(@"qhk Select All Mail: %%ctor 3.");
	[pool drain];
}



