//
// Created by kai on 2019/10/21.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "TestCoreTextView1.h"

#pragma mark - CTRunDelegateCallbacks

CGFloat ImgRunDelegateGetWidthCallback(void *refCon) {
    NSString *imageName = (__bridge NSString *) refCon;
    return [UIImage imageNamed:imageName].size.width;
}

CGFloat ImgRunDelegateGetDescentCallback(void *refCon) {
    return 0;
}

void ImgRunDelegateDeallocCallback(void *refCon) {

}

CGFloat ImgRunDelegateGetAscentCallback(void *refCon) {
    NSString *imageName = (__bridge NSString *) refCon;
    return [UIImage imageNamed:imageName].size.height - 0;
}

@implementation CTImageData
@end

@implementation CTLinkData
@end

@interface TestCoreTextView1 () {
    CTFrameRef _ctFrame;
}

@property (nonatomic, strong) NSMutableArray *imageDataArray;
@property (nonatomic, strong) NSMutableArray *linkDataArray;


@end

@implementation TestCoreTextView1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }

    return self;
}

//https://www.jianshu.com/p/ca676daf371f iOS-CoreText 的使用
//https://www.jianshu.com/p/6db3289fb05d CoreText实现图文混排
//http://www.cocoachina.com/ios/20180329/22838.html 在iOS中如何正确的实现行间距与行高
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGRect bounds = self.bounds;
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, bounds);
//    CGPathAddRect(path, NULL, CGRectInset(bounds, 10, 20));

    // 步骤 4
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"Hello凯👀"];
//    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 16, NULL);
//    [attString addAttribute:(id) kCTFontAttributeName value:(__bridge id) font range:NSMakeRange(0, 5)];
//
//    font = CTFontCreateWithName((CFStringRef) @"ArialMT", 16, NULL);
//    [attString addAttribute:(id) kCTFontAttributeName value:(__bridge id) font range:NSMakeRange(6, 5)];

    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"👀 空心字" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:32]}]];

//    long number = 2;
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"空心字" attributes:@{NSStrokeWidthAttributeName: @(1), NSStrokeColorAttributeName: [UIColor orangeColor], NSFontAttributeName: [UIFont systemFontOfSize:32]}]]; //stroke width 为正数时，foregroundcolor无效，不使用


    CTRunDelegateCallbacks imageCallBacks;
    memset(&imageCallBacks,0,sizeof(CTRunDelegateCallbacks));
    imageCallBacks.version = kCTRunDelegateCurrentVersion;
    imageCallBacks.dealloc = ImgRunDelegateDeallocCallback;
    imageCallBacks.getAscent = ImgRunDelegateGetAscentCallback;
    imageCallBacks.getDescent = ImgRunDelegateGetDescentCallback;
    imageCallBacks.getWidth = ImgRunDelegateGetWidthCallback;

#define kImgName @"imgName"
    NSString *imgName = @"AppIcon";
    CTRunDelegateRef imgRunDelegate = CTRunDelegateCreate(&imageCallBacks, (__bridge void *_Nullable) (imgName));//我们也可以传入其它参数
//    NSMutableAttributedString *imgAttributedStr = [[NSMutableAttributedString alloc] initWithString:@" "];
//    [imgAttributedStr addAttribute:(NSString *) kCTRunDelegateAttributeName value:(__bridge id) imgRunDelegate range:NSMakeRange(0, 1)];
//    CFRelease(imgRunDelegate);
////图片占位符添加
//    [imgAttributedStr addAttribute:kImgName value:imgName range:NSMakeRange(0, 1)];

    NSMutableAttributedString *imgAttributedStr = [[NSMutableAttributedString alloc]
            initWithString:@" " attributes:@{(NSString *) kCTRunDelegateAttributeName: (__bridge id) imgRunDelegate, kImgName: imgName}];
    [attString appendAttributedString:imgAttributedStr];
    CFRelease(imgRunDelegate);

    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"空心字" attributes:@{NSStrokeWidthAttributeName: @(-1), NSStrokeColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:32], NSForegroundColorAttributeName: [UIColor greenColor]}]];

