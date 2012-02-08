//
//  EmoticonViewController.m
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EmoticonViewController.h"
#import "Emoticon.h"

NSString *kNotificationCancelEmoticon  = @"cancel_emoticon";

@implementation EmoticonViewController
@synthesize scrollView;

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
    [self initUIComponent];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc 
{
    [scrollView release];
    [super dealloc];
}

- (void)initUIComponent
{
    self.view.backgroundColor = [UIColor clearColor];
    CGSize size = scrollView.bounds.size;
    
    CGFloat cellWidth   = size.width / 7;
    CGFloat cellHeight  = size.height / 2;
    NSInteger iconWidth = 128;
    NSInteger iconHeight= 128;
    CGFloat startX      = (cellWidth - iconWidth) / 2;
    CGFloat startY      = (cellHeight - iconHeight) / 2;
    
    //添加两个View到ScrollView中
    CGRect firstViewRect = CGRectMake(0, 0, size.width, size.height);
    UIView *firstView = [[UIView alloc]initWithFrame:firstViewRect];
    firstView.backgroundColor = [UIColor orangeColor];
    for (int j = 0; j < 2; j++) 
    {
        for (int i = 0; i < 7; i ++) 
        {
            int index = j * 7 + i;
            Emoticon *icon = [Emoticon getEmoticonFromIndex:index];
            icon.scrollView= scrollView;
            icon.parentView= self.view;
            
            CGFloat x = i * cellWidth + startX;
            CGFloat y = j * cellHeight+ startY;
            CGRect rect = CGRectMake(x, y, iconWidth, iconHeight);
            [icon setFrame:rect];
            
            [firstView addSubview:icon];
        }
    }
    
    CGRect secondViewRect = CGRectMake(size.width, 0, size.width, size.height);
    UIView *secondView= [[UIView alloc]initWithFrame:secondViewRect];
    secondView.backgroundColor = [UIColor orangeColor];
    for (int i = 0; i < 6; i ++) 
    {
        int index = 14 + i;
        Emoticon *icon = [Emoticon getEmoticonFromIndex:index];
        icon.scrollView= scrollView;
        icon.parentView= self.view;
            
        CGFloat x = i * cellWidth + startX;
        CGFloat y = startY;
        CGRect rect = CGRectMake(x, y, iconWidth, iconHeight);
        [icon setFrame:rect];
            
        [secondView addSubview:icon];
    }
    

    
    [scrollView addSubview:firstView];
    [scrollView addSubview:secondView];
    [firstView release];
    [secondView release];
    
    //设置ScrollView ContentSize
    scrollView.contentSize = CGSizeMake(2048, 300);

}

- (IBAction)onBackgroundPressed:(id)sender 
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationCancelEmoticon object:nil];
}
@end
