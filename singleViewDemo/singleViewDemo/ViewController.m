//
//  ViewController.m
//  singleViewDemo
//
//  Created by qianhk on 13-10-5.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    UITextField *textField = [alertView textFieldAtIndex:0];
//    textField.keyboardType = UIKeyboardTypeNumberPad;
//    [alertView show];
	
	[self setTitle:@"First Title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    
    NSLog(@"alertView clicked Button at index %d text=%@", buttonIndex, [textField text]);
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    NSLog(@"alertViewCancel");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSLog(@"sourceController=%@, DestinationController=%@, SegueIdentifier=%@, sender=%@", [segue sourceViewController]
		  , [segue destinationViewController], [segue identifier], sender);
}

@end
