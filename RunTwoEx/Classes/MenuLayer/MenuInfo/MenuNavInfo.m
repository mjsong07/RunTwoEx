//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuNavInfo.h"  
@implementation MenuNavInfo
 
- (id)init:(TargetScene)targetScene
{
	self = [super init];
	if (self) {
        targetScene_ = targetScene;
        [CCMenuItemFont setFontSize:getRS(16)];
        
        NSString  *Back = NSLocalizedString(@"Back", @"");
        
        CCMenuItemFont *goBackTitle = [CCMenuItemFont itemWithString:Back target:self selector:@selector(backCallback:)];
         goBackTitle.scale = 1.3;
        [goBackTitle setColor:ccSOX_BLUE]; 
        [goBackTitle setPosition:ccp(0,0)]; 
        CCMenu *menuBack = [CCMenu menuWithItems: goBackTitle,nil];
         [menuBack setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height- getRS(90)) ];
        [self addChild: menuBack z:1 tag:2 ];
	}
	return self;
}

- (void)backCallback:(id) sender
{
    [SOXSoundUtil play_button];
    CCScene* scene = [SceneSwitch showScene:targetScene_];
  	[[CCDirector sharedDirector] replaceScene:scene];
}
 @end
