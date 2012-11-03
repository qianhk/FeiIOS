#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"
#include "GameOverScene.h"

using namespace cocos2d;
using namespace CocosDenshion;

HelloWorld::~HelloWorld()
{
	if (_targets)
	{
		_targets->release();
		_targets = NULL;
	}
    
	if (_projectiles)
	{
		_projectiles->release();
		_projectiles = NULL;
	}
    
    if (mPlayerSprite)
    {
        mPlayerSprite->release();
        mPlayerSprite = NULL;
    }
    
	// cpp don't need to call super dealloc
	// virtual destructor will do this
}

HelloWorld::HelloWorld()
:_targets(NULL)
,_projectiles(NULL)
,_projectilesDestroyed(0)
,mNextProjectile(NULL)
{
}

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

void HelloWorld::addTarget()
{
    CCSprite *target = CCSprite::create("Target.png", CCRectMake(0,0,27,40) );
    
	// Determine where to spawn the target along the Y axis
	CCSize winSize = CCDirector::sharedDirector()->getVisibleSize();
	float minY = target->getContentSize().height/2;
	float maxY = winSize.height -  target->getContentSize().height/2;
	int rangeY = (int)(maxY - minY);
	// srand( TimGetTicks() );
	int actualY = ( rand() % rangeY ) + (int)minY;
    
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated
	target->setPosition(
                        ccp(winSize.width + (target->getContentSize().width/2),
                            CCDirector::sharedDirector()->getVisibleOrigin().y + actualY) );
	this->addChild(target);
    
	// Determine speed of the target
	int minDuration = (int)2.0;
	int maxDuration = (int)4.0;
	int rangeDuration = maxDuration - minDuration;
	// srand( TimGetTicks() );
	int actualDuration = ( rand() % rangeDuration ) + minDuration;
    
	// Create the actions
	CCFiniteTimeAction* actionMove = CCMoveTo::create( (float)actualDuration,
                                                      ccp(0 - target->getContentSize().width/2, actualY) );
	CCFiniteTimeAction* actionMoveDone = CCCallFuncN::create( this,
                                                             callfuncN_selector(HelloWorld::spriteMoveFinished));
	target->runAction( CCSequence::create(actionMove, actionMoveDone, NULL) );
    
	// Add to targets array
	target->setTag(1);
	_targets->addObject(target);
}

void HelloWorld::spriteMoveFinished(CCNode* sender)
{
	CCSprite *sprite = (CCSprite *)sender;
	this->removeChild(sprite, true);
    
	if (sprite->getTag() == 1)  // target
	{
		_targets->removeObject(sprite);
        
		GameOverScene *gameOverScene = GameOverScene::create();
		gameOverScene->getLayer()->getLabel()->setString("凯提示你，You Lose :[");
		CCDirector::sharedDirector()->replaceScene(gameOverScene);
        
	}
	else if (sprite->getTag() == 2) // projectile
	{
		_projectiles->removeObject(sprite);
	}
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayerColor::initWithColor(ccc4(255, 255, 255, 255)))
    {
        return false;
    }

    this->setTouchEnabled(true);
    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    CCMenuItemImage *pCloseItem = CCMenuItemImage::create(
                                        "CloseNormal.png",
                                        "CloseSelected.png",
                                        this,
                                        menu_selector(HelloWorld::menuCloseCallback) );
    pCloseItem->setPosition( ccp(CCDirector::sharedDirector()->getWinSize().width - 20, 20) );

    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(pCloseItem, NULL);
    pMenu->setPosition( CCPointZero );
    this->addChild(pMenu, 1);

    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label
    CCLabelTTF* pLabel = CCLabelTTF::create("TTKai", "Thonburi", 34);

    // ask director the window size
    CCSize size = CCDirector::sharedDirector()->getWinSize();

    // position the label on the center of the screen
    pLabel->setPosition( ccp(size.width / 2, size.height - 20) );
    pLabel->setColor(ccc3(255, 0, 255));

    // add the label as a child to this layer
    this->addChild(pLabel, 1);

    // add "HelloWorld" splash screen"
    mPlayerSprite = CCSprite::create("Player2.jpg");
    mPlayerSprite->retain();

    // position the sprite on the center of the screen
    mPlayerSprite->setPosition( ccp(mPlayerSprite->getContentSize().width/2, size.height/2) );
    
    

    // add the sprite as a child to this layer
    this->addChild(mPlayerSprite, 0);
    
    this->schedule( schedule_selector(HelloWorld::gameLogic), 1.0 );
    
    _targets = new CCArray;
    _projectiles = new CCArray;
    
    this->schedule( schedule_selector(HelloWorld::updateGame) );
    
    CocosDenshion::SimpleAudioEngine::sharedEngine()->playBackgroundMusic("background-music-aac.wav", true);
    
    return true;
}


