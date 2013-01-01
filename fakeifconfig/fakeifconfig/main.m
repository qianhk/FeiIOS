//
//  main.m
//  fakeifconfig
//
//  Created by qianhk on 12-12-31.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

const NSString* const Log_File_Path = @"~/log/fakeConfig.log";

void writeParamToFileHandle(int argc, const char * argv[], NSFileHandle* fileHandler) {
    NSMutableData* data = [NSMutableData data];
    NSMutableString* muStr = [NSMutableString stringWithCapacity:256];
    NSMutableString* muStrBak = [NSMutableString stringWithCapacity:256];
    for (int idx = 0; idx < argc; ++idx) {
        [muStr appendFormat:[NSString stringWithUTF8String:argv[idx]]];
        [muStrBak appendFormat:[NSString stringWithUTF8String:argv[idx]]];
        if (idx == 0) {
            [muStrBak appendString:@"_bak"];
        }
        [muStr appendString:@" "];
        [muStrBak appendString:@" "];
    }
    [muStr appendString:@"\n"];
    NSLog(@"fake console: cmd is: %@", [muStr description]);
    [fileHandler writeData:[muStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    system([muStrBak UTF8String]);
//    [[[NSTask launchedTaskWithLaunchPath:@"/usr/libexec/InternetSharing"] arguments:nil] waitUntilExit];
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSFileManager* manager = [NSFileManager defaultManager];
        NSString* fullPath = [Log_File_Path stringByExpandingTildeInPath];
        BOOL exist = [manager fileExistsAtPath:fullPath];
        if (!exist) {
            NSError* error = nil;
            BOOL success = [manager createDirectoryAtPath:[fullPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:&error];
            if (!success) {
                NSLog(@"fake console: create dir %@ error: %@", Log_File_Path, [error description]);
                return -2;
            }
            success = [manager createFileAtPath:fullPath contents:nil attributes:nil];
            if (!success) {
                NSLog(@"fake console: create file error");
                return -1;
            }
        }
        NSLog(@"fakeConsole: fullPath=%@", fullPath);
        NSFileHandle* handle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
        [handle seekToEndOfFile];
        writeParamToFileHandle(argc, argv, handle);
        [handle closeFile];
        
    }
    return 0;
}

