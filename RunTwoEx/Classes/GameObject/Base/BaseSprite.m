//
//  ActionSprite.m
//  PompaDroid
//
//  Created by Allen Benson G Tan on 10/21/12.
//  Copyright 2012 WhiteWidget Inc. All rights reserved.
//

#import "BaseSprite.h"

#import "CCAnimationHelper.h"
@implementation BaseSprite
+ (id)objInit
{
    BaseSprite *base = [[self alloc] initWithImage];
    [base initAllAction];
	return [base autorelease]; 
}

- (id)initWithImage //只初始化图片动画  留给子类 重写实现
{
    if (self = [super init]) {
    
    }
    return self;
}
- (void)dealloc
{
    [_baseImgAct release];
    [_baseAct release];
    [super dealloc];
}

- (void)resetAll{
    self.isTouch = false;
    self.isMoveing = false;
    self.visible = false;
}


- (void)initAllAction
{
    self.baseAct = self.baseImgAct;
}

- (void)moveUpRight
{
    [self stopAllActions];
    if(self.isMoveing == false){
        self.isMoveing = true;
        self.isTouch = true; 
        //由于 地图坐标 一直移动  所以 速度加快 需要 调整 移动到右上角的  宽度 
        float moveMapWidth = [SOXConfig getThingMoveRightMapWidth];
        CCMoveBy *mUpRight = [CCMoveBy actionWithDuration:0.8f position:ccp(getRS(moveMapWidth) , G_SCREEN_SIZE.height)];
        id seq = [CCSequence actions:mUpRight,[CCCallFunc actionWithTarget:self selector:@selector(resetAll)], nil];
        [self runAction:seq]; 
    }
}

- (void)baseDo
{
    [self runAction:self.baseAct];
}

- (void)setToHidden
{
    self.visible = false;
}

- (void)setToTouch
{
    self.isTouch = true;
}
//子类如果 只有一张图片  可以使用以下方法
/*
- (id)initWithImage
{
    [super initWithSpriteFrameName:@"xxx.png"];
	return self;
}*/
@end
