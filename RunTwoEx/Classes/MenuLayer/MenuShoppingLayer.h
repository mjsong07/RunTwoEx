//
//  GameSettingLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//
 
#import "MenuBaseLayer.h"
#import "MBProgressHUD.h"
//MBProgressHUDDelegate
@interface MenuShoppingLayer : MenuBaseLayer<UIAlertViewDelegate>{ 
    CCMenu *menuStar1000_ ;
    CCMenu *menuStar3000_ ; 
    CCMenu *menuLife1_ ;
    CCMenu *menuLife3_ ;  
    CCLabelTTF *labelLoading_;
    
}
- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay ;
@property (retain) MBProgressHUD *hud;
+ (id)scene;
@end
