 
#import "Hero.h"
#import "CCAnimationHelper.h" 
#import "HeroInfo.h"
#import "GameLayer.h" 

#import "ScoreLayer.h"
@implementation Hero {
    
    int lastActionState;
    
}


static Hero* hero;
+(Hero*) sharedHero
{
    if(hero == nil){
        hero = [Hero objInit];
    }
	return hero;
}


+ (id)objInit
{ 
    Hero *sprite = [[self alloc] initWithImage];
    [sprite setColor:ccSOX_BLUE];//默认初始化为  蓝色
    [sprite initWithHeroAction];
    [sprite initBumpBox];
	return [sprite autorelease]; 
}
//只初始化图片动画  图片统一用 白底色 方便 调用setColor动态设置颜色
- (id)initWithImage
{ 
    if ((self = [super initWithSpriteFrameName:@"run_1.png"])) { 
        //默认的
        CCAnimation *defAnimation1 = [CCAnimation animationWithFrameBeginEnd: @"run_"  suffix:@"png" frameCount:1 begin:1 end:1  delay:0.1f]; 
        self.defImgAct = [CCAnimate actionWithAnimation:defAnimation1]; 
        
         //默认 跑
        CCAnimation *runAnimation = [CCAnimation animationWithFrameBeginEnd:@"run_" suffix:@"png" frameCount:14 begin:1 end:14 delay:0.06f];
        self.runImgAct = [CCAnimate actionWithAnimation:runAnimation];
        
        //跳跃
        CCAnimation *jumpAnimation1 = [CCAnimation animationWithFrameBeginEnd: @"run_"  suffix:@"png" frameCount:1 begin:9 end:9  delay:0.1f];
        self.jumpImgAct = [CCAnimate actionWithAnimation:jumpAnimation1]; 
        
        CCAnimation *jumpAnimation2 = [CCAnimation animationWithFrameBeginEnd: @"run_"  suffix:@"png" frameCount:1 begin:9 end:9  delay:0.1f];
        self.jumpImgAct2 = [CCAnimate actionWithAnimation:jumpAnimation2];
        
        //滚动
        CCAnimation *scrollAnimation = [CCAnimation animationWithFrameBeginEnd: @"scroll_"  suffix:@"png" frameCount:2 begin:0 end:1  delay:0.06f];
        self.scrollImgAct = [CCAnimate actionWithAnimation:scrollAnimation];  
        
        //受伤
        CCAnimation *hurtAnimation = [CCAnimation animationWithFrameBeginEnd: @"hurt_"  suffix:@"png" frameCount:5 begin:1 end:5  delay:0.06f];
        self.hurtImgAct = [CCAnimate actionWithAnimation:hurtAnimation]; 
        //基本属性设置
        self.centerToLeft = self.contentSize.width/2;//--;52/2=26
        self.centerToBottom = self.contentSize.height/2;//--;76/2=38
        self.createPosion =ccp(G_SCREEN_SIZE.width *1/8, G_SCREEN_SIZE.height - self.centerToBottom);
        self.runPosion =ccp(G_SCREEN_SIZE.width *2/8 ,self.centerToLeft);
        
        self.nowRiseAcc = -0.3;
        self.nowDropAcc = 0.2;
	}
	return self;
} 
//初始化 所有动作
- (void)initWithHeroAction
{
    [self initDefAction];
    [self initRunAction]; 
    [self initJumpAction];
    [self initScrollAction];
    [self initHurtAction];
    [self initDeadAction];
    [self initPowerPerfectAction];
}

//初始所有碰击box
- (void)initBumpBox
{
    BumpBox bumpBox;
    //跑CGRect
    bumpBox.ori.origin = self.position;
    bumpBox.ori.size = self.contentSize;
    //滚动CGRect
    bumpBox.scroll.origin = self.position;
    bumpBox.scroll.size = CGSizeMake(G_TILE_WIDTH, G_TILE_HEIGHT);
    self.bumpBox = bumpBox;
}
//初始所有碰击box
- (void)initDefAction
{
    self.defAct = [CCRepeatForever actionWithAction:self.defImgAct];
    [self.defAct setTag:self.nowActState]; 
}
 //初始所有碰击box
- (void)initRunAction
{ 
    self.runAct = [CCRepeatForever actionWithAction:self.runImgAct];
    [self.runAct setTag:kActionStateRun]; 
}
//初始化死亡
- (void)initDeadAction
{
    CCMoveTo *mUpRight = [CCMoveTo actionWithDuration:0.8f position:ccp(G_SCREEN_SIZE.width*2/3, G_SCREEN_SIZE.height+self.contentSize.height)];
    CCRotateTo *rt = [CCRotateTo  actionWithDuration:0.8f angle:1200];
    CCSpawn *spawn = [CCSpawn actionOne:mUpRight two:rt]; 
    CCSequence *seq = [CCSequence actions: spawn,[CCCallFunc actionWithTarget:self selector:@selector(toShowSaveMe)],nil];
    self.deadAct = seq;
    [self.deadAct setTag:kActionStateDead];
}


