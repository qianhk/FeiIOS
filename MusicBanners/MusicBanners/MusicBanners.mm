#line 1 "/OnGit/FeiIOS/MusicBanners/MusicBanners/MusicBanners.xm"
#import <Foundation/Foundation.h>
#import <SpringBoard/SpringBoard.h>
#import "BulletinBoard/BulletinBoard.h"







__attribute__((visibility("hidden")))
@interface MusicBannersProvider : NSObject<BBDataProvider> {
@private
	BBBulletinRequest *bulletin;
	NSString *nowPlayingTitle;
	NSString *nowPlayingArtist;
	NSString *nowPlayingAlbum;
	UIImage *nowPlayingImage;
}

@end

@implementation MusicBannersProvider

static MusicBannersProvider *sharedProvider;


+ (MusicBannersProvider *)sharedProvider {
	return [[sharedProvider retain] autorelease];
}


- (id)init {
	if ((self = [super init])) {
		sharedProvider = self;
	}
	return self;
}


- (void)dealloc {
	sharedProvider = nil;
	[bulletin release];
	[nowPlayingTitle release];
	[nowPlayingArtist release];
	[nowPlayingAlbum release];
	[nowPlayingImage release];
	[super dealloc];
}


- (NSString *)sectionIdentifier {
	return @"com.apple.mobileipod";
}


- (NSArray *)sortDescriptors {
	return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
}


- (NSArray *)bulletinsFilteredBy:(unsigned)by count:(unsigned)count lastCleared:(id)cleared {
	return nil;
}




- (NSString *)sectionDisplayName {
	return @"Music";
}


- (BBSectionInfo *)defaultSectionInfo {
	BBSectionInfo *sectionInfo = [BBSectionInfo defaultSectionInfoForType:0];
	sectionInfo.notificationCenterLimit = 10;
	sectionInfo.sectionID = [self sectionIdentifier];
	return sectionInfo;
}


#include <objc/message.h>
@class UIImage; @class BBServer; @class SBMediaController; 
static Class _logos_superclass$_ungrouped$BBServer; static void (*_logos_orig$_ungrouped$BBServer$_loadAllDataProviderPluginBundles)(BBServer*, SEL);static Class _logos_supermetaclass$_ungrouped$UIImage; static UIImage * (*_logos_meta_orig$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$)(Class, SEL, NSString *, int, CGFloat);static Class _logos_superclass$_ungrouped$SBMediaController; static void (*_logos_orig$_ungrouped$SBMediaController$_nowPlayingInfoChanged)(SBMediaController*, SEL);static void (*_logos_orig$_ungrouped$SBMediaController$setNowPlayingInfo$)(SBMediaController*, SEL, id);
static Class _logos_static_class$SBMediaController; 
#line 82 "/OnGit/FeiIOS/MusicBanners/MusicBanners/MusicBanners.xm"
- (void)dataProviderDidLoad {
	BOOL hasChanges = NO;
	SBMediaController *mc = [_logos_static_class$SBMediaController sharedInstance];
	NSString *title = mc.nowPlayingTitle;
	if ((title != nowPlayingTitle) && ![title isEqualToString:nowPlayingTitle])
	{
		[nowPlayingTitle release];
		nowPlayingTitle = [title copy];
		hasChanges = YES;
	}
	NSString *artist = mc.nowPlayingArtist;
	if ((artist != nowPlayingArtist) && ![artist isEqualToString:nowPlayingArtist])
	{
		[nowPlayingArtist release];
		nowPlayingArtist = [artist copy];
		hasChanges = YES;
	}
	NSString *album = mc.nowPlayingAlbum;
	if ((album != nowPlayingArtist) && ![album isEqualToString:nowPlayingAlbum])
	{
		[nowPlayingAlbum release];
		nowPlayingAlbum = [album copy];
		hasChanges = YES;
	}
	if (hasChanges)
	{
		NSData *data = [[mc _nowPlayingInfo] objectForKey:@"artworkData"];
		if (data)
		{
			UIImage *image = [[UIImage alloc] initWithData:data];
			[nowPlayingImage release];
			nowPlayingImage = image;
		}
		else
		{
			[nowPlayingImage release];
			nowPlayingImage = nil;
		}
		BBDataProviderWithdrawBulletinsWithRecordID(self, @"com.apple.mobileipod/banner");
		if ([artist length] && [title length])
		{
			if (!bulletin)
			{
				bulletin = [[BBBulletinRequest alloc] init];
				bulletin.sectionID = @"com.apple.mobileipod/banner";
				bulletin.defaultAction = [BBAction actionWithLaunchURL:[NSURL URLWithString:@"music://"] callblock:nil];
				bulletin.bulletinID = @"com.apple.mobileipod/banner";
				bulletin.publisherBulletinID = @"com.apple.mobileipod/banner";
				bulletin.recordID = @"com.apple.mobileipod/banner";
				bulletin.showsUnreadIndicator = NO;
			}
			bulletin.title = title;
			bulletin.subtitle = album;
			bulletin.message = artist;
			NSDate *date = [NSDate date];
			bulletin.date = date;
			bulletin.lastInterruptDate = date;
			bulletin.primaryAttachmentType = nowPlayingImage ? 1 : 0;
			BBDataProviderAddBulletin(self, bulletin);
		}
	}
}


