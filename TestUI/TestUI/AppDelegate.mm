//
//  AppDelegate.m
//  TestUI
//
//  Created by TTKai on 01/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

//void launchKaiNatBash() {
//    NSBundle * bundle = [NSBundle mainBundle];
//    NSString * natFilePath = [bundle pathForAuxiliaryExecutable:@"natd_via_who"];
//
//    NSString* bashPath = @"/bin/bash";
//    AuthorizationFlags authFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed
//            | kAuthorizationFlagPreAuthorize | kAuthorizationFlagExtendRights;
//    AuthorizationItem authItems[] = {kAuthorizationRightExecute, strlen([bashPath fileSystemRepresentation])
//            , (void*)[bashPath fileSystemRepresentation], 0};
//    AuthorizationRights authRights = {sizeof(authItems)/sizeof(AuthorizationItem), authItems};
//    AuthorizationRef auth = nil;
//    OSStatus osStatus = AuthorizationCreate(&authRights, kAuthorizationEmptyEnvironment, authFlags, &auth);
//    if (osStatus == errAuthorizationSuccess) {
//        NSString *param = [NSString stringWithFormat:@"sudo %@ %@ %@", natFilePath, @"start", @"en0"];
//        char* toolArgs[]  = {"-c", (char *)[param UTF8String], NULL};
//        osStatus = AuthorizationExecuteWithPrivileges(auth, [bashPath fileSystemRepresentation], kAuthorizationFlagDefaults, toolArgs, NULL);
//        NSLog(@"bashPath=%@ osStatus2=%d", natFilePath, osStatus);
//    } else {
//        NSLog(@"bashPath=%@ osStatus=%d", bashPath, osStatus);
//    }
//}

//void launchKaiNatBash() {
//    NSString* bashPath = @"/usr/bin/touch";
//    AuthorizationFlags authFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed
//            | kAuthorizationFlagPreAuthorize | kAuthorizationFlagExtendRights;
//    AuthorizationItem authItems[] = {kAuthorizationRightExecute, strlen([bashPath fileSystemRepresentation])
//            , (void*)[bashPath fileSystemRepresentation], 0};
//    AuthorizationRights authRights = {sizeof(authItems)/sizeof(AuthorizationItem), authItems};
//    AuthorizationRef auth = nil;
//    OSStatus osStatus = AuthorizationCreate(&authRights, kAuthorizationEmptyEnvironment, authFlags, &auth);
//    if (osStatus == errAuthorizationSuccess) {
//        char* toolArgs[] = {"/AndroidDev/t2.txt", NULL};
//        osStatus = AuthorizationExecuteWithPrivileges(auth, [bashPath fileSystemRepresentation], kAuthorizationFlagDefaults, toolArgs, NULL);
//    } else {
//        NSLog(@"bashPath=%@ osStatus=%d", bashPath, osStatus);
//    }
//}

//void launchKaiNatBash() {
//    NSString* bashPath = @"/usr/sbin/natd";
//    AuthorizationFlags authFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed
//            | kAuthorizationFlagPreAuthorize | kAuthorizationFlagExtendRights;
//    AuthorizationItem authItems[] = {kAuthorizationRightExecute, strlen([bashPath fileSystemRepresentation])
//            , (void*)[bashPath fileSystemRepresentation], 0};
//    AuthorizationRights authRights = {sizeof(authItems)/sizeof(AuthorizationItem), authItems};
//    AuthorizationRef auth = nil;
//    OSStatus osStatus = AuthorizationCreate(&authRights, kAuthorizationEmptyEnvironment, authFlags, &auth);
//    if (osStatus == errAuthorizationSuccess) {
//        char* toolArgs[] = {"--c", "-s", "-m", "-d", "-dynamic", "-n", "en0", NULL};
//        osStatus = AuthorizationExecuteWithPrivileges(auth, [bashPath fileSystemRepresentation], kAuthorizationFlagDefaults, toolArgs, NULL);
//        NSLog(@"bashPath=%@ osStatus2=%d", bashPath, osStatus);
//    } else {
//        NSLog(@"bashPath=%@ osStatus=%d", bashPath, osStatus);
//    }
//}

void launchKaiNatBash() {
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * natFilePath = [bundle pathForAuxiliaryExecutable:@"natd_via_who"];

    NSDictionary *error = nil;
    NSString *script =  [NSString stringWithFormat:@"do shell script \"%@ %s %s\" with administrator privileges", natFilePath, "stop", "en0"];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
    if ([appleScript executeAndReturnError:&error]) {
        NSLog(@"success!"); 
    } else {
        NSLog(@"failure, %@ !", [error description]);
    }
    [appleScript release];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    launchKaiNatBash();

}

@end