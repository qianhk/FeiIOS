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


%hook MailDelivery

+(id)newWithMessage:(id)message
{
	%log;
	return %orig;
}

+(id)newWithHeaders:(id)headers mixedContent:(id)content textPartsAreHTML:(BOOL)html
{
	%log;
	return %orig;
}

+(id)newWithHeaders:(id)headers HTML:(id)html plainTextAlternative:(id)alternative other:(id)other
{
	%log;
	return %orig;
}

+(BOOL)deliverMessage:(id)message
{
	%log;
	return %orig;
}

-(id)initWithMessage:(id)message
{
	%log;
	return %orig;
}

-(id)initWithHeaders:(id)headers mixedContent:(id)content textPartsAreHTML:(BOOL)html
{
	%log;
	return %orig;
}

-(id)initWithHeaders:(id)headers HTML:(id)html plainTextAlternative:(id)alternative other:(id)other
{
	%log;
	return %orig;
}


-(void)deliverAsynchronously
{
	%log;
	%orig;
}

-(int)deliverSynchronously
{
	%log;
	return %orig;
}

-(int)deliverMessageData:(id)data toRecipients:(id)recipients
{
	%log;
	return %orig;
}



%end

%hook OutgoingMessageDelivery


%end


%hook MailComposeController

-(void)send:(id)send
{
	%log;
	%orig;
}

-(void)sendMessage
{
	%log;
	%orig;
}

-(void)_setupForNewMessage
{
	%log;
	%orig;
}

-(void)_setupForDraft:(id)draft
{
	%log;
	%orig;
}

-(void)_setupForReplyToMessage:(id)message
{
	%log;
	%orig;
}

-(void)_setupForReplyAllToMessage:(id)message
{
	%log;
	%orig;
}

-(void)_setupForForwardOfMessage:(id)message
{
	%log;
	%orig;
}

-(void)_setupForAutosavedMessage:(id)autosavedMessage
{
	%log;
	%orig;
}

-(void)_setupForExistingNewMessage:(id)existingNewMessage headers:(id)headers
{
	%log;
	%orig;
}

-(void)_quoteReplyMessage:(id)message content:(id)content
{
	%log;
	%orig;
}

-(void)_quoteForwardedMessage:(id)message content:(id)content
{
	%log;
	%orig;
}

-(void)_quoteBody:(id)body
{
	%log;
	%orig;
}


%end

%hook ComposeViewController

- (void)mailComposeControllerCompositionFinished:(id)fp8
{
	%log;
	%orig;
}

- (void)mailComposeControllerWillAttemptToSend:(id)fp8
{
	%log;
	%orig;
}

- (void)mailComposeControllerDidAttemptToSend:(id)fp8 mailDelivery:(id)fp12
{
	%log;
	%orig;
}

- (void)mailComposeControllerDidAttemptToSaveDraft:(id)fp8 account:(id)fp12 result:(int)fp16
{
	%log;
	%orig;
}

- (void)mailComposeControllerFinishedLoadingInitialAttachments:(id)fp8
{
	%log;
	%orig;
}



%end

%hook DeliveryQueue

- (void)processDeliveryQueueStartingAtIndex:(unsigned int)fp8
{
	%log;
	%orig;
}

- (void)setPercentDone:(double)fp8
{
	%log;
	%orig;
}

- (int)_performDeliveryOfMessage:(id)fp8 usingAccount:(id)fp12 accountUsed:(id *)fp16
{
	%log;
	return %orig;
}

- (void)_deliverQueuedMessages:(id)fp8
{
	%log;
	%orig;
}

- (int)appendMessageToQueue:(id)fp8 replacingOriginalMessage:(id)fp12
{
	%log;
	return %orig;
}

- (id)potentialAlternateDeliveryAccounts
{
	%log;
	return %orig;
}


%end

