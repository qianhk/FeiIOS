//
//  main.m
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

void init(void)
{
	glClearColor(0.4f, 0.4f, 0.4f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(0.0, 1.0, 0.0, 1.0, -1.0, 1.0);
}

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	glColor3f(1, 1, 1.0f);
	
	glBegin(GL_POLYGON);
	glVertex3f(0.25, 0.25, 0.0);
	glVertex3f(0.75, 0.25, 0.0);
	glVertex3f(0.75, 0.75, 0.0);
	glVertex3f(0.25, 0.75, 0.0);
	glEnd();
	glFlush();
}

int main (int argc, const char * argv[])
{

	@autoreleasepool
	{
	    
	    glutInit(&argc, argv);
		glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
		glutInitWindowSize(250, 250);
		glutInitWindowPosition(100, 100);
		glutCreateWindow("Hello, mac console opengl");
		init();
		glutDisplayFunc(display);
		glutMainLoop();
	    
	}
    return 0;
}

