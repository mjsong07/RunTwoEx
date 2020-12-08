//
//  测试页面
//  RunTwo
//
//  Created by mjsong on 13-10-8.
//
//

#import "MenuTestLayer.h" 
#import "Encryption.h"
#import "SOXEncryption.h"
#import "SaveMeProgressLayer.h"
#import "ThingChar.h"
#import "ThingCharTop.h"
#import "SOXUtil.h"
@implementation MenuTestLayer


+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuTestLayer *nowLayer = [MenuTestLayer node];
    [scene addChild:nowLayer];  
    return scene;
} 
- (id)init
{
    if (self = [super init]) {  
       
         [CCMenuItemFont setFontSize:getRS(25)];
        CCMenuItemFont *itemIndex = [CCMenuItemFont itemWithString:@"Index" target:self selector:@selector(callBack:)];
        
        
        CCMenuItemFont *itemTest = [CCMenuItemFont itemWithString:@"test" target:self selector:@selector(itemTest:)];
        
        
        CCMenuItemFont *itemIsDebug = [CCMenuItemFont itemWithString:@"+Debug" target:self selector:@selector(callIsDebug:)];
        
        CCMenuItemFont *itemIsNotDebug = [CCMenuItemFont itemWithString:@"-Debug" target:self selector:@selector(callIsNotDebug:)];
        
        
        CCMenuItemFont *itemIsShowInfo = [CCMenuItemFont itemWithString:@"+Show" target:self selector:@selector(callIsShowInfo:)];
        
        CCMenuItemFont *itemIsNotShowInfo = [CCMenuItemFont itemWithString:@"-Show" target:self selector:@selector(callIsNotShowInfo:)];
        
        
        
        CCMenuItemFont *itemAdd1 = [CCMenuItemFont itemWithString:@"+star" target:self selector:@selector(callAddStar:)];
      
        CCMenuItemFont *itemAdd11 = [CCMenuItemFont itemWithString:@"+maxStar" target:self selector:@selector(callAddMaxStar:)];
        
        CCMenuItemFont *itemAdd2 = [CCMenuItemFont itemWithString:@"+distance" target:self selector:@selector(callAddDistance:)];
        CCMenuItemFont *itemAdd3 = [CCMenuItemFont itemWithString:@"+score" target:self selector:@selector(callAddScore:)];
        
         
        CCMenuItemFont *itemClean1 = [CCMenuItemFont itemWithString:@"-lifeStar" target:self selector:@selector(callCleanStarAndLife:)];
        CCMenuItemFont *itemClean2 = [CCMenuItemFont itemWithString:@"-achieve" target:self selector:@selector(callCleanAchieve:)];
         CCMenuItemFont *itemClean3 = [CCMenuItemFont itemWithString:@"-scoreDistance" target:self selector:@selector(callCleanScoreDistance:)];
        CCMenu *menuIndex = [CCMenu menuWithItems: itemIndex, itemTest, nil];
        
        CCMenu *menuDebug = [CCMenu menuWithItems: itemIsDebug,itemIsNotDebug,nil];
        CCMenu *menuDebugGameLayerInfoShow = [CCMenu menuWithItems: itemIsShowInfo,itemIsNotShowInfo,nil];
        
        CCMenu *menuAdd = [CCMenu menuWithItems: itemAdd1,itemAdd11,itemAdd2,itemAdd3,nil];
        CCMenu *menuClean = [CCMenu menuWithItems: itemClean1,itemClean2,itemClean3,nil];
        [itemIndex setColor:ccSOX_BLUE];
        [itemTest setColor:ccSOX_PINK];
        [itemAdd1 setColor:ccSOX_BLUE];
        [itemAdd11 setColor:ccSOX_BLUE];
        [itemAdd2 setColor:ccSOX_BLUE];
        [itemAdd3 setColor:ccSOX_BLUE];
        [itemClean1 setColor:ccSOX_PINK];
        [itemClean2 setColor:ccSOX_PINK];
        [itemClean3 setColor:ccSOX_PINK];
        [itemIsDebug setColor:ccSOX_BLUE];
        [itemIsNotDebug setColor:ccSOX_PINK];
        [itemIsShowInfo setColor:ccSOX_BLUE];
        [itemIsNotShowInfo setColor:ccSOX_PINK];
        
        
        [menuAdd alignItemsHorizontally];
        [menuAdd alignItemsHorizontallyWithPadding:4 ];
        [menuClean alignItemsHorizontally];
        [menuClean alignItemsHorizontallyWithPadding:4 ];
        
        
        
        
        
        [menuIndex alignItemsHorizontally];
        [menuIndex alignItemsHorizontallyWithPadding:5 ];
        
        [menuDebug alignItemsHorizontally];
        [menuDebug alignItemsHorizontallyWithPadding:5 ];
        [menuDebugGameLayerInfoShow alignItemsHorizontally];
        [menuDebugGameLayerInfoShow alignItemsHorizontallyWithPadding:5 ];
      
        
        CCMenuItemFont *E0 = [CCMenuItemFont itemWithString:@"E0" target:self selector:@selector(E0:)];
        CCMenuItemFont *E1 = [CCMenuItemFont itemWithString:@"E1" target:self selector:@selector(E1:)];
        CCMenuItemFont *E2 = [CCMenuItemFont itemWithString:@"E2" target:self selector:@selector(E2:)];
        CCMenuItemFont *E3 = [CCMenuItemFont itemWithString:@"E3" target:self selector:@selector(E3:)];
        CCMenuItemFont *N1 = [CCMenuItemFont itemWithString:@"N1" target:self selector:@selector(N1:)];
        CCMenuItemFont *N2 = [CCMenuItemFont itemWithString:@"N2" target:self selector:@selector(N2:)];
        CCMenuItemFont *N3 = [CCMenuItemFont itemWithString:@"N3" target:self selector:@selector(N3:)];
        
        
        
        CCMenuItemFont *H1 = [CCMenuItemFont itemWithString:@"H1" target:self selector:@selector(H1:)];
        CCMenuItemFont *H2 = [CCMenuItemFont itemWithString:@"H2" target:self selector:@selector(H2:)];
        CCMenuItemFont *H3 = [CCMenuItemFont itemWithString:@"H3" target:self selector:@selector(H3:)];
        
        CCMenuItemFont *FAST1 = [CCMenuItemFont itemWithString:@"F1" target:self selector:@selector(FAST1:)];
       
        CCMenuItemFont *FAST2 = [CCMenuItemFont itemWithString:@"F2" target:self selector:@selector(FAST2:)];
        
        [E0 setColor:ccSOX_BLUE];
        [E1 setColor:ccSOX_BLUE];
        [E2 setColor:ccSOX_BLUE];
        [E3 setColor:ccSOX_BLUE];
        
        [N1 setColor:ccSOX_PINK];
        [N2 setColor:ccSOX_PINK];
        [N3 setColor:ccSOX_PINK];
        
        [H1 setColor:ccSOX_PINK];
        [H2 setColor:ccSOX_PINK];
        [H3 setColor:ccSOX_PINK];
        
        [FAST1 setColor:ccSOX_PINK];
        
        [FAST2 setColor:ccSOX_PINK];
        
        CCMenu *menuSp = [CCMenu menuWithItems: E0,E1,E2,E3,N1,N2,N3,H1,H2,H3,FAST1,FAST2,nil];
        [menuSp alignItemsHorizontally];
        [menuSp alignItemsHorizontallyWithPadding:5 ];
       
        CCMenuItemFont *speed4 = [CCMenuItemFont itemWithString:@"S4" target:self selector:@selector(testSpeed4:)];
        CCMenuItemFont *speed5 = [CCMenuItemFont itemWithString:@"S5" target:self selector:@selector(testSpeed5:)];
        CCMenuItemFont *speed6 = [CCMenuItemFont itemWithString:@"S6" target:self selector:@selector(testSpeed6:)];
        CCMenuItemFont *speed7 = [CCMenuItemFont itemWithString:@"S7" target:self selector:@selector(testSpeed7:)];
         
        [speed4 setColor:ccSOX_BLUE];
        [speed5 setColor:ccSOX_BLUE];
        [speed6 setColor:ccSOX_BLUE];
        [speed7 setColor:ccSOX_PINK];
        
        CCMenu *menuSpeed = [CCMenu menuWithItems: speed4,speed5,speed6,speed7,nil];
        [menuSpeed alignItemsHorizontally];
        [menuSpeed alignItemsHorizontallyWithPadding:5 ];
        
        [menuIndex setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height/2 +getRS(70)) ];
        [menuAdd setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height/2+getRS(40) ) ];
        [menuClean setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height/2+getRS(10) ) ];
        [menuSp  setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height/2-getRS(20) ) ];
        [menuSpeed setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height/2-getRS(50) ) ];
        [menuDebug setPosition:ccp(G_SCREEN_SIZE.width/2 - getRS(100),G_SCREEN_SIZE.height/2-getRS(70) ) ];
        [menuDebugGameLayerInfoShow setPosition:ccp(G_SCREEN_SIZE.width/2+getRS(100),G_SCREEN_SIZE.height/2-getRS(70) ) ];

        
        [self addChild:menuIndex];
        [self addChild: menuAdd z:1 tag:2 ];
        [self addChild: menuClean z:1 tag:2 ];
         [self addChild: menuDebug z:1 tag:2 ];
        [self addChild: menuSp z:1 tag:2 ];
        [self addChild: menuSpeed z:1 tag:2 ];
        [self addChild:menuDebugGameLayerInfoShow];
        
    } 
    return self;
}
- (void)E0:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_EASY0];
    [SOXConfig setNowMapRunTimes:G_TIMES_EASY0];
}
- (void)E1:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_EASY1];
    [SOXConfig setNowMapRunTimes:G_TIMES_EASY1];
}
- (void)E2:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_EASY2];
    [SOXConfig setNowMapRunTimes:G_TIMES_EASY2];
}

