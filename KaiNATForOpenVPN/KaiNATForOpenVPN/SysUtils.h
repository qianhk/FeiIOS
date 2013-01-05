//
// Created by TTKai on 13-1-4.
//
// To change the template use AppCode | Preferences | File Templates.
//



#ifndef __SysUtils_H_
#define __SysUtils_H_

#include <iostream>

NSArray * getNetInterface();

BOOL hasProcess(const char *process);

NSString * getProcessExpeted();

typedef enum KaiNatActionType : NSUInteger {
    KaiNatActionTypeStart,
    KaiNatActionTypeStop
}KaiNatActionType;

BOOL launchKaiNatBash(KaiNatActionType action, NSString* netInterface);

#endif //__SysUtils_H_
