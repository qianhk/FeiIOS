//
//  kainotifyController.h
//  kainotify
//
//  Created by hongkai.qian on 12-2-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <BBWeeAppController-Protocol.h>
#import <SpringBoard/SpringBoard.h>

@interface kainotifyController : NSObject <BBWeeAppController>
{
    UIView *_view;
	UILabel *lbl;
	UILabel *_wifiStatus;
	NSTimer* _timer;
	NSInteger _js;
}

- (UIView *)view;

@end