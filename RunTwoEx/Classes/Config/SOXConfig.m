//
//  log.m
//  RunTwo
//
//  Created by mjsong on 13-5-28.
//
//

#import "SOXConfig.h" 
#import "GameLayer.h"
@implementation SOXConfig

static float  testSpeed =  0;// G_TILE_SPEED_NORMAL;// 测试速度变量
static BOOL  testShowGameLayerInfoView = true;// 测试显示 界面

+ (void)initAll{
   isOpenMusic=true;//默认打开
   isOpenSound=true;
    testSpeed =G_TILE_SPEED_NORMAL;
   NSString *music= [SOXDBUtil loadInfo:G_KEY_MUSIC];
    if([SOXUtil isNotNull:music]){
        if([music isEqualToString:@"0"]){
            isOpenMusic=true;
        }else{
            isOpenMusic=false;
        }
    }
    NSString *sound= [SOXDBUtil loadInfo:G_KEY_SOUND];
    if([SOXUtil isNotNull:sound]){
        if([sound isEqualToString:@"0"]){
            isOpenSound=true;
        }else{
            isOpenSound=false;
        }
    }
}

+ (void)setIsOpenMusic:(NSString *)index{ 
    if( [index isEqualToString:@"0"] ){
        isOpenMusic = true;
    }else{
        isOpenMusic = false;
    } 
}
+ (void)setIsOpenSound:(NSString *)index{
    if( [index isEqualToString:@"0"] ){
        isOpenSound = true;
    }else{
        isOpenSound = false;
    }
}
+ (bool)getIsOpenMusic{
    return isOpenMusic;
}
+ (bool)getIsOpenSound{
    return isOpenSound;
}

//0  没有  1 菜单  2 游戏画面
+ (void)setNowOpeningType:(int)index{
    nowOpeningType = index; 
}
+ (int)getNowOpeningType{
    return nowOpeningType;
}
//通过 根据 地图的移动 次数设置游戏难度
+ (void)setNowMapRunTimes:(int)index{
   
    if(index >= G_TIMES_EASY0 && index < G_TIMES_EASY1){ //正常 关卡 默认只走一遍
        nowGameLevel =T_LEVEL_EASY0 ;
    }else if(index >= G_TIMES_EASY1 && index < G_TIMES_EASY2){
        nowGameLevel =T_LEVEL_EASY1 ;
    }else if(index >= G_TIMES_EASY2 && index < G_TIMES_EASY3){
        nowGameLevel =T_LEVEL_EASY2 ;
    }else if(index >= G_TIMES_EASY3 && index < G_TIMES_NORMAL1){
        nowGameLevel =T_LEVEL_EASY3 ;
    }else if(index >= G_TIMES_NORMAL1 && index < G_TIMES_NORMAL2){
        nowGameLevel =T_LEVEL_NORMAL1 ;
    } else if(index >= G_TIMES_NORMAL2 && index <G_TIMES_NORMAL3){
        nowGameLevel = T_LEVEL_NORMAL2;
    } else if(index >= G_TIMES_NORMAL3 && index <G_TIMES_HARD1){
        nowGameLevel = T_LEVEL_NORMAL3;
    }

    else if(index >= G_TIMES_HARD1 && index <G_TIMES_HARD2){//开始 加载 难关
        nowGameLevel = T_LEVEL_HARD1;
    }else if(index >= G_TIMES_HARD2 && index <G_TIMES_HARD3){
        nowGameLevel = T_LEVEL_HARD2;
    }else if(index >= G_TIMES_HARD3 && index <G_TIMES_NORMAL_COMMON_FAST){
        nowGameLevel = T_LEVEL_HARD3;
    }
    
    else if(index >= G_TIMES_NORMAL_COMMON_FAST && index <G_TIMES_HARD_COMMON_FAST){ //开始 提速  循环 0~4关卡
        nowGameLevel = T_LEVEL_NORMAL_COMMON_FAST;
    } else if(index >= G_TIMES_HARD_COMMON_FAST  ){ //开始 提速  循环 1~6关卡 游戏文字简单
        nowGameLevel = T_LEVEL_HARD_COMMON_FAST;
    }

    nowMapRunTimes = index;
}
+ (void)setNowGameLevel:(int)index{
    nowGameLevel = index;
} 
+ (int)getNowMapRunTimes{
    return nowMapRunTimes;
}

//新增 测试 速度
+ (void)setTestSpeed:(int)index{
    testSpeed = index;
}
//新增 测试 游戏关卡测试页面 是否显示
+ (void)setTestShowGameLayerInfoView:(BOOL )bol{
    testShowGameLayerInfoView = bol;
}
//新增 测试 游戏关卡测试页面 是否显示
+ (BOOL)getTestShowGameLayerInfoView{
  return   testShowGameLayerInfoView ;
}

+ (int)getNowGameLevel{
    return nowGameLevel;
}

//获取当前box的等级奖励
+ (int)getNowCharCompleteReword{
     
    int ret = 0 ;
    if(nowGameLevel==T_LEVEL_EASY3){
        ret=  G_REWORD_BOX_EASY_COMPLETE;
    }else if(nowGameLevel==T_LEVEL_NORMAL3){
        ret = G_REWORD_BOX_NORMAL_COMPLETE;
    }else if(nowGameLevel==T_LEVEL_HARD3){
        ret = G_REWORD_BOX_HARD_COMPLETE;
    }else if(nowGameLevel==T_LEVEL_HARD3){
        ret = G_REWORD_BOX_HARD_COMPLETE;
    }else if(nowGameLevel==T_LEVEL_HARD3){
        ret = G_REWORD_BOX_HARD_COMPLETE;
    }
    return ret;
}


