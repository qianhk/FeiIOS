//
//  CustomOpenGLView.m
//  MacOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomOpenGLView.h"

@implementation CustomOpenGLView

- (id)initWithFrame:(NSRect)frame pixelFormat:(NSOpenGLPixelFormat *)format
{
    self = [super initWithFrame:frame];
    if (self)
	{
        _pixelFormat = [format retain];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_surfaceNeedsUpdate:) name:NSViewGlobalFrameDidChangeNotification object:self];
    }
    
    return self;
}

- (void)_surfaceNeedsUpdate:(NSNotification *)notification
{
	[self update];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [_openGLContent makeCurrentContext];
	
	[_openGLContent flushBuffer];
}

+ (NSOpenGLPixelFormat *)defaultPixelFormat
{
	
}

- (void)clearGLContext
{
	
}

- (void)prepareOpenGL
{
	
}

- (void)update
{
	
}

- (void)lockFocus
{
    NSOpenGLContext* context = [self openGLContext];
    [super lockFocus];
    if ([context view] != self)
	{
        [context setView:self];
    }
    [context makeCurrentContext];
}

-(void) viewDidMoveToWindow
{
    [super viewDidMoveToWindow];
    if ([self window] == nil)
        [_openGLContent clearDrawable];
}

@end
