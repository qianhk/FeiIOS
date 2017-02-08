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
//     [self setDetailItem:@"editTextPrimaryActionTrigger"];
}

- (IBAction)editTextDidEnd:(UITextField *)sender {
    [self setDetailItem:@"editTextDidEnd"];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag == 3) {
        [self popupAlert: sender];
    } else {
        [self setDetailItem: [NSString stringWithFormat:@"click_%d", mIndex+=tag]];
    }
}

- (void)popupAlert: (UIControl *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes, sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setDetailItem:@"click yes button"];
    }];
    
    UIAlertAction *yes2Action = [UIAlertAction actionWithTitle:@"Yes2, sure2" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self setDetailItem:@"click yes2 button"];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self setDetailItem:@"click no button"];
    }];
    [controller addAction:yesAction];
    [controller addAction:yes2Action];
    [controller addAction:noAction];
    
    UIPopoverPresentationController *ppc = controller.popoverPresentationController;
    if (ppc != nil) {
        ppc.sourceView = sender;
        ppc.sourceRect = sender.bounds;
    }
    [self presentViewController:controller animated:YES completion:^{
         [self setDetailItem:@"presentViewController"];
    }];
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
