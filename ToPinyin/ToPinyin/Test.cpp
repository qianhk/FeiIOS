//
//  Test.cpp
//  ToPinyin
//
//  Created by qianhk on 12-11-21.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#include "Test.h"

using namespace std;

void fun(int A[])
{
    cout<<"fun len A="<<sizeof(A)/sizeof(int)<<endl<<sizeof(A)<<endl;
}

int main(int argc, const char * argv[])
{
    cout<<sizeof(CBase)<<endl;
    cout<<sizeof(CChildV)<<endl;
    cout<<sizeof(CChildA)<<endl;
    
    int aaa[] = {1, 2,3,4,54,2,3,2};
    cout<<"main len A="<<sizeof(aaa)/sizeof(int)<<endl<<sizeof(aaa)<<endl;
    fun(aaa);
}