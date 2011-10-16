//
//  EncodingConvertAppDelegate.h
//  EncodingConvert
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EncodingConvertAppDelegate : NSObject
<NSApplicationDelegate, NSTextFieldDelegate>
{
	NSWindow *window;
	
	IBOutlet NSTextField *txtChinese;
	IBOutlet NSTextField *txtUnicode;
	IBOutlet NSTextField *txtUTF8;
	IBOutlet NSTextField *txtGBK;
	IBOutlet NSTextField *txtBase64;
	
	IBOutlet NSTextField *txtMD5;
	IBOutlet NSTextField *txtCRC;
	IBOutlet NSTextField *txtSHA1;
	
	IBOutlet NSTextField *labelPrompt;
	
}

@property (nonatomic, retain) NSTextField *labelPrompt;

@property (assign) IBOutlet NSWindow *window;

@end
