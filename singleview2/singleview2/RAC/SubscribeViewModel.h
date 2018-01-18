//
// Created by kai on 2018/1/18.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@class RACCommand;


@interface SubscribeViewModel : NSObject

@property(nonatomic, strong) RACCommand *subscribeCommand;

// write to this property
@property(nonatomic, strong) NSString *email;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@end
