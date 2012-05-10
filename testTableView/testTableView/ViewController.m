//
//  ViewController.m
//  testTableView
//
//  Created by 红凯 钱 on 12-4-27.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[_tv release];
	[_arrText release];
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_tv = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
	[_tv setDelegate:self];
	[_tv setDataSource:self];
	_arrText = [[NSArray alloc] initWithObjects:@"国外媒体今天发表署名为Jessica E. Vascellaro的文章称，对于苹果来说，中国已经不再是无足轻重的市场，而是已经变成了其“中央王国”。", @"凯凯Test", @"我设置了mageview的大小，然后把。", @"就在不久以前，亚太市场在科技巨子苹果的财务报告中还只不过是个脚注。但现在已不再如此。", nil];
	[self.view addSubview:_tv];
	for (NSString* str in _arrText)
	{
		NSLog(@"haha: %@", str);
	}
	
	[_tv reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* singleStr = @"哈哈Test";
	CGFloat singleHeight = [singleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:UILineBreakModeCharacterWrap].height; 
	CGFloat needHeight = [[_arrText objectAtIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(243, 1000) lineBreakMode:UILineBreakModeCharacterWrap].height;
	CGFloat detaHeight = needHeight - singleHeight;
	CGFloat height = 70.0f;
	if (detaHeight > 0.2 )
	{
		height += detaHeight;
	}
	return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_arrText count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* cellIdentify = @"TestCell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
		cell.textLabel.font = [UIFont systemFontOfSize:16];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
		UIImage* image = [UIImage imageNamed:@"Bob_ICON.png"];
//		cell.imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
		[cell.imageView setImage:image];
		cell.detailTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		cell.detailTextLabel.numberOfLines = 0;
	}
	cell.textLabel.text = [NSString stringWithFormat:@"Row haha %d", indexPath.row];
	cell.detailTextLabel.text = [_arrText objectAtIndex:indexPath.row];
	return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
