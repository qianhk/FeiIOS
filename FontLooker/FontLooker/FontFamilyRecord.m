//
//  FontFamilyRecord.m
//  FontLooker
//
//  Created by HJC on 11-5-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontFamilyRecord.h"


@implementation FontFamilyRecord
@synthesize name = m_name;
@synthesize fontNames = m_fontNames;


+ (NSArray*) listAllFamilyRecords
{
    NSArray* array = [UIFont familyNames];
    NSMutableArray* allRecords = [NSMutableArray arrayWithCapacity:[array count]];
    
    for (NSString* string in array)
    {
        FontFamilyRecord* record = [[FontFamilyRecord alloc] initWithFamilyName:string];
        [allRecords addObject:record];
        [record release];
    }

    [allRecords sortUsingSelector:@selector(compare:)];

    return allRecords;
}


- (void) dealloc
{
    [m_name release];
    [m_fontNames release];
    [super dealloc];
}


- (id) initWithFamilyName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        NSArray* array = [UIFont fontNamesForFamilyName:name];
        m_fontNames = [[NSMutableArray alloc] initWithCapacity:[array count]];
        for (NSString* fontName in array)
        {
            [m_fontNames addObject:fontName];
        }
        
        m_name = [name copy];
    }
    return self;
}


- (NSComparisonResult) compare:(FontFamilyRecord*)record
{
    return [self.name compare:record.name];
}


@end
