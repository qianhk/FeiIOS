//
// Created by kai on 2018/5/28.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "UIView+Utils.h"

@interface UIView (Utils)

@end

@implementation UIView (Utils)


- (void)pauseAnimation {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0f;
    self.layer.timeOffset = pausedTime;
}

- (void)resumeAnimation {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0f;
    self.layer.timeOffset = 0.0f;
    self.layer.beginTime = 0.0f;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

@end