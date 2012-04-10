#line 1 "/OnGit/FeiIOS/kanpod/kanpod/kanpod.xm"





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
#import "GraphicsServices/GSEvent.h"  

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
	
	
	for (i = 0; i < size; i++)
	{
		
		[str appendFormat:@"%s\n", strings[i]];
	}
	
	free (strings);
	NSLog(@"%@", str);
}

#include <substrate.h>
@class ML3MusicLibrary; @class MPMediaLibrary; 
static BOOL (*_logos_orig$_ungrouped$MPMediaLibrary$removeItems$)(MPMediaLibrary*, SEL, id); static BOOL _logos_method$_ungrouped$MPMediaLibrary$removeItems$(MPMediaLibrary*, SEL, id); static BOOL (*_logos_orig$_ungrouped$ML3MusicLibrary$writable)(ML3MusicLibrary*, SEL); static BOOL _logos_method$_ungrouped$ML3MusicLibrary$writable(ML3MusicLibrary*, SEL); static sqlite3 * (*_logos_meta_orig$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$)(Class, SEL, id, BOOL, id); static sqlite3 * _logos_meta_method$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$(Class, SEL, id, BOOL, id); static sqlite3 * (*_logos_orig$_ungrouped$ML3MusicLibrary$openedDatabaseHandle)(ML3MusicLibrary*, SEL); static sqlite3 * _logos_method$_ungrouped$ML3MusicLibrary$openedDatabaseHandle(ML3MusicLibrary*, SEL); static void (*_logos_meta_orig$_ungrouped$ML3MusicLibrary$setImportationEnabled$)(Class, SEL, BOOL); static void _logos_meta_method$_ungrouped$ML3MusicLibrary$setImportationEnabled$(Class, SEL, BOOL); static BOOL (*_logos_meta_orig$_ungrouped$ML3MusicLibrary$importationEnabled)(Class, SEL); static BOOL _logos_meta_method$_ungrouped$ML3MusicLibrary$importationEnabled(Class, SEL); 

#line 146 "/OnGit/FeiIOS/kanpod/kanpod/kanpod.xm"



















static BOOL _logos_method$_ungrouped$MPMediaLibrary$removeItems$(MPMediaLibrary* self, SEL _cmd, id items) {

	NSLog(@"-[<MPMediaLibrary: %p> removeItems:%@]", self, items);
	
	BOOL sucess = _logos_orig$_ungrouped$MPMediaLibrary$removeItems$(self, _cmd, items);
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: removeItems: %d, %p,%@",sucess, self, NSStringFromClass([items class])];
	
	if ([items isKindOfClass:[NSArray class]])
	{
		NSArray* arr = (NSArray *)items;
		if ([arr count] > 0)
		{
			id anItem = [arr objectAtIndex:0];
			[str appendFormat:@" firstItem %@", NSStringFromClass([anItem class])];




		}
	}
	
	NSLog(@"%@", str);


	return sucess;
}
















































































































































































































































































































































































































































































































































































































static BOOL _logos_method$_ungrouped$ML3MusicLibrary$writable(ML3MusicLibrary* self, SEL _cmd) {
	NSLog(@"-[<ML3MusicLibrary: %p> writable]", self);

	object_setInstanceVariable(self, "_enableWrites", (void *)YES);
	BOOL sucess = _logos_orig$_ungrouped$ML3MusicLibrary$writable(self, _cmd);
	NSLog(@"qhk kanpod: ML3MusicLibrary writable self=%p %d", self, sucess);
	return sucess;
}


static sqlite3 * _logos_meta_method$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$(Class self, SEL _cmd, id path, BOOL writes, id library) {
	NSLog(@"+[<ML3MusicLibrary: %p> _openedDatabaseHandleForPath:%@ enableWrites:%d forLibrary:%@]", self, path, writes, library);
	return _logos_meta_orig$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$(self, _cmd, path, writes, library);
}








static sqlite3 * _logos_method$_ungrouped$ML3MusicLibrary$openedDatabaseHandle(ML3MusicLibrary* self, SEL _cmd) {
	NSLog(@"-[<ML3MusicLibrary: %p> openedDatabaseHandle]", self);

	object_setInstanceVariable(self, "_enableWrites", (void *)YES);

	return _logos_orig$_ungrouped$ML3MusicLibrary$openedDatabaseHandle(self, _cmd);
}


static void _logos_meta_method$_ungrouped$ML3MusicLibrary$setImportationEnabled$(Class self, SEL _cmd, BOOL enabled) {
	NSLog(@"+[<ML3MusicLibrary: %p> setImportationEnabled:%d]", self, enabled);
	_logos_meta_orig$_ungrouped$ML3MusicLibrary$setImportationEnabled$(self, _cmd, enabled);
}


static BOOL _logos_meta_method$_ungrouped$ML3MusicLibrary$importationEnabled(Class self, SEL _cmd) {
	NSLog(@"+[<ML3MusicLibrary: %p> importationEnabled]", self);
	return _logos_meta_orig$_ungrouped$ML3MusicLibrary$importationEnabled(self, _cmd);
}













































































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
































































































































































































































































































































































static void (*ori_GSSendEvent)(const GSEventRecord* record, mach_port_t port) = GSSendEvent;
void replace_GSSendEvent(const GSEventRecord* record, mach_port_t port)
{


	ori_GSSendEvent(record, port);
}

