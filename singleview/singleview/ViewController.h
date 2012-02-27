//
//  ViewController.h
//  singleview
//
//  Created by hongkai.qian on 12-2-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KaiStatusBar.h"

@interface ViewController : UIViewController
{
	KaiStatusBar* _statusBar;
}

- (IBAction)tttClicked:(id)sender;
- (IBAction)wifi_off:(id)sender;
- (IBAction)wifi_on:(id)sender;
- (IBAction)nsnumberused:(id)sender;
- (IBAction)btnPortClicked:(id)sender;

@end
