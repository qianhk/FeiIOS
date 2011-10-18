//
//  AboutViewController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
//	CGRect rect = self.tableView.frame;
//	rect.origin.y = 60.0f;
//	[self.tableView setFrame:rect];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	UIImageView* headerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.tableView.frame.size.width, 80)] autorelease];
	headerView.contentMode = UIViewContentModeCenter;
	headerView.image = [UIImage imageNamed:@"logo_about.png"];
	UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)] autorelease];
	[view addSubview:headerView];
	self.tableView.tableHeaderView = view;
	
	UILabel* footerView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 48.0f)] autorelease];
    footerView.textAlignment = UITextAlignmentCenter;
    footerView.backgroundColor = [UIColor clearColor];
    footerView.lineBreakMode = UILineBreakModeWordWrap;
    footerView.font = [UIFont systemFontOfSize:14.0f];
    footerView.numberOfLines = 2;
    footerView.textAlignment = UITextAlignmentCenter;
    [footerView setText:NSLocalizedString(@"Copyright", @"the Copyright")];
    
    self.tableView.tableFooterView = footerView;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	CGRect rectHeadImage;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
	{
		rectHeadImage = CGRectMake(0, 20, 320, 80);
	}
	else
	{
		rectHeadImage = CGRectMake(0, 20, 480, 80);
	}
	
	UIView* view = self.tableView.tableHeaderView;
	if (view.subviews > 0)
	{
		UIView* imageView = (UIView *)[view.subviews objectAtIndex:0];
		[imageView setFrame:rectHeadImage];
	}
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.textAlignment = UITextAlignmentLeft;
    }

	NSInteger row = [indexPath row];
	switch (row)
	{
		case 0:
		{
			cell.textLabel.text = NSLocalizedString(@"Author", @"the developer");
			cell.detailTextLabel.text = @"Flying";
			break;
		}
		case 1:
		{
			cell.textLabel.text = NSLocalizedString(@"Version", @"software version");
			cell.detailTextLabel.text = @"1.1.20111019";
			break;
		}
		case 2:
		{
			cell.textLabel.text = NSLocalizedString(@"HomePage", @"the HomePage Url");
			cell.detailTextLabel.text = @"www.devdiv.com";
			break;
		}
		case 3:
		{
			cell.textLabel.text = NSLocalizedString(@"E-Mail", @"the contact email");
			cell.detailTextLabel.text = @"flying@devdiv.com";
			break;
		}
			
//		case 4:
//		{
//			cell.textLabel.text = NSLocalizedString(@"BBS", @"the bbs");
//			cell.detailTextLabel.text = @"www.devdiv.com";
//			break;
//		}
	}
    
    return cell;
}

@end
