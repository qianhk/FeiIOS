//
// Created by kai on 2017/8/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "ArtistData.h"

@interface Artist() {

    NSString *_innerName;

}
@end

@implementation Artist

- (void)setName:(NSString *)name {
    _name = [name mutableCopy];
    _innerName = [_name copy];
}


@end


@implementation Work


@end
