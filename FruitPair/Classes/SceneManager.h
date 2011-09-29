#import <Foundation/Foundation.h>
#import "PlayLayer.h"
#import "MenuLayer.h"
#import "PauseLayer.h"
#import "HighScoresLayer.h"
#import "CreditsLayer.h"
@interface SceneManager : NSObject {
}
+(void) goMenu;
+(void) goPlay;
+(void) goLost;
+(void) goHighScores;
+(void) goCredits;
+(void) goPause;
@end
