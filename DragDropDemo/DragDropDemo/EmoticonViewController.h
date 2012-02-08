//
//  EmoticonViewController.h
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmoticonViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)initUIComponent;

- (IBAction)onBackgroundPressed:(id)sender;

@end
