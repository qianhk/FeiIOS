//
//  Test.h
//  ToPinyin
//
//  Created by qianhk on 12-11-21.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#ifndef __ToPinyin__Test__
#define __ToPinyin__Test__

#include <iostream>

class CBase {};

class CChildV {
    virtual ~CChildV();
};

class CChildA {
    int a;
    char b;
    virtual void TestFunc() = 0;
    virtual void TestVirtual() =  0;
};

#endif /* defined(__ToPinyin__Test__) */
