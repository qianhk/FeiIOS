//
//  UIImage+Utils.m
//  CoreMLDemo
//
//
#import "UIImage+Utils.h"

@implementation UIImage (Utils)

- (UIImage *)imageByScaleToSize:(CGSize)targetSize {
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByScaleWithScale:(float)scale {
    CGFloat targetWidth = self.size.width * scale;
    CGFloat targetHeight = self.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByClipToSize:(CGSize)targetSize {
    CGSize selfSize = self.size;
    CGFloat widthFactor = targetSize.width / selfSize.width;
    CGFloat heightFactor = targetSize.height / selfSize.height;
    CGFloat retainWidth = selfSize.width;
    CGFloat retainHeight = selfSize.height;
    CGPoint point = CGPointMake(0.0, 0.0);
    if (widthFactor < heightFactor) {
        retainWidth = retainHeight * targetSize.width / targetSize.height;
        point.x = (selfSize.width - retainWidth) / 2;
    } else {
        retainHeight = retainWidth * targetSize.height / targetSize.width;
        point.y = (selfSize.height - retainHeight) / 2;
    }
    return [self imageByClipToSize:targetSize withClipRect:CGRectMake(point.x, point.y, retainWidth, retainHeight)];
}

//此方法与imageByClipToSize效果一样
- (UIImage *)imageByClipToSize2:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (CGFloat) ((targetHeight - scaledHeight) * 0.5);
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (CGFloat) ((targetWidth - scaledWidth) * 0.5);
        }
    }

    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByClipToSize:(CGSize)targetSize withClipRect:(CGRect)rect {
    CGSize rectSize = rect.size;
    CGFloat scale_width = targetSize.width / rectSize.width;
    CGFloat scale_height = targetSize.height / rectSize.height;
    CGRect destRect = CGRectMake(-rect.origin.x * scale_width, -rect.origin.y * scale_height,
            self.size.width * scale_width, self.size.height * scale_height);
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:destRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)imageRef {
    NSDictionary *options = @{[NSValue valueWithPointer:kCVPixelBufferCGImageCompatibilityKey]: @YES,
            [NSValue valueWithPointer:kCVPixelBufferCGBitmapContextCompatibilityKey]: @YES};

    CVPixelBufferRef pxbuffer = NULL;

    size_t frameWidth = CGImageGetWidth(imageRef);
    size_t frameHeight = CGImageGetHeight(imageRef);

    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameWidth, frameHeight,
            kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options, &pxbuffer);

    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);

    CVPixelBufferLockBaseAddress(pxbuffer, 0);

    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);

    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(pxdata, frameWidth, frameHeight, 8,
            CVPixelBufferGetBytesPerRow(pxbuffer), rgbColorSpace, (CGBitmapInfo) kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);

    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0, 0, frameWidth, frameHeight), imageRef);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);

    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);

    return pxbuffer;
}

+ (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);        // Lock the image buffer

    uint8_t *baseAddress = (uint8_t *) CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);   // Get information of the image
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8,
            bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);

    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    /* CVBufferRelease(imageBuffer); */  // do not call this!

    return newImage;
}

@end
