
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFNotificationCenter.h>

#import <sqlite3.h>


#import <MediaPlayer/MPMediaQuery.h>
#import <MediaPlayer/MPMediaLibrary.h>
#import <MediaPlayer/MPMediaPlaylist.h>
#import <MediaPlayer/MPMediaItemCollection.h>

#import <objc/runtime.h>
#include <notify.h>

@interface MPMediaLibrary(Test)
+(void)syncGenerationDidChangeForLibraryDataProvider:(id)syncGeneration;
+(void)reloadDisplayValuesForLibraryDataProvider:(id)libraryDataProvider;
+(void)reloadDynamicPropertiesForLibraryDataProvider:(id)libraryDataProvider;
+(void)reloadLibraryDataProvider:(id)provider;
+(void)removeLibraryDataProvider:(id)provider removalReason:(int)reason;
+(void)addLibraryDataProvider:(id)provider;
+(id)libraryDataProviders;
+(id)_libraryDataProviders;
+(id)_libraryForDataProvider:(id)dataProvider;
+(id)mediaLibraryWithUniqueIdentifier:(id)uniqueIdentifier;
+(id)mediaLibraries;
+(id)_mediaLibraries;
+(void)setRunLoopForNotifications:(id)notifications;
+(void)setLibraryServerDisabled:(BOOL)disabled;
+(BOOL)isLibraryServerDisabled;
+(void)endDiscoveringMediaLibraries;
+(void)beginDiscoveringMediaLibraries;
+(id)deviceMediaLibrary;
+(void)setDefaultMediaLibrary:(id)library;
+(id)defaultMediaLibrary;
-(id)libraryDataProvider;
-(id)_initWithLibraryDataProvider:(id)libraryDataProvider;
-(void)_stopConnectionProgressDisplayLink;
-(void)_removeConnectionAssertion:(id)assertion;
-(void)_connectionProgressDisplayLinkCallback:(id)callback;
-(id)_collectionsForQueryCriteria:(id)queryCriteria;
-(void)_clearPendingDisconnection;
-(id)_itemsForQueryCriteria:(id)queryCriteria;
-(BOOL)playlistExistsWithPersistentID:(unsigned long long)persistentID;
-(BOOL)itemExistsWithPersistentID:(unsigned long long)persistentID;
-(void)setFilteringDisabled:(BOOL)disabled;
-(BOOL)isFilteringDisabled;
-(unsigned long long)_persistentIDForAssetURL:(id)assetURL;
-(id)pathForAssetURL:(id)assetURL;
-(BOOL)isValidAssetURL:(id)url;
-(id)syncValidity;
-(float)connectionProgress;
-(BOOL)performTransactionWithBlock:(id)block;
-(id)connectionAssertionWithIdentifier:(id)identifier;
-(void)connectWithAuthenticationData:(id)authenticationData completionBlock:(id)block;
-(BOOL)requiresAuthentication;
-(id)preferredSubtitleLanguages;
-(id)preferredAudioLanguages;
-(BOOL)isGeniusEnabled;
-(double)timestampForAppliedUbiquitousBookmarkKey:(id)appliedUbiquitousBookmarkKey;
-(void)updateUbiquitousBookmarksWithKey:(id)key bookmarkMediaValue:(id)value timestamp:(double)timestamp;
-(void)downloadItem:(id)item completionHandler:(id)handler;
-(BOOL)isArtworkIdenticalForItem:(id)item otherItem:(id)item2 compareRepresentativeItemArtwork:(BOOL)artwork missingAlwaysComparesEqual:(BOOL)equal;
-(BOOL)removePlaylist:(id)playlist;
-(BOOL)removeItems:(id)items;
-(id)addPlaylistWithName:(id)name activeGeniusPlaylist:(BOOL)playlist;
-(id)addPlaylistWithName:(id)name;
-(id)playlistWithPersistentID:(unsigned long long)persistentID;
-(id)newPlaylistWithPersistentID:(unsigned long long)persistentID;
-(id)itemWithPersistentID:(unsigned long long)persistentID verifyExistence:(BOOL)existence;
-(id)itemWithPersistentID:(unsigned long long)persistentID;
-(BOOL)hasVideoPodcasts;
-(BOOL)hasTVShows;
-(BOOL)hasMovieRentals;
-(BOOL)hasITunesUContent;
-(BOOL)hasCompilations;
-(BOOL)hasMovies;
-(BOOL)hasAudibleAudioBooks;
-(BOOL)hasMusicVideos;
-(BOOL)hasVideos;
-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined mediaType:(int)type queryIsEmptyBlock:(id)block;
-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined queryIsEmptyBlock:(id)block;
-(BOOL)hasAudiobooks;
-(BOOL)hasComposers;
-(BOOL)hasGenres;
-(BOOL)hasPodcasts;
-(BOOL)hasSongs;
-(BOOL)hasAlbums;
-(BOOL)hasArtists;
-(BOOL)hasPlaylists;
-(BOOL)hasGeniusMixes;
-(BOOL)hasMedia;
-(BOOL)hasMediaOfType:(int)type;
-(BOOL)libraryHasBeenModifiedWithToken:(id)token;
-(id)modificationToken;
-(id)uniqueIdentifier;
-(id)name;
-(int)status;
-(BOOL)writable;
-(long long)playlistGeneration;
-(unsigned long long)syncGenerationID;
-(void)endGeneratingLibraryChangeNotifications;
-(void)disconnect;
-(void)connectWithCompletionHandler:(id)completionHandler;
-(void)beginGeneratingLibraryChangeNotifications;
-(void)_displayValuesDidChangeNotification:(id)_displayValues;
-(void)_didReceiveMemoryWarning:(id)warning;
-(void)_reloadLibraryForDynamicPropertyChangeWithNotificationInfo:(id)notificationInfo;
-(void)_reloadLibraryForContentsChangeWithNotificationInfo:(id)notificationInfo;
-(void)_clearCachedContentData;
-(void)_clearCachedEntities;
@end

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

