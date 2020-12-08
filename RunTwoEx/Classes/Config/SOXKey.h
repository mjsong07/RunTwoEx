//
//  Config.h
//  RunTwo
//
//  Created by mjsong on 13-5-23.
//
//

#import <Foundation/Foundation.h>

#define G_KEY_SOX_RUNTWO_URL @"http://itunes.apple.com/app/run-two/id722179698?ls=1&mt=8?#rd"

/* 当前是否debug模式*/
#define G_KEY_IS_DEBUG @"nowIsDebugFlag"

#define G_KEY_MUSIC @"music"
#define G_KEY_SOUND @"sound"

#define G_KEY_NOW_STAR_CNT @"nowStarCnt"
#define G_KEY_NOW_LIFE_CNT @"nowLifeCnt"


//当前的 地图 显示文字
#define G_KEY_BMX_ORI_CHAR @"oriBMXChar"//原始的
#define G_KEY_BMX_CREATE_CHAR @"createBMXChar"//生成的
#define G_KEY_BMX_CREATE_TEMP_SHOW_CHAR @"createTempShowBMXChar"//生成的 

#define G_KEY_BMX_NOW_CHAR @"nowBMXChar"//当前的
#define G_KEY_BMX_IS_RUNNING_CHAR @"nowBMXIsRunningChar"//当前的 是否为 进行中

#define G_KEY_PURCHASES_STAR_099 @"com.sox.runtwo.purchases.star.099"
#define G_KEY_PURCHASES_STAR_199 @"com.sox.runtwo.purchases.star.199"
#define G_KEY_PURCHASES_STAR_299 @"com.sox.runtwo.purchases.star.299"


#define G_KEY_LEADERBOARD_SCORE @"com.sox.runtwo.leaderboard.score"
#define G_KEY_LEADERBOARD_DISTANCE @"com.sox.runtwo.leaderboard.distance"
/* 注意 星星 排名 使用的 是用户累计的 星星 而不是 单次最大的星星 */
#define G_KEY_LEADERBOARD_STAR @"com.sox.runtwo.leaderboard.star"   
#define G_KEY_LEADERBOARD_BEST @"com.sox.runtwo.leaderboard.best"

/*
 在 G_KEY_ACHIEVEMENT_SCORE_L
 后面新增 flag(是否已通过)  和  nowVal (当前的分值)  保存本地数据库
 webFlag  记录gamecenter服务器记录 
 如： com.sox.runtwo.achievement.scoreL1.flag
     com.sox.runtwo.achievement.scoreL1.nowVal 
    com.sox.runtwo.achievement.scoreL1.webFlag 
 //记录本地的标识
*/
#define G_KEY_ACHIEVEMENT_FLAG @"flag"   
#define G_KEY_ACHIEVEMENT_NOWVAL @"nowVal"
#define G_KEY_ACHIEVEMENT_WEB_FLAG @"webFlag" 
#define G_KEY_ACHIEVEMENT_WEB_NOWVAL @"webNowVal"

#define G_KEY_ACHIEVEMENT_SCORE_L @"com.sox.runtwo.achievement.scoreL"
#define G_KEY_ACHIEVEMENT_DISTANCE_L @"com.sox.runtwo.achievement.distanceL"
#define G_KEY_ACHIEVEMENT_STAR_L @"com.sox.runtwo.achievement.starL"
#define G_KEY_ACHIEVEMENT_LIFE_L @"com.sox.runtwo.achievement.lifeL"

#define G_KEY_ACHIEVEMENT_SCORE_L1 @"com.sox.runtwo.achievement.scoreL1"
#define G_KEY_ACHIEVEMENT_DISTANCE_L1 @"com.sox.runtwo.achievement.distanceL1"
#define G_KEY_ACHIEVEMENT_STAR_L1 @"com.sox.runtwo.achievement.starL1"
#define G_KEY_ACHIEVEMENT_LIFE_L1 @"com.sox.runtwo.achievement.lifeL1"

#define G_KEY_ACHIEVEMENT_SCORE_L2 @"com.sox.runtwo.achievement.scoreL2"
#define G_KEY_ACHIEVEMENT_DISTANCE_L2 @"com.sox.runtwo.achievement.distanceL2"
#define G_KEY_ACHIEVEMENT_STAR_L2 @"com.sox.runtwo.achievement.starL2"
#define G_KEY_ACHIEVEMENT_LIFE_L2 @"com.sox.runtwo.achievement.lifeL2"

#define G_KEY_ACHIEVEMENT_SCORE_L3 @"com.sox.runtwo.achievement.scoreL3"
#define G_KEY_ACHIEVEMENT_DISTANCE_L3 @"com.sox.runtwo.achievement.distanceL3"
#define G_KEY_ACHIEVEMENT_STAR_L3 @"com.sox.runtwo.achievement.starL3"
#define G_KEY_ACHIEVEMENT_LIFE_L3 @"com.sox.runtwo.achievement.lifeL3"

#define G_KEY_ACHIEVEMENT_SCORE_L4 @"com.sox.runtwo.achievement.scoreL4"
#define G_KEY_ACHIEVEMENT_DISTANCE_L4 @"com.sox.runtwo.achievement.distanceL4"
#define G_KEY_ACHIEVEMENT_STAR_L4 @"com.sox.runtwo.achievement.starL4"
#define G_KEY_ACHIEVEMENT_LIFE_L4 @"com.sox.runtwo.achievement.lifeL4" 

//本地存储加密 key   此处 不能修改,因为已经有用户在使用了
#define G_KEY_DB @"www.soxstudio.com"

//广告 id
#define G_KEY_AD_ADMOB @"a15247d821e7c02"

//应用互推的 appKey
#define G_KEY_AT_APPKEY_RUNTWO @"722179698"

/* 微信接口 信息*/
#define G_KEY_WECHAT_APPID @"wxec7725dbbd3096b7"

#define G_KEY_WECHAT_APPSECRET @"d00bec126bdd970a3f5b23bc5adca715"

//是否点击过评价
#define G_KEY_IS_CLICK_RANK @"isClickRank"



//当前已完的游戏次数
#define G_KEY_GAME_TIMES @"gameTimes"



//文字box通用 名称  以 ; 分割 Volvo  尽量避免 s v o 有大小写开头的  并存
#define G_KEY_THING_CHAR_EASY @"SOX;Sony;Honda;KFC;Pepsi;BMW;Lexus;Mazda;Audi;Ford;FIAT;Sharp;Nikon;NEC;Canon;Casio;JVC;GREE"
//Nestle Unilever
//samsung CocaCola  Alfaromeo PHILIPS Siemens Cadillac infiniti Chevrolet McDonalds
//
#define G_KEY_THING_CHAR_NORMAL @"Runtwo;Toyota;Suzuki;Nissan;Panasonic;Olympus;YAMAHA;Toshiba;Hitachi;Lincoln;LandRover;Jaguar;Ferrari;Bentley;Hyundai;Maybach;Boxster;Peugeot"
//;

@interface SOXKey : NSObject{

} 
@end
