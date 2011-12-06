//
//  OpenGLView.m
//  HelloOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/es1/gl.h>
#import "OpenGLView.h"

@interface OpenGLView()

- (void)setupLayer;
- (void)setupContext;
- (void)setupRenderBuffer;
- (void)setupFrameBuffer;
- (void)render:(CADisplayLink *)displayLink;
- (void)setupVBOs;
- (void)setupDisplayLink;
- (void)setupDepthBuffer;
- (void)loadTexture;
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
	GLuint vertexShader = [self compileShader:@"vertex" withType:GL_VERTEX_SHADER];
	GLuint fragmentShader = [self compileShader:@"fragment" withType:GL_FRAGMENT_SHADER];
	
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
	
	_positionSlot = glGetAttribLocation(programHandle, "Position");
	_colorSlot = glGetAttribLocation(programHandle, "SourceColor");
	glEnableVertexAttribArray(_positionSlot);
	glEnableVertexAttribArray(_colorSlot);
}

- (void)setupVBOs
{
//	GLuint vertexBuffer;
//	glGenBuffers(1, &vertexBuffer);
//	glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
//	glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
//	
//	GLuint indexBuffer;
//	glGenBuffers(1, &indexBuffer);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
//	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
}

- (void)setupDisplayLink
{
	CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
//		GLint param1 = 0;
//		glGetIntegerv(GL_GREEN_BITS, &param1);
		
        [self setupLayer];
		[self setupContext];
		[self setupDepthBuffer];
		[self setupRenderBuffer];
		[self setupFrameBuffer];
		
		[self loadTexture];
		
//		[self compileShaders];
//		[self setupVBOs];
		
		[self setupDisplayLink];
		
//		GLint param = 0;
//		glGetIntegerv(GL_GREEN_BITS, &param);
//		param = -1;
		
		glClearColor(0, 104.0/255.0, 55.0/255.0, 1);
		
		CGRect rect = self.bounds;
		rect.size.height -= 20;
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		CGFloat radio = rect.size.height / rect.size.width;
		glOrthof(-3, 3, -3 * radio, 3 * radio, -20, 20);
//		glTranslatef(0, 0, 0.5);
		glViewport(0, 0, rect.size.width, rect.size.height);
		
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		
		glEnable(GL_DEPTH_TEST);
    }
    return self;
}

- (void)dealloc
{
	[EAGLContext setCurrentContext:nil];
	[_context release];
	_context = nil;
	
	[super dealloc];
}

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
	EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES1;
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

