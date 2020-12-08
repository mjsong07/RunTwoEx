//
//  GameSettingLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//
 
#import "MenuBaseLayer.h" 
#import <GameKit/GameKit.h>  
#import "GameCenterManager.h"
#import "MenuAchieveInfo.h"
@class GameCenterManager;
@interface MenuAchieveLayer : MenuBaseLayer{ 
    
    CCSprite *scoreL1 ;
    CCSprite *distanceL1;
    CCSprite *starL1 ;
    CCSprite *lifeL1 ;
    CCSprite *scoreL2 ;
    CCSprite *starL2 ;
    
    MenuAchieveInfo *achieveInfoL1_;
    MenuAchieveInfo *achieveInfoL2_;
    MenuAchieveInfo *achieveInfoL3_;
    MenuAchieveInfo *achieveInfoL4_;
    
    CCMenuItemToggle *itemTogglelevel1_;
    CCMenuItemToggle *itemTogglelevel2_;
    CCMenuItemToggle *itemTogglelevel3_;
    CCMenuItemToggle *itemTogglelevel4_;
    
}

+ (id)scene;
@end
