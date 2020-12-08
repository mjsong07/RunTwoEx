//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "ThingCharTop.h" 
#import "ThingChar.h"

#define G_CHAR_IMG_WIDTH  40
#define G_CHAR_IMG_MARGIN_LEFT  40/3
#define G_CHAR_TO_BIG  1.3


#define G_CHAR_OPACITY_NORMAL  255

#define G_CHAR_OPACITY_DARK  150

#define G_CHAR_ZORDER  300

@implementation ThingCharTop


- (id)initBase 
{
	self = [super init];
	if (self) {
        // CCSprite *lineImg = [CCSprite spriteWithFile:@"saveMe_progress.png" ];
        CCSprite *rightImg = [CCSprite spriteWithFile:@"char_right.png" ];
        CCSprite *wrongImg = [CCSprite spriteWithFile:@"char_wrong.png" ];
        [rightImg setColor:ccRED];
        [wrongImg setColor:ccRED];
        rightImg.visible = false;
        wrongImg.visible = false;
            
        [self addChild:rightImg z:1 tag:100];
        [self addChild:wrongImg z:1 tag:200];
    }
	return self;
}



- (id)initAll :(NSString*) strVal
{
    [self removeAllChildrenWithCleanup:true];
        
        if(strVal!=nil){
            self.strVal = [strVal retain];
            float starX=   G_CHAR_IMG_MARGIN_LEFT;
             //[SOXDebug logFloat:starX];
            for (int i = 0; i < [strVal length]; i++){
                NSString *nowVal = [strVal substringWithRange:NSMakeRange(i, 1)];
                [strVal substringFromIndex:1];
                ThingChar *thingChar = [ThingChar objBigInit ];
                thingChar.position = ccp(getRS(starX+i*(G_CHAR_IMG_WIDTH + 2))  ,0);// 2 为 之间的空隙
                [thingChar setOpacity:G_CHAR_OPACITY_DARK];//255
                //特殊处理 第一个 默认放大
                if(i == 0){
                    thingChar.scale = G_CHAR_TO_BIG;
                    thingChar.zOrder = 100;
                    [thingChar setOpacity:G_CHAR_OPACITY_NORMAL];
                }
                
                [thingChar setChar:nowVal];
                [self addChild:thingChar z:1 tag:i];
            }
           // [lineImg setPosition:ccp(0,0) ];
            float starX1= (([self.strVal length]*G_CHAR_IMG_WIDTH) )/2;
            
            CCSprite *rightImg = [CCSprite spriteWithFile:@"char_right.png" ];
            CCSprite *wrongImg = [CCSprite spriteWithFile:@"char_wrong.png" ];
            [rightImg setColor:ccRED];
            [wrongImg setColor:ccRED];
            rightImg.visible = false;
            wrongImg.visible = false;
            
            [self addChild:rightImg z:1 tag:100];
            [self addChild:wrongImg z:1 tag:200];
            
            
           // CCSprite *rightImg = (CCSprite*)[self getChildByTag:100];
            //CCSprite *wrongImg = (CCSprite*)[self getChildByTag:200];
            [rightImg setPosition:ccp(getRS(starX1) , 0)];
            [wrongImg setPosition:ccp(getRS(starX1), 0)];
            
            //自动失败隐藏 定时任务
            
            //固定处理
            float speed = [SOXConfig getNowMapMoveSpeed];
            float duration = 15 ;
            if( speed == G_TILE_SPEED_NORMAL){//4倍速度
                duration = 15 ;//11
            }else if( speed == G_TILE_SPEED_FAST){//5倍速度
                duration = 12 ;//8.5
            }
            //播放音乐
            [SOXSoundUtil play_boxTopShow];
             CCDelayTime *waiting=[CCDelayTime actionWithDuration:duration];
            id  blink = [CCSequence actions:waiting,[CCCallFunc actionWithTarget:self selector:@selector(autoFailHiddenAll)],nil];
            [self runAction:blink];
        }
    return self;
}
//获取坐标 居中的 x 和 y
- (CGPoint)getCenterPosition {
    float starX= (G_SCREEN_SIZE.width-  getRS([self.strVal length]*G_CHAR_IMG_WIDTH) )/2;
    return ccp(starX, G_SCREEN_CENTER.y);
}



- (void)updateByStrVal
{
   int index= [SOXMapUtil getNowIndexBySingleCharVal];
    ThingChar *thingChar =(ThingChar*)[self getChildByTag:index];
    if(thingChar != nil){
        thingChar.scale = 1.0;
        [thingChar setColor:ccSOX_PINK ];
        [thingChar setOpacity:G_CHAR_OPACITY_DARK];
        thingChar.zOrder = index;
    }
   
    
    ThingChar *thingCharNext =(ThingChar*)[self getChildByTag:index+1];
    if(thingCharNext != nil){
        thingCharNext.scale = G_CHAR_TO_BIG;
        thingCharNext.color = ccSOX_BLUE;
        thingCharNext.zOrder = G_CHAR_ZORDER;
        [thingCharNext setOpacity:G_CHAR_OPACITY_NORMAL];
    }
}
//成功
- (void)success
{

    for (int i = 0; i < [self.strVal length]; i++){
        ThingChar *thingChar = (ThingChar*)[self getChildByTag:i];
        thingChar.scale = 1.0;
        thingChar.color = ccSOX_PINK;
        [thingChar setOpacity:G_CHAR_OPACITY_DARK];
    }
   CCSprite *right = (CCSprite*)[self getChildByTag:100];
    CCSprite *fail = (CCSprite*)[self getChildByTag:200];
    right.visible = true;
    fail.visible = false;
    
    [self stopAllActions];
    
    id scaleTo = [CCScaleTo actionWithDuration:0.1f scale:1.1];
    [right runAction:scaleTo];
    CCDelayTime *waiting=[CCDelayTime actionWithDuration:1.3f];
    id  blink = [CCSequence actions:waiting,[CCCallFunc actionWithTarget:self selector:@selector(callToMoveRight)],nil];
    [self runAction:blink];
}


- (void)callToMoveRight
{
    CCSprite *right = (CCSprite*)[self getChildByTag:100];
    right.visible = false;
    [self moveUpRight];
}

//失败
- (void)fail
{
    
    for (int i = 0; i < [self.strVal length]; i++){
        ThingChar *thingChar = (ThingChar*)[self getChildByTag:i];
        [thingChar setOpacity:G_CHAR_OPACITY_DARK];

    }
    
    
    CCSprite *right = (CCSprite*)[self getChildByTag:100];
    CCSprite *fail = (CCSprite*)[self getChildByTag:200];
    right.visible = false;
    fail.visible = true;
    id scaleTo = [CCScaleTo actionWithDuration:0.1f scale:1.1];
    
    [self stopAllActions];
    
    [fail runAction:scaleTo];
    CCDelayTime *waiting=[CCDelayTime actionWithDuration:1.3f];
    id  blink = [CCSequence actions:waiting,[CCCallFunc actionWithTarget:self selector:@selector(hiddenAll)],nil];
    [self runAction:blink];
}



- (void)hiddenAll
{
    self.visible =false;
    self.isTouch = false;
    self.isMoveing = false;
}

//过一段时间 自动失败隐藏
- (void)autoFailHiddenAll
{
    [SOXSoundUtil play_boxFail];
     [SOXDBUtil saveInfo:G_KEY_BMX_IS_RUNNING_CHAR :G_STR_NO];
    [self fail];
}



@end
