//
//  FontEditTextController.m
//  FontLooker
//
//  Created by HJC on 11-5-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontEditTextController.h"

#define kTextViewTag    1000

@implementation FontEditTextController


- (UITextView*) textView
{
    return (UITextView*)[self.view viewWithTag:kTextViewTag];
}


- (void) loadView
{
    UIView* aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = aView;
    aView.backgroundColor = [UIColor whiteColor];
    [aView release];
    
    UITextView* aTextView = [[[UITextView alloc] initWithFrame:aView.bounds] autorelease];
    aTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    aTextView.tag = kTextViewTag;
    [aView addSubview:aTextView];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Edit Text", @"");
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardDidShow:) 
												 name:UIKeyboardDidShowNotification 
											   object:nil];
    [self.textView becomeFirstResponder];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardDidShowNotification 
                                                  object:nil];
}



- (void) keyboardDidShow:(NSNotification *)aNotification 
{
    NSDictionary* info = [aNotification userInfo];
	
	NSValue* keyboardValue = (NSValue*)[info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect = [keyboardValue CGRectValue];
    CGFloat keyboardHeight = MIN(keyboardRect.size.height, keyboardRect.size.width);
    
    CGRect rect = self.view.bounds;
    rect.size.height -= keyboardHeight;
    self.textView.frame = rect;
}


@end
