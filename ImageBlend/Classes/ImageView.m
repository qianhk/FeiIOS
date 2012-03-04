//
//  ImageView.m
//  Image
//
//  Created by Bill Dudney on 12/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"


@implementation ImageView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
	{
        // Initialization code
		
    }
    return self;
}

- (void)layoutSubviews
{
	[lrcImage release];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 50), NO, 0);
//	UIGraphicsBeginImageContext(CGSizeMake(320, 50));
	[[UIColor yellowColor] set];
	[@"我是好人呐，学习雷锋好榜样！" drawAtPoint:CGPointMake(0, 0) withFont:[UIFont systemFontOfSize:28]];
	lrcImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
	UIGraphicsEndImageContext();
}

//START:code.drawing.image.drawRect:
- (void)drawRect:(CGRect)rect
{
  UIImage *image = [UIImage imageNamed:@"photo.png"]; //<label id="code.ImageView.drawRect.image"/>
  CGFloat idealSize = 300.0f;
  CGFloat ratio = 1.0f;
  CGFloat heightRatio = idealSize / image.size.height;
  CGFloat widthRatio = idealSize / image.size.width;  
  if(heightRatio < widthRatio)
  { //<label id="code.ImageView.drawRect.ratio"/>
    ratio = heightRatio;
  }
  else
  {
    ratio = widthRatio;
  }
  CGRect imageRect = CGRectMake(10.0f, 10.0f, image.size.width * ratio, image.size.height * ratio);
	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextSetBlendMode(context, kCGBlendModeDifference);
  [image drawInRect:imageRect];  //<label id="code.ImageView.drawRect.draw"/>
	
	UIImage *image2 = [UIImage imageNamed:@"plant.png"];
	CGRect image2Rect = CGRectMake(100, 200, image2.size.width * 0.4, image2.size.height * 0.4);
	[image2 drawInRect:image2Rect blendMode:0 alpha:1];
	
	[lrcImage drawInRect:CGRectMake(0, 330, lrcImage.size.width, lrcImage.size.height)];
	[[UIColor yellowColor] set];
	[@"我是好人呐，学习雷锋好榜样！" drawAtPoint:CGPointMake(0, 365) withFont:[UIFont systemFontOfSize:28]];
	
	[[UIColor greenColor] set];
	[@"我是好人呐" drawAtPoint:CGPointMake(0, 365) withFont:[UIFont systemFontOfSize:28]];
	[@"我是好人呐" drawAtPoint:CGPointMake(0, 400) withFont:[UIFont systemFontOfSize:28]];
	
}
//END:code.drawing.image.drawRect:

- (void)dealloc
{
	[lrcImage release];
	
    [super dealloc];
}


@end
