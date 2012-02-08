//
//  MainViewController.h
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmoticonViewController;

@interface MainViewController : UIViewController
{
    EmoticonViewController      *emoticonViewController;
}

@property (retain, nonatomic) IBOutlet UIImageView *showImage;
@property (retain, nonatomic) EmoticonViewController *emoticonViewController;

- (IBAction)onEmoticonButtonPressed:(id)sender;
- (void)onSelectEmoticon: (NSNotification *)aNotification;
- (void)onCancelEmoticon: (NSNotification *)aNotification;


@end