- (void)E3:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_EASY3];
    [SOXConfig setNowMapRunTimes:G_TIMES_EASY3];
}


- (void)N1:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_NORMAL1];
    [SOXConfig setNowMapRunTimes:G_TIMES_NORMAL1];
}

- (void)N2:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_NORMAL2];
    [SOXConfig setNowMapRunTimes:G_TIMES_NORMAL2];
}

- (void)N3:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_NORMAL3];
    [SOXConfig setNowMapRunTimes:G_TIMES_NORMAL3];
}

- (void)H1:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_HARD1];
    [SOXConfig setNowMapRunTimes:G_TIMES_HARD1];
}

- (void)H2:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_HARD2];
    [SOXConfig setNowMapRunTimes:G_TIMES_HARD2];
}
- (void)H3:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_HARD3];
    [SOXConfig setNowMapRunTimes:G_TIMES_HARD3];
}

- (void)FAST1:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_NORMAL_COMMON_FAST];
    [SOXConfig setNowMapRunTimes:G_TIMES_NORMAL_COMMON_FAST];
}

- (void)FAST2:(id) sender
{
    [SOXConfig setNowGameLevel:T_LEVEL_HARD_COMMON_FAST];
    [SOXConfig setNowMapRunTimes:G_TIMES_HARD_COMMON_FAST];
}


