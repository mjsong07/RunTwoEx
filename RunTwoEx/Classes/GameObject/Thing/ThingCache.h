//
//  ThingCache.h
//  RunTwo
//
//  Created by mjsong on 13-6-3.
//
//

#import "BaseSprite.h"
#import "Hero.h"
@interface ThingCache : CCSprite{ 
    CCSpriteBatchNode *ccBatchNode_;
}

+ (id)objInit;
@property(nonatomic,retain)CCArray* things;//二维数组 存放不同得 物品 障碍
- (BaseSprite*) showObj:(ColorType)thingType :(ThingObjType)objType :(CGPoint)startPosition;//根据x坐标生成
+ (id)objInit;//初始化
//- (void)chkAllIsTouch:(Hero*)hero :(CCTMXTiledMap*)map;//判断 当前人物 与所有障碍是否碰撞
- (ColorType)chkAllIsTouch:(Hero*)hero :(CCTMXTiledMap*)map;


- (bool)chkAllIsFloor:(CrashType)crashType :(Hero*)hero ;
- (void)hiddenAll;
@end
