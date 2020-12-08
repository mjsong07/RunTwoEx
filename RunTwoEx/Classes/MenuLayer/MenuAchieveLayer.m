//
//  GameSettingLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//

#import "MenuAchieveLayer.h" 
#import "GameCenterManager.h" 
#import "MenuAchieveInfo.h"
#import "AchieveInfo.h"
@implementation MenuAchieveLayer

+(id)scene
{
    //重新计算成就
   // [SOXGameCenterUtil calAchieveAll];
    SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
  //  [gameCenterUtil chkUserIsLoad]; //检测用户登录    由于登录 已调用 这个 屏蔽
    [gameCenterUtil loadNowAllAchievements];//加载当前所有成就 
    [gameCenterUtil calAchieveAll];  
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuAchieveLayer *nowLayer = [MenuAchieveLayer node]; 
    [scene addChild:nowLayer];
    return scene;
}
- (id)init
{
    if (self = [super init]) {
        self.touchEnabled = false;
        [super setLinePinkPostion: getRS(-45)];
        CCSprite *level1 =   [CCSprite spriteWithFile:@"achieve_level1.png"];
        CCSprite *level2 =   [CCSprite spriteWithFile:@"achieve_level2.png"];
        CCSprite *level3 =   [CCSprite spriteWithFile:@"achieve_level3.png"];
        CCSprite *level4 =   [CCSprite spriteWithFile:@"achieve_level4.png"];
        
        level1.color = ccSOX_BLUE;
        level2.color = ccSOX_BLUE;
        level3.color = ccSOX_BLUE;
        level4.color = ccSOX_BLUE;
        
        CCSprite *level1Sel =   [CCSprite spriteWithFile:@"achieve_level1.png"];
        CCSprite *level2Sel =   [CCSprite spriteWithFile:@"achieve_level2.png"];
        CCSprite *level3Sel =   [CCSprite spriteWithFile:@"achieve_level3.png"];
        CCSprite *level4Sel =   [CCSprite spriteWithFile:@"achieve_level4.png"];
        
        level1Sel.color = ccSOX_PINK;
        level2Sel.color = ccSOX_PINK;
        level3Sel.color = ccSOX_PINK;
        level4Sel.color = ccSOX_PINK;
        
        CCMenuItemSprite *itemlevel1  =  [ CCMenuItemSprite itemWithNormalSprite:level1 selectedSprite:nil
                                                                         target:nil selector:nil ];
        
        CCMenuItemSprite *itemlevel1Sel  =  [ CCMenuItemSprite itemWithNormalSprite:level1Sel selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        CCMenuItemSprite *itemlevel2  =  [ CCMenuItemSprite itemWithNormalSprite:level2 selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        CCMenuItemSprite *itemlevel2Sel  =  [ CCMenuItemSprite itemWithNormalSprite:level2Sel selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        CCMenuItemSprite *itemlevel3  =  [ CCMenuItemSprite itemWithNormalSprite:level3 selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        CCMenuItemSprite *itemlevel3Sel  =  [ CCMenuItemSprite itemWithNormalSprite:level3Sel selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        
        CCMenuItemSprite *itemlevel4  =  [ CCMenuItemSprite itemWithNormalSprite:level4 selectedSprite:nil
                                                                          target:nil selector:nil ];
        
        
        CCMenuItemSprite *itemlevel4Sel  =  [ CCMenuItemSprite itemWithNormalSprite:level4Sel selectedSprite:nil
                                                                          target:nil selector:nil ];
      
        
        
        itemTogglelevel1_ = [CCMenuItemToggle itemWithTarget:self selector:@selector(toLevel1:) items:
                                             itemlevel1,
                                             itemlevel1Sel,
                                             nil];
        
        itemTogglelevel2_ = [CCMenuItemToggle itemWithTarget:self selector:@selector(toLevel2:) items:
                                              itemlevel2,
                                              itemlevel2Sel,
                                              nil];
        
        itemTogglelevel3_ = [CCMenuItemToggle itemWithTarget:self selector:@selector(toLevel3:) items:
                                              itemlevel3,
                                              itemlevel3Sel,
                                              nil];
        
        itemTogglelevel4_ = [CCMenuItemToggle itemWithTarget:self selector:@selector(toLevel4:) items:
                                              itemlevel4,
                                              itemlevel4Sel,
                                              nil];

        
         
        
          CCMenu *menuLevel = [CCMenu menuWithItems: itemTogglelevel1_,itemTogglelevel2_, itemTogglelevel3_, itemTogglelevel4_ ,nil];
        
       // menuLevel.scale = 1.1;
        [menuLevel alignItemsHorizontally];
        [menuLevel alignItemsHorizontallyWithPadding:14];
        
        menuLevel.scale = 0.9;
        achieveInfoL1_ =[[[MenuAchieveInfo alloc]init:AchieveLevel1]autorelease];
        achieveInfoL2_ =[[[MenuAchieveInfo alloc]init:AchieveLevel2]autorelease];
        achieveInfoL3_ =[[[MenuAchieveInfo alloc]init:AchieveLevel3]autorelease];
        achieveInfoL4_ =[[[MenuAchieveInfo alloc]init:AchieveLevel4]autorelease];
        //int marginTop = 5;
         menuLevel.position =ccp(G_SCREEN_SIZE.width/2- getRS(22) , G_SCREEN_SIZE.height/2+getRS(20));
        CGPoint commonTop =  ccp(G_SCREEN_SIZE.width/2 , G_SCREEN_SIZE.height/2-getRS(110));
        achieveInfoL1_.position = commonTop;//ccp(commonTop.x , commonTop.y);
        achieveInfoL2_.position = commonTop;
        achieveInfoL3_.position = commonTop;
        achieveInfoL4_.position = commonTop; 
        
        [self toLevel1Single];
        
         MenuNavInfo *backNav = [[[MenuNavInfo alloc]init:T_SCENE_SCORE]autorelease];
        [self addChild: backNav];
        [self addChild: menuLevel];
        [self addChild: achieveInfoL1_];
        [self addChild: achieveInfoL2_];
        [self addChild: achieveInfoL3_];
        [self addChild: achieveInfoL4_];
        
    } 
    return self;
}



- (void)toLevel1Single
{ 
    achieveInfoL1_.visible = true;
    achieveInfoL2_.visible = false;
    achieveInfoL3_.visible = false;
    achieveInfoL4_.visible = false;
    [itemTogglelevel1_ setSelectedIndex:1];
    [itemTogglelevel2_ setSelectedIndex:0];
    [itemTogglelevel3_ setSelectedIndex:0];
    [itemTogglelevel4_ setSelectedIndex:0];
    
    SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil]; 
    [gameCenterUtil synWebAchieveAll:1];//同步当前本地的成就 到 web 
    
}

- (void)toLevel1:(id) sender
{
    [SOXSoundUtil play_button];
    [self toLevel1Single];
}
- (void)toLevel2:(id) sender
{
    [SOXSoundUtil play_button];
    achieveInfoL1_.visible = false;
    achieveInfoL2_.visible = true;
    achieveInfoL3_.visible = false;
    achieveInfoL4_.visible = false;
    [itemTogglelevel1_ setSelectedIndex:0];
    [itemTogglelevel2_ setSelectedIndex:1];
    [itemTogglelevel3_ setSelectedIndex:0];
    [itemTogglelevel4_ setSelectedIndex:0];
    SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
    [gameCenterUtil synWebAchieveAll:2];//同步当前本地的成就 到 web
}
- (void)toLevel3:(id) sender
{ 
    [SOXSoundUtil play_button];
    achieveInfoL1_.visible = false;
    achieveInfoL2_.visible = false;
    achieveInfoL3_.visible = true;
    achieveInfoL4_.visible = false;
    [itemTogglelevel1_ setSelectedIndex:0];
    [itemTogglelevel2_ setSelectedIndex:0];
    [itemTogglelevel3_ setSelectedIndex:1];
    [itemTogglelevel4_ setSelectedIndex:0];
    
    SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
    [gameCenterUtil synWebAchieveAll:3];//同步当前本地的成就 到 web
}
- (void)toLevel4:(id) sender
{ 
    [SOXSoundUtil play_button];
    achieveInfoL1_.visible = false;
    achieveInfoL2_.visible = false;
    achieveInfoL3_.visible = false;
    achieveInfoL4_.visible = true;
    [itemTogglelevel1_ setSelectedIndex:0];
    [itemTogglelevel2_ setSelectedIndex:0];
    [itemTogglelevel3_ setSelectedIndex:0];
    [itemTogglelevel4_ setSelectedIndex:1];
    
    SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
    [gameCenterUtil synWebAchieveAll:4];//同步当前本地的成就 到 web

}
@end
