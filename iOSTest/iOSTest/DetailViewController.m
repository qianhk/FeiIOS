//
//  DetailViewController.m
//  iOSTest
//
//  Created by 钱红凯 on 17/2/6.
//  Copyright © 2017年 凯. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController () <UIPopoverControllerDelegate> {
    int mIndex;
}

@property(weak, nonatomic) IBOutlet UITextField *mEditText;

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
        [self popupAlert:sender];
    } else {
        [self setDetailItem:[NSString stringWithFormat:@"click_%d", mIndex += tag]];
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.mEditText resignFirstResponder];
}

- (void)popupAlert:(UIControl *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"message" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes, sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self setDetailItem:@"click yes button"];
    }];

    UIAlertAction *yes2Action = [UIAlertAction actionWithTitle:@"Yes2, sure2" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
        [self setDetailItem:@"click yes2 button"];
    }];

    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
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
    self.detailDescriptionLabel.text = [NSString stringWithFormat:@"item=%@ language=%@", _detailItem, _language];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];

    self.mEditText.text = @"init Value";

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //Terminating app due to uncaught exception 'NSInvalidArgumentException',
        // reason: '-[UIPopoverController initWithContentViewController:] called when not running under UIUserInterfaceIdiomPad.'
        self.languageButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language" style:UIBarButtonItemStylePlain target:self action:@selector(toggleLanguagePopover)];
        self.navigationItem.rightBarButtonItem = self.languageButton;
    }
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

- (void)setLanguage:(NSString *)language {
    _language = [language mutableCopy];
    [self configureView];
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
}

- (void)toggleLanguagePopover {
    if (self.popoverController) {
        [_popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    } else {
        LanguageListController *languageListController = [LanguageListController new];
        languageListController.detailViewController = self;
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:languageListController];
        _popoverController.delegate = self;
        [_popoverController presentPopoverFromBarButtonItem:self.languageButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

//- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
//    return NO;
//}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == _popoverController) {
        self.popoverController = nil;
    }
}

//- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(CGRect *)rect inView:(UIView **)view {
//
//}


@end
