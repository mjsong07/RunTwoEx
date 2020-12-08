//
//  GameLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-9.
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
@interface GameLayer : CCLayer {
    Hero *hero_;
    BumpInfo *bumpTop;
    BumpInfo *bumpBody;
    BumpInfo *bumpBottom;
    bool autoCreateFlag_;  
}
//静态全局方法
+ (GameLayer*)sharedGameLayer;
//初始化
+ (id)scene;

//公开 暂停画面
- (void)toExitPause:(id) sender;
- (void)showSaveMe;
- (void)initThingCharTop:(NSString*)newStrChar;//初始化 游戏文字框
- (void)updateThingCharTop;//更新 游戏文字

- (void)failThingCharTop;
- (void)successThingCharTop;
- (void)resumeGoOnGame;
- (void)heroHurtAll;
- (void)heroDeadAll;

@end
