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

@implementation KaiNATForOpenVPN
@synthesize segCtlVpn;
@synthesize segCtlNat;
@synthesize popupBtnNetworkInterface;

- (NSArray *)getNetInterface {
    
    struct ifaddrs* interfaces = NULL;
    struct ifaddrs* temp_addr = NULL;
    // retrieve the current interfaces - returns 0 on success
    NSInteger success = getifaddrs(&interfaces);
    NSMutableArray* muArray = [NSMutableArray array];
//    NSMutableSet* muSet = [NSMutableSet set];
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            //            if (temp_addr->ifa_addr->sa_family == AF_INET) // internetwork only
            {
                NSString* name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString* address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                NSLog(@"interface name: %s; address: %@ %d", temp_addr->ifa_name, address, temp_addr->ifa_addr->sa_family);
                
                if ([muArray indexOfObject:name] == NSNotFound) {
                    [muArray addObject:name];
                }
//                [muSet addObject:name];
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
//    for (NSUInteger idx = 0; idx < muArray.count; ++idx) {
//        NSLog(@"i name in Array: %@", [muArray objectAtIndex:idx]);
//    }
//    
//    [muSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, BOOL *stop) {
//        NSLog(@"i name in Set: %@", obj);
//    }];
    return muArray;
}


- (void)mainViewDidLoad
{
    NSArray* arrNetInterface = [self getNetInterface];
    NSLog(@"kaiNatForOpenVpn get %ld network interface", [arrNetInterface count]);
    [popupBtnNetworkInterface removeAllItems];
    [popupBtnNetworkInterface addItemsWithTitles:arrNetInterface];
    
    segCtlVpn.selectedSegment = 0;
    segCtlNat.selectedSegment = 0;
    
    [self configViewState];
}

- (void)configViewState {
    [segCtlNat setEnabled:segCtlVpn.selectedSegment == 1];
    [popupBtnNetworkInterface setEnabled:segCtlNat.selectedSegment != 1];
}

- (IBAction)clickSegmentedControl:(id)sender {
    if (sender == segCtlVpn) {
        if (segCtlVpn.selectedSegment == 0) {
            segCtlNat.selectedSegment = 0;
        }
    } else if (sender == segCtlNat){
        
    }
    [self configViewState];
}
@end