%hook MPMediaLibrary

//+ (id)defaultMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: defaultMediaLibrary %p", gaga);
//
//	return gaga;
//}

//+ (id)deviceMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: deviceMediaLibrary %p", gaga);
//	
//	return gaga;
//}

-(BOOL)removeItems:(id)items
{
//	print_trace();
	%log;
	
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

//+(void)syncGenerationDidChangeForLibraryDataProvider:(id)syncGeneration
//{
//	%log;
//	%orig;
//}
//
//+(void)reloadDisplayValuesForLibraryDataProvider:(id)libraryDataProvider
//{
//	%log;
//	%orig;
//}
//
//+(void)reloadDynamicPropertiesForLibraryDataProvider:(id)libraryDataProvider
//{
//	%log;
//	%orig;
//}
//
//+(void)reloadLibraryDataProvider:(id)provider
//{
//	%log;
//	%orig;
//}
//
//+(void)removeLibraryDataProvider:(id)provider removalReason:(int)reason
//{
//	%log;
//	%orig;
//}
//
//+(void)addLibraryDataProvider:(id)provider
//{
//	%log;
//	%orig;
//}
//
//+(id)libraryDataProviders
//{
//	%log;
//	return %orig;
//}
//
//+(id)_libraryDataProviders
//{
//	%log;
//	return %orig;
//}
//
//+(id)_libraryForDataProvider:(id)dataProvider
//{
//	%log;
//	return %orig;
//}
//
//+(id)mediaLibraryWithUniqueIdentifier:(id)uniqueIdentifier
//{
//	id xx = %orig;
//	NSLog(@"qhk kanpod: mediaLibraryWithUniqueIdentifier %@ %p", uniqueIdentifier, xx);
//	return xx;
//}
//
//+(id)mediaLibraries
//{
//	%log;
//	return %orig;
//}
//
//+(id)_mediaLibraries
//{
//	%log;
//	return %orig;
//}
//
//+(void)setRunLoopForNotifications:(id)notifications
//{
//	%log;
//	%orig;
//}
//
//+(void)setLibraryServerDisabled:(BOOL)disabled
//{
//	%log;
//	%orig;
//}
//
//+(BOOL)isLibraryServerDisabled
//{
//	%log;
//	return %orig;
//}
//
//+(void)endDiscoveringMediaLibraries
//{
//	%log;
//	%orig;
//}
//
//+(void)beginDiscoveringMediaLibraries
//{
//	%log;
//	%orig;
//}
//
//+(void)setDefaultMediaLibrary:(id)library
//{
//	%log;
//	%orig;
//}
//
//-(id)libraryDataProvider
//{
////	%log;
//	id xx = %orig;
//	NSLog(@"qhk kanpod: libraryDataProvider self=%p return=%p %@ %@", self, xx, [xx class], xx);
//	return xx;
//}
//
//-(id)_initWithLibraryDataProvider:(id)libraryDataProvider
//{
//	%log;
//	return %orig;
//}
//
//-(void)_stopConnectionProgressDisplayLink
//{
//	%log;
//	%orig;
//}
//
//-(void)_removeConnectionAssertion:(id)assertion
//{
//	%log;
//	%orig;
//}
//
//-(void)_connectionProgressDisplayLinkCallback:(id)callback
//{
//	%log;
//	%orig;
//}
//
//-(id)_collectionsForQueryCriteria:(id)queryCriteria
//{
//	%log;
//	return %orig;
//}
//
//-(void)_clearPendingDisconnection
//{
//	%log;
//	%orig;
//}
//
//-(id)_itemsForQueryCriteria:(id)queryCriteria
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)playlistExistsWithPersistentID:(unsigned long long)persistentID
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)itemExistsWithPersistentID:(unsigned long long)persistentID
//{
//	%log;
//	return %orig;
//}
//
//-(void)setFilteringDisabled:(BOOL)disabled
//{
//	%log;
//	%orig;
//}
//
//-(BOOL)isFilteringDisabled
//{
//	%log;
//	return %orig;
//}
//
//-(unsigned long long)_persistentIDForAssetURL:(id)assetURL
//{
//	%log;
//	return %orig;
//}
//
//-(id)pathForAssetURL:(id)assetURL
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)isValidAssetURL:(id)url
//{
//	%log;
//	return %orig;
//}
//
//-(id)syncValidity
//{
//	%log;
//	return %orig;
//}
//
//-(float)connectionProgress
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)performTransactionWithBlock:(id)block
//{
//	%log;
//	return %orig;
//}
//
//-(id)connectionAssertionWithIdentifier:(id)identifier
//{
//	%log;
//	return %orig;
//}
//
//-(void)connectWithAuthenticationData:(id)authenticationData completionBlock:(id)block
//{
//	%log;
//	%orig;
//}
//
//-(BOOL)requiresAuthentication
//{
//	%log;
//	return %orig;
//}
//
//-(id)preferredSubtitleLanguages
//{
//	%log;
//	return %orig;
//}
//
//-(id)preferredAudioLanguages
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)isGeniusEnabled
//{
//	%log;
//	return %orig;
//}
//
//-(double)timestampForAppliedUbiquitousBookmarkKey:(id)appliedUbiquitousBookmarkKey
//{
//	%log;
//	return %orig;
//}
//
//-(void)updateUbiquitousBookmarksWithKey:(id)key bookmarkMediaValue:(id)value timestamp:(double)timestamp
//{
//	%log;
//	%orig;
//}
//
//-(void)downloadItem:(id)item completionHandler:(id)handler
//{
//	%log;
//	%orig;
//}
//
//-(BOOL)isArtworkIdenticalForItem:(id)item otherItem:(id)item2 compareRepresentativeItemArtwork:(BOOL)artwork missingAlwaysComparesEqual:(BOOL)equal
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)removePlaylist:(id)playlist
//{
//	%log;
//	return %orig;
//}
//
//-(id)addPlaylistWithName:(id)name activeGeniusPlaylist:(BOOL)playlist
//{
//	%log;
//	return %orig;
//}
//
//-(id)addPlaylistWithName:(id)name
//{
//	%log;
//	return %orig;
//}
//
//-(id)playlistWithPersistentID:(unsigned long long)persistentID
//{
//	%log;
//	return %orig;
//}
//
//-(id)newPlaylistWithPersistentID:(unsigned long long)persistentID
//{
//	%log;
//	return %orig;
//}
//
//-(id)itemWithPersistentID:(unsigned long long)persistentID verifyExistence:(BOOL)existence
//{
//	%log;
//	return %orig;
//}
//
//-(id)itemWithPersistentID:(unsigned long long)persistentID
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasVideoPodcasts
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasTVShows
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasMovieRentals
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasITunesUContent
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasCompilations
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasMovies
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasAudibleAudioBooks
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasMusicVideos
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasVideos
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined mediaType:(int)type queryIsEmptyBlock:(id)block
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)_checkHasContent:(BOOL*)content determined:(BOOL*)determined queryIsEmptyBlock:(id)block
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasAudiobooks
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasComposers
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasGenres
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasPodcasts
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasSongs
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasAlbums
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasArtists
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasPlaylists
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasGeniusMixes
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasMedia
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)hasMediaOfType:(int)type
//{
//	%log;
//	return %orig;
//}
//
//-(BOOL)libraryHasBeenModifiedWithToken:(id)token
//{
//	%log;
//	return %orig;
//}
//
//-(id)modificationToken
//{
//	%log;
//	return %orig;
//}
//
//-(id)uniqueIdentifier
//{
////	%log;
//	id xx = %orig;
////	NSString* ii = (NSString *)xx;
//	NSLog(@"qhk kanpod: uniqueIdentifier self=%p return=%p %@ value=%@", self, xx, [xx class], xx);
//	return xx;
//}
//
//-(id)name
//{
//	%log;
//	return %orig;
//}
//
//-(int)status
//{
//	%log;
//	return %orig;
//}

