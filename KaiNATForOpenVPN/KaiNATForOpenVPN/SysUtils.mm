//
// Created by TTKai on 13-1-4.
//
//


#import <ifaddrs.h>
#import <arpa/inet.h>
#include <assert.h>
#include <sys/sysctl.h>

#import "SysUtils.h"

NSArray *getNetInterface() {

    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSInteger success = getifaddrs(&interfaces);
    NSMutableArray *muArray = [NSMutableArray array];
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
//            NSString *address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
//            NSLog(@"interface name: %s; address: %@ %d", temp_addr->ifa_name, address, temp_addr->ifa_addr->sa_family);

            if ([muArray indexOfObject:name] == NSNotFound) {
                [muArray addObject:name];
            }

            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);

    return muArray;
}


int GetBSDProcessList(kinfo_proc **procList, size_t *procCount) {
    int err;
    kinfo_proc *result;
    bool done;
    static const int name[] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t length;

    assert( procList != NULL);
    assert(*procList == NULL);
    assert(procCount != NULL);

    *procCount = 0;

    result = NULL;
    done = false;
    do {
        assert(result == NULL);

        length = 0;
        err = sysctl((int *) name, (sizeof(name) / sizeof(*name)) - 1,
                NULL, &length,
                NULL, 0);
        if (err == -1) {
            err = errno;
        }

        if (err == 0) {
            result = (kinfo_proc *) malloc(length);
            if (result == NULL) {
                err = ENOMEM;
            }
        }

        if (err == 0) {
            err = sysctl((int *) name, (sizeof(name) / sizeof(*name)) - 1,
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
    } while (err == 0 && !done);


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

BOOL hasProcess(const char *process) {
    // [url]http://developer.apple.com/qa/qa2001/qa1123.html[/url]
    // Using sysctl to get all process lists in BSD system

    kinfo_proc *processInfo = NULL;
    size_t count;

    int result = GetBSDProcessList(&processInfo, &count);
    BOOL has = NO;
    if (result == 0 && count > 0) {
        for (int index = 0; index < count; ++index) {
            kinfo_proc p = processInfo[index];
//            NSLog(@"Pid:%i\tName:%s\tprocessName=s", p.kp_proc.p_pid, p.kp_proc.p_comm);
            if (strcmp(p.kp_proc.p_comm, process) == 0) {
                has = YES;
                break;
            }
        }
        free(processInfo);
    }
    return has;
}

NSString* getProcessExpeted() {
    NSString * process = nil;
    @try {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: @"/bin/sh"];
        NSArray *arguments = [NSArray arrayWithObjects: @"-c", @"ps -ax | grep natd", nil];
        [task setArguments: arguments];

        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput: pipe];
        [task setStandardError:pipe];

        NSFileHandle *file = [pipe fileHandleForReading];

        [task launch];
        [task waitUntilExit];

        NSData *data = [file readDataToEndOfFile];

        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [task release];

        NSLog (@"got\n%@", string);

        NSError * error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"natd -s -m -d -dynamic -n (\\w+)" options:0 error:&error];
        NSTextCheckingResult *result = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
        if (result != nil) {
            NSRange range = [result rangeAtIndex:1];
            process = [string substringWithRange:range];
        }
        [string release];
    }
    @catch (NSException *exception) {
        NSLog(@"Kai Exception occurred: %@, %@", exception, [exception userInfo]);
    }
    return process;
}

BOOL launchKaiNatBash(KaiNatActionType action, NSString* netInterface) {
    NSBundle * bundle = [NSBundle bundleWithIdentifier:@"com.njnu.kai.kainatforopenvpn"];
    NSString * natFilePath = [bundle pathForAuxiliaryExecutable:@"natd_via_who"];
    
    NSDictionary *error = nil;
    NSString *script =  [NSString stringWithFormat:@"do shell script \"%@ %@ %@\" with administrator privileges", natFilePath, action == KaiNatActionTypeStart ? @"start" : @"stop", netInterface];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
    BOOL result = [appleScript executeAndReturnError:&error] != nil;
    [appleScript release];
    if (error != nil) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        if ([error objectForKey:NSAppleScriptErrorBriefMessage] != nil) {
            [alert setMessageText:[error objectForKey:NSAppleScriptErrorBriefMessage]];
        } else {
            [alert setMessageText:[error description]];
        }
        [alert runModal];
    }
    return result;
}
