//
// Created by kai on 2018/1/18.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import <Masonry/MASConstraintMaker.h>
#import "SubscribeViewController.h"
#import "SubscribeViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/View+MASAdditions.h>

@interface SubscribeViewController ()

@property(nonatomic, strong) SubscribeViewModel *viewModel;

@property(nonatomic, strong) UITextField *emailTextField;
@property(nonatomic, strong) UIButton *subscribeButton;
@property(nonatomic, strong) UILabel *statusLabel;

@property(nonatomic, strong) UIButton *removeButton;
@property(nonatomic, strong) UIButton *calcButton;

@end

@implementation SubscribeViewController {

}

#pragma mark - Life cycle methods

- (id)init {
    self = [super init];
    if (self) {
        self.viewModel = [SubscribeViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Subscribe Example", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addViews];
    [self defineLayout];
    [self bindWithViewModel];
}

#pragma mark -

- (void)addViews {
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.subscribeButton];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.removeButton];
    [self.view addSubview:self.calcButton];
}

- (void)defineLayout {
    @weakify(self);

    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).with.offset(100.f);
        make.left.equalTo(self.view).with.offset(20.f);
        make.height.equalTo(@50.f);
    }];

    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.emailTextField);
        make.right.equalTo(self.view).with.offset(-25.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
        make.left.equalTo(self.emailTextField.mas_right).with.offset(20.f);
    }];

    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(20.f);
        make.left.equalTo(self.emailTextField);
        make.right.equalTo(self.subscribeButton);
        make.height.equalTo(@30.f);
    }];

    [_removeButton sizeToFit];
    [_calcButton sizeToFit];
    _removeButton.frame = CGRectMake(20, 200, _removeButton.frame.size.width, _removeButton.frame.size.height);
    _calcButton.frame = CGRectMake(CGRectGetMaxX(_removeButton.frame) + 20, 200, _calcButton.frame.size.width, _calcButton.frame.size.height);
}

- (void)bindWithViewModel {
    RAC(self.viewModel, email) = self.emailTextField.rac_textSignal;
    RAC(self.statusLabel, text) = RACObserve(self.viewModel, statusMessage);
    self.emailTextField.text = @"a@b.cn";
    self.viewModel.email = self.emailTextField.text;
    self.subscribeButton.rac_command = self.viewModel.subscribeCommand;
}

- (void)onClickRemoveBtn:(id)sender {
    [self.subscribeButton removeFromSuperview];
    [self.subscribeButton removeFromSuperview];
    UIView *view = nil;
    [view removeFromSuperview];
}

- (void)onClickCalcBtn:(id)sender {
    NSDictionary *attributes = @{
                                 NSFontAttributeName: self.statusLabel.font,
                                 NSKernAttributeName: @(12)
                                 };
    
    NSString * contents = @"试试abc︻︼︽︾〒↑↓☉⊙●〇◎¤★☆■▓「」『』◆◇▲△▼▽◣◥◢◣◤ ◥№↑↓→←↘↙Ψ※㊣∑⌒∩【】〖〗＠ξζω□∮〓※》∏卐√ ╳々♀♂∞①ㄨ≡╬╭╮╰╯╱╲ ▂ ▂ ▃ ▄ ▅ ▆ ▇ █ ▂▃▅▆█ ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁";
    CGSize size = [contents sizeWithAttributes:attributes];
    NSLog(@"lookSize1 %@", NSStringFromCGSize(size));
    
    attributes = @{
                                 NSFontAttributeName: self.statusLabel.font,
                                 NSKernAttributeName: @(-12)
                                 };
    
    size = [contents sizeWithAttributes:attributes];
    NSLog(@"lookSize2 %@", NSStringFromCGSize(size));
    
    attributes = @{
                   NSFontAttributeName: self.statusLabel.font,
                   NSKernAttributeName: @(0)
                   };
    
    size = [contents sizeWithAttributes:attributes];
    NSLog(@"lookSize3 %@", NSStringFromCGSize(size));
    
    UIFont *font = nil;
    @try {
    attributes = @{
                   NSFontAttributeName: font,
                   NSKernAttributeName: @(10)
                   };
    } @catch (NSException *exception) {
    } @finally {
    }
    size = [contents sizeWithAttributes:attributes];
    NSLog(@"lookSize4 %@", NSStringFromCGSize(size));
}

#pragma mark - Views

- (UITextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [UITextField new];
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.font = [UIFont boldSystemFontOfSize:16];
        _emailTextField.placeholder = NSLocalizedString(@"Email address", nil);
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _emailTextField;
}

- (UIButton *)subscribeButton {
    if (!_subscribeButton) {
        _subscribeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_subscribeButton setTitle:NSLocalizedString(@"Subscribe", nil) forState:UIControlStateNormal];
    }
    return _subscribeButton;
}

- (UIButton *)removeButton {
    if (!_removeButton) {
        _removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_removeButton setTitle:NSLocalizedString(@"RemoveBtn", nil) forState:UIControlStateNormal];
        [_removeButton addTarget:self action:@selector(onClickRemoveBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeButton;
}

- (UIButton *)calcButton{
    if (!_calcButton) {
        _calcButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_calcButton setTitle:NSLocalizedString(@"CalcBtn", nil) forState:UIControlStateNormal];
        [_calcButton addTarget:self action:@selector(onClickCalcBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calcButton;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
    }
    return _statusLabel;
}

@end