//%hook MessageViewController
//
//- (void)_handleReplyWithType:(int)fp8 message:(id)fp12 loadRestOfMessage:(BOOL)fp16 includeAttachments:(BOOL)fp20
//{
//	%log;
//	%orig;
//}
//
//- (BOOL)shouldSnapshot
//{
//	%log;
//	return %orig;
//}
//
//- (void)updateTextSize
//{
//	%log;
//	%orig;
//}
//
//- (void)replyButtonClicked:(id)fp8
//{
//	%log;
//	%orig;
//}
//
//- (void)deleteButtonReallyClicked
//{
//	%log;
//	%orig;
//}
//
//- (void)deleteButtonClicked:(id)fp8
//{
//	%log;
//	%orig;
//}
//
//- (void)buttonBar:(id)fp8 didFinishAnimation:(int)fp12 forButton:(int)fp16
//{
//	%log;
//	%orig;
//}
//
//- (void)_reallyDeleteVisibleMessage
//{
//	%log;
//	%orig;
//}
//
//- (void)_deleteSuckEffectAnimationFinished
//{
//	%log;
//	%orig;
//}
//
//- (void)alertSheet:(id)fp8 buttonClicked:(int)fp12
//{
//	%log;
//	%orig;
//}
//
//- (void)displayAlertWithButtons:(id)fp8 title:(id)fp12 redIndex:(int)fp16 context:(id)fp20
//{
//	%log;
//	%orig;
//}
//
//
//%end

%hook MailMessageLibrary

-(void)setBusyHandler:(/*function-pointer*/ void*)handler context:(void*)context
{
	%log;
	%orig;
}

-(void)iterateStatement:(sqlite3_stmt*)statement db:(sqlite3*)db withProgressMonitor:(id)progressMonitor andRowHandler:(/*function-pointer*/ void*)handler context:(void*)context
{
	%log;
	%orig;
}

-(void)sendMessagesForStatement:(sqlite3_stmt*)statement db:(sqlite3*)db to:(id)to options:(unsigned)options timestamp:(double)timestamp
{
	%log;
	%orig;
}

-(void)sendMessagesMatchingQuery:(const char*)query to:(id)to options:(unsigned)options
{
	%log;
	%orig;
}

-(id)messagesMatchingQuery:(const char*)query options:(unsigned)options
{
	%log;
	return %orig;
}

-(unsigned)locationOfMessageID:(long long)messageID inMailbox:(id)mailbox
{
	%log;
	return %orig;
}


%end

%hook MessageLibrary

- (id)duplicateMessages:(id)messages newRemoteIDs:(id)ids forMailbox:(id)mailbox setFlags:(unsigned long long)flags clearFlags:(unsigned long long)flags5 messageFlagsForMessages:(id)messages6 createNewCacheFiles:(BOOL)files
{
	%log;
	return %orig;
}

- (id)messagesForMailbox:(id)mailbox olderThanNumberOfDays:(int)days
{
	%log;
	return %orig;
}

- (id)messageWithMessageID:(id)messageID options:(unsigned)options inMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (id)messagesWithMessageIDHeader:(id)messageIDHeader
{
	%log;
	return %orig;
}

- (id)messageWithLibraryID:(unsigned)libraryID options:(unsigned)options inMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (unsigned)unreadCountForMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (unsigned)deletedCountForMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (unsigned)nonDeletedCountForMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (unsigned)nonDeletedCountForMailbox:(id)mailbox includeServerSearchResults:(BOOL)results includeThreadSearchResults:(BOOL)results3
{
	%log;
	return %orig;
}

- (unsigned)totalCountForMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (id)messageWithMessageID:(id)messageID inMailbox:(id)mailbox
{
	%log;
	return %orig;
}

- (id)dataConsumerForMessage:(id)message part:(id)part
{
	%log;
	return %orig;
}

- (id)dataConsumerForMessage:(id)message part:(id)part incomplete:(BOOL)incomplete
{
	%log;
	return %orig;
}

- (id)dataConsumerForMessage:(id)message isPartial:(BOOL)partial
{
	%log;
	return %orig;
}

- (id)dataConsumerForMessage:(id)message
{
	%log;
	return %orig;
}

- (void)setMessage:(id)message isPartial:(BOOL)partial
{
	%log;
	%orig;
}

- (void)setFlags:(unsigned long long)flags forMessage:(id)message
{
	%log;
	%orig;
}

- (id)addMessages:(id)messages withMailbox:(id)mailbox fetchBodies:(BOOL)bodies newMessagesByOldMessage:(id)message
{
	%log;
	return %orig;
}


%end

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	NSLog(@"qhk Select All Mail: %%ctor 3.");
	[pool drain];
}