//-(BOOL)writable
//{
//	BOOL sucess = %orig;
//	NSLog(@"qhk kanpod: MPMediaLibrary writable self=%p %d", self, sucess);
//	return sucess;
//}

//-(long long)playlistGeneration
//{
//	%log;
//	return %orig;
//}
//
//-(unsigned long long)syncGenerationID
//{
//	%log;
//	return %orig;
//}
//
//-(void)endGeneratingLibraryChangeNotifications
//{
//	%log;
//	%orig;
//}
//
//-(void)disconnect
//{
//	%log;
//	%orig;
//}
//
//-(void)connectWithCompletionHandler:(id)completionHandler
//{
//	%log;
//	%orig;
//}
//
//-(void)beginGeneratingLibraryChangeNotifications
//{
//	%log;
//	%orig;
//}
//
//-(void)_displayValuesDidChangeNotification:(id)_displayValues
//{
//	%log;
//	%orig;
//}
//
//-(void)_didReceiveMemoryWarning:(id)warning
//{
//	%log;
//	%orig;
//}
//
//-(void)_reloadLibraryForDynamicPropertyChangeWithNotificationInfo:(id)notificationInfo
//{
//	%log;
//	%orig;
//}
//
//-(void)_reloadLibraryForContentsChangeWithNotificationInfo:(id)notificationInfo
//{
//	%log;
//	%orig;
//}
//
//-(void)_clearCachedContentData
//{
//	%log;
//	%orig;
//}
//
//-(void)_clearCachedEntities
//{
//	%log;
//	%orig;
//}



