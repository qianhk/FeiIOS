//
//  OpenGLView.h
//  HelloOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLView : UIView
{
	CAEAGLLayer* _eaglLayer;
	EAGLContext* _context;
	GLuint _colorRenderBuffer;
	
	GLuint _positionSlot;
	GLuint _colorSlot;
	
	float _currentRotation;
	
	GLuint _depthRenderBuffer;
	
	float rota;
	
	GLuint textures[6];
}

@end
