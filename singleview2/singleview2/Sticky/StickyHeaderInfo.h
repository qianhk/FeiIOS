//
// Created by kai on 2017/5/25.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StickyHeaderInfo : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat marginLeft;

@property(nonatomic, assign) CGFloat wholeTx;
@property(nonatomic, assign) CGFloat tx;

@end