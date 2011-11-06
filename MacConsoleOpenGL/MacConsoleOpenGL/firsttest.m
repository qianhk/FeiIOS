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

//void init(void);
//void display(void);
//void spinDisplay(void);
//void reSizeWindow(int w, int h);
//void keyPressed(unsigned char key, int x, int y);
//void mousePressed(int button, int state, int x, int y);
//void mouseDraging(int x, int y);
//int mainFirstTest (int argc, const char * argv[]);
void onTimer1(int a);

static GLfloat spin = 0.0;
static bool canDraw = false;

void init1(void)
{
	glClearColor(0.4f, 0.4f, 0.4f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0);
	
	glShadeModel(GL_FLAT);
}

void display1(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1, 1, 0.0f);

// qhk:1
//	glBegin(GL_POLYGON);
//	glVertex3f(0.25, 0.25, 0.0);
//	glVertex3f(0.75, 0.25, 0.0);
//	glVertex3f(0.75, 0.75, 0.0);
//	glVertex3f(0.25, 0.75, 0.0);
//	glEnd();
	
//	glutWireCube(0.75);
//	glutSolidCube(0.75);
	
//	glutWireSphere(0.8, 32, 16);
//	glutSolidSphere(0.8, 32, 16);
	
//	glutWireTorus(0.3, 0.5, 16, 64);
//	glutSolidTorus(0.3, 0.5, 16, 64);
	
//	glutWireIcosahedron();
	
//	glutWireCone(0.3, 1, 16, 16);
	
	glPushMatrix();
	glRotatef(spin, 1.0, 1.0, 1.0);
//	glTranslatef(-0.2, 0, 0);
	glutWireTeapot(0.5);
//	glutSolidTeapot(0.5);
	glPopMatrix();
	glutSwapBuffers();
	
//	glFlush();

	
//	glPushMatrix();
//	glRotatef(spin, 0.0, 0.0, 1.0);
//	glRectf(-0.6, -0.6, 0.6, 0.6);
//	glPopMatrix();
//	glutSwapBuffers();
}

void spinDisplay1(void)
{
	spin += 2.0;
	if (spin > 360.0)
	{
		spin -= 360.0;
	}
	glutPostRedisplay();
}

void reSizeWindow1(int w, int h)
{
//	NSLog(@"new windows size is: %d %d", w, h);
	
	glViewport(0, 0, w, h);
//	glMatrixMode(GL_PROJECTION);
//	glLoadIdentity();
////	glOrtho(-50, 50, -50, 50, -1.0, 1.0);
//	glMatrixMode(GL_MODELVIEW);
//	glLoadIdentity();
}

void keyPressed1(unsigned char key, int x, int y)
{
//	NSLog(@"Key pressed: %c %d %d", key, x, y);
}

void mousePressed1(int button, int state, int x, int y)
{
//	NSLog(@"Mouse Pressed: %d %d %d %d", button, state, x, y);
	switch (button)
	{
		case GLUT_LEFT_BUTTON:
			if (state == GLUT_DOWN)
			{
//				glutIdleFunc(spinDisplay);
				canDraw = true;
				glutTimerFunc(30, onTimer1, 1);
			}
			break;
			
//		case GLUT_MIDDLE_BUTTON:
//			if (state == GLUT_DOWN)
//			{
////				glutIdleFunc(NULL);
//				canDraw = false;
//			}
//			break;
			
		case GLUT_RIGHT_BUTTON:
			if (state == GLUT_DOWN)
			{
				canDraw = false;
			}
			
		default:
			break;
	}
}

void onTimer1(int a)
{
//	printf("onTimer %d\n", a);
	if (canDraw)
	{
		spin += 2.0;
		if (spin > 360.0)
		{
			spin -= 360.0;
		}
		glutPostRedisplay();
		glutTimerFunc(100, onTimer1, 1);
	}
}

void mouseDraging1(int x, int y)
{
//	NSLog(@"mouseDraging: %d %d", x, y);
}

int mainFirstTest (int argc, const char * argv[])
{

	@autoreleasepool
	{
	    
	    glutInit(&argc, (char **)argv);
		glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
		glutInitWindowSize(600, 600);
		glutInitWindowPosition(300, 100);
		glutCreateWindow("Hello, mac console opengl");
		init1();
		glutDisplayFunc(display1);
		glutReshapeFunc(reSizeWindow1);
		glutKeyboardFunc(keyPressed1);
		glutMouseFunc(mousePressed1);
		glutMotionFunc(mouseDraging1);
		
		glutMainLoop();
	    
	}
    return 0;
}

