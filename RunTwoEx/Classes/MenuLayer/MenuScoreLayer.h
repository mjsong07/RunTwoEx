//
//  GameSettingLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//
 
#import "MenuBaseLayer.h"

#import "MBProgressHUD.h"
#import "Reachability.h"

 



@interface MenuScoreLayer : MenuBaseLayer<  GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>{
     
} 
+ (id)scene;

@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain)Reachability *reach;//基本动画
@property NetworkStatus netStatus;//基本动画

@end
