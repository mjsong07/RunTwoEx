//
//  Constant.h
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import <Foundation/Foundation.h> 

#define G_DEBUG_ENABLE 1 //当前是否debug状态 默认0 打开1


#define G_JUMP_HEIGHT 100   //跳跃高度
#define G_PERFECT_TIMES 100 //无敌时间
#define G_DROP_ASPEED_ADD_VAL getRS(0.1) //加速度的递加，不断递加直到为max
#define G_DROP_SPEED_MAX getRS(3)
#define G_RISE_ASPEED_DEF getRS(5)  //初始化 加速度 也可以理解为高度  即基本速度
#define G_RISE_ASPEED_SUB_VAL getRS(0.02)  //加速度的递减，不断递减max直到为 0
#define G_RISE_CNT_MAX getRS(120) //跳跃高度

#define G_LIFE_CNT_DEF 1 //默认 生命数 1
#define G_LIFE_CNT_MAX 8 //最大 生命数 8

#define G_LIFE_SHOW_IMG_CNT_3_5 4 //当 数量为 6 显示心
#define G_LIFE_SHOW_IMG_CNT_4_0 6 //当 数量为 6 显示心



#define G_REWORD_STAR 1 //星星
#define G_REWORD_LINE 2 //线
#define G_REWORD_BOX 1 //box  默认没有 需要连续完成才有意义
#define G_REWORD_BOX_EASY_COMPLETE 30 //都顺利完成
#define G_REWORD_BOX_NORMAL_COMPLETE 50 //都顺利完成
#define G_REWORD_BOX_HARD_COMPLETE 100 //都顺利完成

#define G_THING_CHAR_CREATE_NUM_EASY 9 //文字创建的数量 简单
#define G_THING_CHAR_CREATE_NUM_NORMAL 16 //文字创建的数量 正常

#define G_STAR_CNT_DEF 0 //默认 星星
#define G_TILE_WIDTH  getRS(32) //瓦块 宽
#define G_TILE_HEIGHT getRS(32) //瓦块高

#define G_CACHE_NUM_STAR 500 //默认创建的缓存数量500    可以根据 实际最大加载的 地图数量 和 每个地图 最多的星星和  计算
#define G_CACHE_NUM_LINE 100 //默认创建的缓存数量100
#define G_CACHE_NUM_LIFE 20 //默认创建的缓存数量20
#define G_CACHE_NUM_BOX 50 //默认创建的缓存数量 100
#define G_CACHE_NUM_FLOOR 500 //默认创建的缓存数量 100


#define G_TILE_SPEED_NORMAL getRS(4.0) //默认 正常速度 4getRS(4.0)
#define G_TILE_SPEED_FAST getRS(5.0)  // 加速 5getRS(5.0)



#define G_TIMES_EASY0 0 //默认 简单 只跑一次
#define G_TIMES_EASY1 1 //
#define G_TIMES_EASY2 2 //
#define G_TIMES_EASY3 3 //
#define G_TIMES_NORMAL1 4  //默认 中等 只跑一次
#define G_TIMES_NORMAL2 5  //
#define G_TIMES_NORMAL3 6  //
#define G_TIMES_HARD1 7//默认 高等 只跑一次
#define G_TIMES_HARD2 8//
#define G_TIMES_HARD3 9//
#define G_TIMES_NORMAL_COMMON_FAST 10//0~4关 加速 循环2次
#define G_TIMES_HARD_COMMON_FAST 14//1~6关 加速 循环5次  游戏文字简单



//购买
#define G_PURCHASES_STAR_5000 5000 //购买星星  1000
#define G_PURCHASES_STAR_15000 15000 //购买星星  3000
#define G_PURCHASES_LIFE_1 1 //购买生命  1
#define G_PURCHASES_LIFE_3 3 //购买生命  3


#define G_BUY_LIFE_USED_STAR_500 500 //购买生命 使用的 星星
#define G_BUY_LIFE_USED_STAR_1000 1000 //购买生命 使用的 星星

//成就记录
#define G_ACHIEVEMENT_SCORE_L1 1000 //总分 1000
#define G_ACHIEVEMENT_DISTANCE_L1 1000 //距离 1000
#define G_ACHIEVEMENT_STAR_L1 1000 //星星 500
#define G_ACHIEVEMENT_LIFE_L1 2 //生命 2

#define G_ACHIEVEMENT_SCORE_L2 5000 //总分 5000
#define G_ACHIEVEMENT_DISTANCE_L2 5000 //距离 5000
#define G_ACHIEVEMENT_STAR_L2 5000 //星星 1000
#define G_ACHIEVEMENT_LIFE_L2 4 //生命 4

#define G_ACHIEVEMENT_SCORE_L3 10000 //总分 10000
#define G_ACHIEVEMENT_DISTANCE_L3 10000 //距离 10000
#define G_ACHIEVEMENT_STAR_L3 10000 //星星 3000
#define G_ACHIEVEMENT_LIFE_L3 6 //生命 6

#define G_ACHIEVEMENT_SCORE_L4 50000 //总分 30000
#define G_ACHIEVEMENT_DISTANCE_L4 50000 //距离 30000
#define G_ACHIEVEMENT_STAR_L4 50000 //星星 10000
#define G_ACHIEVEMENT_LIFE_L4 8 //生命 10

#define G_ALERT_DELAY_TIMES 2  //alert显示时间


#define G_STR_NULL @""
#define G_STR_YES @"1"
#define G_STR_NO @"0"

#define G_INT_YES 1
#define G_INT_NO 0


//根据游戏多少次数  显示评价弹出框
#define G_RANK_SHOW_1 10
#define G_RANK_SHOW_2 30
#define G_RANK_SHOW_3 200




//判断是否为 iphone
#define G_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为 ipad
#define G_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为iPhone4    640x960
#define G_IS_IPHONE_4  [[UIScreen mainScreen] bounds].size.height <= 480.0f
//判断是否为iPhone5  640x1136
#define G_IS_IPHONE_5  [[UIScreen mainScreen] bounds].size.height >= 568.0f



//! Gray Color (166,166,166)
static const ccColor3B ccSOX_BLUE = {0 ,102,255};
static const ccColor3B ccSOX_BLUE_SEL = {0,80,202};
static const ccColor3B ccSOX_PINK = {255, 0 ,255};
static const ccColor3B ccSOX_PINK_SEL = {255,0,204};
static const ccColor3B ccSOX_GRAY = {102,102,102};

@interface SOXGlobal : NSObject{
    
} 
@end
