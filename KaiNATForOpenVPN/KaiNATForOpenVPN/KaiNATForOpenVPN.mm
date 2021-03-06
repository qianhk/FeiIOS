//
//  KaiNATForOpenVPN.m
//  KaiNATForOpenVPN
//
//  Created by qianhk on 13-1-3.
//  Copyright (c) 2013年 Njnu. All rights reserved.
//

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <ifaddrs.h>

#import "KaiNATForOpenVPN.h"
#import "SysUtils.h"

@implementation KaiNATForOpenVPN
@synthesize segCtlVpn;
@synthesize segCtlNat;
@synthesize popupBtnNetworkInterface;

- (void)mainViewDidLoad
{
    NSArray* arrNetInterface = getNetInterface();
    NSLog(@"kaiNatForOpenVpn get %ld network interface", [arrNetInterface count]);
    [popupBtnNetworkInterface removeAllItems];
    [popupBtnNetworkInterface addItemsWithTitles:arrNetInterface];
    
    segCtlVpn.selectedSegment = 0;
    segCtlNat.selectedSegment = 0;

//    if (hasProcess("natd")) {
    NSString *expetedProcess = getProcessExpeted();
    if (expetedProcess != nil) {
        segCtlVpn.selectedSegment = 1;
        segCtlNat.selectedSegment = 1;
        [popupBtnNetworkInterface selectItemWithTitle:expetedProcess];
    }
    
    [self configViewState];
}

- (void)configViewState {
    [segCtlNat setEnabled:segCtlVpn.selectedSegment == 1];
    [popupBtnNetworkInterface setEnabled:segCtlNat.selectedSegment != 1];
}

- (IBAction)clickSegmentedControl:(id)sender {
    if (sender == segCtlVpn) {
        if (segCtlVpn.selectedSegment == 0) {
            //vpn off
            if (segCtlNat.selectedSegment == 1) {
                segCtlNat.selectedSegment = 0;
                if (!launchKaiNatBash(KaiNatActionTypeStop, @"qhk_none")) {
                    segCtlVpn.selectedSegment = 1;
                    segCtlNat.selectedSegment = 1;
                }
            }
        } else {
            //vpn On
        }
    } else if (sender == segCtlNat){
        if (segCtlNat.selectedSegment == 0) {
            //nat off
            if (!launchKaiNatBash(KaiNatActionTypeStop, @"qhk_none")) {
                segCtlNat.selectedSegment = 1;
            }
        } else {
            //nat on
            if (!launchKaiNatBash(KaiNatActionTypeStart, [popupBtnNetworkInterface titleOfSelectedItem])) {
                segCtlNat.selectedSegment = 0;
            }
        }
    }
    [self configViewState];
}
@end
