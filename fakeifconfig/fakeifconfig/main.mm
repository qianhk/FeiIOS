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

#include <assert.h>
#include <sys/sysctl.h>

//typedef struct kinfo_proc kinfo_proc;

static int GetBSDProcessList(kinfo_proc **procList, size_t *procCount)
// Returns a list of all BSD processes on the system.  This routine
// allocates the list and puts it in *procList and a count of the
// number of entries in *procCount.  You are responsible for freeing
// this list (use "free" from System framework).
// On success, the function returns 0.
// On error, the function returns a BSD errno value.
{
    int                 err;
    kinfo_proc *        result;
    bool                done;
    static const int    name[] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0 };
    // Declaring name as const requires us to cast it when passing it to
    // sysctl because the prototype doesn't include the const modifier.
    size_t              length;
    
    assert( procList != NULL);
    assert(*procList == NULL);
    assert(procCount != NULL);
    
    *procCount = 0;
    
    // We start by calling sysctl with result == NULL and length == 0.
    // That will succeed, and set length to the appropriate length.
    // We then allocate a buffer of that size and call sysctl again
    // with that buffer.  If that succeeds, we're done.  If that fails
    // with ENOMEM, we have to throw away our buffer and loop.  Note
    // that the loop causes use to call sysctl with NULL again; this
    // is necessary because the ENOMEM failure case sets length to
    // the amount of data returned, not the amount of data that
    // could have been returned.
    
    result = NULL;
    done = false;
    do {
        assert(result == NULL);
        
        // Call sysctl with a NULL buffer.
        
        length = 0;
        err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                     NULL, &length,
                     NULL, 0);
        if (err == -1) {
            err = errno;
        }
        
        // Allocate an appropriately sized buffer based on the results
        // from the previous call.
        
        if (err == 0) {
            result = (kinfo_proc *)malloc(length);
            if (result == NULL) {
                err = ENOMEM;
            }
        }
        
        // Call sysctl again with the new buffer.  If we get an ENOMEM
        // error, toss away our buffer and start again.
        
        if (err == 0) {
            err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                         result, &length,
                         NULL, 0);
            if (err == -1) {
                err = errno;
            }
            if (err == 0) {
                done = true;
            } else if (err == ENOMEM) {
                assert(result != NULL);
                free(result);
                result = NULL;
                err = 0;
            }
        }
    } while (err == 0 && ! done);
    
    // Clean up and establish post conditions.
    
    if (err != 0 && result != NULL) {
        free(result);
        result = NULL;
    }
    *procList = result;
    if (err == 0) {
        *procCount = length / sizeof(kinfo_proc);
    }
    
    assert( (err == 0) == (*procList != NULL) );
    
    return err;
}

void findGivenProcessName()
{
    // [url]http://developer.apple.com/qa/qa2001/qa1123.html[/url]
    // Using sysctl to get all process lists in BSD system
    
    kinfo_proc *processInfo = NULL;
    size_t count;
    
    int result = GetBSDProcessList(&processInfo, &count);
    
    if(result == 0 && count > 0)
    {
        for(int index = 0; index < count; index ++)
        {
            kinfo_proc p = processInfo[index];
            NSLog(@"Pid:%i\tName:%s\tprocessName=s", p.kp_proc.p_pid, p.kp_proc.p_comm);
			if (strcmp(p.kp_proc.p_comm, "fakeifconfig") == 0) {
                NSLog(@"find natd.................");
            }
        }
		free(processInfo);
    }
}

void getProcess() {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/ps"];

    NSArray *arguments = [NSArray arrayWithObjects: @"-alT", nil];
    [task setArguments: arguments];

    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError:pipe];

    NSFileHandle *file = [pipe fileHandleForReading];

    [task launch];
    [task waitUntilExit];

    NSData *data = [file readDataToEndOfFile];

    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog (@"got\n%@", string);
    [string release];
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
//        writeParamToFileHandle(argc, argv, handle);
        [handle closeFile];
        
//        getnetinterface();
        
//        findGivenProcessName();

        getProcess();
    }
    return 0;
}

