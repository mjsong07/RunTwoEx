//
//  ScoreLayer
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "ScoreLayer.h"
#import "HelpLayer.h"
#import "GameLayer.h"
#import "MenuAchieveLayer.h"
#import "ShareManager.h"
@implementation ScoreLayer
 
- (id)init
{
	self = [super init];
	if (self) {
        [CCMenuItemFont setFontSize:getRS(25)];
        NSString  *YouScore =  NSLocalizedString(@"YouScore", @"");
		CCMenuItemFont *title = [CCMenuItemFont itemWithString: YouScore];
        [title setFontName:@"Arial"];
        labelNowStar_ = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:getRS(25)];
        labelNowDistance_ = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:getRS(25)];
        labelNowScore_ = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:getRS(38)];
        
        CCSprite *home = [CCSprite spriteWithFile:@"menu_home.png" ]; 
        [home setColor:ccSOX_BLUE]; 
        
        CCSprite *back = [CCSprite spriteWithFile:@"menu_back.png" ];
        
        CCSprite *again = [CCSprite spriteWithFile:@"menu_again.png" ]; 
        [again setColor:ccSOX_BLUE]; 
         
        CCSprite *share = [CCSprite spriteWithFile:@"menu_share_big.png" ];  
        CCMenuItemSprite *itemHome =  [ CCMenuItemSprite itemWithNormalSprite:home selectedSprite:nil
                                                                       target:self selector:@selector(toMenu:) ];
        
        CCMenuItemSprite *itemBack =  [ CCMenuItemSprite itemWithNormalSprite:back selectedSprite:nil
                                                                       target:self selector:@selector(toBack:) ];
        
        CCMenuItemSprite *itemAgain =  [ CCMenuItemSprite itemWithNormalSprite:again selectedSprite:nil
                                                                        target:self selector:@selector(toAgain:) ];
        
        CCMenuItemSprite *itemShare =  [ CCMenuItemSprite itemWithNormalSprite:share selectedSprite:nil
                                                                        target:self selector:@selector(toShare:) ]; 
        
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0){
            menu_ = [CCMenu menuWithItems: itemHome,itemAgain,itemShare,nil];
        }else{
            menu_ = [CCMenu menuWithItems: itemHome,itemAgain,nil];
        } 
        
		[menu_ alignItemsHorizontally];
        [menu_ alignItemsHorizontallyWithPadding:10];
        
        
        menuBack_ = [CCMenu menuWithItems: itemBack,nil]; 
       
        
        CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png" ];
        CCSprite *star = [CCSprite spriteWithFile:@"menu_star.png" ];
        CCSprite *distance = [CCSprite spriteWithFile:@"menu_distance.png" ]; 
        [star setColor:ccSOX_BLUE];
        [distance setColor:ccSOX_BLUE];
        [labelNowStar_ setColor:ccSOX_PINK];
        [labelNowDistance_ setColor:ccSOX_PINK]; 
        [labelNowScore_ setColor:ccSOX_PINK];
        
        [title setColor:ccSOX_BLUE];
        
        [bg setPosition:G_SCREEN_CENTER];
        [title setPosition:ccp(G_SCREEN_SIZE.width/2- getRS(80), G_SCREEN_SIZE.height/2+getRS(70))];
        [labelNowScore_ setPosition:ccp(G_SCREEN_SIZE.width/2 - getRS(20), G_SCREEN_SIZE.height/2+getRS(70))  ];
        
        [distance setPosition:ccp(G_SCREEN_SIZE.width/2-getRS(110), G_SCREEN_SIZE.height/2+getRS(25))];
        [star setPosition:ccp(G_SCREEN_SIZE.width/2+getRS(30), G_SCREEN_SIZE.height/2+getRS(25))];
        
        [labelNowDistance_ setPosition:ccp(G_SCREEN_SIZE.width/2 -getRS(88), G_SCREEN_SIZE.height/2+getRS(25))  ];
        [labelNowStar_ setPosition:ccp(G_SCREEN_SIZE.width/2+getRS(50), G_SCREEN_SIZE.height/2+getRS(25))  ];
        
         [menu_ setPosition:ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/2-getRS(30))];
        
        
       
        menuBack_.scale = 0.7; 
        [menuBack_ setPosition:ccp(G_SCREEN_SIZE.width/2+getRS(40), G_SCREEN_SIZE.height/2- getRS(100) )];
        menuBack_.visible =false;
        [menu_ setTouchEnabled:false];
        [self addChild:title z:10 tag:2];
        [self addChild:star z:10 tag:2];
        [self addChild:distance z:10 tag:2]; 
        [self addChild:labelNowStar_ z:10 tag:2];
        [self addChild:labelNowDistance_ z:10 tag:2]; 
        [self addChild:labelNowScore_ z:10 tag:2];
        
        [self addChild:bg z:-1 tag:2];
        [self addChild:menu_ z:1 tag:2];
        [self addChild:menuBack_];
        
        
        
	}
	return self;
}


