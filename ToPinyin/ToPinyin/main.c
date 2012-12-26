//
//  main.c
//  ToPinyin
//
//  Created by kai on 12-11-14.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#include <stdio.h>
#include "pinyin.h"

int main_main(int argc, const char * argv[])
{

    printf("Hello, World!\n");
    
    const char **pinyins;
    wchar_t line_char = 0x94b1; //钱
    int count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x5586; //喆
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    
    line_char = 0x9753; //靓
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x513f; //儿
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x856d; //蕭
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x4e9e; //亞
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x8ed2; //軒
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }
    
    line_char = 0x41; //A
    count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
    printf("\ncount=%d\n", count);
    for (int i = 0; i < count; ++i) {
        printf("value%d=%s\n", i, pinyins[i]);
    }

    wchar_t* ooxx = L"我是好人abc";
    int ll = sizeof(ooxx);
    int lll = wcslen(ooxx);
    printf("ll=%d lll=%d", ll, lll);
    for (int lli = 0; lli < lll; ++lli) {
        line_char = ooxx[lli];
        count = pinyin_get_pinyins_by_unicode(line_char, &pinyins);
        printf("\ncount=%d\n", count);
        for (int i = 0; i < count; ++i) {
            printf("value%d=%s\n", i, pinyins[i]);
        }

    }

    return 0;
}

