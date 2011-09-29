#import "MusicHandler.h"



static NSString *BUTTON_CLICK_EFFECT = @"button_click_effect.mp3";
static NSString *CONNECT_EFFECT = @"connect_effect.mp3";

@interface MusicHandler()
	+(void) playEffect:(NSString *)path;
@end


@implementation MusicHandler

+(void) preload{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
		[engine preloadEffect:BUTTON_CLICK_EFFECT];
		[engine preloadEffect:CONNECT_EFFECT];
	}
}

+(void) notifyConnect{
	[MusicHandler playEffect:CONNECT_EFFECT];	
}

+(void) notifyButtonClick{
	[MusicHandler playEffect:BUTTON_CLICK_EFFECT];
}

+(void) playEffect: (NSString *) path{
	[[SimpleAudioEngine sharedEngine] playEffect:path];
}
@end
