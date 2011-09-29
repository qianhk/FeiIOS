#import "HighScoresLayer.h"
#import "User.h"

@implementation HighScoresLayer
-(id) init{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	CCLabel *timeLabel = [CCLabel labelWithString:@"Time Records" fontName:@"Marker Felt" fontSize:30];
	timeLabel.position = ccp(160,450);
	[self addChild: timeLabel];
	
	NSArray *timeRecords = [Record getHighTimes];
	for (int i=0; i<[timeRecords count]; i++) {
		Record *each = [timeRecords objectAtIndex:i];
		CCLabel *labelName = [CCLabel labelWithString:each.name fontName:@"Marker Felt" fontSize:15];
		labelName.position = ccp(100, 400-30*i);
		[self addChild:labelName];
		
		CCLabel *labelValue = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", each.time] fontName:@"Marker Felt" fontSize:15];
		labelValue.position = ccp(200, 400-30*i);
		[self addChild:labelValue];
	}
	
	CCLabel *scoreLabel = [CCLabel labelWithString:@"Score Records" fontName:@"Marker Felt" fontSize:30];
	scoreLabel.position = ccp(160,260);
	[self addChild: scoreLabel];
	
	NSArray *scoreRecords = [Record getHighScores];
	for (int i=0; i<[scoreRecords count]; i++) {
		Record *each = [scoreRecords objectAtIndex:i];
		CCLabel *labelName = [CCLabel labelWithString:each.name fontName:@"Marker Felt" fontSize:15];
		labelName.position = ccp(100, 210-30*i);
		[self addChild:labelName];
		
		CCLabel *labelValue = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", each.score] fontName:@"Marker Felt" fontSize:15];
		labelValue.position = ccp(200, 210-30*i);
		[self addChild:labelValue];
	}
	
	CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
	CCMenu *menu = [CCMenu menuWithItems: back, nil];
	menu.position = ccp(280, 70);
	[self addChild: menu];
	return self;
}

-(void) back: (id) sender{
	[SceneManager goMenu];
}
@end
