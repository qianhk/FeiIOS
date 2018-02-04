//
//  UIImage+Utils.m
//  CoreMLDemo
//
//  Created by xuzichao on 08/06/2017.
//  Copyright © 2017 xuzichao. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

- (UIImage *)scaleToSize:(CGSize)targetSize {
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaleWithScale:(float)scale {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)croppingForSize:(CGSize)targetSize {
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
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width

        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (CGFloat) ((targetHeight - scaledHeight) * 0.5);
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (CGFloat) ((targetWidth - scaledWidth) * 0.5);
        }
    }

    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if (newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)cutImageWithTargetSize:(CGSize)targetSize clipRect:(CGRect)rect {
    //图片大小和实际显示大小的比例
    CGFloat scale_width = self.size.width / targetSize.width;
    CGFloat scale_height = self.size.height / targetSize.height;
    //实际剪切区域
    CGRect clipRect = CGRectMake(rect.origin.x * scale_width,
            rect.origin.y * scale_height,
            rect.size.width * scale_width,
            rect.size.height * scale_height);

    //开启图形上下文
    UIGraphicsBeginImageContext(targetSize);
    //画图
    [self drawAtPoint:CGPointMake(-clipRect.origin.x, -clipRect.origin.y)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(UIImage *)originImage {
    CGImageRef image = originImage.CGImage;
    NSDictionary *options = @{[NSValue valueWithPointer:kCVPixelBufferCGImageCompatibilityKey]: @YES,
            [NSValue valueWithPointer:kCVPixelBufferCGBitmapContextCompatibilityKey]: @YES};

    CVPixelBufferRef pxbuffer = NULL;

    size_t frameWidth = CGImageGetWidth(image);
    size_t frameHeight = CGImageGetHeight(image);

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
    CGContextDrawImage(context, CGRectMake(0, 0, frameWidth, frameHeight), image);
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
