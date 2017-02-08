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

@end

@implementation DetailViewController

- (IBAction)buttonPressed:(UIButton *)sender {
    [self setDetailItem: [NSString stringWithFormat:@"click_%d", mIndex++]];
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
