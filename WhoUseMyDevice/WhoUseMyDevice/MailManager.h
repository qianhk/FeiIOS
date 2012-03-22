//
//  MailManager.h
//  WhoUseMyDevice
//
//  Created by kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>

#import "SKPSMTPMessage.h"

@interface MailManager : NSObject<SKPSMTPMessageDelegate>
{
	
}

- (void)sendMailByAwayFailedTimes:(NSInteger)failedTimes location:(NSString *)location photo:(UIImage *)photo;

@end
