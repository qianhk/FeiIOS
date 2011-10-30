//
//  OpenGLView.m
//  HelloOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "OpenGLView.h"

@interface OpenGLView()

- (void)setupLayer;
- (void)setupContext;
- (void)setupRenderBuffer;
- (void)setupFrameBuffer;
- (void)render;

@end

@implementation OpenGLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        [self setupLayer];
		[self setupContext];
		[self setupRenderBuffer];
		[self setupFrameBuffer];
		[self render];
    }
    return self;
}

- (void)dealloc
{
	[_context release];
	_context = nil;
	
	[super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass
{
	return [CAEAGLLayer class];
}

- (void)setupLayer
{
	_eaglLayer = (CAEAGLLayer *)self.layer;
	_eaglLayer.opaque = YES;
}

- (void)setupContext
{
	EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
	_context = [[EAGLContext alloc] initWithAPI:api];
	if (_context == nil)
	{
		NSLog(@"Failed to initialize OpenGLES 2.0 context");
		exit(1);
	}
	
	if (![EAGLContext setCurrentContext:_context])
	{
		NSLog(@"Failed to set current OpenGL context");
		exit(2);
	}
}

- (void)setupRenderBuffer
{
	glGenRenderbuffers(1, &_colorRenderBuffer);
	glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
	[_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupFrameBuffer
{
	GLuint frameBuffer;
	glGenFramebuffers(1, &frameBuffer);
	glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
}

- (void)render
{
	glClearColor(0, 104.0/255.0, 55.0/255.0, 0.5);
	glClear(GL_COLOR_BUFFER_BIT);
	[_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