void HelloWorld::ccTouchesEnded(CCSet* touches, CCEvent* event)
{
    if (mNextProjectile) return;
    
	// Choose one of the touches to work with
	CCTouch* touch = (CCTouch*)( touches->anyObject() );
	CCPoint location = touch->getLocation();
    
	CCLog("++++++++after  x:%f, y:%f", location.x, location.y);
    
	// Set up initial location of projectile
	CCSize winSize = CCDirector::sharedDirector()->getVisibleSize();
	mNextProjectile = CCSprite::create("Projectile2.jpg");
    mNextProjectile->retain();
	mNextProjectile->setPosition( ccp(20, winSize.height/2) );
    
	// Determinie offset of location to projectile
	float offX = location.x - mNextProjectile->getPosition().x;
	float offY = location.y - mNextProjectile->getPosition().y;
    
	// Bail out if we are shooting down or backwards
	if (offX <= 0) return;
    
	
    
	// Determine where we wish to shoot the projectile to
	float realX = winSize.width + (mNextProjectile->getContentSize().width/2);
	float ratio = offY / offX;
	float realY = (realX * ratio) + mNextProjectile->getPosition().y;
	CCPoint realDest = ccp(realX, realY);
    
	// Determine the length of how far we're shooting
	float offRealX = realX - mNextProjectile->getPosition().x;
	float offRealY = realY - mNextProjectile->getPosition().y;
	float length = sqrtf((offRealX * offRealX) + (offRealY*offRealY));
	float velocity = 480/1; // 480pixels/1sec
	float realMoveDuration = length/velocity;
    
    float angleRadians = atanf(offRealY/offRealX);
    float angleDegress = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegress;
    float rotateSpeed = 0.5 / M_PI;
    float rotateDuration = fabs(angleRadians * rotateSpeed);

    mPlayerSprite->runAction(CCSequence::create(CCRotateTo::create(rotateDuration, cocosAngle), CCCallFuncN::create(this, callfuncN_selector(HelloWorld::finishShoot)), NULL));
    
	// Move projectile to actual endpoint
	mNextProjectile->runAction( CCSequence::create(
                                              CCMoveTo::create(realMoveDuration, realDest),
                                              CCCallFuncN::create(this,
                                                                  callfuncN_selector(HelloWorld::spriteMoveFinished)),
                                              NULL) );
    
	// Add to projectiles array
	mNextProjectile->setTag(2);
	
}

void HelloWorld::finishShoot(cocos2d::CCNode* sender)
{
    // Ok to add now - we've double checked position
	this->addChild(mNextProjectile);
    _projectiles->addObject(mNextProjectile);
    
	CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect("pew-pew-lei.wav");
    
    mNextProjectile->release();
    mNextProjectile = NULL;
}

void HelloWorld::gameLogic(float dt)
{
	this->addTarget();
}


void HelloWorld::updateGame(float dt)
{
	CCArray *projectilesToDelete = new CCArray;
    CCObject* it = NULL;
    CCObject* jt = NULL;
    
	// for (it = _projectiles->begin(); it != _projectiles->end(); it++)
    CCARRAY_FOREACH(_projectiles, it)
	{
		CCSprite *projectile = dynamic_cast<CCSprite*>(it);
		CCRect projectileRect = CCRectMake(
                                           projectile->getPosition().x - (projectile->getContentSize().width/2),
                                           projectile->getPosition().y - (projectile->getContentSize().height/2),
                                           projectile->getContentSize().width,
                                           projectile->getContentSize().height);
        
		CCArray* targetsToDelete =new CCArray;
        
		// for (jt = _targets->begin(); jt != _targets->end(); jt++)
        CCARRAY_FOREACH(_targets, jt)
		{
			CCSprite *target = dynamic_cast<CCSprite*>(jt);
			CCRect targetRect = CCRectMake(
                                           target->getPosition().x - (target->getContentSize().width/2),
                                           target->getPosition().y - (target->getContentSize().height/2),
                                           target->getContentSize().width,
                                           target->getContentSize().height);
            
			// if (CCRect::CCRectIntersectsRect(projectileRect, targetRect))
            if (projectileRect.intersectsRect(targetRect))
			{
				targetsToDelete->addObject(target);
			}
		}
        
		// for (jt = targetsToDelete->begin(); jt != targetsToDelete->end(); jt++)
        CCARRAY_FOREACH(targetsToDelete, jt)
		{
			CCSprite *target = dynamic_cast<CCSprite*>(jt);
			_targets->removeObject(target);
			this->removeChild(target, true);
            
			_projectilesDestroyed++;
			if (_projectilesDestroyed >= 5)
			{
				GameOverScene *gameOverScene = GameOverScene::create();
				gameOverScene->getLayer()->getLabel()->setString("You Win!");
				CCDirector::sharedDirector()->replaceScene(gameOverScene);
			}
		}
        
		if (targetsToDelete->count() > 0)
		{
			projectilesToDelete->addObject(projectile);
		}
		targetsToDelete->release();
	}
    
	// for (it = projectilesToDelete->begin(); it != projectilesToDelete->end(); it++)
    CCARRAY_FOREACH(projectilesToDelete, it)
	{
		CCSprite* projectile = dynamic_cast<CCSprite*>(it);
		_projectiles->removeObject(projectile);
		this->removeChild(projectile, true);
	}
	projectilesToDelete->release();
}


void HelloWorld::menuCloseCallback(CCObject* pSender)
{
    CCDirector::sharedDirector()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