- (void)callIsDebug:(id) sender
{
    [SOXDBUtil saveInfo:G_KEY_IS_DEBUG :@"1"];
}
- (void)callIsNotDebug:(id) sender
{
   [SOXDBUtil saveInfo:G_KEY_IS_DEBUG :@"0"];
}

- (void)callIsShowInfo:(id) sender
{
    [SOXConfig setTestShowGameLayerInfoView:TRUE];
}
- (void)callIsNotShowInfo:(id) sender
{
    [SOXConfig setTestShowGameLayerInfoView:FALSE];
}


- (void)testSpeed4:(id) sender
{
    [SOXConfig setTestSpeed: 4]; 
}
- (void)testSpeed5:(id) sender
{
    [SOXConfig setTestSpeed: 5];
}
- (void)testSpeed6:(id) sender
{
  [SOXConfig setTestSpeed: 6];
}

- (void)testSpeed7:(id) sender
{
    [SOXConfig setTestSpeed: 7];
}




- (void)callBack:(id) sender
{
    
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

- (void)itemTest:(id) sender
{
    /*
    NSArray *array = [G_KEY_THING_CHAR_EASY componentsSeparatedByString:@";"];
    
    int randomI = rand()%array.count;
     NSString *nowStrChar  = array[randomI];
    NSString *newStrChar =[SOXUtil createRandomCharList:nowStrChar :10];
    */
    //SONY   10 SOOYDNY
    
    //根据当前可以生产的 所有 box  生产 新的字符串
    //前提 原始的符串 必须要保证按顺序
     
}

 


- (void)refresh 
{
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_TEST];
    [[CCDirector sharedDirector] replaceScene:newScene];
}
- (void)callAddStar:(id) sender
{
    double stars = [SOXDBGameUtil loadNowStar];
    stars = stars+1000;
    [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:stars]];
    [self refresh];
}
- (void)callAddMaxStar:(id) sender
{
    double stars = [SOXDBGameUtil loadBestStar];
    stars = stars+1000;
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_STAR :[SOXUtil doubleToString:stars]];
    [self refresh]; 
}

