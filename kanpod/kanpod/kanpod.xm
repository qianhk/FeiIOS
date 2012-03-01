
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


%hook MPMediaLibrary

//+ (id)defaultMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: defaultMediaLibrary %p", gaga);
//
//	return gaga;
//}
//
//+ (id)deviceMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: deviceMediaLibrary %p", gaga);
//	
//	return gaga;
//}

- (void)messageWithNoReturnAndOneArgument:(id)originalArgument
{
	%log;

	%orig(originalArgument);
	
	// or, for exmaple, you could use a custom value instead of the original argument: %orig(customValue);
}

#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

void print_trace (void)
{
	void *array[20];
	size_t size;
	char **strings;
	size_t i;
	
	size = backtrace (array, 20);
	strings = backtrace_symbols (array, size);
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: Obtained %zd stack frames.\n", size];
	//	printf ("Obtained %zd stack frames.\n", size);
	
	for (i = 0; i < size; i++)
	{
		//		printf ("%s\n", strings[i]);
		[str appendFormat:@"%s\n", strings[i]];
	}
	
	free (strings);
	NSLog(@"%@", str);
}

-(BOOL)removeItems:(id)items
{
	print_trace();
	
	BOOL sucess = %orig;
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: removeItems: %d, %p,%@",sucess, self, NSStringFromClass([items class])];
	
	if ([items isKindOfClass:[NSArray class]])
	{
		NSArray* arr = (NSArray *)items;
		if ([arr count] > 0)
		{
			id anItem = [arr objectAtIndex:0];
			[str appendFormat:@" firstItem %@", NSStringFromClass([anItem class])];
//			if ([anItem isKindOfClass:[MPConcreteMediaItem class]])
//			{
//				MPConcreteMediaItem* mediaItem = (MPConcreteMediaItem *)anItem;
//			}
		}
	}
	
	NSLog(@"%@", str);


	return sucess;
}

+(void)syncGenerationDidChangeForLibraryDataProvider:(id)syncGeneration
{
	%log;
	%orig;
}

+(void)reloadDisplayValuesForLibraryDataProvider:(id)libraryDataProvider
{
	%log;
	%orig;
}

+(void)reloadDynamicPropertiesForLibraryDataProvider:(id)libraryDataProvider
{
	%log;
	%orig;
}

+(void)reloadLibraryDataProvider:(id)provider
{
	%log;
	%orig;
}

+(void)removeLibraryDataProvider:(id)provider removalReason:(int)reason
{
	%log;
	%orig;
}

+(void)addLibraryDataProvider:(id)provider
{
	%log;
	%orig;
}

+(id)libraryDataProviders
{
	%log;
	%orig;
}

+(id)_libraryDataProviders
{
	%log;
	%orig;
}

+(id)_libraryForDataProvider:(id)dataProvider
{
	%log;
	%orig;
}

+(id)mediaLibraryWithUniqueIdentifier:(id)uniqueIdentifier
{
	%log;
	%orig;
}

+(id)mediaLibraries
{
	%log;
	%orig;
}

+(id)_mediaLibraries
{
	%log;
	%orig;
}

+(void)setRunLoopForNotifications:(id)notifications
{
	%log;
	%orig;
}

+(void)setLibraryServerDisabled:(BOOL)disabled
{
	%log;
	%orig;
}

+(BOOL)isLibraryServerDisabled
{
	%log;
	%orig;
}

+(void)endDiscoveringMediaLibraries
{
	%log;
	%orig;
}

+(void)beginDiscoveringMediaLibraries
{
	%log;
	%orig;
}

+(id)deviceMediaLibrary
{
	%log;
	%orig;
}

+(void)setDefaultMediaLibrary:(id)library
{
	%log;
	%orig;
}

+(id)defaultMediaLibrary
{
	%log;
	%orig;
}

-(id)libraryDataProvider
{
	%log;
	%orig;
}

-(id)_initWithLibraryDataProvider:(id)libraryDataProvider
{
	%log;
	%orig;
}

