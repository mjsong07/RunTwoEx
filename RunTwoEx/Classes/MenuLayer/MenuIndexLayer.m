//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//
 
#import "MenuBaseLayer.h" 
#import "MenuIndexLayer.h" 

@implementation MenuIndexLayer

+ (id)scene
{ 
	CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_INDEX];
	MenuIndexLayer *layer = [MenuIndexLayer node]; 
	[scene addChild: layer];
    [SOXSoundUtil play_MenuBackgroundMusic];
	return scene;
}

- (id)init
{
    self = [super init];
	if (self) { 
        [CCMenuItemFont setFontSize:getRS(25)];
        CCSprite *play = [CCSprite spriteWithFile:@"menu_index_play.png" ];  
        CCSprite *more = [CCSprite spriteWithFile:@"menu_index_more.png" ]; 
        [play setColor:ccSOX_BLUE]; 
        [more setColor:ccSOX_PINK]; 
        
        CCSprite *logo = [CCSprite spriteWithFile:@"menu_logo.png" ];
        [logo setPosition:G_SCREEN_CENTER];
        logo.position = ccp(G_SCREEN_SIZE.width/2, G_SCREEN_SIZE.height/2+ getRS(20));
        [self addChild:logo z:-1 tag:2]; 
        
        CCMenuItemSprite *itemPlay =  [ CCMenuItemSprite itemWithNormalSprite:play selectedSprite:nil
                                                                       target:self selector:@selector(newGameFun:) ];
        CCMenuItemSprite *itemMore =  [ CCMenuItemSprite itemWithNormalSprite:more selectedSprite:nil
                                                                       target:self selector:@selector(moreFun:) ];
         
        itemPlay.scale = 1.2;
        itemMore.scale = 1.2;
		CCMenu *menu = [CCMenu menuWithItems:itemPlay,itemMore, nil];
		[menu alignItemsVertically];
        [menu setPosition:ccp(G_SCREEN_SIZE.width/2, getRS(110))];
        [self addChild:menu z:1 tag:2];  
        
        int i=0;
        for( CCNode *child in [menu children] ) {
			CGPoint dstPoint = child.position;
			int offset = G_SCREEN_SIZE.width/2 + getRS(50);
			if( i % 2 == 0){
				offset = -offset;
                dstPoint.y=dstPoint.y+getRS(10);//调整菜单距离
            }
			child.position = ccp( dstPoint.x + offset, dstPoint.y);
			[child runAction:
			 [CCEaseElasticOut actionWithAction:
			  [CCMoveBy actionWithDuration:2 position:ccp(dstPoint.x - offset,0)]
										 period: 0.35f]
             ];
			i++;
		}
        
	}
	return self;
}
 
- (void)newGameFun:(id) sender
{
    [SOXSoundUtil play_button];
    CCScene* scene = [SceneSwitch showScene:T_SCENE_GAME_LAYER];
  	[[CCDirector sharedDirector] replaceScene:scene];
}
- (void)moreFun:(id) sender
{
    [SOXSoundUtil play_button];
    CCScene* scene = [SceneSwitch showScene:T_SCENE_SCORE];
    [[CCDirector sharedDirector] replaceScene:scene];
} 

@end
