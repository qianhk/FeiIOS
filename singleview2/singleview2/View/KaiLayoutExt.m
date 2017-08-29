//
// Created by kai on 2017/8/28.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <objc/runtime.h>
#import "KaiLayoutExt.h"
#import "SimpleLinearLayout.h"

const char *const ASSOCIATEDOBJECT_KEY_KAI_VIEW_LAYOUT_EXT = "ASSOCIATEDOBJECT_KEY_KAI_VIEW_LAYOUT_EXT";

@implementation ViewLayoutExt

@end

@implementation UIView (ViewLayoutExt)


- (ViewLayoutExt *)viewLayoutExt {

    ViewLayoutExt *obj = objc_getAssociatedObject(self, ASSOCIATEDOBJECT_KEY_KAI_VIEW_LAYOUT_EXT);
    if (obj == nil) {
        obj = [ViewLayoutExt new];
        objc_setAssociatedObject(self, ASSOCIATEDOBJECT_KEY_KAI_VIEW_LAYOUT_EXT, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }

    return obj;
}


- (CGFloat)extMarginLeft {
    return self.viewLayoutExt.extMarginLeft;
}

- (void)setExtMarginLeft:(CGFloat)extMarginLeft {
    self.viewLayoutExt.extMarginLeft = extMarginLeft;
}

- (CGFloat)extMarginRight {
    return self.viewLayoutExt.extMarginRight;
}

- (void)setExtMarginRight:(CGFloat)extMarginRight {
    self.viewLayoutExt.extMarginRight = extMarginRight;
}

//- (void)setHidden:(BOOL)hidden {
//    if (self.isHidden == hidden) {
//        return;
//    }
//
//    [super setHidden:hidden];
//    if (hidden == NO) {
//        if ([self.superview isKindOfClass:[SimpleLinearLayout class]]) {
//            [self setNeedsLayout];
//        }
//    }
//
//}

@end
