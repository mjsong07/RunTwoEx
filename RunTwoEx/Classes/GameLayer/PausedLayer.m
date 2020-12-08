//
//  PausedLayer
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "PausedLayer.h" 
#import "HelpLayer.h"
#import "MenuSettingInfo.h"
@implementation PausedLayer
 
- (id)init
{
	self = [super init];
	if (self) { 
        [CCMenuItemFont setFontSize:getRS(25)];
              
        CCSprite *resume = [CCSprite spriteWithFile:@"menu_resume.png" ];  
        CCSprite *home = [CCSprite spriteWithFile:@"menu_home.png" ];  
        CCSprite *again = [CCSprite spriteWithFile:@"menu_again.png" ];   
        [resume setColor:ccSOX_BLUE];
        [home setColor:ccSOX_BLUE];
        [again setColor:ccSOX_BLUE];
                 
        CCMenuItemSprite *itemResume =  [ CCMenuItemSprite itemWithNormalSprite:resume selectedSprite:nil  disabledSprite:nil   target:self selector:@selector(toResume:) ];
        
        CCMenuItemSprite *itemHome =  [ CCMenuItemSprite itemWithNormalSprite:home selectedSprite:nil
                                                                    target:self selector:@selector(toMenu:) ];
        
      
        CCMenuItemSprite *itemAgain =  [ CCMenuItemSprite itemWithNormalSprite:again selectedSprite:nil
                                                                       target:self selector:@selector(toAgain:) ]; 
       		menu_ = [CCMenu menuWithItems: itemHome,itemResume,itemAgain,nil];
                  
                
		[menu_ alignItemsHorizontally];  
        [itemHome setPosition:ccp(itemHome.position.x-getRS(20), itemHome.position.y)];
        [itemAgain setPosition:ccp(itemAgain.position.x+getRS(20), itemAgain.position.y)];
        [menu_ setPosition:ccp(G_SCREEN_SIZE.width/2, getRS(190))];
        
        MenuSettingInfo *menuSettingInfo = [[[MenuSettingInfo alloc]init:T_SOUND_GAME]autorelease];
        [self addChild:menuSettingInfo];
        [menuSettingInfo setPosition:ccp(G_SCREEN_SIZE.width/2+getRS(70), getRS(110))];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png" ];
        [bg setPosition:G_SCREEN_CENTER]; 
        [self addChild:bg z:-1 tag:2]; 
        [self addChild:menu_ z:1 tag:2]; 
        [menu_ setTouchEnabled:false];
	}
	return self;
}

- (void)showLayer
{
    [self setVisible:true];
    [menu_ setTouchEnabled:true]; 
}


- (void)hiddenLayer
{
    [self setVisible:false]; 
    [menu_ setTouchEnabled:false];
} 
//返回主菜单
- (void)toAgain:(id) sender
{ 
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
//返回主菜单
- (void)toMenu:(id) sender
{
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
	[[CCDirector sharedDirector] replaceScene:newScene]; 
}
//继续
- (void)toResume:(id) sender
{
    [SOXSoundUtil play_button];
    if ([[CCDirector sharedDirector]isPaused]) {
        [[CCDirector sharedDirector]resume]; 
        [self hiddenLayer];
    } else {
        [[CCDirector sharedDirector] pause];
        [self showLayer];
    }
} 

@end