//检查当前游戏的 次数  提示 是否评价
- (void)chkAndShowRank
{
	
    int gameTimes =[SOXDBUtil loadInfoReturnInt:G_KEY_GAME_TIMES];//记录当前的游戏次数
    BOOL isClickRank =[SOXDBUtil loadInfoReturnBool:G_KEY_IS_CLICK_RANK];//记录当前的游戏次数
    
    //更新游戏次数  同时判断是否需要弹出评价框
    gameTimes = gameTimes+1;
    [SOXDBUtil updateInfoByInt:G_KEY_GAME_TIMES : gameTimes];//更新游戏次数
    bool isShow = false;
    if(isClickRank == false){//如果没有点击过 继续判断
        if(gameTimes == G_RANK_SHOW_1){//20次 提示评价
            isShow = true;
        }else if( gameTimes == G_RANK_SHOW_2){//20次 提示评价
            isShow = true;
        }else if( gameTimes == G_RANK_SHOW_3){//20次 提示评价
            isShow = true;
        }
    }
    if(isShow == true){
        NSString *RankGame =NSLocalizedString(@"RankGame", @"");
        NSString *Yes =NSLocalizedString(@"Yes", @"");
        NSString *No =NSLocalizedString(@"No", @"");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:RankGame delegate:self cancelButtonTitle:No otherButtonTitles:Yes, nil];
        [alertView setTag:1]; //设置 唯一key
        [alertView show];
        [alertView release];
    }
}



//星星购买 生命提示框结果回调
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // int tag= [alertView tag];
    if(buttonIndex == 1){//点击了确认
        [SOXDBUtil updateInfoByBool:G_KEY_IS_CLICK_RANK :true ];//更新为点击过评论
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:G_KEY_SOX_RUNTWO_URL]];
    }
}


- (NSMutableDictionary*)updateDBScoreInfo
{
    
    HeroInfo *heroInfo = [GameHelper getHeroInfo];
    if (heroInfo != nil){
        double doubleTotalDistance = [heroInfo totalDistance];
        double doubleStarCnt = [heroInfo starCnt];
        double doubleScore = [SOXUtil floatToInt:doubleTotalDistance]   + doubleStarCnt *4 ;  //公式 分数=距离 + 星星*3
        //更新最新 星星数量
        //先查出原来的 星星数量  + 当前得分的星星数量
        double dbStarCnt =[SOXDBGameUtil loadNowStar];
        double lastStarCnt = doubleStarCnt + dbStarCnt;
        [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:lastStarCnt]];
        SOXGameCenterUtil *gameCenterUtil = [SOXGameCenterUtil sharedSOXGameCenterUtil];
        //更新最高距离
        bool isNeedUpdate = [SOXDBUtil chkIsNeedUpdateByDouble:G_KEY_LEADERBOARD_DISTANCE : doubleTotalDistance];
        if(isNeedUpdate){
            [SOXDBUtil updateInfoByDouble:G_KEY_LEADERBOARD_DISTANCE : doubleTotalDistance];//更新最新本地 距离
            [gameCenterUtil submitLeaderboardScore:doubleTotalDistance :G_KEY_LEADERBOARD_DISTANCE];//更新最新gamecenter 距离
        }
        //更新最高分数
        bool isNeedUpdate2 = [SOXDBUtil chkIsNeedUpdateByDouble:G_KEY_LEADERBOARD_SCORE : doubleScore];
        if(isNeedUpdate2){
            [SOXDBUtil updateInfoByDouble:G_KEY_LEADERBOARD_SCORE : doubleScore];//更新最新本地 分数
            [gameCenterUtil submitLeaderboardScore:doubleScore :G_KEY_LEADERBOARD_SCORE];//更新最新gamecenter 分数
        }
        //更新最高总数星星
        bool isNeedUpdate3 = [SOXDBUtil chkIsNeedUpdateByDouble:G_KEY_LEADERBOARD_STAR : doubleStarCnt];
        if(isNeedUpdate3){
            [SOXDBUtil updateInfoByDouble:G_KEY_LEADERBOARD_STAR : doubleStarCnt];//更新最新本地 距离
            [gameCenterUtil submitLeaderboardScore:doubleStarCnt :G_KEY_LEADERBOARD_STAR];//更新最新gamecenter 距离
        }
        //还原生命数量 为 原始数量
       // [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :[SOXUtil intToString:G_LIFE_CNT_DEF]];
        
        //重新更新所有成就
        [gameCenterUtil calAchieveAll];
         NSMutableDictionary *scoreMapDict = [[[NSMutableDictionary alloc] initWithCapacity:3]autorelease];
        [scoreMapDict setObject:[SOXUtil doubleToString:doubleTotalDistance] forKey:@"TotalDistance"];
        [scoreMapDict setObject:[SOXUtil doubleToString:doubleStarCnt] forKey:@"StarCnt"];
        [scoreMapDict setObject:[SOXUtil doubleToString:doubleScore] forKey:@"Score"];
        return scoreMapDict;
    }
    return nil;
    
}


