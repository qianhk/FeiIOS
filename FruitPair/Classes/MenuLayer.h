#import "cocos2d.h"
#import "User.h"
#import "SceneManager.h"
#import "BaseLayer.h"
#import "MusicHandler.h"
@interface MenuLayer : BaseLayer {
}

- (void)onStartNew:(id)sender;
- (void)onResume:(id)sender;
- (void)onHighscores:(id)sender;
- (void)onCredits:(id)sender;
@end
