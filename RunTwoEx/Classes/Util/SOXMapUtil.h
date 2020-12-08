//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"
#import "CCTMXTiledMap.h"
#import "cocos2d.h"
@interface SOXMapUtil : NSObject
 
//判断2个 精灵是否 碰击 
+ (bool)chkPointInTMX :(CGPoint)pos :(CCTMXTiledMap*)tileMap;
+ (CGRect)spriteToRect:(CCSprite*)sp; 
+ (CGRect)spriteToRectByHero:(CCSprite*)sp; 
+ (CGPoint)getNowPointInMapLocation:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap;
+ (CGPoint)getPonitByMapTile:(CGPoint)heroPiont tileMap:(CCTMXTiledMap*)tileMap;
+ (CGPoint)getPointByObjLayerDict:(NSDictionary*)dict tileMap:(CCTMXTiledMap*)tileMap :(CGFloat)width :(CGFloat) height
;
+ (bool)chkPointIsLessZreo:(CGPoint)pos;

+ (CCArray*)mapIterator:(CCTMXTiledMap*)tileMap :(NSString *)objectLayerName;


+ (Boolean)chkHeroIsTouchMapSp:(CCSprite*)hero :(CCSprite*)chkMapSp :(float)subX;

//检查人物是否 碰撞 地图
+ (Boolean)chkHeroBumpIsTouch:(CCSprite*)sp :(CrashType)crashType :(CCSprite*)chkMapSp :(float)subX;
+ (NSString*)initBMXCharAll:(int)createNum;
+ (NSString*)getBMXCreateSingleCharVal;
+ (bool)chkBMXSingleChar:(NSString*)nowSingleChar;

+ (void)updateBMXCharVal:(NSString*)nowSingleVal;
+ (int)getNowIndexBySingleCharVal;
+ (bool)chkBMXCharSuccess;
 
 
@end
