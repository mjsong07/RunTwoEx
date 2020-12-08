//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"
@interface SOXSoundUtil : NSObject
//初始化所有音频
+ (void)initSoundMusic;

+ (void)play_MenuBackgroundMusic;

+ (void)play_GameBackgroundMusic;
+ (void)pause_BackgroundMusic;

//+ (void)play_BackgroundMusic;
+ (void)play_change;
//跳跃
+ (void)play_jump;
//滚动
+ (void)play_scroll;
//受伤
+ (void)play_hurt;

+ (void)play_score;

+ (void)play_life;

//死亡
+ (void)play_dead;
+ (void)play_button;
+ (void)play_star;
+ (void)play_line;
+ (void)play_box;

+ (void)play_boxTopShow;

+ (void)play_boxTopTime;


+ (void)play_boxSuccess;

+ (void)play_boxFail;

+ (void)play_shopSuccess;


+ (void)playEffect:(NSString *)fileName;
+ (void)playBg:(NSString *)fileName;


//静音
+ (void)close_sound;
//还原 声音
+ (void)open_sound;
@end
