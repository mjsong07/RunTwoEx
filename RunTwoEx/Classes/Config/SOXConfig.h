//
//  Config.h
//  RunTwo
//
//  Created by mjsong on 13-5-23.
//
//

#import <Foundation/Foundation.h>
#import "SOXUtil.h"
#import "Hero.h"

//当前地图 移动得 次数
static int  nowMapRunTimes;//当前 已经循环了多少次关卡
//当前游戏 难度等级
static int  nowGameLevel;//  当前游戏等级
static bool isOpenMusic;// 背景声音 0 为 开 1 为关
static bool isOpenSound;// 按钮声音
static int  nowOpeningType;//1 菜单  2 游戏画面

static float  testSpeed;// 测试速度变量

static BOOL  testShowGameLayerInfoView;// 测试关卡 地图数量界面



@interface SOXConfig : NSObject{

}

+ (void)initAll;
+ (void)setIsOpenMusic:(NSString *)index;
+ (void)setIsOpenSound:(NSString *)index; 
+ (void)setNowMapRunTimes:(int)index;
+ (void)setNowGameLevel:(int)index;
+ (int)getNowMapRunTimes;
+ (int)getNowGameLevel;

+ (int)getNowCharCompleteReword;
+ (bool)getIsOpenMusic;
+ (bool)getIsOpenSound;

+ (void)setNowOpeningType:(int)index;
+ (int)getNowOpeningType;
+ (float)getNowMapMoveSpeed; 
+ (float)getAD_BeforeLayerMoveSpeed; 
+ (float)getADBgLayerMoveSpeed;
+ (float)getSunBgLayerMoveSpeed;

+ (float)getNowMapMoveSpeedNoHurt;


+ (float)getHeroBaseRiseSpeed;
+ (float)getHeroNowRiseSpeed:(float)nowSpeed;

+ (float)getHeroBaseDropSpeed;
+ (float)getHeroNowDropSpeed:(float)nowSpeed; 
+ (float)getThingMoveRightMapWidth;
 
//重置 游戏 关卡 速度
+ (void)resetAll;

+ (double)getAchieveNum:(NSString*)key;

+ (void)setTestSpeed:(int)index;

+ (void)setTestShowGameLayerInfoView:(BOOL)index;

+ (BOOL)getTestShowGameLayerInfoView;

@end
