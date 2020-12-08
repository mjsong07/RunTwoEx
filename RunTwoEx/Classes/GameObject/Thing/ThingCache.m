//
//  ThingCache.m
//  RunTwo
//  工厂方法  统一生成物品  提高性能
//
//  Created by mjsong on 13-6-3.
//
//

#import "ThingCache.h"  
#import "Hero.h"
#import "GameLayer.h"
#import "ThingChar.h"
@implementation ThingCache
+ (id)objInit
{
    ThingCache *sprite = [[self alloc] init];
    [sprite initAllThing];
	return [sprite autorelease];
} 

- (id)init
{
	if ((self = [super init]))
	{ 
		CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"life.png"]; 
		ccBatchNode_ = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
		[self addChild:ccBatchNode_ z:10];
	}
     	
	return self;
}
 
- (void)initAllThing
{
	self.things = [[[CCArray alloc] initWithCapacity:ColorTypeMax]autorelease];
    //先初始化 每个物品需要得 数量
	for (int i = 0; i < ColorTypeMax; i++)
	{ 
		int capacity = 0;
		switch (i)
		{ 
			case ColorTypeBlue:
				capacity = G_CACHE_NUM_STAR+G_CACHE_NUM_LINE+G_CACHE_NUM_BOX;
				break;
            case ColorTypePink:
				capacity =  G_CACHE_NUM_STAR+G_CACHE_NUM_LINE+G_CACHE_NUM_BOX;
				break;
			case ColorTypeRed:
				capacity = G_CACHE_NUM_LIFE;
            case ColorTypeBlack:
				capacity = G_CACHE_NUM_FLOOR;
				break;
		}
		CCArray* array = [CCArray arrayWithCapacity:capacity];
		[_things addObject:array];
	}
	//根据 数量  初始化物品
    //i 开始是 类型
    //j 开始是 重复得对象
	for (int i = 0; i < ColorTypeMax; i++)
	{
		CCArray* array = [_things objectAtIndex:i]; 
        if(i == ColorTypeBlue || i == ColorTypePink){
                [self createBatchForObjType:array :G_CACHE_NUM_STAR :i :ThingObjStar];
                [self createBatchForObjType:array :G_CACHE_NUM_LINE :i :ThingObjLine];
                [self createBatchForObjType:array :G_CACHE_NUM_BOX :i :ThingObjBox]; 
        } else  if(i == ColorTypeRed){
            [self createBatchForObjType:array :G_CACHE_NUM_LIFE :i :ThingObjLife];
        } else  if(i == ColorTypeBlack){
            [self createBatchForObjType:array :G_CACHE_NUM_FLOOR :i :ThingObjFloor];
        }
	}
}
-(void) dealloc{
    [_things release];
    [super dealloc];
}
//
- (void)createBatchForObjType:(CCArray*)array :(int)createNum :(int)colorType :(ThingObjType)objType
{ 
    for (int j = 0; j < createNum; j++)
    {
        BaseSprite *baseSprite = nil;
        //由于 文字box 的 特殊需要动态显示文字 不能使用统一的缓存ccBatchNode  需要单独直接创建
        if(objType == ThingObjBox){
            baseSprite = [ThingChar objInit:colorType];
            [self addChild:baseSprite];
        }else{
            baseSprite = [Thing objInit:colorType :objType];
            [ccBatchNode_ addChild:baseSprite z:0 tag:colorType];
        }
        [baseSprite setVisible:false];
        [array addObject:baseSprite];
    }
}

 

