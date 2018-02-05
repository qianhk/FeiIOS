//
//  AppDelegate.m
//  singleview2
//
//  Created by hongkai.qian on 12-2-27.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#import "AppDelegate.h"

#import "MainTabBarViewController.h"
#import "AppUINavigationController.h"

@interface AppDelegate () <UINavigationControllerDelegate>
@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    BOOL useNavi = YES;

    self.viewController = [[MainTabBarViewController alloc] init];

    if (useNavi) {
        self.navController = [[AppUINavigationController alloc] init];
        self.navController.delegate = self;
        self.viewController.title = @"KaiPractice";
        [self.navController pushViewController:self.viewController animated:YES];
//        [self.navController setNavigationBarHidden:YES];
    }

    self.window.rootViewController = useNavi ? self.navController : self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSLog(@"lookNavigation willShowViewController vc=%@", NSStringFromClass(viewController.class));
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSLog(@"lookNavigation didShowViewController vc=%@", NSStringFromClass(viewController.class));
//    [self.navController setNavigationBarHidden:viewController == self.viewController];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//    NSLog(@"lookNavigation interactionControllerForAnimationController vc=%@", NSStringFromClass(animationController.class));
//    return nil;
//}

//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC {
//    NSLog(@"lookNavigation animationControllerForOperation operation=%ld fromVC=%@, toVc=%@", (long)operation, NSStringFromClass(fromVC.class), NSStringFromClass(toVC.class));
//    return nil;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
