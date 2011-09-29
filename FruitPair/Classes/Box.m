#import "Box.h"
@interface Box()
-(int) repair;
-(int) repairSingleColumn: (int) columnIndex;
@end

@implementation Box
@synthesize layer;
@synthesize size;
@synthesize lock;

-(id) initWithSize: (CGSize) aSize factor: (int) aFacotr{
	self = [super init];
	size = aSize;
	OutBorderTile = [[Tile alloc] initWithX:-1 Y:-1];
	content = [NSMutableArray arrayWithCapacity: size.height];
	
	for (int y=0; y<size.height; y++) {
		
		NSMutableArray *rowContent = [NSMutableArray arrayWithCapacity:size.width];
		for (int x=0; x < size.width; x++) {
			Tile *tile = [[Tile alloc] initWithX:x Y:y];
			[rowContent addObject:tile];
			[tile release];
		}
		[content addObject:rowContent];
		[content retain];
	}
	
	readyToRemoveTiles = [NSMutableSet setWithCapacity:5];
	[readyToRemoveTiles retain];
	return self;
}

-(Tile *) objectAtX: (int) x Y: (int) y{
	if (x < 0 || x >= kBoxWidth || y < 0 || y >= kBoxHeight) {
		return OutBorderTile;
	}
	return [[content objectAtIndex: y] objectAtIndex: x];
}

-(void) checkWith: (Orientation) orient{
	int iMax = (orient == OrientationHori) ? size.width : size.height;
	int jMax = (orient == OrientationVert) ? size.height : size.width;
	for (int i=0; i<iMax; i++) {
		int count = 0;
		int value = -1;
		first = nil;
		second = nil;
		for (int j=0; j<jMax; j++) {
			Tile *tile = [self objectAtX:((orient == OrientationHori) ?i :j)  Y:((orient == OrientationHori) ?j :i)];
			if(tile.value == value){
				count++;
				if (count > 3) {
					[readyToRemoveTiles addObject:tile];
				}else
					if (count == 3) {
						[readyToRemoveTiles addObject:first];
						[readyToRemoveTiles addObject:second];
						[readyToRemoveTiles addObject:tile];
						first = nil;
						second = nil;
						
					}else if (count == 2) {
						second = tile;
					}else {
						
					}
				
			}else {
				count = 1;
				first = tile;
				second = nil;
				value = tile.value;
			}
		}
	}
}

-(BOOL) check{
	[self checkWith:OrientationHori];	
	[self checkWith:OrientationVert];
	
	NSArray *objects = [[readyToRemoveTiles objectEnumerator] allObjects];
	if ([objects count] == 0) {
		return NO;
	}
	
	int count = [objects count];
	for (int i=0; i<count; i++) {

		Tile *tile = [objects objectAtIndex:i];
		tile.value = 0;
		if (tile.sprite) {
			CCAction *action = [CCSequence actions:[CCScaleTo actionWithDuration:0.3f scale:0.0f],
								[CCCallFuncN actionWithTarget: self selector:@selector(removeSprite:)],
								nil];
			[tile.sprite runAction: action];
		}
	}

	[readyToRemoveTiles removeAllObjects];
	int maxCount = [self repair];
	
	[layer runAction: [CCSequence actions: [CCDelayTime actionWithDuration: kMoveTileTime * maxCount + 0.03f],
					   [CCCallFunc actionWithTarget:self selector:@selector(afterAllMoveDone)],
					   nil]];
	return YES;
}

-(void) removeSprite: (id) sender{
	[layer removeChild: sender cleanup:YES];
}

-(void) afterAllMoveDone{
	if([self check]){
		
	}else {
		if ([self haveMore]) {
			[self unlock];
		}else {
			for (int y=0; y< kBoxHeight; y++) {
				for (int x=0; x< kBoxWidth; x++) {
					Tile *tile = [self objectAtX:x Y:y];
					tile.value = 0;
				}
			}
			[self check];
		}
	}

}	 
	 
-(void) unlock{
	self.lock = NO;
}

-(int) repair{
	int maxCount = 0;
	for (int x=0; x<size.width; x++) {
		int count = [self repairSingleColumn:x];
		if (count > maxCount) {
			maxCount = count;
		}
	}
	return maxCount;
}
				 