//获取当前地图移动得速度
+ (float)getNowMapMoveSpeed{  
    float ret=[SOXConfig getNowMapMoveSpeedNoHurt];
    Hero *hero=[GameHelper getHero]; 
    //碰撞时候 缓慢减速
    if(hero.nowActState == kActionStateHurt){
        return ret/100;
    } 
    return ret;
}
//获取当前速度  不包括 受伤停止
+ (float)getNowMapMoveSpeedNoHurt{ 
    float ret= G_TILE_SPEED_NORMAL;
    BOOL isDebug = [SOXDBGameUtil loadIsDebug];
    if(isDebug == true){
        return testSpeed;
    }else{
        if(nowGameLevel==T_LEVEL_NORMAL_COMMON_FAST){
            ret=  G_TILE_SPEED_FAST;
        }else if(nowGameLevel==T_LEVEL_HARD_COMMON_FAST){
            ret = G_TILE_SPEED_FAST;
        } 
    }
       return ret;
}

+ (float)getHeroBaseRiseSpeed{
    float ret = 0; 
    ret= [SOXConfig getNowMapMoveSpeedNoHurt]+ getRS(4);//6;
    return ret; 
}

+ (float)getHeroNowRiseSpeed:(float)nowSpeed{
    float ret = nowSpeed*(1);
    return ret;
}

+ (float)getHeroBaseDropSpeed{
    float ret = 0;
    ret= [SOXConfig getNowMapMoveSpeedNoHurt]+getRS(3);
    return ret;
}

+ (float)getHeroNowDropSpeed:(float)nowSpeed{
    float ret = nowSpeed*(1.000);
    return ret;
} 
//前段 广告 以 地图 速度 ＋1
+ (float)getAD_BeforeLayerMoveSpeed{ 
    //float  micro= rand()%3*0.1;
    return [SOXConfig getNowMapMoveSpeed]+ getRS(1);
}
+ (float)getADBgLayerMoveSpeed{
    //float  micro= rand()%3*0.1;
    return [SOXConfig getNowMapMoveSpeed]-  getRS(1);
}
+ (float)getSunBgLayerMoveSpeed{ 
    
    float ret= [self getNowMapMoveSpeedNoHurt];
    return ret/10- getRS(0.2) ;
    
}

+ (float)getThingMoveRightMapWidth{
    float ret= G_SCREEN_SIZE.width +[SOXConfig getNowMapMoveSpeed]*25; 
    return ret;
} 
+ (void)resetAll{
    //是否打开测试模式
     BOOL isDebug = [SOXDBGameUtil loadIsDebug];
    if(isDebug == true){
        
    }else{
        nowGameLevel = T_LEVEL_EASY0;
        nowMapRunTimes = 0;
    }
    
}





//查询 成就 数量
+ (double)getAchieveNum:(NSString*)key{
    int num = 0;
    if([key isEqualToString: G_KEY_ACHIEVEMENT_SCORE_L1]){
        num = G_ACHIEVEMENT_SCORE_L1;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_DISTANCE_L1]){
        num = G_ACHIEVEMENT_DISTANCE_L1;
    }else if([key isEqualToString:G_KEY_ACHIEVEMENT_LIFE_L1]){
        num =G_ACHIEVEMENT_LIFE_L1;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_STAR_L1]){
        num =G_ACHIEVEMENT_STAR_L1 ;
    }
    
    else if([key isEqualToString: G_KEY_ACHIEVEMENT_SCORE_L2]){
        num = G_ACHIEVEMENT_SCORE_L2;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_DISTANCE_L2]){
        num = G_ACHIEVEMENT_DISTANCE_L2;
    }else if([key isEqualToString:G_KEY_ACHIEVEMENT_LIFE_L2]){
        num =G_ACHIEVEMENT_LIFE_L2;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_STAR_L2]){
        num =G_ACHIEVEMENT_STAR_L2 ;
    }
    
    else if([key isEqualToString: G_KEY_ACHIEVEMENT_SCORE_L3]){
        num = G_ACHIEVEMENT_SCORE_L3;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_DISTANCE_L3]){
        num = G_ACHIEVEMENT_DISTANCE_L3;
    }else if([key isEqualToString:G_KEY_ACHIEVEMENT_LIFE_L3]){
        num =G_ACHIEVEMENT_LIFE_L3;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_STAR_L3]){
        num =G_ACHIEVEMENT_STAR_L3 ;
    }
    
    else if([key isEqualToString: G_KEY_ACHIEVEMENT_SCORE_L4]){
        num = G_ACHIEVEMENT_SCORE_L4;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_DISTANCE_L4]){
        num = G_ACHIEVEMENT_DISTANCE_L4;
    }else if([key isEqualToString:G_KEY_ACHIEVEMENT_LIFE_L4]){
        num =G_ACHIEVEMENT_LIFE_L4;
    }else if([key isEqualToString: G_KEY_ACHIEVEMENT_STAR_L4]){
        num =G_ACHIEVEMENT_STAR_L4 ;
    }
    
    return num;
}


@end
