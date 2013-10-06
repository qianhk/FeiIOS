//
//  RootViewController.m
//  singleViewDemo
//
//  Created by qianhk on 13-10-5.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

@interface RootViewController ()

//- (void)performAdd:(id)sender;

@end

@implementation RootViewController

- (void)addTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 200, 150)];
    UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    currencyLabel.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    currencyLabel.font = textField.font;
    [currencyLabel sizeToFit];
    textField.leftView = currencyLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)performAdd:(id)sender
{
    NSLog(@"Action method add got called");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"First Controller";
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(performAdd:)];
    self.navigationItem.rightBarButtonItem = barBtnItem;
    
    [self addTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushSecondController
{
    SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:secondViewController animated:YES];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(pushSecondController) withObject:nil afterDelay:3.0f];
}



@end
