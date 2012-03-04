//
//  ImageAppDelegate.m
//  Image
//
//  Created by Bill Dudney on 12/12/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "ImageAppDelegate.h"
#import "ImageViewController.h"

@implementation ImageAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
