//
//  ViewController.h
//  ipaPng2Png
//
//  Created by 红凯 钱 on 12-3-11.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
	NSString* ipaPngDir;
	NSString* normalPngDir;
}
@property (retain, nonatomic) IBOutlet UISlider *_slider;

- (IBAction)btnConvertIpaPng2Png:(id)sender;
@end
