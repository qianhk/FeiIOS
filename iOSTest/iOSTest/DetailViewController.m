//
//  DetailViewController.m
//  iOSTest
//
//  Created by 钱红凯 on 17/2/6.
//  Copyright © 2017年 凯. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    int mIndex;
}

@property (weak, nonatomic) IBOutlet UITextField *mEditText;

@end

@implementation DetailViewController

- (IBAction)editTextPrimaryActionTrigger:(UITextField *)sender {
     [self setDetailItem:@"editTextPrimaryActionTrigger"];
}

- (IBAction)editTextDidEnd:(UITextField *)sender {
    [self setDetailItem:@"editTextDidEnd"];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag == 3) {
        [self popupAlert];
    } else {
        [self setDetailItem: [NSString stringWithFormat:@"click_%d", mIndex+=tag]];
    }
}

- (void)popupAlert {
    
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    _mEditText.text = @"init Value";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSString *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