//    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef) attString);
//    CGContextSetTextPosition(context, 10.0, bounds.size.height - 100);//文本的起点
//    CTLineDraw(line, context);
//    return;

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    _ctFrame = frame;
    // 步骤 5
    CTFrameDraw(frame, context);



    //绘制图片
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);//获取第行的起始点
    for (int i = 0; i < lineCount; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;//上缘线
        CGFloat lineDescent;//下缘线
        CGFloat lineLeading;//行间距
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);//获取此行的字形参数

        //获取此行中每个CTRun
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CFIndex runCount = CFArrayGetCount(runs);
        for (int j = 0; j < runCount; j++) {
            CGFloat runAscent;//此CTRun上缘线
            CGFloat runDescent;//此CTRun下缘线
            CGPoint lineOrigin = lineOrigins[i];//此行起点

            CTRunRef run = CFArrayGetValueAtIndex(runs, j);//获取此CTRun
            NSDictionary *attributes = (NSDictionary *) CTRunGetAttributes(run);

            CGRect runRect;
            //获取此CTRun的上缘线，下缘线,并由此获取CTRun和宽度
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);

            //CTRun的X坐标
            CGFloat runOrgX = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runRect = CGRectMake(runOrgX, lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);

            NSString *imgName = [attributes objectForKey:kImgName];
            if (imgName) {
                UIImage *image = [UIImage imageNamed:imgName];
                if (image) {
                    CGRect imageRect;
                    imageRect.size = image.size;
                    imageRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageRect.origin.y = lineOrigin.y;
                    CGContextDrawImage(context, imageRect, image.CGImage);
                    NSLog(@"lookKai drawRect found Image row=%ld run=%ld rect=%@ '%@'", i, j, NSStringFromCGRect(imageRect), imgName);
                    //以下操作仅仅是演示示例，实战时请在渲染之前处理数据，做到最佳实践。
                    if (!_imageDataArray) {
                        _imageDataArray = [[NSMutableArray alloc] init];
                    }
                    BOOL imgExist = NO;
                    for (CTImageData *ctImageData in _imageDataArray) {
                        if (ctImageData.idx == j) {
                            imgExist = YES;
                            break;
                        }
                    }
                    if (!imgExist) {
                        CTImageData *ctImageData = [[CTImageData alloc] init];
                        ctImageData.imgHolder = imgName;
                        ctImageData.imageRect = imageRect;
                        ctImageData.idx = j;
                        [_imageDataArray addObject:ctImageData];
                    }
                }
            }
        }
    }


//    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
//    CGContextSetLineWidth(context, 10.0);
//    CGContextSetLineJoin(context, kCGLineJoinMiter);
//    CGContextAddRect(context, CGRectMake(10, 420, 100, 100));
//    CGContextStrokePath(context);
//
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
//    CGContextSetLineWidth(context, 15.0);
//    CGContextSetLineJoin(context, kCGLineJoinBevel);
//    CGContextAddRect(context, CGRectMake(130, 420, 100, 100));
//    CGContextStrokePath(context);
//
//    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1.0);
//    CGContextSetLineWidth(context, 20.0);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGContextAddRect(context, CGRectMake(260, 420, 100, 100));
//    CGContextStrokePath(context);



    // 步骤 6
//    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

- (void)setupEvents {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

- (CFIndex)touchPointOffset:(CGPoint)point {
    //获取所有行
    CFArrayRef lines = CTFrameGetLines(_ctFrame);

    if (lines == nil) {
        return -1;
    }
    CFIndex count = CFArrayGetCount(lines);

    //获取每行起点
    CGPoint origins[count];
    CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0, 0), origins);


    //Flip
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);

    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        CGPoint lineOrigin = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);

        //获取每一行Rect
        CGFloat ascent = 0.0f;
        CGFloat descent = 0.0f;
        CGFloat leading = 0.0f;
        CGFloat width = (CGFloat) CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGRect lineRect = CGRectMake(lineOrigin.x, lineOrigin.y - descent, width, ascent + descent);

        lineRect = CGRectApplyAffineTransform(lineRect, transform);

        if (CGRectContainsPoint(lineRect, point)) {
            //将point相对于view的坐标转换为相对于该行的坐标
            CGPoint linePoint = CGPointMake(point.x - lineRect.origin.x, point.y - lineRect.origin.y);
            //根据当前行的坐标获取相对整个CoreText串的偏移
            idx = CTLineGetStringIndexForPosition(line, linePoint);
        }
    }
    return idx;
}

- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    //先判断是否是点击的图片Rect
    CGRect bounds = self.bounds;
    for (CTImageData *imageData in _imageDataArray) {
        CGRect imageRect = imageData.imageRect;
        CGFloat imageOriginY = bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imageRect.origin.x, imageOriginY, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(rect, point)) {
            NSLog(@"lookKai tap image handle");
            return;
        }
    }

    //再判断链接
    CFIndex idx = [self touchPointOffset:point];
    if (idx != -1) {
        for (CTLinkData *linkData in _linkDataArray) {
            if (NSLocationInRange(idx, linkData.range)) {
                NSLog(@"tap link handle,url:%@", linkData.url);
                break;
            }
        }
    }
}

@end
