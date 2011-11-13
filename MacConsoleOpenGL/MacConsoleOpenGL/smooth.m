//
//  smooth.mm
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

void initSmooth()
{
	glClearColor(0.7, 0.7, 0.7, 0);
	glShadeModel(GL_SMOOTH);
}

void triangle(void)
{
	glBegin(GL_TRIANGLES);
	glColor3f(1, 0, 0);
	glVertex2f(5, 5);
	glColor3f(0, 1, 0);
	glVertex2f(25, 5);
	glColor3f(0, 0, 1);
	glVertex2f(5, 25);
	glEnd();
}

void displaySmooth(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	triangle();
	glFlush();
}

void reshapeSmooth(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	if (w <= h)
	{
		gluOrtho2D(0, 30, 0, 30.0f * h / w);
	}
	else
	{
		gluOrtho2D(0, 30.0f * w / h, 0, 30);
	}
	
	glMatrixMode(GL_MODELVIEW);
}

int mainSmooth(int argc, const char* argv[])
{
	glutInit(&argc, (char **)argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(800, 600);
	glutInitWindowPosition(300, 200);
	glutCreateWindow(argv[0]);
	initSmooth();
	glutDisplayFunc(displaySmooth);
	glutReshapeFunc(reshapeSmooth);
	glutMainLoop();

	return 0;
}