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
	IBOutlet UILabel *lbltext;
}

- (IBAction)tttClicked:(id)sender;
- (IBAction)wifi_off:(id)sender;
- (IBAction)wifi_on:(id)sender;
- (IBAction)nsnumberused:(id)sender;
- (IBAction)btnPortClicked:(id)sender;
- (IBAction)btnNSCoderClicked:(id)sender;
- (IBAction)btnDeletePod:(id)sender;
- (IBAction)btnInfoBClicked:(id)sender;

@end
