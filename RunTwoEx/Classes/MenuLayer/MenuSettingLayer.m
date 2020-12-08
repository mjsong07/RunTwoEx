//
//  GameSettingLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//

#import "MenuSettingLayer.h"  
#import "MenuSettingInfo.h"

@implementation MenuSettingLayer
+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuSettingLayer *nowLayer = [MenuSettingLayer node];
    [scene addChild:nowLayer];
    return scene;
}
- (id)init
{
    if (self = [super init]) {
        MenuScoreInfo *menuScore = [[[MenuScoreInfo alloc]init]autorelease];  
        MenuSettingInfo *menuSettingInfo =[[[MenuSettingInfo alloc]init:T_SOUND_MENU]autorelease];
        MenuNavInfo *backNav = [[[MenuNavInfo alloc]init:T_SCENE_SCORE]autorelease];
        [menuScore setPosition:G_STYLE_MENULAYER_MARGIN_TOP2 ];
        [menuSettingInfo setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height-getRS(210) ) ];
        [self addChild: backNav];
        [self addChild:menuScore]; 
        [self addChild: menuSettingInfo];
    }
    return self;
}
- (void)backCallback: (id) sender
{ 
    [SOXSoundUtil play_button];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_SCORE];
	[[CCDirector sharedDirector] replaceScene:newScene];
}

@end