%end

//@interface ML3MusicLibrary
//{
//	BOOL _enableWrites;
//}
//@end
//
//@interface ML3MusicLibrary(xxxxxxxx)
//- (void)setEnableWrite;
//@end
//
//@implementation ML3MusicLibrary(xxxxxxxx)
//
//- (void)setEnableWrite
//{
//	_enableWrites = YES;
//}
//
//@end

%hook ML3MusicLibrary

- (BOOL)writable
{
	%log;
//	print_trace();
	object_setInstanceVariable(self, "_enableWrites", (void *)YES);
	BOOL sucess = %orig;
	NSLog(@"qhk kanpod: ML3MusicLibrary writable self=%p %d", self, sucess);
	return sucess;
}

+ (sqlite3 *)_openedDatabaseHandleForPath:(id)path enableWrites:(BOOL)writes forLibrary:(id)library
{
	%log;
	return %orig;
}

//+ (sqlite3 *)openedDatabaseHandleForPath:(id)path enableWrites:(BOOL)writes
//{
//	%log;
//	return %orig;
//}

- (sqlite3 *)openedDatabaseHandle
{
	%log;
//	[self setEnableWrite];
	object_setInstanceVariable(self, "_enableWrites", (void *)YES);
//	NSLog(@"qhk kanpod: ML3MusicLibrary openedDatabaseHandle self=%p", self);
	return %orig;
}

