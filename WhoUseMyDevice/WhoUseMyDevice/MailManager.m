//
//  MailManager.m
//  WhoUseMyDevice
//
//  Created by Kai on 12-3-21.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "MailManager.h"

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
//    testMsg.subject = @"Title:haha no interface mail";
    testMsg.wantsSecure = YES;
	testMsg.validateSSLChain = YES;
    testMsg.delegate = self;
    
//    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, @"This is a 测试消息.",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
//    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
//    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
//    
//    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
//                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
//	
//	UIImage* pngImage = [UIImage imageNamed:@"grass.png"];
//	NSData* picData = UIImagePNGRepresentation(pngImage);
//	NSDictionary* plainPart2 = [NSDictionary dictionaryWithObjectsAndKeys:@"image/png",kSKPSMTPPartContentTypeKey,
//								[picData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey, @"attachment;\r\n\tfilename=\"grass.png\"", kSKPSMTPPartContentDispositionKey,nil];
//	
//	UIImage* pngImage2 = [UIImage imageNamed:@"2.jpg"];
//	NSData* picData2 = UIImagePNGRepresentation(pngImage2);
//	NSDictionary* plainPart3 = [NSDictionary dictionaryWithObjectsAndKeys:@"image/png",kSKPSMTPPartContentTypeKey,
//								[picData2 encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey, @"attachment;\r\n\tfilename=\"meinv.png\"", kSKPSMTPPartContentDispositionKey,nil];
    
//    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
//    
//    [testMsg send];
	
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
	
//	[self release];
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    [message release];
    
    NSLog(@"qhk WhoUseMyDevice: Mail message failed <error(%d): %@>", [error code], [error localizedDescription]);
	
//	[self release];
}

- (void)sendMailByAwayFailedTimes:(NSInteger)failedTimes location:(NSString *)location photo:(UIImage *)photo
{
	SKPSMTPMessage* message = [self createMailHeader];
	message.subject = [NSString stringWithFormat:@"Who use my device: Away failed %d Times", failedTimes];
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, location,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
	message.parts = [NSArray arrayWithObjects:plainPart,nil];
//	[self retain];
	[message send];
}

@end