- (void)toShowSaveMe
{
    [self setVisible:false];
    [[GameHelper getGameLayer] showSaveMe];
    
//    ScoreLayer *scoreLayer= (ScoreLayer*)[[GameHelper getGameLayer] getChildByTag:T_LAYER_SCORE];
//    [scoreLayer showLayer];
//    [scoreLayer setVisible:true];

}
 

- (void)initJumpAction
{
    id repJump=  [CCRepeatForever actionWithAction:self.jumpImgAct];
    self.jumpAct = repJump;
    [self.jumpAct setTag:kActionStateJump];
}

- (void)initJumpAction2
{
    id repJump=  [CCRepeatForever actionWithAction:self.jumpImgAct2];
    self.jumpAct = repJump;
    [self.jumpAct setTag:kActionStateJump];
}
//初始化 无敌
- (void)initPowerPerfectAction
{ 
    CCFadeIn *fin = [CCFadeIn actionWithDuration:0.2];
    CCFadeOut *fout = [CCFadeOut actionWithDuration:0.2 ];
   // CCDelayTime *waiting=[CCDelayTime actionWithDuration:7.0f];
    id  blink = [CCSequence actions:fout,fin,nil];
    id blinkRepeat = [CCRepeat actionWithAction:blink times:10];//延长无敌时间10
    id setToPerfect = [CCCallFunc actionWithTarget:self selector :@selector(setPowerToPerfect)];
    id setToNone = [CCCallFunc actionWithTarget:self selector :@selector(setPowerToNone)];
    CCAction *blinkSeq = [CCSequence actions:setToPerfect,blinkRepeat,setToNone ,nil];
    self.powerPerfectAct = blinkSeq;
    [self.powerPerfectAct setTag:kActionStatePowerPerfect];
}

//初始化受伤
- (void)initHurtAction
{ 
    id hurtAction = [CCSequence actions: self.hurtImgAct,[CCCallFunc actionWithTarget:self selector:@selector(hurtToRun)], nil];
    self.hurtAct = hurtAction; 
    [self.hurtAct setTag:kActionStateHurt]; 
}
//初始化 滚动
- (void)initScrollAction
{
    id repScroll = [CCRepeatForever actionWithAction:self.scrollImgAct]; 
    self.scrollAct = repScroll;  
    [self.scrollAct setTag:kActionStateScroll]; 
} 

//默认动作
- (void)defaultDo
{
    [self stopNowAction];
    [self stopActionByTag:kActionStateDef];
    [self initDefAction];
    [self runAction:self.defAct]; 
}
//默认跑步
- (void)run
{
    [self restAllSpeed];
    self.dropState = kDropStateNone;
    self.jumpLevelState = kJumpLevelNone;//跑步时候 还原 跳跃状态未 初始
    [self stopNowAction];
    [self initRunAction]; 
    [self runAction:self.runAct];  
    self.nowActState = kActionStateRun;
}

- (void)hurtToRun
{
    if(self.nowActState == kActionStateScroll){
    
    }else{
        [self run];
    }
    
}
 

//切换角色 //只改变角色 当前的动作保留
- (void)change
{
    
    if (self.nowActState != kActionStateDead) {
        [SOXSoundUtil play_change];
        if (self.nowRoleState == kRoleStateBlue) {
            self.nowRoleState = kRoleStatePink;
            [self setColor:ccSOX_PINK];
        } else {
            self.nowRoleState = kRoleStateBlue;
            [self setColor:ccSOX_BLUE];
        }
       /* if (self.nowActState == kActionStateRun) {
            [self run];
        } else if (self.nowActState == kActionStateScroll) {
            //手工调用 因为 scroll 以判断如果 是滚动就不再调用
            [self stopNowAction];
            [self runAction:self.scrollAct]; 
        } else  if (self.nowActState == kActionStateJump) {
            [self defaultDo];
        } */
    } 
}