-(void)_stopConnectionProgressDisplayLink
{
	%log;
	%orig;
}

-(void)_removeConnectionAssertion:(id)assertion
{
	%log;
	%orig;
}

-(void)_connectionProgressDisplayLinkCallback:(id)callback
{
	%log;
	%orig;
}

-(id)_collectionsForQueryCriteria:(id)queryCriteria
{
	%log;
	%orig;
}

-(void)_clearPendingDisconnection
{
	%log;
	%orig;
}

-(id)_itemsForQueryCriteria:(id)queryCriteria
{
	%log;
	%orig;
}

-(BOOL)playlistExistsWithPersistentID:(unsigned long long)persistentID
{
	%log;
	%orig;
}

-(BOOL)itemExistsWithPersistentID:(unsigned long long)persistentID
{
	%log;
	%orig;
}

-(void)setFilteringDisabled:(BOOL)disabled
{
	%log;
	%orig;
}

-(BOOL)isFilteringDisabled
{
	%log;
	%orig;
}

-(unsigned long long)_persistentIDForAssetURL:(id)assetURL
{
	%log;
	%orig;
}

-(id)pathForAssetURL:(id)assetURL
{
	%log;
	%orig;
}

-(BOOL)isValidAssetURL:(id)url
{
	%log;
	%orig;
}

-(id)syncValidity
{
	%log;
	%orig;
}

-(float)connectionProgress
{
	%log;
	%orig;
}

-(BOOL)performTransactionWithBlock:(id)block
{
	%log;
	%orig;
}

-(id)connectionAssertionWithIdentifier:(id)identifier
{
	%log;
	%orig;
}

-(void)connectWithAuthenticationData:(id)authenticationData completionBlock:(id)block
{
	%log;
	%orig;
}

-(BOOL)requiresAuthentication
{
	%log;
	%orig;
}

-(id)preferredSubtitleLanguages
{
	%log;
	%orig;
}

-(id)preferredAudioLanguages
{
	%log;
	%orig;
}

-(BOOL)isGeniusEnabled
{
	%log;
	%orig;
}

-(double)timestampForAppliedUbiquitousBookmarkKey:(id)appliedUbiquitousBookmarkKey
{
	%log;
	%orig;
}

-(void)updateUbiquitousBookmarksWithKey:(id)key bookmarkMediaValue:(id)value timestamp:(double)timestamp
{
	%log;
	%orig;
}

-(void)downloadItem:(id)item completionHandler:(id)handler
{
	%log;
	%orig;
}

-(BOOL)isArtworkIdenticalForItem:(id)item otherItem:(id)item2 compareRepresentativeItemArtwork:(BOOL)artwork missingAlwaysComparesEqual:(BOOL)equal
{
	%log;
	%orig;
}

-(BOOL)removePlaylist:(id)playlist
{
	%log;
	%orig;
}

-(BOOL)removeItems:(id)items
{
	%log;
	%orig;
}

-(id)addPlaylistWithName:(id)name activeGeniusPlaylist:(BOOL)playlist
{
	%log;
	%orig;
}

-(id)addPlaylistWithName:(id)name
{
	%log;
	%orig;
}

-(id)playlistWithPersistentID:(unsigned long long)persistentID
{
	%log;
	%orig;
}

-(id)newPlaylistWithPersistentID:(unsigned long long)persistentID
{
	%log;
	%orig;
}

-(id)itemWithPersistentID:(unsigned long long)persistentID verifyExistence:(BOOL)existence
{
	%log;
	%orig;
}

-(id)itemWithPersistentID:(unsigned long long)persistentID
{
	%log;
	%orig;
}

-(BOOL)hasVideoPodcasts
{
	%log;
	%orig;
}

-(BOOL)hasTVShows
{
	%log;
	%orig;
}

-(BOOL)hasMovieRentals
{
	%log;
	%orig;
}

-(BOOL)hasITunesUContent
{
	%log;
	%orig;
}

