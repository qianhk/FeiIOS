#import "constants.h";
@interface Tile : NSObject {
	int x, y, value;
	CCSprite *sprite;
}


@property (nonatomic, readonly) int x, y;
@property (nonatomic) int value;
@property (nonatomic, retain) CCSprite *sprite;

-(id) initWithX: (int) posX Y: (int) posY;
-(BOOL) nearTile: (Tile *)othertile;
-(void) trade:(Tile *)otherTile;
-(CGPoint) pixPosition;
@end
