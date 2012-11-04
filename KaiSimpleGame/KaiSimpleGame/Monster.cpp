//
//  Monster.cpp
//  KaiSimpleGame
//
//  Created by qianhk on 12-11-4.
//
//

#include "Monster.h"

WeakAndFastMonster* WeakAndFastMonster::monster() {
    WeakAndFastMonster* monster = new WeakAndFastMonster();
    monster->initWithFile("Target.png");
    monster->autorelease();
    monster->_curHp = 1;
    monster->_minMoveDuration = 3;
    monster->_maxMoveDuration = 5;
    return monster;
}

StrongAndSlowMonster* StrongAndSlowMonster::monster() {
    StrongAndSlowMonster* monster = new StrongAndSlowMonster();
    if (monster && monster->initWithFile("Target2.png")) {
        monster->autorelease();
        monster->_curHp = 3;
        monster->_minMoveDuration = 6;
        monster->_maxMoveDuration = 12;
        return monster;
    }
    
    CC_SAFE_DELETE(monster);
    return NULL;
}

