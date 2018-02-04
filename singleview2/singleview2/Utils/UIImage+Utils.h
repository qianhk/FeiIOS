//
//  UIImage+Utils.h
//  CoreMLDemo
//
//  Created by xuzichao on 08/06/2017.
//  Copyright © 2017 xuzichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (Utils)

- (UIImage *)scaleToSize:(CGSize)targetSize;

- (UIImage *)scaleWithScale:(float)scale;

- (UIImage *)croppingForSize:(CGSize)targetSize;

- (UIImage *)cutImageWithTargetSize:(CGSize)targetSize clipRect:(CGRect)rect;

- (CVPixelBufferRef)pixelBufferFromCGImage:(UIImage *)image;

+ (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
