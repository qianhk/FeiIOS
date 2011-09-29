#import "CreditsLayer.h"


@implementation CreditsLayer
-(id) init{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
	CCMenu *menu = [CCMenu menuWithItems: back, nil];
	menu.position = ccp(160, 150);
	[self addChild: menu];
	return self;
}

-(void) back: (id) sender{
	[SceneManager goMenu];
}

@end
