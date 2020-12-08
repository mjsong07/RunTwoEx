//
//  SOXMapUtil.m
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import "SOXDBGameUtil.h"  
#import "SOXDBUtil.h"
#import "SOXUtil.h"
@implementation SOXDBGameUtil   
+ (double)loadNowStar{
    double nowStar=[SOXDBUtil loadInfoReturnDouble:G_KEY_NOW_STAR_CNT];
    return nowStar;
}
+ (int)loadNowLife{
    int nowLife=[SOXDBUtil loadInfoReturnInt:G_KEY_NOW_LIFE_CNT];
    //如果没有查到 生命记录 取系统默认的 2个
    if(nowLife <= 0){
        nowLife = G_LIFE_CNT_DEF;
        [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :[SOXUtil intToString:nowLife]];//同时记录一下
    }
    return nowLife;
}

+ (double)loadBestDistance{
    double nowDistance=[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_DISTANCE];
    return nowDistance;
}
+ (double)loadBestScore{
    double score=[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
    return score;
}
+ (double)loadBestStar{
    double score=[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_STAR];
    return score;
}
//检测当前是不是debug模式
+ (bool)loadIsDebug{
    bool isDebug = false;
    if(G_DEBUG_ENABLE == 1){
        isDebug = [SOXDBUtil loadInfoReturnBool:G_KEY_IS_DEBUG ];
    }
    return isDebug;
}

+ (bool)loadBMXCharIsRunning{
    bool flag=[SOXDBUtil loadInfoReturnBool:G_KEY_BMX_IS_RUNNING_CHAR];
    return flag;
}


@end
