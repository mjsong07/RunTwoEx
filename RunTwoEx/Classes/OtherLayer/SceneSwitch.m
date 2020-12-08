//
//  SceneSwitch
//  SoxFrame
//
//  Created by jason yang on 14-02-26
//
//

#import "SceneSwitch.h"
#import "LogoLayer.h"
#import "GameLayer.h"
#import "MenuIndexLayer.h"
#import "MenuSettingLayer.h"
#import "MenuShoppingLayer.h"
#import "MenuAchieveLayer.h"
#import "SOXEnum.h"
#import "PausedLayer.h"
#import "MenuScoreLayer.h"
#import "MenuShareLayer.h"
#import "HelpLayer.h"
#import "MenuTestLayer.h"

@implementation SceneSwitch
+ (id)showScene:(TargetScene)targetScene
{  
    return [[[self alloc] initWithTargetScene:targetScene] autorelease];
}
- (id)initWithTargetScene:(TargetScene)targetScene
{
    if(self = [super init]){
        _targetScene = targetScene;
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild: bgcolor z:-1];
        [self scheduleUpdate]; 
    }
    return self;
}
- (void)update:(ccTime)delta
{
    [self unscheduleAllSelectors]; 
    switch (_targetScene) {
        case T_SCENE_NULL:
            break;
        case T_SCENE_MENU:
            break;
        case T_SCENE_PAUSE:
            break;
        case T_SCENE_LOGO:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LogoLayer scene] withColor:ccWHITE]];
            break;
        case T_SCENE_INDEX:
            [[CCDirector sharedDirector] replaceScene:[MenuIndexLayer scene]];
            break;
        case T_SCENE_SCORE:
            [[CCDirector sharedDirector] replaceScene:[MenuScoreLayer scene]];
            break;
        case T_SCENE_SHARE:
            [[CCDirector sharedDirector] replaceScene:[MenuShareLayer scene]];
            break;
        case T_SCENE_SHOPPING:
            [[CCDirector sharedDirector] replaceScene:[MenuShoppingLayer scene]];
            break;
        case T_SCENE_ACHIEVE:
            [[CCDirector sharedDirector] replaceScene:[MenuAchieveLayer scene]];
            break;
        case T_SCENE_GAME_LAYER:
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
            break;
        case T_SCENE_SETTING:
            [[CCDirector sharedDirector] replaceScene:[MenuSettingLayer scene]];
            break;
        case T_SCENE_HELP:
            [[CCDirector sharedDirector] replaceScene:[HelpLayer scene]];
            break;
        case T_SCENE_TEST:
            [[CCDirector sharedDirector] replaceScene:[MenuTestLayer scene]];
            break;
        case T_SCENE_MAX:
            break;
    }
}
- (void)dealloc{
    [super dealloc];
}
@end