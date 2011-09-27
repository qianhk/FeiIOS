//
//  SwitchViewController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "SwitchViewController.h"
#import "GeneralInfoController.h"
#import "TasksController.h"

@implementation SwitchViewController

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

- (id)init
{
	[super init];
	
	if (self)
	{

	}
	return self;
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	CGRect rect = [[UIScreen mainScreen] bounds];
	CGRect rectbottom = CGRectMake(0, rect.size.height - 20 - 44, rect.size.width, 44);
	
	tabBar = [[UITabBar alloc] initWithFrame:rectbottom];
	tabBarItem0 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"General", @"for general info") image:[UIImage imageNamed:@"generalinfo.png"] tag:100];
	tabBarItem1 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Tasks", @"for phone tasks") image:[UIImage imageNamed:@"tasks.png"] tag:101];
	tabBarItem2 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Profiles", @"for phone profiles") image:[UIImage imageNamed:@"profiles.png"] tag:102];
	tabBarItem3 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Network", @"for phone network") image:[UIImage imageNamed:@"network.png"] tag:103];
	tabBarItem4 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Camera", @"for camera") image:[UIImage imageNamed:@"camera.png"] tag:104];
	tabBarItem5 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Hardware", @"for hardware text") image:[UIImage imageNamed:@"hardware.png"] tag:105];
	tabBarItem6 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"About", @"for about prompt") image:[UIImage imageNamed:@"about.png"] tag:106];
	NSArray* array = [NSArray arrayWithObjects:tabBarItem0,tabBarItem1,tabBarItem2,tabBarItem3,tabBarItem4, tabBarItem5,tabBarItem6, nil];
	[tabBar setItems:array animated:YES];
	[tabBar setDelegate:self];
	[self.view addSubview:tabBar];
	
	generalInfo = [[GeneralInfoController alloc] initWithStyle:UITableViewStylePlain];
	tasksInfo = [[TasksController alloc] initWithStyle:UITableViewStylePlain];

	[self.view addSubview:generalInfo.view];
	[self.view addSubview:tasksInfo.view];
	
	tabBar.selectedItem = tabBarItem0;
	[self.view bringSubviewToFront:generalInfo.view];
}

- (void)dealloc
{
	[generalInfo release];
	[tasksInfo release];
	
	[tabBarItem0 release];
	[tabBarItem1 release];
	[tabBarItem2 release];
	[tabBarItem3 release];
	[tabBarItem4 release];
	[tabBarItem5 release];
	[tabBarItem6 release];
	[tabBar release];
	[imgView release];
	[bkgView release];
	
	[super dealloc];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//	[UIView beginAnimations:@"Test" context:nil];
//	[UIView setAnimationDuration:0.5];
	if (item.tag == 100)
	{
//		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:generalInfo.view cache:YES];
		[self.view bringSubviewToFront:generalInfo.view];
	}
	else if (item.tag == 101)
	{
		[self.view bringSubviewToFront:tasksInfo.view];
	}
	else
	{
//		[self.view sendSubviewToBack:generalInfo.view];
	}
//	[UIView commitAnimations];
}

@end
