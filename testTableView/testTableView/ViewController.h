//
//  ViewController.h
//  testTableView
//
//  Created by 红凯 钱 on 12-4-27.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
	UITableView* _tv;
	NSArray* _arrText;
}

@end
