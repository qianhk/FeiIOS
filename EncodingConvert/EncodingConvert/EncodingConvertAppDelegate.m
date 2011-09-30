//
//  EncodingConvertAppDelegate.m
//  EncodingConvert
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "EncodingConvertAppDelegate.h"

@implementation EncodingConvertAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	[txtChinese setDelegate:self];
}

//- (void)textDidChange:(NSNotification *)notification
//{
//	NSLog(@"textDidChange:");
//}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
	if ([aNotification.object isKindOfClass:[NSTextField class]])
	{
		NSTextField* textField = (NSTextField *)aNotification.object;
		NSLog(@"text = %@", [textField stringValue]);
	}
}

//- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
//{
//	NSLog(@"control:(NSControl *) textShouldEndEditing:(NSText *);");
//}

@end
