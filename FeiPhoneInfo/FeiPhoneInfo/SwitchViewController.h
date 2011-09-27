//
//  SwitchViewController.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeneralInfoController;
@class TasksController;

@interface SwitchViewController : UIViewController<UITabBarDelegate>
{
	UIView* bkgView;
	UIImageView* imgView;
	UITabBar* tabBar;
	UITabBarItem* tabBarItem0;
	UITabBarItem* tabBarItem1;
	UITabBarItem* tabBarItem2;
	UITabBarItem* tabBarItem3;
	UITabBarItem* tabBarItem4;
	UITabBarItem* tabBarItem5;
	
	GeneralInfoController* generalInfo;
	TasksController*	tasksInfo;
}

@end
