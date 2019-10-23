//
// Created by kai on 2019/10/21.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTImageData : NSObject

@property (nonatomic, strong) NSString *imgHolder;
@property (nonatomic, strong) NSURL *imgPath;
@property (nonatomic) NSInteger idx;
@property (nonatomic) CGRect imageRect;

@end

@interface TestCoreTextView1 : UIView
@end
