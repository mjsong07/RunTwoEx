//
//  GameLayer.m
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "GameLayer.h"
#import "Hero.h"
#import "InputLayer.h"
#import "HeroInfo.h"
#import "BumpInfo.h"
#import "ThingLayer.h"
#import "BGLayer.h"
#import "ADLayer.h"
#import "BgTmxLayer.h"
#import "PausedLayer.h"
#import "ScoreLayer.h"
#import "GADBannerView.h"
#import "GameLayerInfo.h"
#import "SaveMeProgressLayer.h"
#import "ThingCharTop.h"
#import "GameLayerInfo.h"
@implementation GameHelper {
   
}

+(GameLayer*) getGameLayer
{
    GameLayer *layer = (GameLayer*)[GameLayer sharedGameLayer];
    return layer;
}

+ (GameLayerInfo*)getGameLayerInfo
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_OBJ_GAME_LAYER_INFO];
	return (GameLayerInfo*)node;
}


+ (Hero*)getHero
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_OBJ_HERO];
	return (Hero*)node;
}

+ (HeroInfo*)getHeroInfo
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_OBJ_HERO_INFO];
	return (HeroInfo*)node;
}

+ (ADLayer*)getAD_BeforeLayer
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_LAYER_BG_AD_BEFORE];
	return (ADLayer*)node;
}
+ (ADLayer*)getAD_AfterLayer
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_LAYER_BG_AD_AFTER];
	return (ADLayer*)node;
}
+ (BGLayer*)getBGLayer
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_LAYER_BG];
	return (BGLayer*)node;
}
+ (BgTmxLayer *)getBgTmxLayer
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_LAYER_BG_TMX];
	return (BgTmxLayer *)node;
}

//障碍物
+ (CCTMXTiledMap*)getBgTmxMap
{
    CCNode* node = [[self getBgTmxLayer]getChildByTag:T_OBJ_TMX_MAP];
	return (CCTMXTiledMap*)node;
}
+ (ThingLayer*)getThingLayer
{
    CCNode* node = [[GameHelper getGameLayer] getChildByTag:T_LAYER_THING];
	return (ThingLayer*)node;
}
@end
