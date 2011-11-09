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

void initPlanet()
{
	
}


void displayPlanet()
{
	
}

void reshapePlanet(int w, int h)
{
	
}

void keyboardPlanet(unsigned char key, int x, int y)
{
	
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
