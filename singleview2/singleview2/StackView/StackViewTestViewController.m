//
//  StackViewTestViewController.m
//  singleview2
//
//  Created by qianhk on 2018/9/13.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "StackViewTestViewController.h"

@interface StackViewTestViewController ()

@end

@implementation StackViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:4]; //都等4，只能随机选一个进入
        NSLog(@"线程1");
        sleep(2);
        NSLog(@"线程1 end");
        [lock unlockWithCondition:5];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:4];
        NSLog(@"线程1_1");
        sleep(2);
        NSLog(@"线程1_1 end");
        [lock unlockWithCondition:6];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:0];
        NSLog(@"线程2");
        sleep(3);
        NSLog(@"线程2解锁成功");
        [lock unlockWithCondition:2];
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:2];
        NSLog(@"线程3");
        sleep(3);
        NSLog(@"线程3解锁成功");
        [lock unlockWithCondition:3];
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:3];
        NSLog(@"线程4");
        sleep(2);
        NSLog(@"线程4解锁成功");
        [lock unlockWithCondition:4];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:5];
        NSLog(@"线程5");
        sleep(2);
        NSLog(@"线程5 end");
        [lock unlockWithCondition:4];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:6];
        NSLog(@"线程6");
        sleep(2);
        NSLog(@"线程6 end");
        [lock unlockWithCondition:66];
    });

    NSLog(@"lookKai viewDidLoad end");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
