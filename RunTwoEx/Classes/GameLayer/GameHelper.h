//
//  GameLayer.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//
 
#import "CCLayer.h"
#import "Hero.h"
#import "HeroInfo.h"
#import "ThingCache.h"
#import "CCTMXTiledMap.h"
#import "BumpInfo.h"
#import "ADLayer.h"
#import "ThingLayer.h"
#import "GADBannerView.h"
#import "GameLayerInfo.h"
#import "GameLayer.h"
@interface GameHelper : CCLayer {
    
}


+ (GameLayer*) getGameLayer;
+ (Hero*)getHero;   //主角
+ (HeroInfo*)getHeroInfo; //人物信息
+ (CCTMXTiledMap*)getBgTmxMap;//获取地图
+ (BgTmxLayer *)getBgTmxLayer;//获取地图背景
+ (ADLayer*)getAD_BeforeLayer;//获取前置广告地图
+ (ADLayer*)getAD_AfterLayer;//获取前置广告地图
+ (ThingLayer*)getThingLayer;
+ (BGLayer*)getBGLayer;

+ (GameLayerInfo*)getGameLayerInfo;
 
@end
