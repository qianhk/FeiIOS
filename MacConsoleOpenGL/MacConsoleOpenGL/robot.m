//
//  robot.m
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

static int shoulder = 0, elbow = 0;

void initRobot()
{
	glClearColor(0.5, 0.5, 0.5, 0);
	glShadeModel(GL_FLAT);
}

void displayRobot()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glPushMatrix();
	
	glTranslatef(-1.0, 0, 0);
	glRotatef((GLfloat)shoulder, 0, 0, 1);
	glTranslatef(1, 0, 0);
	glPushMatrix();
	glScalef(2, 0.4, 1);
	glutWireCube(1.0);
	glPopMatrix();
	
	glTranslatef(1, 0, 0);
	glRotatef((GLfloat)elbow, 0, 0, 1);
	glTranslatef(1, 0, 0);
	glPushMatrix();
	glScalef(2, 0.4, 1);
	glutWireCube(1.0);
	glPopMatrix();
	
	glTranslatef(1.35, 0, 0);
	glRotatef((GLfloat)elbow, 0, 0, 1);
//	glTranslatef(0.6, 0, 0);
	glScalef(0.4, 0.1, 0.2);
	glutWireCube(1);

	
	glPopMatrix();
	glutSwapBuffers();
}

void reshapeRobot(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(65, w * 1.0f /h, 1, 20);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glTranslated(0, 0, -5.0);
}

void keyboardRobot(unsigned char key, int x, int y)
{
	switch (key)
	{
		case 's':
			shoulder = (shoulder + 5) % 360;
			glutPostRedisplay();
			break;
		
		case 'S':
			shoulder = (shoulder - 5) % 360;
			glutPostRedisplay();
			break;
		
		case 'e':
			elbow = (elbow + 5) % 360;
			glutPostRedisplay();
			break;
		
		case 'E':
			elbow = (elbow - 5) % 360;
			glutPostRedisplay();
			break;
		
		default:
			break;
	}
}

int mainRobot(int argc, char * argv[])
{
	glutInit(&argc, (char **)argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(800, 600);
	glutInitWindowPosition(300, 200);
	glutCreateWindow(argv[0]);
	initRobot();
	glutDisplayFunc(displayRobot);
	glutReshapeFunc(reshapeRobot);
	glutKeyboardFunc(keyboardRobot);
	GLint nMax = 0; // nMax = 32
	glGetIntegerv(GL_MAX_MODELVIEW_STACK_DEPTH, &nMax);
	glutMainLoop();
	
	return 0;
}