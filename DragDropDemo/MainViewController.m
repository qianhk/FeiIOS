//
//  MainViewController.m
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "EmoticonViewController.h"

extern NSString *kNotificationSelectEmoticon;
extern NSString *kNotificationCancelEmoticon;
extern NSString *kEmoticonID;
extern NSString *kSelectEmoticonByDragDrop;

@implementation MainViewController
@synthesize showImage;
@synthesize emoticonViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSelectEmoticon:) name:kNotificationSelectEmoticon object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onCancelEmoticon:) name:kNotificationCancelEmoticon object:nil];
}

- (void)viewDidUnload
{
    [self setShowImage:nil];
    [self setEmoticonViewController:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)onEmoticonButtonPressed:(id)sender 
{
    self.emoticonViewController = nil;
    emoticonViewController = [[EmoticonViewController alloc]initWithNibName:@"EmoticonViewController" bundle:nil];
    [self.view addSubview:emoticonViewController.view];
}

- (void)onSelectEmoticon: (NSNotification *)aNotification
{
    NSDictionary *data = aNotification.userInfo;
    NSNumber *index = [data objectForKey:kEmoticonID];
    NSString *filename = [[[NSString alloc]initWithFormat:@"%d.png",[index intValue]]autorelease];
    showImage.image = [UIImage imageNamed:filename];
}
- (void)onCancelEmoticon: (NSNotification *)aNotification
{
    [emoticonViewController.view removeFromSuperview];
    self.emoticonViewController = nil;
}


- (void)dealloc 
{
    [showImage release];
    [emoticonViewController release];
    [super dealloc];
}
@end
