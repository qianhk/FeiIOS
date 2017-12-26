//
// Created by kai on 2017/12/26.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <YYText/YYTextView.h>
#import "YYTextTestViewController.h"
#import "YYTextParserObject.h"

@interface YYTextTestViewController ()

@property (nonatomic, strong) YYTextView *yyText;

@end

@implementation YYTextTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.view.frame;
    self.yyText = [[YYTextView alloc] initWithFrame:CGRectMake(20, 100, rect.size.width, 100)];
    [self.view addSubview:self.yyText];

    self.yyText.textParser = [YYTextParserObject new];

    self.yyText.text = @"#试试# abc 单独#";

}




@end
