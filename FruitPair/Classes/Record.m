#import "Record.h"

@implementation Record
@synthesize name;
@synthesize score;
@synthesize time;

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:kRecordName];
    [encoder encodeInt:self.score forKey:kRecordScore];
	[encoder encodeInt:self.time forKey:kRecordTime];
}
-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        self.name = [decoder decodeObjectForKey:kRecordName];
        self.score = [decoder decodeIntForKey:kRecordScore];
		self.time = [decoder decodeIntForKey:kRecordTime];
    }
    return self;
}


+(int) trySaveScoreRecord: (Record *) newRecord{
	NSArray *scores = [Record getHighScores];
	int scoreIndex = 0;
	for (int i=0; i<[scores count]; scoreIndex++, i++) {
		Record *each = [scores objectAtIndex:i];
		if (each.score<= newRecord.score) {
			scoreIndex = i;
			break;
		}
		
	}
	if (scoreIndex < 0 || scoreIndex >= kMaxRecordCount) {
		return -1;
	}
	
	
	
	NSMutableArray *newScores = [NSMutableArray arrayWithArray: scores];
	[newScores insertObject:newRecord atIndex:scoreIndex];
	if ([newScores count] > kMaxRecordCount) {
		[newScores removeLastObject];
	}
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newScores];
	[[NSUserDefaults standardUserDefaults] setValue:data forKey:kRecordScore];
	[[NSUserDefaults standardUserDefaults] synchronize];	
	return scoreIndex;
}

+(int) trySaveTimeRecord: (Record *) newRecord{
	NSArray *times = [Record getHighTimes];
	int timeIndex = 0;
	for (int i=0; i<[times count]; timeIndex++, i++) {
		Record *each = [times objectAtIndex:i];
		if (each.time>= newRecord.time) {
			timeIndex = i;
			break;
		}
		
	}
	if (timeIndex < 0 || timeIndex >= kMaxRecordCount) {
		return -1;
	}
	
	NSMutableArray *newTimeRecords = [NSMutableArray arrayWithArray: times];
	[newTimeRecords insertObject:newRecord atIndex:timeIndex];
	if ([newTimeRecords count] > kMaxRecordCount) {
		[newTimeRecords removeLastObject];
	}
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newTimeRecords];
	[[NSUserDefaults standardUserDefaults] setValue:data forKey:kRecordTime];
	[[NSUserDefaults standardUserDefaults] synchronize];
	return timeIndex;	
}

+(NSArray *) getHighScores{
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kRecordScore];
	return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}

+(NSArray *) getHighTimes{
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kRecordTime];
	return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}



+(Record *)createCurrentRecord{
	Record *newRecord = [[Record alloc] init];
	newRecord.name = [User name];
	newRecord.score = [User score];
	newRecord.time = [User usedTime];
	return newRecord;
}

@end
