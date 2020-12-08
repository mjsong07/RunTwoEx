//
//  PausedLayer
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "SaveMeProgressLayer.h" 
#import "HelpLayer.h"
#import "MenuSettingInfo.h"
#import "GameLayer.h"
#import "ScoreLayer.h"
@implementation SaveMeProgressLayer
 
- (id)init
{
	self = [super init];
	if (self) {
        isClick_= false;
        [CCMenuItemFont setFontSize:getRS(25)];
        CCSprite  *progressLine = [CCSprite spriteWithFile:@"saveMe_progress.png" ];
        CCSprite *saveMeSprite = [CCSprite spriteWithFile:@"saveMe500.png" ];
        CCMenuItemSprite *itemSaveMe =  [ CCMenuItemSprite itemWithNormalSprite:saveMeSprite selectedSprite:nil  disabledSprite:nil   target:self selector:@selector(buy1LifeUsedStar:) ];
        
        CCMenu *menuSaveMe = [CCMenu menuWithItems: itemSaveMe,nil];
		[menuSaveMe alignItemsHorizontally];
        
        [progressLine setColor:ccSOX_PINK];
        CCProgressTimer *progress=[CCProgressTimer progressWithSprite:progressLine ];
        menuSaveMe.position=G_SCREEN_CENTER;
        progress.position=ccp(G_SCREEN_CENTER.x, G_SCREEN_CENTER.y- getRS(18));
        progress.percentage = 0; //当前进度
        
        progress.type=kCCProgressTimerTypeBar;//进度条的显示样式
        [progress setMidpoint:ccp(0,0 )];
        [progress setBarChangeRate:ccp(1,0)];
        [self addChild:progress z:50 tag:90];
        [self addChild:menuSaveMe z:49];
        [self scheduleUpdate];
	}
	return self;
} 

-(void)update:(ccTime)dt{
    CCProgressTimer*ct=(CCProgressTimer*)[self getChildByTag:90];
    ct.percentage = ct.percentage+ 1.5;//0.65
    if(ct.percentage>=100){
        [self setVisible:FALSE];
         [self unscheduleUpdate];
        //只有还没有点击 按钮才显示成绩 排名
        if(isClick_ == false){
            //如果没有点击 自动 跳到结算排名界面
            [self showScoreLayer];
        }
        isClick_ = true;
    }
}


-(void)showScoreLayer{
    ScoreLayer *scoreLayer= (ScoreLayer*)[[GameHelper getGameLayer] getChildByTag:T_LAYER_SCORE];
    [scoreLayer showLayer];
    [scoreLayer setVisible:true];
}




- (void)buy1LifeUsedStar: (id) sender
{
    if(isClick_ ==  false){
        isClick_ = true;
        [self unscheduleUpdate];
        [self setVisible:FALSE];
        [SOXSoundUtil play_button];
        
        
        
        double nowHeroInfoStarCnt = 0;
        
        HeroInfo *heroInfo = [GameHelper getHeroInfo];
        if (heroInfo != nil){
            nowHeroInfoStarCnt = [heroInfo starCnt];
        }
        double subStars = G_BUY_LIFE_USED_STAR_500;
        double nowStarCnt = [SOXDBGameUtil loadNowStar] +nowHeroInfoStarCnt;
         double nowAllStarCnt = nowStarCnt +nowHeroInfoStarCnt;
      //  int lifeCnt = [SOXDBGameUtil loadNowLife];
        //必须满足1000个星星
        NSString  *message = [NSString stringWithFormat:@"Not enough Stars to buy [%d Lifes]!",1 ];
        if(nowAllStarCnt< subStars){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:message
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:@"Get Stars", nil];
            
            [alert show];
            [alert release];
        }else{
            //如果原来剩余星星足以支付  直接扣除
            if(nowStarCnt>=subStars){
                nowStarCnt = nowStarCnt - subStars;
                [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:nowStarCnt] ];
            }else{
            //需要加上当前游戏中的 金币
                double needCnt =    subStars - nowStarCnt;
                nowHeroInfoStarCnt =nowHeroInfoStarCnt-needCnt ;
                [heroInfo updateStar:nowHeroInfoStarCnt];
                [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:0] ];
            }
            //更新当前星星数量
            //  lifeCnt = lifeCnt + 1;
          //  [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :[SOXUtil intToString:lifeCnt] ];
            [[GameHelper getGameLayer] resumeGoOnGame];//继续游戏
        }
    }
}

//弹出对话框 后 直接结算显示 成绩
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //int tag= [alertView tag];
    if(buttonIndex == 0){//点击了确认
        //弹出对话框 后 直接结算显示 成绩
        [self showScoreLayer];
    }else{
        
        //先更新 分数再跳转
        ScoreLayer *scoreLayer= (ScoreLayer*)[[GameHelper getGameLayer] getChildByTag:T_LAYER_SCORE];
        [scoreLayer updateDBScoreInfo];
        
        [[CCDirector sharedDirector]resume];
        CCScene* newScene = [SceneSwitch showScene:T_SCENE_SHOPPING];
        [[CCDirector sharedDirector] replaceScene:newScene];
    }
  
}





-(void)dealloc{
    [self unscheduleUpdate];
    [super dealloc];
}

@end
