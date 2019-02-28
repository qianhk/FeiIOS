//
//  TestScanBackgroundLayer.h
//  singleview2
//
//  Created by k on 2019/2/27.
//  Copyright © 2019 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestScanBackgroundLayer : CALayer

- (instancetype)initWithBounds:(CGRect)bounds BackgroundColor:(UIColor *)backgroundColor focusRect:(CGRect)focusRect;

- (void)updateFocus:(CGRect)focusRect Completion:(void (^)(void))completion;

@property (assign, nonatomic) CGFloat animateDurationWhenFocusChange;

@end

NS_ASSUME_NONNULL_END
