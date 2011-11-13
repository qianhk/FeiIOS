//
//  stroke.m
//  MacConsoleOpenGL
//
//  Created by KaiKai on 11-11-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

#define PT 1
#define STROKE 2
#define END 3

typedef struct charpoint
{
	GLfloat x, y;
	int type;
}CP;

CP Adata[] = {
	{ 0, 0, PT}, {0, 9, PT}, {1, 10, PT}, {4, 10, PT}, 
	{5, 9, PT}, {5, 0, STROKE}, {0, 5, PT}, {5, 5, END}
};

CP Edata[] = {
	{5, 0, PT}, {0, 0, PT}, {0, 10, PT}, {5, 10, STROKE},
	{0, 5, PT}, {4, 5, END}
};

CP Pdata[] = {
	{0, 0, PT}, {0, 10, PT},  {4, 10, PT}, {5, 9, PT}, {5, 6, PT}, 
	{4, 5, PT}, {0, 5, END}
};

CP Rdata[] = {
	{0, 0, PT}, {0, 10, PT},  {4, 10, PT}, {5, 9, PT}, {5, 6, PT}, 
	{4, 5, PT}, {0, 5, STROKE}, {3, 5, PT}, {5, 0, END}
};

CP Sdata[] = {
	{0, 1, PT}, {1, 0, PT}, {4, 0, PT}, {5, 1, PT}, {5, 4, PT}, 
	{4, 5, PT}, {1, 5, PT}, {0, 6, PT}, {0, 9, PT}, {1, 10, PT}, 
	{4, 10, PT}, {5, 9, END}
};

/*  drawLetter() interprets the instructions from the array
 *  for that letter and renders the letter with line segments.
 */
static void drawLetter(CP *l)
{
	glBegin(GL_LINE_STRIP);
	while (1) {
		switch (l->type) {
			case PT:
				glVertex2fv(&l->x);
				break;
			case STROKE:
				glVertex2fv(&l->x);
				glEnd();
				glBegin(GL_LINE_STRIP);
				break;
			case END:
				glVertex2fv(&l->x);
				glEnd();
				glTranslatef(8.0, 0.0, 0.0);
				return;
		}
		l++;
	}
}

char *test1 = "Aqhk SPARE SERAPE APPEARS AS";
char *test2 = "APES PREPARE RARE PEPPERS";

static void printStrokedString(char *s)
{
	GLsizei len = strlen(s);
	glCallLists(len, GL_BYTE, (GLbyte *)s);
}

/*  Create a display list for each of 6 characters	*/
void initStroke()
{
	glClearColor(0.3, 0.3, 0.3, 0);
	GLuint base;
	
	glShadeModel (GL_FLAT);
	
	base = glGenLists (128);
	glListBase(base);
	glNewList(base+'A', GL_COMPILE); drawLetter(Adata); glEndList();
	glNewList(base+'E', GL_COMPILE); drawLetter(Edata); glEndList();
	glNewList(base+'P', GL_COMPILE); drawLetter(Pdata); glEndList();
	glNewList(base+'R', GL_COMPILE); drawLetter(Rdata); glEndList();
	glNewList(base+'S', GL_COMPILE); drawLetter(Sdata); glEndList();
	glNewList(base+' ', GL_COMPILE); glTranslatef(8.0, 0.0, 0.0); glEndList();
}

void displayStroke(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(1, 1, 1);
	
	glPushMatrix();
	glScalef(4, 4, 4);
	glTranslatef(10, 30, 0);
	printStrokedString(test1);
	glPopMatrix();
	
	glPushMatrix();
	glScalef(2, 2, 2);
	glTranslatef(10, 13, 0);
	printStrokedString(test2);
	glPopMatrix();
	
	glFlush();
}

void reshapeStroke(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	gluOrtho2D(0, w, 0, h);
}

void keyboardStroke(unsigned char key, int x, int y)
{
	switch (key)
	{
		case ' ':
			glutPostRedisplay();
			break;
			
		case 27:
			exit(0);
			break;
			
		default:
			break;
	}
}

int mainStroke(int argc, const char* argv[])
{
	glutInit(&argc, (char **)argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(800, 600);
	glutInitWindowPosition(300, 200);
	glutCreateWindow(argv[0]);
	initStroke();
	glutDisplayFunc(displayStroke);
	glutReshapeFunc(reshapeStroke);
	glutKeyboardFunc(keyboardStroke);
	glutMainLoop();
	
	return 0;
}

