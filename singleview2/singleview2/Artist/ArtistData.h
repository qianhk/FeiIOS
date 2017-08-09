//
// Created by kai on 2017/8/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Work : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *info;

@property (nonatomic, assign) BOOL isExpanded;

@end


@interface Artist : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSArray<Work *> *workList;

@end
