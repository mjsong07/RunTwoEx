//
//  GameLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "GameLayer.h"
#import "Hero.h"
#import "InputLayer.h"  
#import "HeroInfo.h"
#import "BumpInfo.h" 
#import "ThingLayer.h"
#import "BGLayer.h"
#import "ADLayer.h"
#import "BgTmxLayer.h"
#import "PausedLayer.h"
#import "ScoreLayer.h"   
#import "GADBannerView.h" 
#import "GameLayerInfo.h"
#import "SaveMeProgressLayer.h"
#import "ThingCharTop.h" 
@implementation GameLayer {
   
}
+ (id)scene
{
	CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_GAME_LAYER];
    //加载所有图片信息
    //先初始化 缓存 下面新建得 才能通过全局静态访问
    //instanceOfThingCache = [ThingCache objInit];
    //instanceOfThingCacheNotMove = [ThingCache objInit];
    //重置游戏 难度
    [SOXConfig resetAll];
    
    BGLayer *bgLayer = [BGLayer node];//底背景
    ThingLayer *thingLayer = [ThingLayer objInit];//障碍物  依赖地图生成 
    
    ADLayer *adBeforeLayer = [ADLayer objInit:T_LAYER_BG_AD_BEFORE :9];  //前端 广告背景
    ADLayer *adAfterLayer = [ADLayer objInit:T_LAYER_BG_AD_AFTER :9];
    GameLayer *gameLayer = [GameLayer node]; 
    InputLayer *inputLayer = [InputLayer node];
    
    [scene addChild: gameLayer z:1];
//	[scene addChild: inputLayer z:1];
    
    CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    [scene addChild: bgcolor z:-1];
    PausedLayer *pausedLayer = [PausedLayer node];
    ScoreLayer *scoreLayer = [ScoreLayer node];
    
   // [gameLayer addChild:bgcolor z:-10];//底色
    [gameLayer addChild:bgLayer z:-1  tag:T_LAYER_BG];//底背景
   
    [gameLayer addChild:thingLayer z:2  tag: T_LAYER_THING];//障碍物
    
    
    
    ThingCharTop *charTop= [[ThingCharTop alloc ]initBase];
    [gameLayer addChild:charTop z:12 tag:T_LAYER_CHARTOP];
    
    BgTmxLayer *bgTmxLayer = [BgTmxLayer sharedBgTmxLayer]; //地图背景
    
    [bgTmxLayer reset];
    
    [gameLayer addChild:bgTmxLayer z:0 tag:T_LAYER_BG_TMX];//地图
    
    [gameLayer addChild:adAfterLayer z:-3  tag: T_LAYER_BG_AD_AFTER];//广告
    [gameLayer addChild:adBeforeLayer z:11  tag: T_LAYER_BG_AD_BEFORE];//广告
    
    [gameLayer addChild:pausedLayer z:20  tag: T_LAYER_PAUSED];//暂停
    [gameLayer addChild:scoreLayer z:21  tag: T_LAYER_SCORE];//游戏结束  显示分数层
    [gameLayer addChild:inputLayer z:22 tag:T_LAYER_INPUT ];//游戏按钮
    
    [pausedLayer setVisible:false];//默认隐藏
    [scoreLayer setVisible:false];//默认隐藏 
    //把 notMove 添加到 scene 里面 防止 被系统清理
  //  [scene addChild: [SOXObjCacheUtil sharedThingCacheNotMove] z:0  tag: T_OBJ_THING_CACHE_NO_MOVE];
    //由于 动态创建得 障碍物  必须 跟着地图 移动 所以 需要 添加再 地图上 
    [thingLayer addChild:[SOXObjCacheUtil sharedThingCache] z:23 tag:100]; 
    [SOXSoundUtil play_GameBackgroundMusic];
     
    return scene;
}

//初始化 所有动作
- (void)initHeroInfo
{
    HeroInfo *info= [HeroInfo herInfoInit ]; 
    [self addChild:info z:12 tag:T_OBJ_HERO_INFO];
    info.position= ccp(0,G_SCREEN_SIZE.height-   G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP );
    info.anchorPoint = ccp(0,0);
}
//初始化 游戏中信息 主要用于测试
- (void)initGameLayerInfo
{
    GameLayerInfo *info= [GameLayerInfo gameLayerInfoInit ];
    [self addChild:info z:12 tag:T_OBJ_GAME_LAYER_INFO];
    info.position= ccp(0,G_SCREEN_SIZE.height- G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP);
    info.anchorPoint = ccp(0,0);
}


