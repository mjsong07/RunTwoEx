//
//  Effect.m
//  RunTwo
//
//  Created by mjsong on 13-5-23.
//
//
#import "HeroInfo.h"  
#import "ThingCache.h"
#import "GameLayer.h"
@implementation HeroInfo

+ (id)herInfoInit
{ 
    HeroInfo *sprite=[[[self alloc] initWithImage]autorelease];
    [sprite initStar]; 
    [sprite initLife];
    [sprite initStarNumber];
    [sprite initDistanceInfo];
	return sprite;
}

- (id)initWithImage
{
    if ((self = [super init])) {
        //  480 3.5 特殊处理 区分不用 分辨率
        if([[CCDirector sharedDirector] winSize].width == 480){
            self.showLifeCnt =G_LIFE_SHOW_IMG_CNT_3_5;
        }else{
            //568 4.0
            self.showLifeCnt =G_LIFE_SHOW_IMG_CNT_4_0;
        }
	}
	return self;
}
-(void)update:(ccTime)dt{ 
    float speed= [SOXConfig getNowMapMoveSpeed] ;
    if([SOXConfig getNowMapMoveSpeed]>3){
        speed= ([SOXConfig getNowMapMoveSpeed])/15;//+0.05
    } 
    _totalDistance += speed; 
    double fTime= _totalDistance;// * 10 ;
    NSString *strShow =[SOXUtil notRounding:fTime afterPoint:0];
    
    if(fTime >= 100000000 && fTime <= 100000050){//50差防止 速度过快 导致 不执行
        [distanceLabel_ setFontSize:getRS(18)];
        //[SOXDebug logStr:@"setDistanceFontsize18"];
    }
    
    [distanceLabel_ setString:strShow];
}  
- (void)initDistanceInfo
{ 
    CCSprite *distanceTitle = [CCSprite spriteWithFile:@"menu_distance.png" ];
    _totalDistance = 0;
//    _totalDistance = 99999900;
    distanceLabel_ = [CCLabelTTF labelWithString:[SOXUtil intToString:_totalDistance] fontName:@"Arial" fontSize:getRS(25)];
    distanceLabel_.color = ccSOX_BLUE;
    [distanceTitle setColor:ccSOX_BLUE];
    distanceTitle.position = ccp(G_SCREEN_SIZE.width- getRS(303),0);
    distanceLabel_.position = ccp(G_SCREEN_SIZE.width-getRS(280),0);
    [distanceLabel_ setAnchorPoint:ccp(0, 0.5)];
    [self addChild:distanceTitle z:100];
    [self addChild:distanceLabel_ z:100];
    
    [self schedule:@selector(update:)];
}


- (void)initStar
{
    CCSprite *star = [CCSprite spriteWithFile:@"menu_star.png" ];
    [star setColor:ccSOX_BLUE];
    star.position = ccp(G_SCREEN_SIZE.width- getRS(150),0);
    [self addChild:star ];
}
- (void)initStarNumber
{
     self.starCnt = G_STAR_CNT_DEF; 
    NSString *strStarCnt = [SOXUtil intToString: self.starCnt];
    starLabel_= [CCLabelTTF labelWithString:strStarCnt fontName:@"Arial" fontSize:getRS(25)];
    starLabel_.position = ccp(G_SCREEN_SIZE.width-getRS(130),0);
    starLabel_.color = ccSOX_BLUE;
    [starLabel_ setAnchorPoint:ccp(0, 0.5)];
    [self addChild:starLabel_];
}

- (void)initLife 
{
    int nowLife = [SOXDBGameUtil loadNowLife]; 
     lifeImg_ = [CCSprite spriteWithFile:@"menu_life.png" ];
    //[lifeImg setColor:ccSOX_BLUE];  
    self.lifeCnt = nowLife;
    NSString *strLifeCnt = [NSString stringWithFormat:@"%d",nowLife ]; 
    lifeLabel_= [CCLabelTTF labelWithString:strLifeCnt fontName:@"Arial" fontSize:getRS(28)];
    lifeLabel_.position = ccp(getRS(50),0);
    lifeImg_.position = ccp(lifeImg_.contentSize.width/2,0);
    lifeLabel_.color = ccRED;
    [self addChild:lifeImg_];
    [self addChild:lifeLabel_];  
    if(nowLife <= self.showLifeCnt){
        [lifeImg_ setVisible:false];
        [lifeLabel_ setVisible:false];
         [self initLifeNum:self.lifeCnt];
    }else{ 
        [lifeImg_ setVisible:true];
        [lifeLabel_ setVisible:true]; 
    } 
}

- (void)initLifeNum:(int)cnt
{
    [lifeArray_ release];
    lifeArray_ = [[CCArray arrayWithCapacity:cnt] retain];
    for (int i = 0; i < cnt; i++)
    { 
        CCSprite *lifeImg = [CCSprite spriteWithFile:@"menu_life.png" ];
        lifeImg.position = ccp(lifeImg.contentSize.width/2+ getRS(i*33)  ,0);
        [self addChild:lifeImg];
        [lifeArray_ addObject:lifeImg];
    }
}

//更新 星星
- (void)updateStar:(double)num
{
    self.starCnt = num;
    NSString *strShowFormat =[SOXUtil notRounding:self.starCnt afterPoint:0];
    [starLabel_ setString:strShowFormat];
    if(self.starCnt >= 1000000 && self.starCnt <= 1000020){//20差防止 一次吃了多个 星星 导致 不执行
        [starLabel_ setFontSize:getRS(18)];
        //[SOXDebug logStr:@"setStarFontsize18"];
    }
}
//更新 生命
- (void)updateLife:(int)num
{
    if(num <= self.showLifeCnt){
        [lifeImg_ setVisible:false];
        [lifeLabel_ setVisible:false];
        for (int i=lifeArray_.count-1; i >=0; i--) {
            CCSprite *sprite = [lifeArray_ objectAtIndex:i];
            [sprite setVisible:false];
           // [sprite resetAll];
        }
        [lifeArray_ removeAllObjects];
        [self initLifeNum:num];
    }else{
        [lifeImg_ setVisible:true];
        [lifeLabel_ setVisible:true];
        [lifeLabel_ setString:[NSString stringWithFormat:@"%d",  num]];
    } 
} 

- (void)dealloc
{
    [lifeArray_ release];
    [super dealloc];
}
@end
