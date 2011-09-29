#import "PauseLayer.h"


@implementation PauseLayer

-(id) init{
	self = [super init];
	
	CCMenuItemFont *resume = [CCMenuItemFont itemFromString:@"resume" target:self selector: @selector(resume:)];
	CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
	CCMenu *menu = [CCMenu menuWithItems: resume, back, nil];
	[menu alignItemsVerticallyWithPadding: 30.0f]; 
	
	
	float delayTime = 0.3f;
	
	for (CCMenuItemFont *each in [menu children]) {
		each.scaleX = 0.0f;
		each.scaleY = 0.0f;
		CCAction *action = [CCSequence actions:
							[CCDelayTime actionWithDuration: delayTime],
							[CCScaleTo actionWithDuration:0.5F scale:1.0],
							nil];
		delayTime += 0.2f;
		[each runAction: action];
	}
	[self addChild: menu];
	return self;
}

-(void) resume: (id) sender{
	[MusicHandler notifyButtonClick];
	[[CCDirector sharedDirector] popScene];
}
-(void) back: (id) sender{
	[MusicHandler notifyButtonClick];
	[SceneManager goMenu];
}
@end
