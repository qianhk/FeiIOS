//
//  MyOpenGLView.m
//  MacOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <OpenGL/gl.h>

#import "MyOpenGLView.h"

@interface MyOpenGLView()

- (void)drawAnObject;

@end

@implementation MyOpenGLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawAnObject
{
	glColor3f(1.0f, 0.85f, 0.35f);
	glBegin(GL_TRIANGLES);
	{
		glVertex3f(0, 0.6, 0);
		glVertex3f(-0.2, -0.3, 0);
		glVertex3f(0.2, -0.3, 0);
	}
	glEnd();
}

- (void)drawRect:(NSRect)dirtyRect
{
	glClearColor(0, 0, 0, 0);
	glClear(GL_COLOR_BUFFER_BIT);
	[self drawAnObject];
	glFlush();
}

@end
