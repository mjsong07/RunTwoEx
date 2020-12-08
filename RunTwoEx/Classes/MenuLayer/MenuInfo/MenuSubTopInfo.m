//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuSubTopInfo.h" 

@implementation MenuSubTopInfo



- (void)initTest
{
    [CCMenuItemFont setFontSize:getRS(30)];
    CCMenuItemFont *test1 = [CCMenuItemFont itemWithString:@"test" target:self selector:@selector(testCallBack1:)];
    [test1 setColor:ccSOX_BLUE];
    CCMenu *menuTest = [CCMenu menuWithItems: test1,nil];
    [menuTest alignItemsVertically];
    [menuTest alignItemsVerticallyWithPadding:2 ];
     CGPoint commonTop = ccp( getRS(-200),getRS(-30));
    [menuTest setPosition:commonTop ];
    [self addChild: menuTest z:1 tag:2 ];
}
- (void)testCallBack1:(id) sender
{ 
    [[CCDirector sharedDirector] replaceScene: [SceneSwitch showScene:T_SCENE_TEST]];
}

- (id)init
{
	self = [super init];
	if (self) {
        if(G_DEBUG_ENABLE == 1){
            [self initTest];//测试 方法 发布需要屏蔽
        } 
        
        [CCMenuItemFont setFontSize:getRS(16)];
        CCSprite *share_ = [CCSprite spriteWithFile:@"menu_share.png" ];
        CCSprite *shopping_ = [CCSprite spriteWithFile:@"menu_shopping.png" ]; 
        CCMenuItemSprite *itemShopping =  [ CCMenuItemSprite itemWithNormalSprite:shopping_ selectedSprite:nil
                                                                        target:self selector:@selector(toShoppingPage:) ];
        
        CCMenuItemSprite *itemShare =  [ CCMenuItemSprite itemWithNormalSprite:share_ selectedSprite:nil
                                                                           target:self selector:@selector(toSharePage:) ];
        
        CCMenu *infoMenu; 
        //分享只支持6.0
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0){
            infoMenu  = [CCMenu menuWithItems: itemShopping, itemShare ,  nil];
        }else{
            infoMenu  = [CCMenu menuWithItems: itemShopping ,  nil];
        } 
        infoMenu.scale = 0.8;
       
        
        CGPoint commonTop = ccp(0,0);
        
        //  480 3.5 特殊处理 区分不用 分辨率
        if([[CCDirector sharedDirector] winSize].width == 480){
         infoMenu.position =   ccp(0-G_SCREEN_SIZE.width/2 -  getRS(85) , commonTop.y-getRS(58));
        }else{
            //568 4.0
         infoMenu.position =   ccp(0-G_SCREEN_SIZE.width/2 - getRS(94), commonTop.y-getRS(58));
        }
        
        [infoMenu alignItemsHorizontally];
        [infoMenu alignItemsHorizontallyWithPadding:5];
        [self addChild:infoMenu];
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
