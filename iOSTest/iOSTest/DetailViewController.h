//
//  DetailViewController.h
//  iOSTest
//
//  Created by 钱红凯 on 17/2/6.
//  Copyright © 2017年 凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong) UIBarButtonItem *languageButton;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, copy) NSString *language;

@end

