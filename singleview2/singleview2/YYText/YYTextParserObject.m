//
// Created by kai on 2017/12/26.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "YYTextParserObject.h"
#import <YYText/NSAttributedString+YYText.h>

@interface YYTextParserObject ()

@property (nonatomic, strong) NSRegularExpression *regex;

@end

@implementation YYTextParserObject

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *pattern = @"#.+?#";
        self.regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    }

    return self;
}


- (BOOL)parseText:(nullable NSMutableAttributedString *)text selectedRange:(nullable NSRangePointer)selectedRange {
    __block BOOL changed = NO;
    [_regex enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.yy_rangeOfAll usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (!result) return;
        NSRange range = result.range;
        if (range.location == NSNotFound || range.length < 1) return;
//        if ([text attribute:YYTextBindingAttributeName atIndex:range.location effectiveRange:NULL]) return;

        NSRange bindingRange = NSMakeRange(range.location, range.length);
        YYTextBinding *binding = [YYTextBinding bindingWithDeleteConfirm:NO];
        [text yy_removeDiscontinuousAttributesInRange:bindingRange];
        [text yy_setTextBinding:binding range:bindingRange];
        [text yy_setColor:[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0] range:bindingRange];
        changed = YES;
    }];
    return changed;
}


@end
