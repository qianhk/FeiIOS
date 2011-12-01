//
//  jet.m
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

#import "math3d.h"

// Rotation amounts
static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;

void initjet()
{
	glEnable(GL_DEPTH_TEST);	// Hidden surface removal
    glEnable(GL_CULL_FACE);		// Do not calculate inside of jet
    glFrontFace(GL_CCW);		// Counter clock-wise polygons face out
	
	glEnable(GL_LIGHTING);
	GLfloat ambientLight[] = {0.3f, 0.3f, 0.3f, 1.0f};
	GLfloat diffuseLight[] = {0.7f, 0.7f, 0.7f, 1.0f};
	GLfloat specular[] = {1.0f, 1.0f, 1.0f, 1.0f};
	//	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);
	
	glLightfv(GL_LIGHT0, GL_AMBIENT, ambientLight);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuseLight);
	glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
	glEnable(GL_LIGHT0);
	
	glEnable(GL_COLOR_MATERIAL);
	
	glColorMaterial(GL_FRONT,GL_AMBIENT_AND_DIFFUSE);
	
	GLfloat specref[] = {1.0f, 1.0f, 1.0f, 1.0f};
	glMaterialfv(GL_FRONT, GL_SPECULAR, specref);
	glMateriali(GL_FRONT, GL_SHININESS, 128);
	
	glEnable(GL_NORMALIZE);
	
    // Nice light blue
    glClearColor(0.0f, 0.0f, 1.0f,1.0f);

}

