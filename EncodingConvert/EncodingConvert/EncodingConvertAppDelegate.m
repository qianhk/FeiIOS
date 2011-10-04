//
//  EncodingConvertAppDelegate.m
//  EncodingConvert
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "EncodingConvertAppDelegate.h"
#import "EncodingConvert.h"

@implementation EncodingConvertAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	[txtChinese setDelegate:self];
	[txtUnicode setDelegate:self];
	[txtUTF8 setDelegate:self];
	[txtGBK setDelegate:self];
	[txtBase64 setDelegate:self];
	
	_encodingConvert = [[EncodingConvert alloc] init];
}

- (void)applicationDidHide:(NSNotification *)notification
{
	NSLog(@"applicationDidHide:%@", notification);
}

- (void)dealloc
{
	[_encodingConvert release];
	
	[super dealloc];
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
		NSString* textValue = [textField stringValue];
		NSString* unicodeValue = textValue;
		NSLog(@"text changed = %@", textValue);
		
		switch (textField.tag)
		{
			case 660:
				[txtUnicode setStringValue:[EncodingConvert convertChineseToUnicode:textValue]];
				[txtUTF8 setStringValue:[EncodingConvert convertUnicodeToUTF8:unicodeValue]];
				[txtGBK setStringValue:[EncodingConvert convertUnicodeToGBK:unicodeValue]];
				break;
				
			case 661:
				{
					unicodeValue = [EncodingConvert convertUnicodeToChinese:textValue];
					[txtChinese setStringValue:unicodeValue];
				}
				break;
				
			case 662:
				break;
				
			case 663:
				break;
				
			case 664:
				break;
				
			default:
				break;
		}

	}
}

//- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
//{
//	NSLog(@"control:(NSControl *) textShouldEndEditing:(NSText *);");
//}

@end
