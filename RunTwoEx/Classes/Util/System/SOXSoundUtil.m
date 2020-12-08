//
//  SOXMapUtil.m
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import "SOXSoundUtil.h"  
#import "SimpleAudioEngine.h"
@implementation SOXSoundUtil  

//预加载 所有音频
+ (void)initSoundMusic
{
    
    //游戏中音乐
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg.wav"];
     //菜单音乐
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg_menu.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"button.mp3"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"change.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"dead.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hurt.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"score.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"scroll.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"life.mp3"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"jump.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"star.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"line.mp3"];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"box.mp3"];
    
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"box_success.mp3"];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"box_fail.mp3"];
    
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"boxtop_show.mp3"];
    
    
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"shop_success.mp3"];
    
    
  //  [[SimpleAudioEngine sharedEngine] preloadEffect:@"box_time.mp3"];
    
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.3f];
}

//按钮声
+ (void)playEffect:(NSString *)fileName
{
    if( [SOXConfig getIsOpenSound] ){
        [[SimpleAudioEngine sharedEngine] playEffect:fileName];
    }
}
+ (void)playBg:(NSString *)fileName
{
    if( [SOXConfig getIsOpenSound] ){ 
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:fileName loop:true];
    }
}
//设置静音
+ (void)close_sound
{ 
    [[SimpleAudioEngine sharedEngine] setMute:YES];
}

//还原 声音
+ (void)open_sound
{
    [[SimpleAudioEngine sharedEngine] setMute:NO];
}

+ (void)play_MenuBackgroundMusic
{
  //  [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1.6f];
    if( [SOXConfig getIsOpenMusic] ){
        if( [[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] ){
            if([SOXConfig getNowOpeningType] == T_SOUND_MENU ){
            
            }else{
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                 [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg_menu.wav"];
            } 
        }else{ 
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg_menu.wav"];
        } 
        [SOXConfig setNowOpeningType:T_SOUND_MENU];
    } 
}
+ (void)play_GameBackgroundMusic
{
   // [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5f];
    if( [SOXConfig getIsOpenMusic] ){
        if( [[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]){
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg.wav"];
        [SOXConfig setNowOpeningType:T_SOUND_GAME];
    } 
   
}
 

+ (void)pause_BackgroundMusic
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

//弹出游戏分数
+ (void)play_score
{
    [SOXSoundUtil playEffect:@"score.wav"];
}
//弹出游戏分数
+ (void)play_change
{
    [SOXSoundUtil playEffect:@"change.mp3"];
}
 

//按钮声
+ (void)play_button
{ 
    [SOXSoundUtil playEffect:@"button.mp3"];
}
//跳跃
+ (void)play_jump
{ 
    [SOXSoundUtil playEffect:@"jump.wav"]; 
}
//滚动
+ (void)play_scroll
{ 
    [SOXSoundUtil playEffect:@"scroll.wav"]; 
}
//受伤
+ (void)play_hurt
{
    [SOXSoundUtil playEffect:@"hurt.wav"]; 
}
//死亡
+ (void)play_dead
{
    [SOXSoundUtil playEffect:@"dead.mp3"];  
}

+ (void)play_life{
    [SOXSoundUtil playEffect:@"life.mp3"];  
}

//星星
+ (void)play_star
{
    [SOXSoundUtil playEffect:@"star.mp3"];
} 
//
+ (void)play_line
{
    [SOXSoundUtil playEffect:@"line.mp3"];
}
//
+ (void)play_box
{
    [SOXSoundUtil playEffect:@"box.mp3"];
}

+ (void)play_boxTopTime
{
   // [SOXSoundUtil playEffect:@"box_time.mp3"];
}

+ (void)play_boxTopShow
{
    [SOXSoundUtil playEffect:@"boxtop_show.mp3"];
}

+ (void)play_boxSuccess
{
    [SOXSoundUtil playEffect:@"life.mp3"];
}

+ (void)play_boxFail
{
    [SOXSoundUtil playEffect:@"box_fail.mp3"];
}

+ (void)play_shopSuccess
{
    [SOXSoundUtil playEffect:@"shop_success.mp3"];
}





@end
