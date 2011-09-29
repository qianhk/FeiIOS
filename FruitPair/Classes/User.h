#define kScore @"kScore"
#define kWindedLevel @"kWindedLevel"
#define kWantLevel @"kWantLevel"
#define kName @"kName"
#define kUsedTime @"kUsedTime"

#import "constants.h"
@interface User : NSObject {
}

+(void) clear;

+(NSString *) name;
+(int) score;
+(int) usedTime;
+(int) winedLevel;
+(int) nextLevel;

+(void) saveName: (NSString *) name;
+(void) saveScore: (int) score;
+(void) saveWinedLevel: (int) winedLevel;
+(void) saveUsedTime: (int) usedTime;
@end