- (BaseSprite*)showObj:(ColorType)thingType :(ThingObjType)objType :(CGPoint)startPosition
{
    CCArray* array = [_things objectAtIndex:thingType];
	Thing* thing = nil;
	CCARRAY_FOREACH(array, thing)
	{
        if( thing.objType == objType){
            if (thing.visible == NO)
            {
                [thing setVisible: true];
                [thing setPosition:startPosition];
                [thing initAllAction];
                [thing baseDo];
                //如果 当前是 box 特殊处理 同时显示对应的 文本信息
                if(objType == ThingObjBox){
                    if([SOXDBGameUtil loadBMXCharIsRunning]){
                       NSString *singleChar =  [SOXMapUtil getBMXCreateSingleCharVal];
                       // [SOXDebug logStr:singleChar];
                        ThingChar *thingChar =(ThingChar*)thing;
                        [thingChar setChar:singleChar];
                        thingChar.visible = true;
                    }
                }
                break;
            }
        } 
	}
    return thing;
}


 
//隐藏 所有
- (void)hiddenAll
{
    for (int i = 0; i < _things.count; i++)
	{
        CCArray* array = [_things objectAtIndex:i];
        for (int j = 0; j < array.count; j++)
        {
            BaseSprite *obj=  (BaseSprite*)[array objectAtIndex:j];
           // [obj resetAll];
            obj.isTouch = false;
            obj.isMoveing = false;
            obj.visible = false;
        } 
    }
}


- (ColorType)chkAllIsTouch:(Hero*)hero :(CCTMXTiledMap*)map
{
    //遍历缓存 物品
    for (int i = 0; i < _things.count; i++)
	{
      bool bol=  [self chkAllIsTouch:i :hero :map];
        if(bol==true){
            //return i;
           // break;
        }
    }
    return ColorTypeNull;
}


- (bool)chkByRole:(ColorType)thingType :(Hero*)hero :(BaseSprite *)star
{
    //当前是 蓝色 障碍
    bool isRight = true;// 
    if(thingType == ColorTypeBlue){
        if(hero.nowRoleState == kRoleStateBlue){
            isRight = true; 
        }else{
            isRight = false;
        }
    }
    if(thingType == ColorTypePink){
        if(hero.nowRoleState == kRoleStatePink){
            isRight = true;
        }else{
            isRight = false;
        }
    }
    return isRight; 
}

- (void)toDoByRole:(bool)isRight :(Hero*)hero :(BaseSprite *)baseSprite
{ 
    if(isRight){
        if(baseSprite.isTouch == true){
            
        }else{
            [baseSprite setToTouch]; 
            BaseThing *baseThing=(BaseThing*) baseSprite;
            if(baseThing.objType == ThingObjStar){
                [SOXSoundUtil play_star];
                [hero updateHeroStars:G_REWORD_STAR];
                 [baseSprite moveUpRight];
            }else if(baseThing.objType == ThingObjLine){
                [SOXSoundUtil play_line];
                [hero updateHeroStars:G_REWORD_LINE];
                 [baseSprite moveUpRight];
            } else if(baseThing.objType == ThingObjBox){
               // [SOXSoundUtil play_star];
               // [hero updateHeroStars:G_REWORD_BOX];
                //特殊 处理 校验 当前是否按顺序 碰撞 box
                bool isRunningFlag = [SOXDBUtil loadInfoReturnBool:G_KEY_BMX_IS_RUNNING_CHAR];
               // bool isEnd = false;
                int nowState = 0;  // 0为未碰撞 1 为成功 2 为失败
                if(isRunningFlag == true){
                    ThingChar *thingChar=(ThingChar*) baseThing;
                    NSString *nowSingleVal =  thingChar.strChar;
                    bool flag = [SOXMapUtil chkBMXSingleChar:nowSingleVal];
                    if(flag == true){
                         [SOXMapUtil updateBMXCharVal:nowSingleVal];//更新 最新 当前状态
                        if([SOXMapUtil chkBMXCharSuccess]){
                             [SOXSoundUtil play_boxSuccess];
                            nowState = 1;
                            [[GameHelper getGameLayer]successThingCharTop];
                             int reword = [SOXConfig getNowCharCompleteReword];
                            [hero updateHeroStars:reword];//都顺利完成 奖励
                          //  isEnd = true;
                        }else{
                            [[GameHelper getGameLayer]updateThingCharTop];
                        }
                    }else{//没有碰撞到
                        [SOXSoundUtil play_boxFail];
                        nowState = 2;
                         [[GameHelper getGameLayer]failThingCharTop];
                       // isEnd = true;
                        
                    }
                }
                [hero updateHeroStars:G_REWORD_BOX];
                if(nowState == 0){
                 [SOXSoundUtil play_star];
                }else if(nowState == 1){
                [SOXSoundUtil play_boxSuccess];
                }else if(nowState == 2){
                    [SOXSoundUtil play_boxFail];
                }
                 [baseSprite moveUpRight];
                
            }
           
        }
    }else{
        if(hero.powerState != kPowerStatePerfect){
            [[GameHelper getGameLayer]heroHurtAll]; 
        }
    }
}




