//
//  FontFamilyRecord.h
//  FontLooker
//
//  Created by HJC on 11-5-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FontFamilyRecord : NSObject 
{
@private
    NSString*       m_name;
    NSMutableArray* m_fontNames;
}
@property (nonatomic, readonly) NSString*   name;
@property (nonatomic, readonly) NSArray*    fontNames;

+ (NSArray*) listAllFamilyRecords;

- (id) initWithFamilyName:(NSString*)name;

@end
