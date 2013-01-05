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

void launchKaiNatBash();

#endif //__SysUtils_H_