- (void)setupDepthBuffer
{
	glGenRenderbuffers(1, &_depthRenderBuffer);
	glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
	glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
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
	
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

const GLfloat cubeVertices[] =
{
	// Define the front face
	
	-1.0, 
	1.0, 
	1.0,             
	// top left
	
	-1.0, 
	-1.0, 
	1.0,            
	// bottom left
	
	1.0, 
	-1.0, 
	1.0,             
	// bottom right
	
	1.0, 
	1.0, 
	1.0,              
	// top right
	
	// Top face
	
	-1.0, 
	1.0, 
	-1.0,            
	// top left (at rear)
	
	-1.0, 
	1.0, 
	1.0,             
	// bottom left (at front)
	
	1.0, 
	1.0, 
	1.0,              
	// bottom right (at front)
	
	1.0, 
	1.0, 
	-1.0,             
	// top right (at rear)
	
	// Rear face
	
	1.0, 
	1.0, 
	-1.0,             
	// top right (when viewed from front)
	
	1.0, 
	-1.0, 
	-1.0,            
	// bottom right
	
	-1.0, 
	-1.0, 
	-1.0,           
	// bottom left
	
	-1.0, 
	1.0, 
	-1.0,            
	// top left
	
	// bottom face
	
	-1.0, 
	-1.0, 
	1.0,
	
	-1.0, 
	-1.0, 
	-1.0,
	
	1.0, 
	-1.0, 
	-1.0,
	
	1.0, 
	-1.0, 
	1.0,
	
	// left face
	
	-1.0, 
	1.0, 
	-1.0,
	
	-1.0, 
	1.0, 
	1.0,
	
	-1.0, 
	-1.0, 
	1.0,
	
	-1.0, 
	-1.0, 
	-1.0,
	
	// right face
	
	1.0, 
	1.0, 
	1.0,
	
	1.0, 
	1.0, 
	-1.0,
	
	1.0, 
	-1.0, 
	-1.0,
	
	1.0, 
	-1.0, 
	1.0
	
};   

const GLshort squareTextureCoords[]=
{
	// Front face
	0, 0
	,       
	// top left
	0, 1
	,       
	// bottom left
	1,1
	,       
	// bottom right
	1,0
	,       
	// top right
	
	// Top face
	0,1
	,       
	// top left
	0,0
	,       
	// bottom left
	1,0
	,       
	// bottom right
	1,1
	,       
	// top right
	
	// Rear face
	0,0
	,       
	// top left
	0,1
	,       
	// bottom left
	1,1
	,       
	// bottom right
	1,0
	,       
	// top right
	
	// Bottom face
	0,1
	,       
	// top left
	0,0
	,       
	// bottom left
	1,0
	,       
	// bottom right
	1,1
	,       
	// top right
	
	// Left face
	0,1
	,       
	// top left
	0,0
	,       
	// bottom left
	1,0
	,       
	// bottom right
	1,1
	,       
	// top right
	
	// Right face
	0,1
	,       
	// top left
	0,0
	,       
	// bottom left
	1,0
	,       
	// bottom right
	1,1
	,       
	// top right
};

const GLfloat pyramidVertices[] = {
	// Our pyramid consists of 4 triangles and a square base.
	// We'll start with the square base
	-1.0, -1.0, 1.0,            // front left of base
	1.0, -1.0, 1.0,             // front right of base
	1.0, -1.0, -1.0,            // rear left of base
	-1.0, -1.0, -1.0,           // rear right of base
	
	//＊＊＊＊＊＊Front face
	-1.0 ,-1.0 ,1.0,            
	// bottom left of triangle
	
	1.0 ,-1.0 ,1.0,            
	// bottom right
	
	0.0 ,1.0 ,0.0,              
	// top centre -- all triangle vertices will meet here
	
	//＊＊＊＊＊Rear face
	1.0 ,-1.0 ,-1.0,   
	// bottom right (when viewed through front face)
	
	-1.0 ,-1.0 ,-1.0,           
	// bottom left
	
	0.0 ,1.0 ,0.0,            
	// top centre
	
	//＊＊＊＊＊＊＊ left face
	-1.0 ,-1.0 ,-1.0,           
	// bottom rear
	
	-1.0 ,-1.0 ,1.0,            
	// bottom front
	
	0.0 ,1.0 ,0.0,            
	// top centre
	
	//＊＊＊＊＊＊ right face
	1.0 ,-1.0 ,1.0,             
	// bottom front
	
	1.0 ,-1.0 ,-1.0,            
	// bottom rear
	
	0.0 ,1.0 ,0.0
	// top centre
};

const GLfloat blendRectangle[]=
{
	2.5, 2.0, 0.0,
	-2.5,2.0,0.0,
	-2.5,-2.5,0.0,
	2.5,-2.5,0.0
};

- (void)render:(CADisplayLink *)displayLink
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	rota += 0.5;
	if (rota >= 360)
	{
		rota -= 360;
	}

	glTexCoordPointer(2, GL_SHORT, 0, squareTextureCoords);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glPushMatrix();
	{
		glTranslatef(0, -2.0, -6.0);
		glRotatef(rota, 1, 0, 0);
		glVertexPointer(3, GL_FLOAT, 0, pyramidVertices);
		glEnableClientState(GL_VERTEX_ARRAY);
		
		glColor4f(0.7, 0.7, 0.3, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		
		glColor4f(0, 1, 0, 1);
		glDrawArrays(GL_TRIANGLES, 4, 3);
		
		glColor4f(0, 0, 1, 1);
		glDrawArrays(GL_TRIANGLES, 7, 3);
		
		glColor4f(1, 1, 0, 1);
		glDrawArrays(GL_TRIANGLES, 10, 3);
		
		glColor4f(1, 0, 1, 1);
		glDrawArrays(GL_TRIANGLES, 13, 3);
	}
	glPopMatrix();
	
	
	glPushMatrix();
	{
		glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
		glEnableClientState(GL_VERTEX_ARRAY);
		
		glTranslatef(0, 2.0, -6.0);
		glRotatef(rota, 1, 1, 1);

		glColor4f(1, 0, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		
		glColor4f(0.0, 1.0, 0.0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 4, 4);
		
		glColor4f(0, 0, 1, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 8, 4);
		
		glColor4f(1, 1, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 12, 4);
		
		glColor4f(0, 1, 1, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 16, 4);
		
		glColor4f(1, 0, 1, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 20, 4);
	}
	glPopMatrix();
	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	glPushMatrix();
	{
//		glTranslatef(0, 1, 0);
		glVertexPointer(3, GL_FLOAT, 0, blendRectangle);
//		glEnableClientState(<#GLenum array#>)
		glColor4f(0, 0, 1, 0.2);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		
	}
	glPopMatrix();
	
	glDisable(GL_BLEND);
	
	[_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)loadTexture
{
	UIImage* image = [UIImage imageNamed:@"017.JPG"];
	CGImageRef textureImage = image.CGImage;
	if (textureImage == nil)
	{
		NSLog(@"Failed to load texture image");
		return;
	}
	NSInteger texWidth = image.size.width;
	NSInteger texHeight = image.size.height;
	GLubyte* textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	
	CGContextRef textureContext = CGBitmapContextCreate(textureData, texWidth, texHeight, 8, texWidth * 4, CGImageGetColorSpace(textureImage), kCGImageAlphaPremultipliedLast);
	CGContextDrawImage(textureContext, CGRectMake(0, 0, texWidth, texHeight), textureImage);
	CGContextRelease(textureContext);
	
	glGenTextures(1, &textures[0]);
	glBindTexture(GL_TEXTURE_2D, textures[0]);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glEnable(GL_TEXTURE_2D);
}

//- (void)drawRect:(CGRect)rect
//{
//	NSString* str = @"Test凯凯";
//	[[UIColor blueColor] set];
//	[str drawAtPoint:CGPointMake(20, 150) withFont:[UIFont systemFontOfSize:20]];
//}

@end
