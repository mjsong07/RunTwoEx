//
//  HeroInfo.h
//  RunTwo
//
//  Created by mjsong on 13-5-26.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"  
#import "BaseSprite.h"
@interface HeroInfo : BaseSprite  {
    CCArray* lifeArray_;
    CCLabelTTF* starLabel_;
    CCLabelTTF* distanceLabel_;
    CCLabelTTF* lifeLabel_;
    CCSprite *lifeImg_ ;
}

@property double totalDistance;//游戏持续时间
@property int lifeCnt;
@property int showLifeCnt;//显示生命数量的变量 用于区分 3.5 和 4.0 屏幕问题
@property double starCnt;

+ (id)herInfoInit; //初始化
- (void)updateStar:(double)num;//更新 星星
- (void)updateLife:(int)num;//更新 生命



- (void)initDistanceInfo;
- (void)initStar;
- (void)initStarNumber;
- (void)initLife;


@end
