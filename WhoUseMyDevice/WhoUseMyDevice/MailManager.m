//
//  MailManager.m
//  WhoUseMyDevice
//
//  Created by Kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "MailManager.h"
#import "NSData+Base64Additions.h"

@implementation MailManager

- (SKPSMTPMessage *)createMailHeader
{    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = @"xxx@d.com";
    testMsg.toEmail = @"xxx@vip.qq.com";
    testMsg.relayHost = @"smtp.gmail.com";
    testMsg.requiresAuth = YES;
    testMsg.login = @"xxxxd.com";
    testMsg.pass = @"asdfasdf";
    testMsg.wantsSecure = YES;
	testMsg.validateSSLChain = YES;
    testMsg.delegate = self;
	
	return testMsg;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    
    NSLog(@"qhk WhoUseMyDevice: Mail message sent.");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    [message release];
    
    NSLog(@"qhk WhoUseMyDevice: Mail message failed <error(%d): %@>", [error code], [error localizedDescription]);
}

- (void)sendMailByAwayFailedTimes:(NSInteger)failedTimes location:(NSString *)location photo:(UIImage *)photo
{
	SKPSMTPMessage* message = [self createMailHeader];
	message.subject = [NSString stringWithFormat:@"Who use my device: Away failed %d Times", failedTimes];
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, location,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
	
	NSData* picData = UIImagePNGRepresentation(photo);
	NSDictionary* plainPart2 = [NSDictionary dictionaryWithObjectsAndKeys:@"image/png",kSKPSMTPPartContentTypeKey,
								[picData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey, @"attachment;\r\n\tfilename=\"PersonUseMyDevice.png\"", kSKPSMTPPartContentDispositionKey,nil];
	
	message.parts = [NSArray arrayWithObjects:plainPart, plainPart2,nil];

	[message send];
}

@end