- (void)callAddScore:(id) sender
{
    double score = [SOXDBGameUtil loadBestScore];
    score = score+1000;
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_SCORE :[SOXUtil doubleToString:score]];
    [self refresh];
}
- (void)callAddDistance:(id) sender
{
    double distance = [SOXDBGameUtil loadBestDistance];
    distance = distance+1000;
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_DISTANCE :[SOXUtil doubleToString:distance]];
    [self refresh];
}


- (void)callCleanStarAndLife:(id) sender
{
     [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :@"0"];
     [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :@"1"];
    
     [self refresh];
}
//清空排行榜
- (void)callCleanScoreDistance:(id) sender
{ 
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_SCORE :@"0"];
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_DISTANCE :@"0"];
    [SOXDBUtil saveInfo:G_KEY_LEADERBOARD_STAR :@"0"];
    [self refresh];
}


//清空成就
- (void)callCleanAchieve:(id) sender
{ 
    [self cleanAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L1];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L2];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L3];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_DISTANCE_L4];
    
    [self cleanAchieve:G_KEY_ACHIEVEMENT_LIFE_L1];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_LIFE_L2];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_LIFE_L3];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_LIFE_L4];
    
    
    [self cleanAchieve:G_KEY_ACHIEVEMENT_SCORE_L1];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_SCORE_L2];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_SCORE_L3];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_SCORE_L4];
    
    
    [self cleanAchieve:G_KEY_ACHIEVEMENT_STAR_L1];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_STAR_L2];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_STAR_L3];
    [self cleanAchieve:G_KEY_ACHIEVEMENT_STAR_L4]; 
    
    SOXGameCenterUtil *gameCenterUtil = [SOXGameCenterUtil sharedSOXGameCenterUtil];
    [gameCenterUtil resetAchievements];
    
    [self refresh];
}

- (void)cleanAchieve:(NSString*)achieveKey
{
    NSString *keyFlag= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_FLAG];
    NSString *keyVal= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_NOWVAL]; 
    
    NSString *keyWebFlag= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_WEB_FLAG];
    NSString *keyWebVal= [ NSString stringWithFormat:@"%@%@",achieveKey,G_KEY_ACHIEVEMENT_WEB_NOWVAL];
    
    [SOXDBUtil saveInfo:keyFlag :G_STR_NO];
    [SOXDBUtil saveInfo:keyVal :[SOXUtil doubleToString:0.0]];
    
    [SOXDBUtil saveInfo:keyWebFlag :G_STR_NO];
    [SOXDBUtil saveInfo:keyWebVal :[SOXUtil doubleToString:0.0]];
}


@end
