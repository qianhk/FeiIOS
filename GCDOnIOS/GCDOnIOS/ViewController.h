//
//  ViewController.h
//  GCDOnIOS
//
//  Created by kai on 12-3-10.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UISlider *_slider;
- (IBAction)btn_GcdSourceTypeDataAddBegin:(id)sender;
- (IBAction)btn_SourceSetTimer:(id)sender;

@end
