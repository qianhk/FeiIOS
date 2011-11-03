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
//- (void)setupVBOs;
//- (void)setupDisplayLink;
//- (void)setupDepthBuffer;

@end

@implementation OpenGLView

- (GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType
{
	NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
	NSError* error;
	NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
	if (!shaderString)
	{
		NSLog(@"Error loading shader: %@", error.localizedDescription);
		exit(3);
	}
	
	GLuint shaderHandle = glCreateShader(shaderType);
	
	const char * shaderStringUTF8 = [shaderString UTF8String];
	int shaderStringLength = [shaderString length];
	glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
	
	glCompileShader(shaderHandle);
	
	GLint compileSucess;
	glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSucess);
	if (compileSucess == GL_FALSE)
	{
		GLchar message[256];
		glGetShaderInfoLog(shaderHandle, sizeof(message), 0, &message[0]);
		NSString *messageString = [NSString stringWithUTF8String:message];
		NSLog(@"%@", messageString);
		exit(4);
	}
	
	return shaderHandle;
}

- (void)compileShaders
{
	GLuint vertexShader = [self compileShader:@"SimpleVertex" withType:GL_VERTEX_SHADER];
	GLuint fragmentShader = [self compileShader:@"SimpleFragment" withType:GL_FRAGMENT_SHADER];
	
	GLuint programHandle = glCreateProgram();
	glAttachShader(programHandle, vertexShader);
	glAttachShader(programHandle, fragmentShader);
	glLinkProgram(programHandle);
	
	GLint linkSucess;
	glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSucess);
	if (linkSucess == GL_FALSE)
	{
		GLchar messages[256];
		glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
		NSString* messageString = [NSString stringWithUTF8String:messages];
		NSLog(@"%@", messageString);
		exit(5);
	}
	
	glUseProgram(programHandle);
}

//- (void)setupDisplayLink
//{
//	CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
//	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        [self setupLayer];
		[self setupContext];
		[self setupRenderBuffer];
		[self setupFrameBuffer];
		
		[self compileShaders];
		
//		[self setupDisplayLink];
		
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

//- (void)setupDepthBuffer
//{
//	glGenRenderbuffers(1, &_depthRenderBuffer);
//	glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
//	glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
//}

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
	
//	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

//- (void)render:(CADisplayLink *)displayLink
- (void)render
{
	glClearColor(0, 104.0/255.0, 55.0/255.0, 0.5);
	glClear(GL_COLOR_BUFFER_BIT);
	
//	glColor4f(1.0, 1.0, 1.0, 1.0);
//	glOrthof(0.0, 1.0, 0.0, 1.0, -1.0, 1.0);
	glViewport(0, 0, self.frame.size.width, self.frame.size.height);

	
	const GLfloat squareVertices[] = {
        -0.5f, -0.5f,
        0.5f,  -0.5f,
        -0.5f,  0.5f,
        0.5f,   0.5f,
    };
    const GLubyte squareColors[] = {
        255, 255,   0, 255,
        0,   255, 255, 255,
        0,     0,   0,   0,
        255,   0, 255, 255,
    };
	
	glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors); //enable the normalized flag
    glEnableVertexAttribArray(ATTRIB_COLOR);
	
	glDrawArrays(GL_TRIANGLES, 0, 4);
	
	
	[_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
