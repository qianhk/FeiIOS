#import "Tile.h"

@implementation Tile
@synthesize x, y, value, sprite;

-(id) initWithX: (int) posX Y: (int) posY{
	self = [super init];
	x = posX;
	y = posY;
	return self;
}

-(BOOL) nearTile: (Tile *)othertile{
	return 
	(x == othertile.x && abs(y - othertile.y)==1)
	||
	(y == othertile.y && abs(x - othertile.x)==1);
}

-(void) trade: (Tile *)otherTile{
	CCSprite *tempSprite = [sprite retain];
	int tempValue = value;
	self.sprite = otherTile.sprite;
	self.value = otherTile.value;
	otherTile.sprite = tempSprite;
	otherTile.value = tempValue;
	[tempSprite release];
}

-(CGPoint) pixPosition{
	return ccp(kStartX + x * kTileSize +kTileSize/2.0f,kStartY + y * kTileSize +kTileSize/2.0f);
}
@end
