//
//  UIWebViewDemoViewController.h
//  UIWebViewDemo
//
//  Created by skylin zhu on 11-7-28.
//  Copyright 2011年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewDemoViewController :UIViewController<UIWebViewDelegate> {    
    IBOutlet UIWebView *webView;
    IBOutlet UITextField *textField;
    UIActivityIndicatorView *activityIndicatorView;
    
}
- (IBAction)buttonPress:(id) sender;
- (void)loadWebPageWithString:(NSString*)urlString;
@end