//检查所有 物件是否与 障碍碰撞
- (bool)chkAllIsFloor:(CrashType)crashType :(Hero*)hero 
{
    CCArray* array = [_things objectAtIndex:ColorTypeBlack];
	BaseSprite* thing;
    for (int i = 0; i < array.count; i++) {
        thing = [array objectAtIndex:i];
        BaseSprite *floor = (BaseSprite*)thing;
        if (floor.visible == YES&& floor.isTouch == false) {
                bool bol= false;
//                bool bolBody = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBody  :thing  :self.position.x ];
//                bool bolBottom = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBottom  :thing  :self.position.x ];
//                bool bolTop = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeTop  :thing  :self.position.x ];
            
            
            if(hero.nowActState == kActionStateScroll){
            
            
            }
                if(crashType == CrashTypeTop){ // 比较X 轴bool  bolTop
                      bol = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeTop  :floor  :self.position.x ];
                }else if(crashType == CrashTypeBody){ // 比较X 轴
                    bool bolBody = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBody  :thing  :self.position.x ];
//                    bool bolBottom = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBottom  :thing  :self.position.x ];
                    bol =  bolBody ;
                    
                }else if(crashType == CrashTypeBottom){
                    bool bolBody = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBody  :thing  :self.position.x ];
                    
                    bool bolBottom = [ SOXMapUtil chkHeroBumpIsTouch:hero :CrashTypeBottom  :thing  :self.position.x ];
                        bol = bolBottom ;
                    if(bolBody ==true && bolBottom == true){// 如果当前x 和 y 同时碰撞 优先取y  不取x
                        if(hero.nowActState != kActionStateScroll){
                            bol = false;
                        }
                    }
                }
            if (bol == true) {
                return true;
            }
		}
    }
    return false;
}



//检查所有 物件是否发生碰撞
- (bool)chkAllIsTouch:(ColorType)thingType :(Hero*)hero :(CCTMXTiledMap*)map
{
    CCArray* array = [_things objectAtIndex:thingType];
	BaseSprite* thing; 
    for (int i = 0; i < array.count; i++) { 
        thing = [array objectAtIndex:i];
        BaseSprite *star = (BaseSprite*)thing;
        if (thing.visible == YES&& star.isTouch == false) {
            bool bol= false;
            //如果 当前对象 是 文字类型box  特殊处理 x左边 往左移动
            if([star isKindOfClass:[ThingChar class]]){
                bol= [ SOXMapUtil chkHeroIsTouchMapSp:hero :thing  :self.position.x-16];
            }else{
                bol= [ SOXMapUtil chkHeroIsTouchMapSp:hero :thing  :self.position.x ];
            }
            if (bol == true) {
                if(thingType==ColorTypeBlue) {
                   bool bol= [self chkByRole:thingType :hero :star];
                    [self toDoByRole:bol :hero :star];
                }else if(thingType == ColorTypePink) {
                    bool bol= [self chkByRole:thingType :hero :star];
                    [self toDoByRole:bol :hero :star];
                } else if(thingType == ColorTypeRed) {
                    [SOXSoundUtil play_life];
                    [hero updateHeroLifes:1];
                    [star moveUpRight];
                }
                return true;
            }  
		}
    }
    return false;
} 
@end