-(int) repairSingleColumn: (int) columnIndex{
	int extension = 0;
	for (int y=0; y<size.height; y++) {
		Tile *tile = [self objectAtX:columnIndex Y:y];
			if(tile.value == 0){
				extension++;
			}else if (extension == 0) {
				
			}else{
				Tile *destTile = [self objectAtX:columnIndex Y:y-extension];
				
				CCSequence *action = [CCSequence actions:
									  [CCMoveBy actionWithDuration:kMoveTileTime*extension position:ccp(0,-kTileSize*extension)],
									  nil];
				
				[tile.sprite runAction: action];

				destTile.value = tile.value;
				destTile.sprite = tile.sprite;

			}
	}
	
	for (int i=0; i<extension; i++) {
		int value = (arc4random()%kKindCount+1);
		Tile *destTile = [self objectAtX:columnIndex Y:kBoxHeight-extension+i];
		NSString *name = [NSString stringWithFormat:@"q%d.png",value];
		CCSprite *sprite = [CCSprite spriteWithFile:name];
		sprite.position = ccp(kStartX + columnIndex * kTileSize + kTileSize/2, kStartY + (kBoxHeight + i) * kTileSize + kTileSize/2);
		CCSequence *action = [CCSequence actions:
							  [CCMoveBy actionWithDuration:kMoveTileTime*extension position:ccp(0,-kTileSize*extension)],
							  nil];
		[layer addChild: sprite];
		[sprite runAction: action];
		destTile.value = value;
		destTile.sprite = sprite;
	}
	return extension;
}

-(BOOL) haveMore{
	for (int y=0; y<size.height; y++) {
		for (int x=0; x<size.width; x++) {
			Tile *aTile = [self objectAtX:x Y:y];
			
			//v 1 2
			if (aTile.y-1 >= 0) {
				Tile *bTile = [self objectAtX:x Y:y-1];
				if (aTile.value == bTile.value) {
					{
						Tile *cTile = [self objectAtX:x Y:y+2];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
							Tile *cTile = [self objectAtX:x-1 Y:y+1];
							if (cTile.value == aTile.value) {
								return YES;
							}
					}
					{
							Tile *cTile = [self objectAtX:x+1 Y:y+1];
							if (cTile.value == aTile.value) {
								return YES;
							}
					}
					
					{
						Tile *cTile = [self objectAtX:x Y:y-3];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
							Tile *cTile = [self objectAtX:x-1 Y:y-2];
							if (cTile.value == aTile.value) {
								return YES;
							}
					}
					{
							Tile *cTile = [self objectAtX:x+1 Y:y-2];
							if (cTile.value == aTile.value) {
								return YES;
							}
						}
						
					}
					
			}
			//v 1 3
			if (aTile.y-2 >= 0) {
				Tile *bTile = [self objectAtX:x Y:y-2];
				if (aTile.value == bTile.value) {
					
					{
						Tile *cTile = [self objectAtX:x Y:y+1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
						Tile *cTile = [self objectAtX:x Y:y-3];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					
				
					{
						Tile *cTile = [self objectAtX:x-1 Y:y-1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					{
						Tile *cTile = [self objectAtX:x+1 Y:y-1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
						
				}
			}
			// h 1 2
			if (aTile.x+1 < kBoxWidth) {
				Tile *bTile = [self objectAtX:x+1 Y:y];
				if (aTile.value == bTile.value) {
					{
						Tile *cTile = [self objectAtX:x-2 Y:y];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
						Tile *cTile = [self objectAtX:x-1 Y:y-1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					{
						Tile *cTile = [self objectAtX:x-1 Y:y+1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
						Tile *cTile = [self objectAtX:x+3 Y:y];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
						Tile *cTile = [self objectAtX:x+2 Y:y-1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					{
						Tile *cTile = [self objectAtX:x+2 Y:y+1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
				}
			}
			
			//h 1 3
			if (aTile.x+2 >= kBoxWidth) {
				Tile *bTile = [self objectAtX:x+2 Y:y];
				if (aTile.value == bTile.value) {
					{
						Tile *cTile = [self objectAtX:x+3 Y:y];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					{
						Tile *cTile = [self objectAtX:x-1 Y:y];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					
					
					{
						Tile *cTile = [self objectAtX:x+1 Y:y-1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
					{
						Tile *cTile = [self objectAtX:x+1 Y:y+1];
						if (cTile.value == aTile.value) {
							return YES;
						}
					}
				}
			}
		}
	}
	return NO;
}

@end