- (void)showLayer
{
    
   
    double doubleDistance = 0;
    double doubleStar = 0;
    double doubleScore = 0;
    
   NSMutableDictionary *map =  [self updateDBScoreInfo];
    if(map!=nil){
       NSString *strTotalDistanceDB = (NSString*)[map objectForKey:@"TotalDistance"];
       NSString *strStarCntDB = (NSString*)[map objectForKey:@"StarCnt"];
       NSString *strScoreDB = (NSString*) [map objectForKey:@"Score"];
        if(![SOXUtil isNotNull:strTotalDistanceDB]) {
            strTotalDistanceDB = @"0";
        }
        
        if(![SOXUtil isNotNull:strStarCntDB]) {
            strStarCntDB = @"0";
        }
        if(![SOXUtil isNotNull:strScoreDB]) {
            strScoreDB = @"0";
        }
          doubleDistance=[strTotalDistanceDB doubleValue] ;
          doubleStar=[strStarCntDB doubleValue] ;
          doubleScore=[strScoreDB doubleValue] ;
    }
    
    NSString *strTotalDistance = [SOXUtil notRounding:doubleDistance afterPoint:0];
    NSString *strStarCnt = [SOXUtil notRounding:doubleStar afterPoint:0];
    NSString *strScore = [SOXUtil notRounding:doubleScore afterPoint:0];
    if(strScore.length >= 9){
        [labelNowScore_ setFontSize:getRS(30)];
    }
    if(strStarCnt.length >= 8){
        [labelNowStar_ setFontSize:getRS(18)];
    }
    if(strTotalDistance.length >= 8){
        [labelNowDistance_ setFontSize:getRS(18)];
    }
    
    [labelNowScore_ setString:strScore];
    [labelNowDistance_ setString:strTotalDistance];
    [labelNowStar_ setString:strStarCnt];
    
    [labelNowScore_ setAnchorPoint:ccp(0, 0.5)];
    [labelNowStar_ setAnchorPoint:ccp(0, 0.5)];
    [labelNowDistance_ setAnchorPoint:ccp(0, 0.5)];
    
    //更新分享的 分数
     [SOXSoundUtil play_score];
    [self setVisible:true];
    //暂停画面
    [[CCDirector sharedDirector] pause];
    [menu_ setTouchEnabled:true];
    //检查是否 弹出提示
    [self chkAndShowRank];
    
    
}
- (void)hiddenLayer
{
    [self setVisible:false];
    [menu_ setTouchEnabled:false];
}

//重新开始
- (void)toAgain:(id) sender
{
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
	[[CCDirector sharedDirector] replaceScene:newScene];
} 
//重新开始
- (void)toShare:(id) sender
{ 
    [SOXSoundUtil play_button];
    
    //屏蔽 广告 
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    
    //初始化 分享界面
   /*
    menu_.visible = false; 
    shareInfo_.visible = true;
    menuBack_.visible =true;
    [menu_ setTouchEnabled:false];
    [shareInfo_ setTouchEnabled:true];
    [menuBack_ setTouchEnabled:true]; */
    
    
    double  score = [[labelNowScore_ string ]doubleValue] ;
    NSString *shareContent =NSLocalizedString(@"shareContent", @"");
    if( score<=0){
        
    }else{
        NSString *shareScoreContent =NSLocalizedString(@"shareScoreContent", @"");
        NSString *shareScoreContentBy =NSLocalizedString(@"shareScoreContentBy", @"");
        NSString *strScore =[SOXUtil notRounding:score afterPoint:0];
        shareContent = [NSString  stringWithFormat:@"%@ %@ %@!",shareScoreContent,strScore,shareScoreContentBy];
    }
    UIImage *image= [SOXGameUtil makeaShot];
    [ShareManager showShareComponentWithText:shareContent image:image urlString:G_KEY_SOX_RUNTWO_URL];
    
}

//返回 
- (void)toBack:(id) sender
{
    [SOXSoundUtil play_button];
    //还原 广告 
    [[SOXGameUtil getBaseRootView] showGAD]; 
    menu_.visible = true;
    menuBack_.visible =false;
    [menu_ setTouchEnabled:true];
    [menuBack_ setTouchEnabled:false];
}

//返回主菜单
- (void)toMenu:(id) sender
{
     [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
	[[CCDirector sharedDirector] replaceScene:newScene]; 
} 

@end
