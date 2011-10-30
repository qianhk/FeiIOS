//
//  CustomOpenGLView.h
//  MacOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomOpenGLView : NSView
{
@private
	NSOpenGLContext* _openGLContent;
	NSOpenGLPixelFormat* _pixelFormat;
}

+ (NSOpenGLPixelFormat *)defaultPixelFormat;
- (id)initWithFrame:(NSRect)frameRect pixelFormat:(NSOpenGLPixelFormat *)format;
- (void)setOpenGLContext:(NSOpenGLContext *)content;
- (NSOpenGLContext *)openGLContext;
- (void)clearGLContext;
- (void)prepareOpenGL;
- (void)update;
- (void)setPixelFormat:(NSOpenGLPixelFormat *)pixelFormat;
- (NSOpenGLPixelFormat *)pixelFormat;

@end
