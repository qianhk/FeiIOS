//
// Created by kai on 2018/1/18.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "SubscribeViewModel.h"
#import "NSString+EmailAdditions.h"

@interface SubscribeViewModel ()
@property (nonatomic, strong) RACSignal *emailValidSignal;
@end

@implementation SubscribeViewModel

- (id)init {
    self = [super init];
    if (self) {
         [self mapSubscribeCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapSubscribeCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.subscribeCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
        NSLog(@"started mainThread=%d signal=%p", [NSThread currentThread].isMainThread, subscribeSignal);
        return NSLocalizedString(@"Sending request...", nil);
    }];

    //executionSignals 不包含error 经试验error变成complete
    RACSignal *completedMessageSource = [self.subscribeCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
        NSLog(@"completed outer mainThread=%d signal=%p", [NSThread currentThread].isMainThread, subscribeSignal);
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            NSLog(@"completed event=%@ mainThread=%d signal=%p"
                  , event, [NSThread currentThread].isMainThread, subscribeSignal);
            return event.eventType == RACEventTypeCompleted;
        }] map:^id(id value) {
            NSLog(@"completed map mainThread=%d", [NSThread currentThread].isMainThread);
            return NSLocalizedString(@"Thanks", nil);
        }];
    }];

    RACSignal *failedMessageSource = [[self.subscribeCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        NSLog(@"failed [%@] mainThread=%d", error, [NSThread currentThread].isMainThread);
        return NSLocalizedString(@"Error :(", nil);
    }];

    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)subscribeCommand {
    if (!_subscribeCommand) {
        @weakify(self);
        _subscribeCommand = [[RACCommand alloc] initWithEnabled:self.emailValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSLog(@"subscribeCommand %@ mainThread=%d", input, [NSThread currentThread].isMainThread);
            return [SubscribeViewModel postEmail:self.email];
        }];
    }
    return _subscribeCommand;
}

+ (RACSignal *)postEmail:(NSString *)email {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer new];
//    NSDictionary *body = @{@"email": email ?: @""};
//    return [[[manager rac_POST:kSubscribeURL parameters:body] logError] replayLazily];

//    return [RACSignal return:email];

    RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"postEmail doing sth. mainThread=%d", [NSThread currentThread].isMainThread);
        [NSThread sleepForTimeInterval:2.f];
        static int js = 0;
        ++js;
        [subscriber sendNext:@666];
        [subscriber sendNext:@667];
        [subscriber sendNext:@668];

        if (js % 2 == 0) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:@"domain888" code:666 userInfo:nil]];
        }
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"postEmail dispose mainThread=%d", [NSThread currentThread].isMainThread);
        }];
    }] subscribeOn:[RACScheduler scheduler]] deliverOnMainThread];
    NSLog(@"postEmail %@ mainThread=%d signal=%p", email, [NSThread currentThread].isMainThread, signal);
    return signal;
}

- (RACSignal *)emailValidSignal {
    if (!_emailValidSignal) {
        _emailValidSignal = [RACObserve(self, email) map:^id(NSString *email) {
            NSLog(@"emailValidSignal %@ mainThread=%d", email, [NSThread currentThread].isMainThread);
            return @([email isValidEmail]);
        }];
    }
    return _emailValidSignal;
}

@end
