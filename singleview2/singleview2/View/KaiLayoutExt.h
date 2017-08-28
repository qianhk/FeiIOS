//
// Created by kai on 2017/8/28.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewLayoutExt : NSObject

@property (nonatomic, assign) CGFloat extMarginLeft;
@property (nonatomic, assign) CGFloat extMarginRight;

@end


@interface UIView(ViewLayoutExt)

@property (nonatomic, assign) CGFloat extMarginLeft;
@property (nonatomic, assign) CGFloat extMarginRight;

@property (nonatomic, strong, readonly) ViewLayoutExt *viewLayoutExt;

@end