//初始化 游戏文字
- (void)initThingCharTop:(NSString*)newStrChar
{
    ThingCharTop *charTop = (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    charTop.visible =true;
    [charTop initAll:newStrChar];
   float centerX = [charTop getCenterPosition].x;
    CGPoint  afterPoint=ccp(centerX, getRS(200));//y 不变换
    CGPoint beforePoint= ccp(G_SCREEN_SIZE.width, getRS(200) );
    charTop.position =beforePoint;
     [charTop runAction: [CCEaseElasticOut actionWithAction:  [CCMoveTo actionWithDuration:2 position:afterPoint]  period: 0.35f]];
}

//更新 游戏文字
- (void)updateThingCharTop
{
    ThingCharTop *charTop = (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
   [charTop updateByStrVal];
}
- (void)successThingCharTop
{
    [SOXDBUtil saveInfo:G_KEY_BMX_IS_RUNNING_CHAR :G_STR_NO];
    ThingCharTop *charTop = (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    [charTop success];
}
- (void)failThingCharTop
{
    [SOXDBUtil saveInfo:G_KEY_BMX_IS_RUNNING_CHAR :G_STR_NO];
    ThingCharTop *charTop = (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    [charTop fail];
}


- (id)init
{
    if(self = [super init]){
        //初始化 背景
        //打开定时调度  定时刷新人物的坐标 
       // self.TouchEnabled = YES;
        instanceOfGameScene = self;
        [self initHero];
        [self initMenu];
        [self initHeroInfo];
        
        if(G_DEBUG_ENABLE == 1){
            if([SOXConfig getTestShowGameLayerInfoView] == TRUE){
                [self initGameLayerInfo];
            }
        }
        [self initBumpBox];
        
        [self scheduleUpdate];
    }
    return self;
}
//初始化 碰撞4个 box
- (void)initBumpBox
{
     bumpTop=[[BumpInfo objInit]retain];
    bumpBody=[[BumpInfo objInit]retain];
    bumpBottom=[[BumpInfo objInit]retain];
}
//初始化  人物
- (void)initHero
{
    hero_= [Hero sharedHero];
    
    [hero_ initCreate];
    
    [hero_ run];
    hero_.position =hero_.createPosion;
    [self addChild:hero_ z:10 tag:T_OBJ_HERO];
    hero_.scaleX=1;
    hero_.scale = 0.9;
}

//初始化菜单
- (void)initMenu{ 
    CCSprite *pause = [CCSprite spriteWithFile:@"menu_pause.png" ]; 
    [pause setColor:ccSOX_BLUE]; 
    CCMenuItemSprite *itemPause =  [ CCMenuItemSprite itemWithNormalSprite:pause selectedSprite:nil
                                                                   target:self selector:@selector(toPause:) ]; 
    
    CCMenu *mn = [CCMenu menuWithItems:itemPause, nil];
    mn.position=CGPointZero; 
    itemPause.position=ccp(G_SCREEN_SIZE.width- getRS(25),G_SCREEN_SIZE.height- G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP);
    itemPause.scale = 0.9;
    [self addChild:mn z:10 tag:T_OBJ_MENU_PAUSED];
}
- (void)toMenu:(id) sender
{
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
	[[CCDirector sharedDirector] replaceScene:newScene];

}
- (void)toPause:(id) sender
{
    [SOXSoundUtil play_button];
    PausedLayer *pausedLayer= (PausedLayer*)[self getChildByTag:T_LAYER_PAUSED];
    
    if ([[CCDirector sharedDirector]isPaused]) {
        [[CCDirector sharedDirector]resume];
        [pausedLayer hiddenLayer];
    } else {
        [[CCDirector sharedDirector] pause];
        [pausedLayer showLayer];
    }  
}
//该方法 用于 外部调用
- (void)toExitPause:(id) sender
{  
    PausedLayer *pausedLayer= (PausedLayer*)[self getChildByTag:T_LAYER_PAUSED]; 
    [pausedLayer showLayer]; 
}



//检查人物是否 离开了屏幕
- (BOOL)chkHeroIsOutScreen
{
    int moreX = getRS(50);
    if(hero_.position.x + hero_.contentSize.width +moreX<0){
        return true;
    }
    return false;
}
//检查人物是否原来预定的位置
- (BOOL)chkHeroIsInOriPosition
{
    int oriX = hero_.runPosion.x;
    if(hero_.position.x >= oriX){
        return true;
    }
    return false;
}




//检查 更新  当前人物 的 状态 主要用于 障碍物 处理
- (void)updateHeroStatus
{
    Hero  *hero = [GameHelper getHero];
    [bumpBody initBumpByHero:CrashTypeBody  :hero  ];
//    //y  坐标 检查  下面
    [bumpBottom initBumpByHero:CrashTypeBottom   :hero  ];
    
    //特殊处理 如果 当前同时
//    if(bumpBody.isFloor == true && bumpBottom.isFloor == true){
//        bumpBottom.isFloor  = false;
//    }
    //是否下降
    bool isDrop = YES;
    bool isHurt = NO;
    bool isFrontDisorder = NO;//是否前面是障碍
    //如果当前不是滚动 才查询头部碰撞处理
        if (hero.nowActState == kActionStateJump) {
//            [bumpTop initBump:bgTmxlayer:hero.getBumpPointX_UP];
             [bumpTop initBumpByHero:CrashTypeTop  :hero  ];
            if (bumpTop.isFloor ) {
                  //  isHurt = YES;
                    isDrop = YES;
                    hero.jumpState = kJumpStateDown ;
                }
        }
        if (bumpBody.isFloor ) {
           // isHurt = YES;
            isFrontDisorder = YES;
        }
    //如果当前有障碍物  人物移动的 跟随 画面往左边移动
    if(isFrontDisorder == true){
        float subX = hero.position.x-  getRS([SOXConfig getNowMapMoveSpeed]) ;
        hero.position = ccp(subX, hero.position.y);
        if([self chkHeroIsOutScreen]){
            [hero updateHeroLifes:-1];
            
            if( hero.lifes<0){
               // [self showSaveMe];
                [self heroDeadAll];
                //显示分数
            }else{
                hero.position = ccp([hero_ contentSize].width+getRS(30), G_SCREEN_SIZE.height -getRS(30));//64+
                [hero again];
            }
            
            
            [self heroDeadAll];
            return ;
        }
    } 
    
    //是否碰击 到 障碍物
    if(isHurt){
        [self heroHurtAll];
        return ;
    }     //判断 人物是否 往下 降落
    if (bumpBottom.isFloor ) {
        isDrop=NO;
    }
    
    //没有障碍物  但又到了底边    如果 是跳越中 变奔跑
    if ( hero.position.y-hero.centerToBottom <= 0) {
        isDrop = NO; 
        //直接 固定 紧贴底边
        hero.position = ccp(hero.position.x, hero.centerToBottom- getRS(5));
    }
    
    
    //如果人物不在 原定的位置上面 加速往前冲
    if(hero_.nowActState == kActionStateRun || hero.nowActState == kActionStateScroll){
        if(isFrontDisorder != true){
            //如果当前在 原定位置 不往前移动
            if([self chkHeroIsInOriPosition]){
                
            }else{
                //往前移动
                float addX = hero.position.x + getRS([SOXConfig getNowMapMoveSpeed]/2) ;//[SOXConfig getNowMapMoveSpeed]
                hero.position = ccp(addX, hero.position.y);
            }
        }
    }
    
    
    
    
    //如果当前人物正在跳跃
    if (hero.nowActState == kActionStateJump && hero.jumpState == kJumpStateUp) {
        [hero rise];
        if(hero.nowRiseSpeed <=  0){// if(hero.nowRiseSpeed <=  0){  hero.nowRiseCnt>= G_RISE_CNT_MAX
            hero.jumpState = kJumpStateDown ;
         }
        //if(hero.nowRiseSpeed<=0){
        //    hero.jumpState = kJumpStateDown ;
       // }
    } else {
        //掉落
        if (isDrop) {
            if(hero.nowActState == kActionStateRun ||
               (hero.nowActState==kActionStateJump && hero.jumpState ==kJumpStateDown)
               || hero.nowActState==kActionStateHurt|| hero.nowActState==kActionStateScroll
               ){
                if(bumpBottom.isFloorNext==true ){ //如果下一帧的大于等于接触障碍  直接 固定下落的高度
                    float subVal = 0;
                    if(bumpBottom.isFloorNext==true && bumpBottom.nextPoint.y!=0){
                        subVal =hero.position.y-hero.centerToBottom-( (10*G_TILE_WIDTH)- (bumpBottom.nextPoint.y)*G_TILE_WIDTH) ;
                    }
                    if(subVal>=hero.nowDropSpeed || subVal<=0){
                        [hero drop];
                    }else{ 
                        [hero drop: subVal+5]; 
                    } 
                }else{
                 [hero drop];
                }
               
            }
            //掉落 碰撞到物体
        }else{
            
            //如果 当前是跳完到地面－－停止动画->变跑
             if (hero.nowActState == kActionStateJump) {
                if (hero.jumpState!=kJumpStateUp) {
                    [hero run];
                }
            }else{
                if (hero.dropState == kDropStateDown) { 
                    if(hero.nowActState==kActionStateHurt){
                    
                    }else{ 
                        [hero run];
                    }
                    
                }
            } 
        }
    } 
}




//更新 地图 上面  需要动态创建得 物体  和 敌人 根据 地图当前移动得x 坐标 范围
/*
- (void)updateBGAllThingAndEmeny
{
    CCTMXTiledMap *map = [self getBgTmxMap];  
    //如果到达某个临界值  则动态绘制制定范围得 物体和敌人
    if (map.position.x<-100 && map.position.x >- 103) {
        
    }
    if (autoCreateFlag_==false) {
        autoCreateFlag_ = true;
        [[self getThingLayer] showAllThingsByX:ccp( map.position.x*(-1)-100, 0) :100000];
    }
}*/

//判断人物 是否 碰撞 障碍
- (void)updateAutoShowOrHiddenThings
{
    Hero *hero = [GameHelper getHero];
    ThingCache *thingCache = [SOXObjCacheUtil sharedThingCache]; //[self getBgThingCache];
    CCTMXTiledMap *map = [GameHelper getBgTmxMap];
    [thingCache chkAllIsTouch :hero :map];
}

//英雄受伤得 处理
- (void)heroHurtAll
{
    Hero *hero = [GameHelper getHero];
    if(hero.powerState!=kPowerStatePerfect){
        [hero updateHeroLifes:-1];
        if( hero.lifes<0){
            //[self showSaveMe];
            [self heroDeadAll];
            //显示分数 
        }else{ 
            [hero hurt];   
        }
    }
}


- (void)showSaveMe
{
    // [[CCDirector sharedDirector] pause];
    SaveMeProgressLayer *saveMeProgree = [[[SaveMeProgressLayer alloc]init]autorelease];
    [self addChild:saveMeProgree z:30];
}


//购买成功  继续游戏
- (void)resumeGoOnGame
{
    //因此暂停按钮
    CCMenu *menu= (CCMenu*)[self getChildByTag:T_OBJ_MENU_PAUSED];
    [menu setVisible:true];
    Hero *hero = [GameHelper getHero];
    //从-1 变为 0 
//    hero.lifes++;
    hero.lifes = 0;
    
     hero.position = ccp([hero_ contentSize].width+getRS(30), G_SCREEN_SIZE.height -getRS(30));//64+
    [hero again];
    
    [[CCDirector sharedDirector] resume];
    [self resumeAllLayerAction];
}
 


//停止当前 所有 layer
- (void)stopAllLayerAction
{
    BGLayer *bglayer = [GameHelper getBGLayer];
    BgTmxLayer *bgTmxLayer = [GameHelper getBgTmxLayer];
    //已经死亡
    [bglayer stopAllActions];
    [bglayer unscheduleAllSelectors];
    ADLayer *adLayer = [GameHelper getAD_BeforeLayer];
    ADLayer *adBgLayer = [GameHelper getAD_AfterLayer];
    [bgTmxLayer unscheduleAllSelectors];
    [bgTmxLayer stopAllActions];
    [adLayer stopAllActions];
    [adLayer unscheduleAllSelectors];
    [adBgLayer stopAllActions];
    [adBgLayer unscheduleAllSelectors];
    
    [[GameHelper getHeroInfo] stopAllActions];
    [[GameHelper getHeroInfo] unscheduleAllSelectors];
    
    
    
    ThingCharTop *charTop=   (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    [charTop stopAllActions];
    [charTop unscheduleAllSelectors]; 
    
}


//停止当前 所有 layer
- (void)pauseAllLayerAction
{
    BGLayer *bglayer = [GameHelper getBGLayer];
    BgTmxLayer *bgTmxLayer = [GameHelper getBgTmxLayer];
    //已经死亡
    [bglayer pauseSchedulerAndActions];
    ADLayer *adLayer = [GameHelper getAD_BeforeLayer];
    ADLayer *adBgLayer = [GameHelper getAD_AfterLayer];
    [bgTmxLayer pauseSchedulerAndActions];
    [adLayer pauseSchedulerAndActions];
    [adBgLayer pauseSchedulerAndActions];
    [[GameHelper getHeroInfo] pauseSchedulerAndActions];
    
    ThingCharTop *charTop=   (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    [charTop pauseSchedulerAndActions];
    
}

//停止当前 所有 layer
- (void)resumeAllLayerAction
{
    BGLayer *bglayer = [GameHelper getBGLayer];
    BgTmxLayer *bgTmxLayer = [GameHelper getBgTmxLayer];
    //已经死亡
    [bglayer resumeSchedulerAndActions];
    ADLayer *adLayer = [GameHelper getAD_BeforeLayer];
    ADLayer *adBgLayer = [GameHelper getAD_AfterLayer];
    [bgTmxLayer resumeSchedulerAndActions];
    [adLayer resumeSchedulerAndActions];
    [adBgLayer resumeSchedulerAndActions];
    [[GameHelper getHeroInfo] resumeSchedulerAndActions];
    
    
    ThingCharTop *charTop=   (ThingCharTop*)[self getChildByTag:T_LAYER_CHARTOP];
    [charTop resumeSchedulerAndActions];
    
}



- (void)heroDeadAll
{
    /*
    BGLayer *bglayer = [self getBGLayer];
    BgTmxLayer *bgTmxLayer = [self getBgTmxLayer];   
    //已经死亡
    [bglayer stopAllActions];
    [bglayer unscheduleAllSelectors]; 
    ADLayer *adLayer = [self getAD_BeforeLayer];
    ADLayer *adBgLayer = [self getAD_AfterLayer];
    [bgTmxLayer unscheduleAllSelectors];
    [bgTmxLayer stopAllActions];
    [adLayer stopAllActions];
    [adLayer unscheduleAllSelectors];
    [adBgLayer stopAllActions];
    [adBgLayer unscheduleAllSelectors]; 
    
    [[self getHeroInfo] stopAllActions];
    [[self getHeroInfo] unscheduleAllSelectors];*/
    
    [self pauseAllLayerAction];
    [[GameHelper getHero] dead];
    //因此暂停按钮
    CCMenu *menu= (CCMenu*)[self getChildByTag:T_OBJ_MENU_PAUSED];
    [menu setVisible:false];
    //此处应该 显示 分数页面 由于需要等人物 死亡动画结束才调用
    //停止广告
}



- (void)update:(ccTime)delta
{
    //只有人物未死亡 才一直调用定时任务
    if(hero_.nowActState != kActionStateDead ){
        BgTmxLayer *bgTmxLayer = [GameHelper getBgTmxLayer];
        BGLayer *bgLayer = [GameHelper getBGLayer];
        ThingLayer *thingLayer = [GameHelper getThingLayer];
        InputLayer *inputLayer = (InputLayer*)[self getChildByTag:T_LAYER_INPUT];
        ADLayer *AdBeforeLayer = [GameHelper getAD_BeforeLayer];
        ADLayer *AdAfterLayer = [GameHelper getAD_AfterLayer];
        [AdBeforeLayer updateADLayer:delta];
        [AdAfterLayer updateADLayer:delta];
        [bgLayer updateBGLayer:delta]; 
        [bgTmxLayer updateTMX:delta];
        [thingLayer updateThing:delta];
        [inputLayer updateInput:delta];
        [self updateHeroStatus];
        [self updateAutoShowOrHiddenThings]; 
    }
}
static GameLayer* instanceOfGameScene;
+(GameLayer*) sharedGameLayer
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
} 
- (void)onEnter
{
	[super onEnter];
    //初始化 广告
    [[SOXGameUtil getBaseRootView]showGAD];
}

- (void)onExit
{
	//Completely remove the controller
	//[adController setDelegate:nil];
	//[adController release];
	//adController = nil;
	
	[super onExit];
}


-(void)dealloc{
     
    [[SOXGameUtil getBaseRootView]hiddenGAD];
    [bumpTop release];
    [bumpBody release];
    [bumpBottom release]; 
    [super dealloc];
}
 
#ifdef DEBUG

- (void)draw
{
     [super draw];
    Hero *hero=  [GameHelper getHero];
    if(hero!=nil){
        glLineWidth(3.0f);
        glColor4f(1, 0, 1, 1);
        CGRect heroRect=[SOXMapUtil spriteToRectByHero:hero];
         [SOXDebug drawRectFaster:[hero getBumpRectTop]];
       [SOXDebug drawRectFaster:[hero getBumpRectBody]];
       [SOXDebug drawRectFaster:[hero getBumpRectBottom]];
     //    [SOXDebug drawRectFaster:[hero getBumpRectScrollBody]];
     //    [SOXDebug drawRectFaster:[hero getBumpRectScrollBottom]];
//       [SOXDebug drawRectFaster:heroRect];
    }
}
#endif
 

@end