- (CGFloat)attachmentAspectRatioForRecordID:(NSString *)recordID {
	if (nowPlayingImage)
	{
		CGSize size = nowPlayingImage.size;
		if (size.height > 0.0f)
			return size.width / size.height;
	}
	return 1.0f;
}


- (NSData *)attachmentPNGDataForRecordID:(NSString *)recordID sizeConstraints:(BBThumbnailSizeConstraints *)constraints {
	if (constraints && nowPlayingImage) {
		CGSize imageSize = nowPlayingImage.size;
		CGSize maxSize;
		maxSize.width = constraints.fixedWidth;
		maxSize.height = constraints.fixedHeight;
		
		if (maxSize.width > 0.0f) {
			if (maxSize.height > 0.0f) {
				if (imageSize.width *maxSize.height > maxSize.width * imageSize.height)
					maxSize.height = maxSize.width * imageSize.height /  imageSize.width;
				else
					maxSize.width = maxSize.height * imageSize.width / imageSize.height;
			} else {
				maxSize.height = maxSize.width * imageSize.height /  imageSize.width;
			}
		} else {
			if (maxSize.height > 0.0f) {
				maxSize.width = maxSize.height * imageSize.width / imageSize.height;
			} else {
				
				return nil;
			}
		}
		UIGraphicsBeginImageContextWithOptions(maxSize, NO, constraints.thumbnailScale);
		CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationDefault);
		[nowPlayingImage drawInRect:(CGRect){{0.0f,0.0f},maxSize}];
		UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return UIImagePNGRepresentation(result);
	}
	return nil;
}

@end




