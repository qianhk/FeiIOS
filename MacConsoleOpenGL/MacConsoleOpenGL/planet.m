//
//  planet.m
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

static int year = 0, day = 0, day2 = 0;

void initPlanet()
{
	glClearColor(0, 0, 0, 0);
	glShadeModel(GL_FLAT);
}


void displayPlanet()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1, 1, 1);
	glPushMatrix();
	glutWireSphere(1.0, 20, 16);
	
	glRotatef((GLfloat)year, 0, 1, 0);
	glTranslatef(2, 0, 0);
	
	glPushMatrix();
	glRotatef((GLfloat)day, 0, 1, 0);
	glutWireSphere(0.6, 16, 10);
	glPopMatrix();
	
	glRotatef((GLfloat)day2, 1, 0, 0);
	glTranslatef(0, 1.2, 0);
	glutWireSphere(0.3, 10, 8);
	

	glPopMatrix();
	
	glutSwapBuffers();
}

void reshapePlanet(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60, w/h, 1, 20);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0, 0, 5, 0, 0, 0, 0, 1, 0);
}

void keyboardPlanet(unsigned char key, int x, int y)
{
	switch (key)
	{
		case 'd':
		{
			day = (day + 10) % 360;
			day2 = (day2 + 5) % 360;
			glutPostRedisplay();
		}
		break;
			
		case 'D':
		{
			day = (day - 10) % 360;
			day2 = (day2 - 5) % 360;
			glutPostRedisplay();	
		}
		break;
			
		case 'y':
		{
			year = (year + 5) % 360;
			glutPostRedisplay();
		}
		break;
			
		case 'Y':
		{
			year = (year - 5) % 360;
			glutPostRedisplay();	
		}
		break;
			
		default:
			break;
	}
}

int mainPlanet(int argc, const char * argv[])
{
	glutInit(&argc, (char **)argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(800, 600);
	glutInitWindowPosition(300, 200);
	glutCreateWindow(argv[0]);
	initPlanet();
	glutDisplayFunc(displayPlanet);
	glutReshapeFunc(reshapePlanet);
	glutKeyboardFunc(keyboardPlanet);
	glutMainLoop();
	
	return 0;
}
