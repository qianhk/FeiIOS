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

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
// you may need to include other headers


void getnetinterface() {
    
    struct ifaddrs* interfaces = NULL;
    struct ifaddrs* temp_addr = NULL;
    // retrieve the current interfaces - returns 0 on success
    NSInteger success = getifaddrs(&interfaces);
    NSMutableArray* muArray = [NSMutableArray array];
    NSMutableSet* muSet = [NSMutableSet set];
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
                [muSet addObject:name];
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);

    for (NSUInteger idx = 0; idx < muArray.count; ++idx) {
        NSLog(@"i name in Array: %@", [muArray objectAtIndex:idx]);
    }
    
    [muSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, BOOL *stop) {
        NSLog(@"i name in Set: %@", obj);
    }];
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
        
        getnetinterface();
        
    }
    return 0;
}

