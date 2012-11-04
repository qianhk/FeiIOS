//
//  Monster.h
//  KaiSimpleGame
//
//  Created by qianhk on 12-11-4.
//
//

#ifndef __KaiSimpleGame__Monster__
#define __KaiSimpleGame__Monster__

#include "cocos2d.h"

class Monster : public cocos2d::CCSprite {
public:
    int _curHp;
    int _minMoveDuration;
    int _maxMoveDuration;
};

class WeakAndFastMonster : public Monster {
public:
    static WeakAndFastMonster* monster();
};

class StrongAndSlowMonster : public Monster {
public:
    static StrongAndSlowMonster* monster();
};

#endif /* defined(__KaiSimpleGame__Monster__) */