static void (*ori_GSSendSimpleEvent)(GSEventType type, mach_port_t port) = GSSendSimpleEvent;
void replace_GSSendSimpleEvent(GSEventType type, mach_port_t port)
{

	ori_GSSendSimpleEvent(type, port);
}

static void (*ori_GSSendSystemEvent)(const GSEventRecord* record) = GSSendSystemEvent;
void replace_GSSendSystemEvent(const GSEventRecord* record)
{

	ori_GSSendSystemEvent(record);
}































static void (*oriEventCallBack)(GSEventRef event) = NULL;






void kaiEventCallBack(GSEventRef event)
{
	CFDictionaryRef dic = GSEventCreatePlistRepresentation(event);
	GSEventType type = GSEventGetType(event);
	GSEventSubType subType = GSEventGetSubType(event);
	NSLog(@"qhk in kaiEventCallBack %p %@ type=%d type=%d", event, dic, type, subType);
	CFRelease(dic);
	oriEventCallBack(event);
}

static void (*ori_GSEventRegisterEventCallBack)(void(*callback)(GSEventRef event)) = GSEventRegisterEventCallBack;

void replace_GSEventRegisterEventCallBack(void(*callback)(GSEventRef event))
{
	NSLog(@"qhk replace_GSEventRegisterEventCallBack");
	oriEventCallBack = callback;
	ori_GSEventRegisterEventCallBack(kaiEventCallBack);
}

static __attribute__((constructor)) void _logosLocalCtor_f52378e1()
{
	NSLog(@"qhk kanpod: init begin 5.");
	
	NSBundle* bundle = [NSBundle mainBundle];
	NSString* biden = [bundle bundleIdentifier];
	NSString* execPath = [bundle executablePath];
	mach_port_t curPort = GSCopyPurpleNamedPort([biden UTF8String]);
	NSLog(@"qhk kanpod: bundle %p %@, %@ port=0x%08X", bundle, biden, execPath, curPort);
	
	{{Class _logos_class$_ungrouped$MPMediaLibrary = objc_getClass("MPMediaLibrary"); MSHookMessageEx(_logos_class$_ungrouped$MPMediaLibrary, @selector(removeItems:), (IMP)&_logos_method$_ungrouped$MPMediaLibrary$removeItems$, (IMP*)&_logos_orig$_ungrouped$MPMediaLibrary$removeItems$);Class _logos_class$_ungrouped$ML3MusicLibrary = objc_getClass("ML3MusicLibrary"); Class _logos_metaclass$_ungrouped$ML3MusicLibrary = object_getClass(_logos_class$_ungrouped$ML3MusicLibrary); MSHookMessageEx(_logos_class$_ungrouped$ML3MusicLibrary, @selector(writable), (IMP)&_logos_method$_ungrouped$ML3MusicLibrary$writable, (IMP*)&_logos_orig$_ungrouped$ML3MusicLibrary$writable);MSHookMessageEx(_logos_metaclass$_ungrouped$ML3MusicLibrary, @selector(_openedDatabaseHandleForPath:enableWrites:forLibrary:), (IMP)&_logos_meta_method$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$, (IMP*)&_logos_meta_orig$_ungrouped$ML3MusicLibrary$_openedDatabaseHandleForPath$enableWrites$forLibrary$);MSHookMessageEx(_logos_class$_ungrouped$ML3MusicLibrary, @selector(openedDatabaseHandle), (IMP)&_logos_method$_ungrouped$ML3MusicLibrary$openedDatabaseHandle, (IMP*)&_logos_orig$_ungrouped$ML3MusicLibrary$openedDatabaseHandle);MSHookMessageEx(_logos_metaclass$_ungrouped$ML3MusicLibrary, @selector(setImportationEnabled:), (IMP)&_logos_meta_method$_ungrouped$ML3MusicLibrary$setImportationEnabled$, (IMP*)&_logos_meta_orig$_ungrouped$ML3MusicLibrary$setImportationEnabled$);MSHookMessageEx(_logos_metaclass$_ungrouped$ML3MusicLibrary, @selector(importationEnabled), (IMP)&_logos_meta_method$_ungrouped$ML3MusicLibrary$importationEnabled, (IMP*)&_logos_meta_orig$_ungrouped$ML3MusicLibrary$importationEnabled);}}





	
	MSHookFunction(sqlite3_open, replace_sqlite3_open, &ori_sqlite3_open);
	MSHookFunction(sqlite3_open_v2, replace_sqlite3_open_v2, &ori_sqlite3_open_v2);
	MSHookFunction(GSSendEvent, replace_GSSendEvent, &ori_GSSendEvent);
	MSHookFunction(GSSendSimpleEvent, replace_GSSendSimpleEvent, &ori_GSSendSimpleEvent);
	MSHookFunction(GSSendSystemEvent, replace_GSSendSystemEvent, &ori_GSSendSystemEvent);

	MSHookFunction(GSEventRegisterEventCallBack, replace_GSEventRegisterEventCallBack, &ori_GSEventRegisterEventCallBack);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, removefirstMedia, CFSTR("com.njnu.kai.kanpod/removefirst"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}



