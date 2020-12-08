//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuBaseLayer.h" 
#import "MenuTopInfo.h"
#import "MenuScoreInfo.h"
#import "MenuSubTopInfo.h"

@implementation MenuBaseLayer

+ (id)scene
{ 
	CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_INDEX];
	MenuBaseLayer *layer = [MenuBaseLayer node]; 
	[scene addChild: layer];
    [SOXSoundUtil play_MenuBackgroundMusic];
	return scene;
}

- (void)setLinePinkPostion :(int)marginY
{
    menuLinePink_.position = ccp(menuLinePink_.position.x , menuLinePink_.position.y+  marginY);
}
- (void)reloadInfo
{
    [menuTopInfo_ reloadInfo]; 
}
- (id)init
{
	self = [super init];
	if (self) { 
        CCSprite *manLeft = [CCSprite spriteWithFile:@"man_white.png" ];
        CCSprite *manRight = [CCSprite spriteWithFile:@"man_white.png" ];
        [manLeft setColor:ccSOX_BLUE];
        [manRight setColor:ccSOX_PINK];
        manRight.scaleX = -1; 
        menuLineBlue_ = [CCSprite spriteWithFile:@"menu_index_line.png" ];
        menuLinePink_ = [CCSprite spriteWithFile:@"menu_index_line.png" ];
        [menuLineBlue_ setColor:ccSOX_BLUE];
        [menuLinePink_ setColor:ccSOX_PINK];
        menuLineBlue_.scaleX=1.2; 
        menuLinePink_.scaleX=1.2;
        menuLineBlue_.position = ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/5*4);  
        menuLinePink_.position = ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/5); 
        manLeft.position = ccp(manLeft.contentSize.width/2, G_SCREEN_CENTER.y);
        manRight.position = ccp(G_SCREEN_SIZE.width-manRight.contentSize.width/2,G_SCREEN_CENTER.y ); 
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        menuTopInfo_ = [[[MenuTopInfo alloc] init]autorelease];
        
         menuSubTopInfo_ = [[[MenuSubTopInfo alloc] init]autorelease];
        
        commonInfoTopPoint_ = G_STYLE_MENULAYER_NOW_STAR_LIFE_POINT;
        [menuTopInfo_ setPosition:commonInfoTopPoint_];
        [menuTopInfo_ reloadInfo];
        [menuSubTopInfo_ setPosition:commonInfoTopPoint_];
        [self addChild:bgcolor z:-1];
        [self addChild:manLeft];
        [self addChild:manRight];
        [self addChild:menuLineBlue_];
        [self addChild:menuLinePink_];
        [self addChild:menuTopInfo_];
        [self addChild:menuSubTopInfo_];
              
	}
	return self;
}

 

@end