+ (void)setImportationEnabled:(BOOL)enabled
{
	%log;
	%orig;
}

+ (BOOL)importationEnabled
{
	%log;
	return %orig;
}

%end

//%hook IUMediaListDataSource
//
//- (BOOL)deleteIndex:(unsigned)index
//{
//	%log;
//	BOOL sucess = %orig;
//	NSLog(@"qhk kanpod: result=%d deleteIndex:%u", sucess, index);
//	return sucess;
//}
//
//%end
//
//%hook IUMediaQueriesDataSource
//
//- (BOOL)deleteIndexesInRange:(NSRange)range
//{
//	%log;
//	BOOL sucess = %orig;
//	NSLog(@"qhk kanpod: deleteIndexesInRange %d %d", range.location, range.length);
//	return sucess;
//}
//
//%end

//%hook NSFileManager
//
//+ (NSFileManager *)defaultManager
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSDictionary *)attributesOfFileSystemForPath:(NSString *)path error:(NSError **)error
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)setAttributes:(NSDictionary *)attributes ofItemAtPath:(NSString *)path error:(NSError **)error
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)fileExistsAtPath:(NSString *)path
//{
//	%log;
//	NSLog(@"path %@", path);
//	return %orig;
//}
//
//- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory
//{
//	%log;
//	NSLog(@"path %@", path);
//	return %orig;
//}
//
//
//
//
//
//%end

static void removefirstMedia(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	MPMediaLibrary* library = [MPMediaLibrary defaultMediaLibrary];
	NSDate* date = [library lastModifiedDate];
	BOOL writable = [library writable];
	MPMediaQuery* songsQuery = [MPMediaQuery songsQuery];
    NSArray* songs = [songsQuery items];
	NSMutableString* str = [NSMutableString stringWithFormat:@"library=%p %@ writable=%d count=%d", library, date, writable ,[songs count]];
	if ([songs count] > 0)
	{
		MPMediaItem* item = [songs objectAtIndex:0];
		[str appendFormat:@"\n%@ - %@\n", [item valueForProperty:MPMediaItemPropertyArtist], [item valueForProperty:MPMediaItemPropertyTitle]];
		NSArray* deleteItems = [NSArray arrayWithObject:item];
		//		MPMediaItemCollection* coll = [MPMediaItemCollection collectionWithItems:deleteItems];
		
		BOOL haveRemove = [library respondsToSelector:@selector(removeItems:)];
		BOOL removeSucess = NO;
		if (haveRemove)
		{
			removeSucess = [library removeItems:deleteItems];
		}
		
		[str appendFormat:@"haveRemoveItems:haveRemoveMehtod=%d removeResult=%d", haveRemove,removeSucess];
		NSLog(@"qhk kanpad: static void removefirstMedia()\n%@", str);
    }

}

//extern void CFNotificationCenterAddObserver(CFNotificationCenterRef center, const void *observer, CFNotificationCallback callBack, CFStringRef name, const void *object, CFNotificationSuspensionBehavior suspensionBehavior);

static int (*ori_sqlite3_open)(const char *filename, sqlite3 **ppdb) = sqlite3_open;
int replace_sqlite3_open(const char * filename, sqlite3 **ppdb)
{
	NSLog(@"sqlite3_open %s", filename);
	return ori_sqlite3_open(filename, ppdb);
}

