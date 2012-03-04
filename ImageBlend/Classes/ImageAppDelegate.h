//
//  ImageAppDelegate.h
//  Image
//
//  Created by Bill Dudney on 12/12/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageViewController;

@interface ImageAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ImageViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageViewController *viewController;

@end

