//
//  KaiNATForOpenVPN.h
//  KaiNATForOpenVPN
//
//  Created by qianhk on 13-1-3.
//  Copyright (c) 2013年 Njnu. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface KaiNATForOpenVPN : NSPreferencePane {
    NSSegmentedControl *segCtlVpn;
    NSSegmentedControl *segCtlNat;
    NSPopUpButton *popupBtnNetworkInterface;
}


- (void)mainViewDidLoad;
@property (assign) IBOutlet NSSegmentedControl *segCtlVpn;
@property (assign) IBOutlet NSSegmentedControl *segCtlNat;
@property (assign) IBOutlet NSPopUpButton *popupBtnNetworkInterface;

- (IBAction)clickSegmentedControl:(id)sender;
@end