static int (*ori_sqlite3_open_v2)(const char *filename, sqlite3 **ppdb, int flags, const char *zVfs) = sqlite3_open_v2;
int replace_sqlite3_open_v2(const char * filename, sqlite3 **ppdb, int flags, const char* zVfs)
{
	NSLog(@"sqlite3_open_v2 %s flags=0x%X, zfs=%s", filename, flags, zVfs);
	print_trace();
	int r = ori_sqlite3_open_v2(filename, ppdb, flags, zVfs);
	NSLog(@"sqlite3_open_v2 return %d", r);
	return r;
}

//%hook NSBundle
//
//- (NSString *)bundleIdentifier
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)executablePath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)executableURL
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSBundle *)mainBundle
//{
//	%log;
//	id xx = %orig;
////	NSLog(@"qhk kanpod: mainBundle: return %p", xx);
//	return xx;
//}
//
//+ (NSBundle *)bundleWithPath:(NSString *)path
//{
//	%log;
//	
//	return %orig;
//}
//
//- (id)initWithPath:(NSString *)path
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSBundle *)bundleWithURL:(NSURL *)url
//{
//	%log;
//	
//	return %orig;
//}
//
//- (id)initWithURL:(NSURL *)url
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSBundle *)bundleForClass:(Class)aClass
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSBundle *)bundleWithIdentifier:(NSString *)identifier
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSArray *)allBundles
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSArray *)allFrameworks
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)load
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)isLoaded
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)unload
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)preflightAndReturnError:(NSError **)error
//{
//	%log;
//	
//	return %orig;
//}
//
//- (BOOL)loadAndReturnError:(NSError **)error
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)bundleURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)resourceURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)URLForAuxiliaryExecutable:(NSString *)executableName
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)privateFrameworksURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)sharedFrameworksURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)sharedSupportURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)builtInPlugInsURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSURL *)appStoreReceiptURL
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)bundlePath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)resourcePath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)pathForAuxiliaryExecutable:(NSString *)executableName
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)privateFrameworksPath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)sharedFrameworksPath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)sharedSupportPath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)builtInPlugInsPath
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSDictionary *)infoDictionary
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSDictionary *)localizedInfoDictionary
//{
//	%log;
//	
//	return %orig;
//}
//
//- (id)objectForInfoDictionaryKey:(NSString *)key
//{
//	%log;
//	
//	return %orig;
//}
//
//- (Class)classNamed:(NSString *)className
//{
//	%log;
//	
//	return %orig;
//}
//
//- (Class)principalClass
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSArray *)localizations
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSArray *)preferredLocalizations
//{
//	%log;
//	
//	return %orig;
//}
//
//- (NSString *)developmentLocalization
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSArray *)preferredLocalizationsFromArray:(NSArray *)localizationsArray
//{
//	%log;
//	
//	return %orig;
//}
//
//+ (NSArray *)preferredLocalizationsFromArray:(NSArray *)localizationsArray forPreferences:(NSArray *)preferencesArray
//{
//	%log;
//	
//	return %orig;
//}
//
//
//%end

%ctor
{
	NSLog(@"qhk kanpod: init begin.");
	
	NSBundle* bundle = [NSBundle mainBundle];
	NSString* biden = [bundle bundleIdentifier];
	NSString* execPath = [bundle executablePath];
	NSLog(@"qhk kanpod: bundle %p %@, %@", bundle, biden, execPath);
	
	%init;
//	currentTransform = CATransform3DIdentity;
//	icons = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
//	notify_register_check("com.apple.springboard.rawOrientation", &notify_token);
//	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, OrientationChangedCallback, CFSTR("com.apple.springboard.rawOrientation"), NULL, CFNotificationSuspensionBehaviorCoalesce);
//	NSLog(@"qhk: IconRotator init end.");
	
	MSHookFunction(sqlite3_open, replace_sqlite3_open, &ori_sqlite3_open);
	MSHookFunction(sqlite3_open_v2, replace_sqlite3_open_v2, &ori_sqlite3_open_v2);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, removefirstMedia, CFSTR("com.njnu.kai.kanpod/removefirst"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}