void displayjet()
{
	M3DVector3f vNormal;	// Storeage for calculated surface normal
	
	// Clear the window with current clearing color
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	// Save the matrix state and do the rotations
	glPushMatrix();
	glRotatef(xRot, 1.0f, 0.0f, 0.0f);
	glRotatef(yRot, 0.0f, 1.0f, 0.0f);
	
	
	// Nose Cone - Points straight down
    // Set material color
	glColor3ub(128, 128, 128);
	glBegin(GL_TRIANGLES);
	glNormal3f(0.0f, -1.0f, 0.0f);
	glNormal3f(0.0f, -1.0f, 0.0f);
	glVertex3f(0.0f, 0.0f, 60.0f);
	glVertex3f(-15.0f, 0.0f, 30.0f);
	glVertex3f(15.0f,0.0f,30.0f);
	
	glColor3ub(255, 255, 255);
	// Verticies for this panel
	{
        M3DVector3f vPoints[3] = {{ 15.0f, 0.0f,  30.0f},
			{ 0.0f,  15.0f, 30.0f},
			{ 0.0f,  0.0f,  60.0f}};
		
        // Calculate the normal for the plane
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
		glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}	
	
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f, 0.0f, 60.0f },
			{ 0.0f, 15.0f, 30.0f },
			{ -15.0f, 0.0f, 30.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	glColor3ub(0,255,0);
	// Body of the Plane ////////////////////////
	{
        M3DVector3f vPoints[3] = {{ -15.0f, 0.0f, 30.0f },
			{ 0.0f, 15.0f, 30.0f },
			{ 0.0f, 0.0f, -56.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f, 0.0f, -56.0f },
			{ 0.0f, 15.0f, 30.0f },
			{ 15.0f,0.0f,30.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
    
	glNormal3f(0.0f, -1.0f, 0.0f);
	glVertex3f(15.0f,0.0f,30.0f);
	glVertex3f(-15.0f, 0.0f, 30.0f);
	glVertex3f(0.0f, 0.0f, -56.0f);
    
	glColor3ub(128,128,128);
	///////////////////////////////////////////////
	// Left wing
	// Large triangle for bottom of wing
	{
        M3DVector3f vPoints[3] = {{ 0.0f,2.0f,27.0f },
			{ -60.0f, 2.0f, -8.0f },
			{ 60.0f, 2.0f, -8.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
		glColor3f(0.5f, 0.0f, 0.5f);
	}
	
	
	{
        M3DVector3f vPoints[3] = {{ 60.0f, 2.0f, -8.0f},
			{0.0f, 7.0f, -8.0f},
			{0.0f,2.0f,27.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	{
        M3DVector3f vPoints[3] = {{60.0f, 2.0f, -8.0f},
			{-60.0f, 2.0f, -8.0f},
			{0.0f,7.0f,-8.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	glColor3ub(64,64,64);
	{
        M3DVector3f vPoints[3] = {{0.0f,2.0f,27.0f},
			{0.0f, 7.0f, -8.0f},
			{-60.0f, 2.0f, -8.0f}};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
		glColor3f(0, 1.0f, 0.5f);
	}
	
	glColor3ub(255,128,255);
	// Tail section///////////////////////////////
	// Bottom of back fin
	glNormal3f(0.0f, -1.0f, 0.0f);
	glVertex3f(-30.0f, -0.50f, -57.0f);
	glVertex3f(30.0f, -0.50f, -57.0f);
	glVertex3f(0.0f,-0.50f,-40.0f);
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f,-0.5f,-40.0f },
			{30.0f, -0.5f, -57.0f},
			{0.0f, 4.0f, -57.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f, 4.0f, -57.0f },
			{ -30.0f, -0.5f, -57.0f },
			{ 0.0f,-0.5f,-40.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	{
        M3DVector3f vPoints[3] = {{ 30.0f,-0.5f,-57.0f },
			{ -30.0f, -0.5f, -57.0f },
			{ 0.0f, 4.0f, -57.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f,0.5f,-40.0f },
			{ 3.0f, 0.5f, -57.0f },
			{ 0.0f, 25.0f, -65.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	
	{
        M3DVector3f vPoints[3] = {{ 0.0f, 25.0f, -65.0f },
			{ -3.0f, 0.5f, -57.0f},
			{ 0.0f,0.5f,-40.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	{
        M3DVector3f vPoints[3] = {{ 3.0f,0.5f,-57.0f },
			{ -3.0f, 0.5f, -57.0f },
			{ 0.0f, 25.0f, -65.0f }};
		
        m3dFindNormal(vNormal, vPoints[0], vPoints[1], vPoints[2]);
        glNormal3fv(vNormal);
		glVertex3fv(vPoints[0]);
		glVertex3fv(vPoints[1]);
		glVertex3fv(vPoints[2]);
	}
	
	
	glEnd();
	
	// Restore the matrix state
	glPopMatrix();
	// Display the results
	
	glutSwapBuffers();
}

void reshapejet(int w, int h)
{
	GLfloat fAspect;
	GLfloat lightPos[] = {-50.f, 50.f, 100.0f, 1.0f};
	GLfloat nRange = 80.0f;
    // Prevent a divide by zero
    if(h == 0)
        h = 1;
	
    // Set Viewport to window dimensions
    glViewport(0, 0, w, h);
	
    // Reset coordinate system
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
	
	fAspect = (GLfloat)w/(GLfloat)h;
	gluPerspective(45.0f, fAspect, 1.0f, 225.0f);
	
//    // Establish clipping volume (left, right, bottom, top, near, far)
//    if (w <= h) 
//        glOrtho (-nRange, nRange, -nRange*h/w, nRange*h/w, -nRange, nRange);
//    else 
//        glOrtho (-nRange*w/h, nRange*w/h, -nRange, nRange, -nRange, nRange);
	
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
	glLightfv(GL_LIGHT0, GL_POSITION, lightPos);
	glTranslatef(0, 0, -150.0f);
}

void keyPressedjet(unsigned char key, int x, int y)
{
	NSLog(@"Key pressed: %c %d %d", key, x, y);}

void SpecialKeysjet(int key, int x, int y)
{
    if(key == GLUT_KEY_UP)
        xRot-= 5.0f;
	
    if(key == GLUT_KEY_DOWN)
        xRot += 5.0f;
	
    if(key == GLUT_KEY_LEFT)
        yRot -= 5.0f;
	
    if(key == GLUT_KEY_RIGHT)
        yRot += 5.0f;
	
    if(key > 356.0f)
        xRot = 0.0f;
	
    if(key < -1.0f)
        xRot = 355.0f;
	
    if(key > 356.0f)
        yRot = 0.0f;
	
    if(key < -1.0f)
        yRot = 355.0f;
	
    // Refresh the Window
    glutPostRedisplay();
}


int mainjet(int argc, const char * argv[])
{
	@autoreleasepool
	{
	    glutInit(&argc, (char **)argv);
		glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
		glutInitWindowSize(800, 600);
		glutInitWindowPosition(300, 100);
		glutCreateWindow("Hello, jet");
		initjet();
		glutReshapeFunc(reshapejet);
		glutDisplayFunc(displayjet);
		glutKeyboardFunc(keyPressedjet);
		glutSpecialFunc(SpecialKeysjet);
		glutMainLoop();
	    
	}
    return 0;
	
}