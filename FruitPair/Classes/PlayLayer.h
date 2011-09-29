#import "cocos2d.h"
#import "Box.h"
#import "BaseLayer.h"
@interface PlayLayer : BaseLayer
{
	Box *box;
	Tile *selectedTile;
	Tile *firstOne;
}
+(id) scene;
-(void) changeWithTileA: (Tile *) a TileB: (Tile *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
@end