//上升
- (void)rise
{
    
    //    float nowRiseSpeed =[SOXConfig getHeroNowRiseSpeed:self.nowRiseSpeed];
    
    //     float lastSpeed =        nowRiseSpeed+self.nowRiseAcc;
    //     velocity = ccpAdd(velocity, accelorate);
    self.position = ccpAdd(self.position,ccp(0,getRS(self.nowRiseSpeed)));
    self.nowRiseSpeed =  self.nowRiseSpeed  + self.nowRiseAcc;
    
    //微调
    float  base =  [SOXConfig getNowMapMoveSpeedNoHurt];
    float riseAccAdd =0.01;
    if(base == G_TILE_SPEED_NORMAL){
        riseAccAdd =0.01;
    }else{
        riseAccAdd =0.02;
    }
    
    self.nowRiseAcc = self.nowRiseAcc-riseAccAdd;
    self.nowRiseCnt += self.nowRiseSpeed;
}

//掉落
- (void)drop
{ 
//    float nowDropSpeed = [SOXConfig getHeroNowDropSpeed:self.nowDropSpeed];
    self.nowDropSpeed =self.nowDropSpeed +self.nowDropAcc;
    self.position = ccpSub(self.position,ccp(0, getRS(self.nowDropSpeed) ));
    self.dropState = kDropStateDown;
}
- (void)drop:(float)distance
{
    //float nowDropSpeed = [SOXConfig getHeroNowDropSpeed:self.nowDropSpeed];
   // self.nowDropSpeed =distance;
    self.position = ccpSub(self.position,ccp(0, getRS(distance)  ));
    self.dropState = kDropStateDown;
}
- (void)restAllSpeed
{ 
    self.nowRiseSpeed = [SOXConfig getHeroBaseRiseSpeed];
    self.nowDropSpeed = [SOXConfig getHeroBaseDropSpeed];
    self.nowRiseCnt = 0;
    self.nowRiseAcc = -0.3;
    self.nowDropAcc = 0.2;

}

//跳
- (void)jump
{
    
    if ( self.nowActState!=kActionStateScroll  && self.nowActState!=kActionStateHurt&& self.nowActState!=kActionStateDead)
    {
        bool isCanJump = false;
        if (self.nowActState != kActionStateJump ) {
            isCanJump = true;
        } else {
            if (self.jumpLevelState == kJumpLevel1) {
                isCanJump = true; 
            }
        }
        if ( isCanJump ) {
            [SOXSoundUtil play_jump];
            [self stopNowAction];
            [self jumpLevelAdd];
//            [self initJumpAction];
            if (self.jumpLevelState == kJumpLevel1) {
                [self initJumpAction];
            }else{
                [self initJumpAction2];
            }
            self.nowRiseCnt = 0;//起始 为0 
            self.nowRiseSpeed = [SOXConfig getHeroBaseRiseSpeed];//初始化加速度
            self.jumpState =  kJumpStateUp;
            
            
            [self runAction:self.jumpAct];
            self.nowActState = kActionStateJump;
        } 
    }
}

- (void)jumpLevelAdd
{
    if (self.jumpLevelState == kJumpLevelNone) {
        self.jumpLevelState = kJumpLevel1;
    }else{
        self.jumpLevelState = kJumpLevelNone;
    }
}
//死亡
- (void)dead
{
    if (self.nowActState != kActionStateDead) {
        [SOXSoundUtil play_dead];
        [self stopAllActions];
        [self runAction :self.deadAct]; 
        self.nowActState = kActionStateDead;
    }
}


- (void)again
{//
     [self initCreate]; 
    [self runAction:self.powerPerfectAct];
}

- (void)initCreate
{
    self.lifes = [SOXDBGameUtil loadNowLife];
    self.nowRoleState = kRoleStateBlue;
    self.stars = G_STAR_CNT_DEF;
    
    [self stopAllActions];
    [self setVisible:true];
    [self setRotation:1];
    [self run];
}

 


- (void)hurt
{
   
    if (self.nowActState != kActionStateHurt && self.nowActState != kActionStateDead && self.powerState !=kPowerStatePerfect ) {
         [SOXSoundUtil play_hurt];
        [self stopNowAction]; 
        [self runAction:self.hurtAct]; 
        [self runAction:self.powerPerfectAct];
        self.nowActState = kActionStateHurt;
    }
}
//滚动
- (void)scroll
{
   
    if (self.nowActState != kActionStateScroll  && self.nowActState != kActionStateHurt && self.nowActState !=kActionStateDead && self.nowActState != kActionStateJump )
    {
         [SOXSoundUtil play_scroll];
        [self initScrollAction];
        [self stopNowAction];
        [self runAction:self.scrollAct]; 
        self.nowActState = kActionStateScroll;
    }
}

- (void)stopNowAction
{
   [self stopActionByTag:self.nowActState]; 
} 
//回调方法 设置 人物的 跳跃 状态
- (void)setJumpUp
{
    self.jumpState = kJumpStateUp;
}

- (void)setJumpDown
{
    self.jumpState = kJumpStateDown;
    self.dropState = kDropStateDown;
}

