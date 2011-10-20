//
//  TasksController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <sys/sysctl.h>
#import <mach/mach_host.h>

#import "TaskViewController.h"

@interface TaskViewController()

- (void)printProcessInfo;

@end

@implementation TaskViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
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

- (void)printProcessInfo
{
	int mib[5];
	struct kinfo_proc *procs = NULL, *newprocs;
	int i, st, nprocs;
	size_t miblen, size;
	
	/* Set up sysctl MIB */
	mib[0] = CTL_KERN;
	mib[1] = KERN_PROC;
	mib[2] = KERN_PROC_ALL;
	mib[3] = 0;
	miblen = 4;
	
	/* Get initial sizing */
	st = sysctl(mib, miblen, NULL, &size, NULL, 0);
	
	/* Repeat until we get them all ... */
	do
	{
		/* Room to grow */
		size += size / 10;
		newprocs = (struct kinfo_proc *)realloc(procs, size);
		if (!newprocs)
		{
			if (procs)
			{
				free(procs);
			}
			[_arrKey addObject:@"error"];
			[_dic setObject:@"Error: realloc failed." forKey:@"error"];
			return;
		}
		procs = newprocs;
		st = sysctl(mib, miblen, procs, &size, NULL, 0);
	}
	while (st == -1 && errno == ENOMEM);
	
	if (st != 0)
	{
		[_arrKey addObject:@"error"];
		[_dic setObject:@"Error: sysctl(KERN_PROC) failed." forKey:@"error"];
		return;
	}
	
	/* Do we match the kernel? */
	assert(size % sizeof(struct kinfo_proc) == 0);
	
	nprocs = size / sizeof(struct kinfo_proc);
	
	if (nprocs == 0)
	{
		[_arrKey addObject:@"error"];
		[_dic setObject:@"Error: printProcessInfo." forKey:@"error"];
		return;
	}
	
	for (i = nprocs - 1; i >= 0; --i)
	{
		const struct kinfo_proc &procInfo = procs[i];
//		printf("%5d\t%s\n",(int)procInfo.kp_proc.p_pid, procInfo.kp_proc.p_comm);
		NSMutableString* title = [NSMutableString stringWithFormat:@"%4d      ", procInfo.kp_proc.p_pid];
		NSString* tmpTitle = [NSString stringWithCString:procInfo.kp_proc.p_comm encoding:NSASCIIStringEncoding];
		[title appendString:tmpTitle];
		NSNumber* number = [NSNumber numberWithInt:procInfo.kp_proc.p_pid];
		[_arrKey addObject:number];
		[_dic setObject:title forKey:number];
	}
	free(procs);
	[_arrKey sortUsingSelector:@selector(compare:)];
	return;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	// Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[self printProcessInfo];
	[self.tableView reloadData];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(timerCome) userInfo:nil repeats:YES];
}

- (void)timerCome
{
	[_arrKey removeAllObjects];
	[_dic removeAllObjects];
	[self printProcessInfo];
	[self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[_timer invalidate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 0;
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
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//		[self configCell:cell];
		cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
//	NSLocale* locale = [NSLocale currentLocale];
//	NSString* disS = [locale displayNameForKey:NSLocaleIdentifier value:[locale localeIdentifier]];
//    cell.textLabel.text = disS;
	NSNumber* key = [_arrKey objectAtIndex:[indexPath row]];
	cell.textLabel.text = [_dic objectForKey:key];
	cell.imageView.image = [UIImage imageNamed:@"process.png"];
	
//	UILabel *label = (UILabel *)[cell viewWithTag:6666];
//	label.text = [NSString stringWithFormat:@"%d", [indexPath row] + 1];
	
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//	return [NSString stringWithFormat:NSLocalizedString(@"%d Process", @""), [_arrKey count]];
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UILabel* footerView = [[[UILabel alloc] init] autorelease];
    footerView.textAlignment = UITextAlignmentCenter;
    footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
//	footerView.shadowColor = [UIColor colorWithWhite:0.8 alpha:0.8];
	footerView.textColor = [UIColor whiteColor];
    footerView.lineBreakMode = UILineBreakModeWordWrap;
    footerView.font = [UIFont boldSystemFontOfSize:18.0f];
    footerView.numberOfLines = 1;
    [footerView setText:[NSString stringWithFormat:NSLocalizedString(@"%d Process", @""), [_arrKey count]]];

	return footerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
