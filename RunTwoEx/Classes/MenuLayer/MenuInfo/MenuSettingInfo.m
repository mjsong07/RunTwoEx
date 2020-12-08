//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuSettingInfo.h" 

@implementation MenuSettingInfo
 
- (id)init:(SoundType)soundType
{
	self = [super init];
	if (self) {
        [CCMenuItemFont setFontSize:getRS(16)];  
        self.soundType = soundType;
        // distanceImg.scale  = 0.8;
        CCSprite *music = [CCSprite spriteWithFile:@"menu_music.png" ];
        CCSprite *musicStop = [CCSprite spriteWithFile:@"menu_music_stop.png" ];
        CCSprite *sound = [CCSprite spriteWithFile:@"menu_sound.png" ];
        CCSprite *soundStop = [CCSprite spriteWithFile:@"menu_sound_stop.png" ];
        [music setColor:ccSOX_BLUE];
        [musicStop setColor:ccSOX_PINK];
        [sound setColor:ccSOX_BLUE];
        [soundStop setColor:ccSOX_PINK];
        
        CCMenuItemSprite *itemMusic =  [ CCMenuItemSprite itemWithNormalSprite:music selectedSprite:nil
                                                                        target:self selector:nil ];
        CCMenuItemSprite *itemMusicStop =  [ CCMenuItemSprite itemWithNormalSprite:musicStop
                                                                    selectedSprite:nil
                                                                            target:self
                                                                          selector:nil ];
        CCMenuItemSprite *itemSound =  [ CCMenuItemSprite itemWithNormalSprite:sound selectedSprite:nil
                                                                        target:self selector:nil ];
        CCMenuItemSprite *itemSoundStop =  [ CCMenuItemSprite itemWithNormalSprite:soundStop selectedSprite:nil
                                                                            target:self selector:nil ];
        CCMenuItemToggle *itemMusicToggle = [CCMenuItemToggle itemWithTarget:self
                                                                    selector:@selector(musicCallback:)
                                                                       items: itemMusic, itemMusicStop, nil];
        
        CCMenuItemToggle *itemSoundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundCallback:) items:
                                             itemSound,
                                             itemSoundStop,
                                             nil];
        
        
        CCSprite *help = [CCSprite spriteWithFile:@"menu_help.png" ];
        [help setColor:ccSOX_BLUE];
        CCMenuItemSprite *itemHelp =  [ CCMenuItemSprite itemWithNormalSprite:help selectedSprite:nil
                                                                       target:self selector:@selector(toHelp:) ];
        
        
        
        [SOXDBUtil initInfoByMenuItem:itemMusicToggle :G_KEY_MUSIC];
        [SOXDBUtil initInfoByMenuItem:itemSoundToggle :G_KEY_SOUND];
        //itemShare, 
        CCMenu *smallMenu = [CCMenu menuWithItems: itemMusicToggle,itemSoundToggle, itemHelp,nil];
        smallMenu.position = ccp(0, 0);
        [smallMenu alignItemsHorizontally];
        [smallMenu alignItemsHorizontallyWithPadding:2];
        //[smallMenu setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height-180 ) ];
        [self addChild: smallMenu z:1 tag:2 ];

	}
	return self;
}

//设置 声音
- (void)musicCallback: (id) sender
{
    [SOXSoundUtil play_button];
    NSString *index= [SOXUtil intToString:[sender selectedIndex]];
    //同时 设置 全局得 变量值
    [SOXConfig setIsOpenMusic:index];
    [SOXDBUtil saveInfo:G_KEY_MUSIC : index];
     
    if( [sender selectedIndex] == 0){
        if(self.soundType == T_SOUND_MENU){
             [SOXSoundUtil play_MenuBackgroundMusic]; 
        }else if(self.soundType == T_SOUND_GAME){ 
             [SOXSoundUtil play_GameBackgroundMusic];
        } 
    } else
    {
        [SOXSoundUtil pause_BackgroundMusic];
    }
         
   
}
- (void)soundCallback: (id) sender
{
    NSString *index= [SOXUtil intToString:[sender selectedIndex]];
    //同时 设置 全局得 变量值
    [SOXConfig setIsOpenSound:index];
    [SOXDBUtil saveInfo:G_KEY_SOUND : index];
    //打开 按钮声
    if( [sender selectedIndex] == 0){
        [SOXSoundUtil play_button];
    }
}

//帮助页面
- (void)toHelp:(id) sender
{
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_HELP];
	[[CCDirector sharedDirector] replaceScene:newScene];
}

@end
