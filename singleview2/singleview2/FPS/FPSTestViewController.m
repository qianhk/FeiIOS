//
// Created by kai on 2019-07-08.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import "FPSTestViewController.h"

@interface FPSTestViewController ()


@end

@implementation FPSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __kindof UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"Frida4"];
    cell.textLabel.numberOfLines = 0;
    
//    cell.textLabel.text = [self calculateRandomText];
//    cell.textLabel.backgroundColor = [UIColor orangeColor];
//    cell.textLabel.opaque = YES;
//    cell.layer.shouldRasterize = YES;
//    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    NSShadow *shadow = [NSShadow new];
    shadow.shadowBlurRadius = 8;
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowOffset = CGSizeMake(3, 3);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10], NSShadowAttributeName: shadow};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:[self calculateRandomText] attributes:attributes];
    cell.textLabel.attributedText = attrStr;
    return cell;
}

- (NSString *)calculateRandomText {
    NSMutableString *str = [NSMutableString new];
    static NSString *globalText = @"这些高亮图层的选项同样在iOS模拟器的调试菜单也可用（图12.5）。我们之前说过用模拟器测试性能并不好，但如果你能通过这些高亮选项识别出性能问题出在什么地方的话，那么使用iOS模拟器来验证问题是否解决也是比真机测试更有效的。";
    int maxLen = globalText.length;
    for (int idx = 0; idx < 100; ++idx) {
        [str appendString:[globalText substringWithRange:NSMakeRange(arc4random_uniform(maxLen), 1)]];
    }
    return str;
}

@end
