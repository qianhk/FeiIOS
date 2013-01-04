//
//  UIWebViewDemoViewController.m
//  UIWebViewDemo
//
//  Created by skylin zhu on 11-7-28.
//  Copyright 2011年 mysoft. All rights reserved.
//

#import "UIWebViewDemoViewController.h"

@implementation UIWebViewDemoViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)buttonPress:(id) sender
{
    [textField resignFirstResponder]; 
    [self loadWebPageWithString:textField.text];
    
}
- (void)loadWebPageWithString:(NSString*)urlString
{

    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    [alterview release];
}
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView.scalesPageToFit =YES;
    webView.delegate =self;
    activityIndicatorView = [[UIActivityIndicatorView alloc] 
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite] ; 
    [self.view addSubview : activityIndicatorView] ;
    [self buttonPress:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
