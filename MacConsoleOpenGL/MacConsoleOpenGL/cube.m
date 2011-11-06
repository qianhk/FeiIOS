//
//  cube.mm
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-6.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

void init3()
{
	glClearColor(0.8, 0.8, 0.8, 0);
	glShadeModel(GL_FLAT);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	glFrustum(-1.0, 1.0, -1.0, 1.0, 1.5, 20);
	glMatrixMode(GL_MODELVIEW);

}

void display3()
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	glColor3f(1, 1, 1);
	glLoadIdentity();
	
	gluLookAt(0, 0, 1.9, 0.0, 0.0, 0, 0.0, 1, 0);
//	glTranslatef(0, 0, -5.0);
//	glScalef(1, 2, 1);
	glutWireCube(1.0);
	
	glFlush();
}

void reshape3(int w, int h)
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
}

int mainCube(int argc, const char* argv[])
{
	glutInit(&argc, (char **)argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(500, 500);
	glutInitWindowPosition(100, 100);
	glutCreateWindow(argv[0]);
	init3();
	glutDisplayFunc(display3);
	glutReshapeFunc(reshape3);
	glutMainLoop();
	
	return 0;
}