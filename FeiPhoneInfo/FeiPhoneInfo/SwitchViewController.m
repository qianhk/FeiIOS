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
	
//	CGRect rect = [[UIScreen mainScreen] bounds];
	
//	bkgView = [[UIView alloc] initWithFrame:rect];
////	self.view = bkgView;
//	[self.view addSubview:bkgView];
//	bkgView.backgroundColor = [UIColor clearColor];
	
//	UIImage *image = [UIImage imageNamed:@"splash.jpg"];
//    imgView = [[UIImageView alloc] initWithFrame:rect];
//    imgView.image = image;
//	self.view = imgView;

	CGRect rectbottom = CGRectMake(0, 416, 320, 44);
	tabBar = [[UITabBar alloc] initWithFrame:rectbottom];
	tabBarItem0 = [[UITabBarItem alloc] initWithTitle:@"000" image:nil tag:100];
	tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"001" image:nil tag:101];
	tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"002" image:nil tag:102];
	tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"003" image:nil tag:103];
	tabBarItem4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:104];
	NSArray* array = [NSArray arrayWithObjects:tabBarItem0,tabBarItem1,tabBarItem2,tabBarItem3,tabBarItem4, nil];
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
	if (item.tag == 100)
	{
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
}

@end