static void _logos_super$_ungrouped$BBServer$_loadAllDataProviderPluginBundles(BBServer* self, SEL _cmd) {return ((void (*)(BBServer*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$BBServer, @selector(_loadAllDataProviderPluginBundles)))(self, _cmd);}static void _logos_method$_ungrouped$BBServer$_loadAllDataProviderPluginBundles(BBServer* self, SEL _cmd) {
	_logos_orig$_ungrouped$BBServer$_loadAllDataProviderPluginBundles(self, _cmd);
	MusicBannersProvider *p = [[MusicBannersProvider alloc] init];
	[self _addDataProvider:p sortSectionsNow:YES];
	[p release];
}






static UIImage * _logos_meta_super$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$(Class self, SEL _cmd, NSString * bundleIdentifier, int format, CGFloat scale) {return ((UIImage * (*)(Class, SEL, NSString *, int, CGFloat))class_getMethodImplementation(_logos_supermetaclass$_ungrouped$UIImage, @selector(_applicationIconImageForBundleIdentifier:format:scale:)))(self, _cmd, bundleIdentifier, format, scale);}static UIImage * _logos_meta_method$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$(Class self, SEL _cmd, NSString * bundleIdentifier, int format, CGFloat scale) {
	if ((format == 10) && [bundleIdentifier isEqualToString:@"com.apple.mobileipod"])
	{
		
		NSBundle *bundle = [NSBundle bundleWithPath:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"/Applications/Music~ipad.app" : @"/Applications/Music~iphone.app"];
		return [UIImage imageNamed:@"nc_icon.png" inBundle:bundle] ?: [[UIImage imageNamed:@"Icon-Small.png" inBundle:bundle] _applicationIconImageForFormat:format precomposed:YES scale:scale];
	}
	return _logos_meta_orig$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$(self, _cmd, bundleIdentifier, format, scale);
}






static void _logos_super$_ungrouped$SBMediaController$_nowPlayingInfoChanged(SBMediaController* self, SEL _cmd) {return ((void (*)(SBMediaController*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBMediaController, @selector(_nowPlayingInfoChanged)))(self, _cmd);}static void _logos_method$_ungrouped$SBMediaController$_nowPlayingInfoChanged(SBMediaController* self, SEL _cmd) {
	_logos_orig$_ungrouped$SBMediaController$_nowPlayingInfoChanged(self, _cmd);
	[sharedProvider dataProviderDidLoad];
}


static void _logos_super$_ungrouped$SBMediaController$setNowPlayingInfo$(SBMediaController* self, SEL _cmd, id newValue) {return ((void (*)(SBMediaController*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SBMediaController, @selector(setNowPlayingInfo:)))(self, _cmd, newValue);}static void _logos_method$_ungrouped$SBMediaController$setNowPlayingInfo$(SBMediaController* self, SEL _cmd, id newValue) {
	_logos_orig$_ungrouped$SBMediaController$setNowPlayingInfo$(self, _cmd, newValue);
	[sharedProvider dataProviderDidLoad];
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
{Class _logos_class$_ungrouped$BBServer = objc_getClass("BBServer"); _logos_superclass$_ungrouped$BBServer = class_getSuperclass(_logos_class$_ungrouped$BBServer); { Class _class = _logos_class$_ungrouped$BBServer;Method _method = class_getInstanceMethod(_class, @selector(_loadAllDataProviderPluginBundles));if (_method) {_logos_orig$_ungrouped$BBServer$_loadAllDataProviderPluginBundles = _logos_super$_ungrouped$BBServer$_loadAllDataProviderPluginBundles;if (!class_addMethod(_class, @selector(_loadAllDataProviderPluginBundles), (IMP)&_logos_method$_ungrouped$BBServer$_loadAllDataProviderPluginBundles, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$BBServer$_loadAllDataProviderPluginBundles = (void (*)(BBServer*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$BBServer$_loadAllDataProviderPluginBundles = (void (*)(BBServer*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$BBServer$_loadAllDataProviderPluginBundles);}}}Class _logos_class$_ungrouped$UIImage = objc_getClass("UIImage"); Class _logos_metaclass$_ungrouped$UIImage = object_getClass(_logos_class$_ungrouped$UIImage); _logos_supermetaclass$_ungrouped$UIImage = class_getSuperclass(_logos_metaclass$_ungrouped$UIImage); { Class _class = _logos_metaclass$_ungrouped$UIImage;Method _method = class_getInstanceMethod(_class, @selector(_applicationIconImageForBundleIdentifier:format:scale:));if (_method) {_logos_meta_orig$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$ = _logos_meta_super$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$;if (!class_addMethod(_class, @selector(_applicationIconImageForBundleIdentifier:format:scale:), (IMP)&_logos_meta_method$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$, method_getTypeEncoding(_method))) {_logos_meta_orig$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$ = (UIImage * (*)(Class, SEL, NSString *, int, CGFloat))method_getImplementation(_method);_logos_meta_orig$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$ = (UIImage * (*)(Class, SEL, NSString *, int, CGFloat))method_setImplementation(_method, (IMP)&_logos_meta_method$_ungrouped$UIImage$_applicationIconImageForBundleIdentifier$format$scale$);}}}Class _logos_class$_ungrouped$SBMediaController = objc_getClass("SBMediaController"); _logos_superclass$_ungrouped$SBMediaController = class_getSuperclass(_logos_class$_ungrouped$SBMediaController); { Class _class = _logos_class$_ungrouped$SBMediaController;Method _method = class_getInstanceMethod(_class, @selector(_nowPlayingInfoChanged));if (_method) {_logos_orig$_ungrouped$SBMediaController$_nowPlayingInfoChanged = _logos_super$_ungrouped$SBMediaController$_nowPlayingInfoChanged;if (!class_addMethod(_class, @selector(_nowPlayingInfoChanged), (IMP)&_logos_method$_ungrouped$SBMediaController$_nowPlayingInfoChanged, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBMediaController$_nowPlayingInfoChanged = (void (*)(SBMediaController*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$SBMediaController$_nowPlayingInfoChanged = (void (*)(SBMediaController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBMediaController$_nowPlayingInfoChanged);}}}{ Class _class = _logos_class$_ungrouped$SBMediaController;Method _method = class_getInstanceMethod(_class, @selector(setNowPlayingInfo:));if (_method) {_logos_orig$_ungrouped$SBMediaController$setNowPlayingInfo$ = _logos_super$_ungrouped$SBMediaController$setNowPlayingInfo$;if (!class_addMethod(_class, @selector(setNowPlayingInfo:), (IMP)&_logos_method$_ungrouped$SBMediaController$setNowPlayingInfo$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBMediaController$setNowPlayingInfo$ = (void (*)(SBMediaController*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$SBMediaController$setNowPlayingInfo$ = (void (*)(SBMediaController*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBMediaController$setNowPlayingInfo$);}}}} {_logos_static_class$SBMediaController = objc_getClass("SBMediaController"); } 
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
#line 235 "/OnGit/FeiIOS/MusicBanners/MusicBanners/MusicBanners.xm"
