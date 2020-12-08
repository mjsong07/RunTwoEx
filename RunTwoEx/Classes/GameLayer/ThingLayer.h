//
//  ThingLayer.h
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "CCLayer.h"
#import "Hero.h"
@class ThingCache;
@class CCTMXTiledMap;

@interface ThingLayer : CCLayer{ 
}
//初始化方法
+ (id)objInit ; 
- (id)initWithMap; 
- (void)initAllThings :(CCTMXTiledMap*)tileMap :(float)startPointX; 
- (void)updateThing:(ccTime)delta;
@end
