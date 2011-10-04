//
//  EncodingConvertAppDelegate.m
//  EncodingConvert
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "EncodingConvertAppDelegate.h"
#import "EncodingConvert.h"

@interface EncodingConvertAppDelegate()

- (void)dealTextChangeEvent:(NSTextField*)textField;

@end

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
}

- (void)applicationDidHide:(NSNotification *)notification
{
	NSLog(@"applicationDidHide:%@", notification);
}

- (void)dealloc
{	
	[super dealloc];
}

//- (void)textDidChange:(NSNotification *)notification
//{
//	NSLog(@"textDidChange:");
//}

- (void)dealTextChangeEvent:(NSTextField *)textField
{
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
			[txtUTF8 setStringValue:[EncodingConvert convertUnicodeToUTF8:unicodeValue]];
			[txtGBK setStringValue:[EncodingConvert convertUnicodeToGBK:unicodeValue]];
		}
			break;
			
		case 662:
		{
			unicodeValue = [EncodingConvert convertUTF8ToUnicode:textValue];
			[txtChinese setStringValue:unicodeValue];
			[txtUnicode setStringValue:[EncodingConvert convertChineseToUnicode:unicodeValue]];
			[txtGBK setStringValue:[EncodingConvert convertUnicodeToGBK:unicodeValue]];
		}
			break;
			
		case 663:
		{
			unicodeValue = [EncodingConvert convertGBKToUnicode:textValue];
			[txtChinese setStringValue:unicodeValue];
			[txtUnicode setStringValue:[EncodingConvert convertChineseToUnicode:unicodeValue]];
			[txtUTF8 setStringValue:[EncodingConvert convertUnicodeToUTF8:unicodeValue]];
		}
			break;
			
		case 664:
			break;
			
		default:
			break;
	}
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
	if ([aNotification.object isKindOfClass:[NSTextField class]])
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		NSTextField* textField = (NSTextField *)aNotification.object;
		[self performSelector:@selector(dealTextChangeEvent:) withObject:textField afterDelay:0];
	}
}

//- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
//{
//	NSLog(@"control:(NSControl *) textShouldEndEditing:(NSText *);");
//}

@end