- (void)setPowerToPerfect
{
    self.powerState = kPowerStatePerfect;
}

- (void)setPowerToNone
{
    self.powerState = kPowerStateNone; 
}  
//
//获取  碰击 x  头部
- (CGRect)getBumpRectTop
{
    CGPoint point;
    point = ccp(self.position.x - getRS(8)   ,self.position.y + getRS(8) );
    CGRect rect= CGRectMake(point.x, point.y, G_TILE_WIDTH* 2/3, G_TILE_HEIGHT*2/5);
    return rect;
}
//获取  碰击 x  中间
- (CGRect)getBumpRectBody
{
    CGPoint point;
    point = ccp(self.position.x   ,self.position.y - getRS(20) );
    CGRect rect= CGRectMake(point.x, point.y, G_TILE_WIDTH- getRS(10), G_TILE_HEIGHT);
    return rect;
}

//获取  碰击 x  底部
- (CGRect)getBumpRectBottom
{
    CGPoint point;
   point = ccp(self.position.x - getRS(18) ,self.position.y-self.centerToBottom);
    CGRect rect= CGRectMake(point.x, point.y, G_TILE_WIDTH, G_TILE_HEIGHT);
    return rect;
}

//获取 滚动 碰击 x  中间
- (CGRect)getBumpRectScrollBody
{
    CGPoint point;
    point = ccp(self.position.x - getRS(30) ,self.position.y-getRS(25));
    CGRect rect= CGRectMake(point.x  , point.y , G_TILE_WIDTH+getRS(26) , G_TILE_HEIGHT* 2/5);
    return rect;
}

//获取 滚动 碰击 x  下面
- (CGRect)getBumpRectScrollBottom
{
    CGPoint point;
     point = ccp(self.position.x - getRS(30) ,self.position.y-getRS(35));
    CGRect rect= CGRectMake(point.x  , point.y, G_TILE_WIDTH+getRS(26) , G_TILE_HEIGHT* 2/5);
    return rect;
}


- (void)updateHeroLifes:(int)i{
   HeroInfo *heroInfo = [GameHelper getHeroInfo];
    if (i == 1) {
        self.lifes++;
    } else {
        self.lifes--;
    }
    if (self.lifes <= 0) {
       // self.lifes=0;
    }
    //不限制游戏中 得到过多的心
//    if(self.lifes >= G_LIFE_CNT_MAX) {
//        self.lifes = G_LIFE_CNT_MAX;
//    }
    [heroInfo updateLife:self.lifes]; 
    //每次 受伤(-)或者 接触心(+) 都更新 生命 值
    if(self.lifes>=G_LIFE_CNT_DEF){//小于 默认生命 不扣除
        
        NSString *newLife = [SOXUtil intToString:self.lifes]; 
        [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :newLife];
    }
    
}

- (void)updateHeroStars:(double)i
{
    HeroInfo *heroInfo = [GameHelper getHeroInfo];
    self.stars = self.stars + i;
  /*  if(i == 1){
        self.stars++;
        //[SOXSoundUtil play_star];
    }else{
        self.stars--;
    }*/
    [heroInfo updateStar:self.stars];
}

- (void)setHeroMoveLeft
{
    self.scaleX = 1;
    self.position = ccp([self contentSize].width+getRS(20), self.position.y);
}

- (void)setHeroMoveRight
{
    self.scaleX = -1; 
    self.position = ccp(self.position.x+ getRS(250), self.position.y);
}
 /*
- (void)setPosition:(CGPoint)pos
{  
    if (self.nowActState != kActionStateDead) {
        float halfWidth = self.contentSize.width * 0.5f;
        float halfHeight = self.contentSize.height * 0.5f+3;
        if (pos.x < halfWidth) {
            pos.x = halfWidth;
        } else if (pos.x > (G_SCREEN_SIZE.width - halfWidth)) {
            pos.x = G_SCREEN_SIZE.width - halfWidth;
        } 
        if (pos.y < halfHeight) {
            pos.y = halfHeight;
        } else if (pos.y > (G_SCREEN_SIZE.height - halfHeight))
        {
            //pos.y = G_SCREEN_SIZE.height - halfHeight;
        } 
    }
    [super setPosition:pos];
}
*/
- (void)dealloc{
    [_defImgAct release];
    [_runAct release];
    [_jumpAct release];
    [_scrollAct release];
    [_hurtAct release];
    [_powerPerfectAct release];
    [_deadAct release];
    [_defAct release];
    [_runImgAct release];
    [_jumpImgAct release];
    [_scrollImgAct release];
    [_hurtImgAct release];
    [super dealloc]; 
}

#ifdef DEBUG
 
#endif
@end
