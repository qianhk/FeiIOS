//
// Created by kai on 2018/1/18.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import "SubscribeViewModel.h"
#import "NSString+EmailAdditions.h"

@interface SubscribeViewModel ()
@property(nonatomic, strong) RACSignal *emailValidSignal;
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
        return NSLocalizedString(@"Sending request...", nil);
    }];

    RACSignal *completedMessageSource = [self.subscribeCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeCompleted;
        }] map:^id(id value) {
            return NSLocalizedString(@"Thanks", nil);
        }];
    }];

    RACSignal *failedMessageSource = [[self.subscribeCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        return NSLocalizedString(@"Error :(", nil);
    }];

    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)subscribeCommand {
    if (!_subscribeCommand) {
        @weakify(self);
        _subscribeCommand = [[RACCommand alloc] initWithEnabled:self.emailValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
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
    [RACSignal return:@"Ok_Kai"];
}

- (RACSignal *)emailValidSignal {
    if (!_emailValidSignal) {
        _emailValidSignal = [RACObserve(self, email) map:^id(NSString *email) {
            return @([email isValidEmail]);
        }];
    }
    return _emailValidSignal;
}

@end
