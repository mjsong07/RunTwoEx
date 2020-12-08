//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuTopInfo.h" 

@implementation MenuTopInfo

- (void)reloadInfo
{
    int nowLifeCnt = [SOXDBGameUtil loadNowLife]; 
    double nowStarCnt = [SOXDBGameUtil loadNowStar];
    NSString *strNowLifeCnt = [SOXUtil intToString:nowLifeCnt];
    NSString *strNowStarCnt =[SOXUtil notRounding:nowStarCnt afterPoint:0];
    
    [labelLife_ setString:strNowLifeCnt];
    [labelStar_ setString:strNowStarCnt]; 
    //特殊处理 如果 星星数量只有0~2位   缩短 显示 的 宽度
   if(strNowStarCnt.length >= 5 ){
       double sub =(strNowStarCnt.length - 4 )*11;
       self.position =  ccp(G_STYLE_MENULAYER_NOW_STAR_LIFE_POINT.x- getRS(sub), G_STYLE_MENULAYER_NOW_STAR_LIFE_POINT.y);
    } 
}

- (id)init
{
	self = [super init];
	if (self) {
        
        [CCMenuItemFont setFontSize:getRS(16)];
        star_ = [CCSprite spriteWithFile:@"menu_star.png" ];
        life_ = [CCSprite spriteWithFile:@"menu_life.png" ];
        frame_ = [CCSprite spriteWithFile:@"achieve_frame.png" ];// 
        
        [star_ setColor:ccSOX_BLUE];
        [frame_ setColor:ccSOX_BLUE];
        life_.scale = 0.6;
        star_.scale = 0.6;
        frame_.scaleX = 1.5;
        labelLife_ = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:getRS(20)];
        labelStar_ = [CCLabelTTF labelWithString:@"0"  fontName:@"Arial" fontSize:getRS(20)];
        labelLife_.color = ccSOX_PINK;
        labelStar_.color = ccSOX_PINK; 
        CGPoint commonTop = ccp(0,0);
        frame_.position = ccp(commonTop.x + getRS(60), commonTop.y);
        life_.position =  ccp(commonTop.x - getRS(70), commonTop.y);
        labelLife_.position = ccp(commonTop.x - getRS(50), commonTop.y);
        star_.position =  ccp(commonTop.x - getRS(20), commonTop.y);
        labelStar_.anchorPoint =ccp(0,0.5);
        labelStar_.position =  ccp(commonTop.x - getRS(5) , commonTop.y);
        
        [self addChild:star_ z:1 tag:2];
        [self addChild:life_ z:1 tag:2]; 
        [self addChild:frame_ z:1 tag:2];
        [self addChild:labelStar_ z:1 tag:2];
        [self addChild:labelLife_ z:1 tag:2]; 
        [self reloadInfo]; 
	}
	return self;
}

- (void)toSharePage: (id) sender
{
    [SOXSoundUtil play_button];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_SHARE];
	[[CCDirector sharedDirector] replaceScene:newScene];
}


- (void)toShoppingPage: (id) sender
{
    [SOXSoundUtil play_button];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_SHOPPING];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
@end
