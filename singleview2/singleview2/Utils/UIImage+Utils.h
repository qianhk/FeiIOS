//
//  UIImage+Utils.h
//  CoreMLDemo
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (Utils)

//不等比缩放到目标大小
- (UIImage *)imageByScaleToSize:(CGSize)targetSize;

//等比缩放到指定比例
- (UIImage *)imageByScaleWithScale:(float)scale;

//等比缩放到指定目标大小，长边砍头去尾crop，保留中间
//供显示需要usingScreenScale=YES,清晰 供CoreML图像识别不需要，输入参数成倍增加
- (UIImage *)imageByClipToSize:(CGSize)targetSize usingScreenScale:(BOOL)usingScreenScale;

//将指定的Rect缩放到指定目标大小，是否等比取决于目标Rect的size是否与图片size比例相同
- (UIImage *)imageByClipToSize:(CGSize)targetSize withClipRect:(CGRect)rect usingScreenScale:(BOOL)usingScreenScale;

//等比缩放到指定大小，以图片短边作居中正方形，正方形先顶到targetSize的边为准
- (UIImage *)imageByMiddleSquareSideToShortSizeSide:(CGSize)targetSize;

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)imageRef;

+ (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