-(BOOL)hasCompilations
{
	%log;
	%orig;
}

-(BOOL)hasMovies
{
	%log;
	%orig;
}

-(BOOL)hasAudibleAudioBooks
{
	%log;
	%orig;
}

-(BOOL)hasMusicVideos
{
	%log;
	%orig;
}

-(BOOL)hasVideos
{
	%log;
	%orig;
}

-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined mediaType:(int)type queryIsEmptyBlock:(id)block
{
	%log;
	%orig;
}

-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined queryIsEmptyBlock:(id)block
{
	%log;
	%orig;
}

-(BOOL)hasAudiobooks
{
	%log;
	%orig;
}

-(BOOL)hasComposers
{
	%log;
	%orig;
}

-(BOOL)hasGenres
{
	%log;
	%orig;
}

-(BOOL)hasPodcasts
{
	%log;
	%orig;
}

-(BOOL)hasSongs
{
	%log;
	%orig;
}

-(BOOL)hasAlbums
{
	%log;
	%orig;
}

-(BOOL)hasArtists
{
	%log;
	%orig;
}

-(BOOL)hasPlaylists
{
	%log;
	%orig;
}

-(BOOL)hasGeniusMixes
{
	%log;
	%orig;
}

-(BOOL)hasMedia
{
	%log;
	%orig;
}

-(BOOL)hasMediaOfType:(int)type
{
	%log;
	%orig;
}

-(BOOL)libraryHasBeenModifiedWithToken:(id)token
{
	%log;
	%orig;
}

-(id)modificationToken
{
	%log;
	%orig;
}

-(id)uniqueIdentifier
{
	%log;
	%orig;
}

-(id)name
{
	%log;
	%orig;
}

-(int)status
{
	%log;
	%orig;
}

-(BOOL)writable
{
	%log;
	%orig;
}

-(long long)playlistGeneration
{
	%log;
	%orig;
}

-(unsigned long long)syncGenerationID
{
	%log;
	%orig;
}

-(void)endGeneratingLibraryChangeNotifications
{
	%log;
	%orig;
}

-(void)disconnect
{
	%log;
	%orig;
}

-(void)connectWithCompletionHandler:(id)completionHandler
{
	%log;
	%orig;
}

-(void)beginGeneratingLibraryChangeNotifications
{
	%log;
	%orig;
}

-(void)_displayValuesDidChangeNotification:(id)_displayValues
{
	%log;
	%orig;
}

-(void)_didReceiveMemoryWarning:(id)warning
{
	%log;
	%orig;
}

-(void)_reloadLibraryForDynamicPropertyChangeWithNotificationInfo:(id)notificationInfo
{
	%log;
	%orig;
}

-(void)_reloadLibraryForContentsChangeWithNotificationInfo:(id)notificationInfo
{
	%log;
	%orig;
}

-(void)_clearCachedContentData
{
	%log;
	%orig;
}

-(void)_clearCachedEntities
{
	%log;
	%orig;
}



%end

%hook IUMediaListDataSource

- (BOOL)deleteIndex:(unsigned)index
{
	BOOL sucess = %orig;
	NSLog(@"qhk kanpod: result=%d deleteIndex:%u", sucess, index);
}

%end

%hook IUMediaQueriesDataSource

- (BOOL)deleteIndexesInRange:(NSRange)range
{
	BOOL sucess = %orig;
	NSLog(@"qhk kanpod: deleteIndexesInRange %d %d", range.location, range.length);
	return sucess;
}

%end

%ctor
{
	NSLog(@"qhk kanpod: init begin.");
	%init;
//	currentTransform = CATransform3DIdentity;
//	icons = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
//	notify_register_check("com.apple.springboard.rawOrientation", &notify_token);
//	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, OrientationChangedCallback, CFSTR("com.apple.springboard.rawOrientation"), NULL, CFNotificationSuspensionBehaviorCoalesce);
//	NSLog(@"qhk: IconRotator init end.");
}



