//
//  MenuLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "CCLayer.h"
#import "MenuTopInfo.h"
#import "MenuScoreInfo.h"
#import "MenuSubTopInfo.h"
#import "BaseLayer.h"
@interface MenuBaseLayer : BaseLayer{
    CCSprite *menuLineBlue_ ;
    CCSprite *menuLinePink_ ;
    MenuTopInfo *menuTopInfo_ ;
    
    MenuSubTopInfo *menuSubTopInfo_ ;
    
    MenuScoreInfo *menuScoreInfo_ ;
    CGPoint commonInfoTopPoint_ ;
} 
- (void)setLinePinkPostion :(int)marginY;
- (void)reloadInfo;
+(id)scene;
@end
