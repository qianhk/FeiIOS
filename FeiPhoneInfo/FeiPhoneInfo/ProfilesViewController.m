//
//  ProfileViewController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <OpenGLES/es1/gl.h>
#import "ProfilesViewController.h"

@interface ProfilesViewController()

- (void)getIntegerValue:(GLenum)pname keyStr:(NSString *)keyStr;
- (void)getBooleanValue:(GLenum)pname keyStr:(NSString *)keyStr;
- (void)getStringValue:(GLenum)pname keyStr:(NSString *)keyStr;

@end

@implementation ProfilesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)getIntegerValue:(GLenum)pname keyStr:(NSString *)keyStr
{
//	NSString* retainKeyStr = [keyStr retain];
	GLint param = 0;
	glGetIntegerv(pname, &param);
	[_arrKey addObject:keyStr];
	[_dic setValue:[NSString stringWithFormat:@"%d", param] forKey:keyStr];
}

- (void)getBooleanValue:(GLenum)pname keyStr:(NSString *)keyStr
{
	GLboolean param = 0;
	glGetBooleanv(pname, &param);
	[_arrKey addObject:keyStr];
	[_dic setValue:param ? @"Yes" : @"No" forKey:keyStr];
}

- (void)getStringValue:(GLenum)pname keyStr:(NSString *)keyStr
{
	const GLubyte* value = glGetString(pname);;
	[_arrKey addObject:keyStr];
	if (value != NULL)
	{
		[_dic setValue:[NSString stringWithUTF8String:(unsigned char *)value] forKey:keyStr];
	}
	else
	{
		[_dic setValue:@" " forKey:keyStr];
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
	EAGLContext* _context = [[EAGLContext alloc] initWithAPI:api];
	if (![EAGLContext setCurrentContext:_context])
	{
		NSLog(@"Failed to set current OpenGL context");
//		exit(2);
	}
	
	[self getIntegerValue:GL_MAX_LIGHTS keyStr:@"Max_Lights"];
	[self getIntegerValue:GL_MAX_MODELVIEW_STACK_DEPTH keyStr:@"Max_ModelView_Stack_Depth"];
	[self getIntegerValue:GL_MAX_PROJECTION_STACK_DEPTH keyStr:@"Max_Projection_Stack_Depth"];
	[self getIntegerValue:GL_MAX_TEXTURE_STACK_DEPTH keyStr:@"Max_Texture_Stack_Depth"];
	[self getIntegerValue:GL_SUBPIXEL_BITS keyStr:@"Subpixel_Bits"];
	[self getIntegerValue:GL_MAX_TEXTURE_SIZE keyStr:@"Max_Texture_Size"];
	[self getIntegerValue:GL_MAX_TEXTURE_UNITS keyStr:@"Max_Texture_Units"];
//	[self getIntegerValue:GL_MAX_VIEWPORT_DIMS keyStr:@"Max_ViewPort_Dims"];
	
	[self getStringValue:GL_RENDERER keyStr:@"Renderer"];
//	[self getStringValue:GL_SHADING_LANGUAGE_VERSION keyStr:@"Shading_Language_Version"];
	[self getStringValue:GL_VENDOR keyStr:@"Vendor"];
	[self getStringValue:GL_VERSION keyStr:@"Version"];
	[self getStringValue:GL_EXTENSIONS keyStr:@"Extensions"];
	
	[self getIntegerValue:GL_RED_BITS keyStr:@"Red_Bits"];
	[self getIntegerValue:GL_GREEN_BITS keyStr:@"Green_Bits"];
	[self getIntegerValue:GL_BLUE_BITS keyStr:@"Blue_Bits"];
	[self getIntegerValue:GL_ALPHA_BITS keyStr:@"Alpha_Bits"];
	
	[self getIntegerValue:GL_STENCIL_BITS keyStr:@"Stencil_Bits"];
	[self getIntegerValue:GL_DEPTH_BITS keyStr:@"Depth_Bits"];
	
	[_context release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arrKey count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		[super configCell:cell];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:6666];
	label.text = [NSString stringWithFormat:@"%d", [indexPath row] + 1];
    cell.textLabel.text = [_arrKey objectAtIndex:[indexPath row]];
	cell.detailTextLabel.text = [_dic objectForKey:cell.textLabel.text];
    
    return cell;
}


@end
