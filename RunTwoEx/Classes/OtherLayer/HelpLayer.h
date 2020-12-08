//
//  GameSettingLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//

#import "BaseLayer.h"

@interface HelpLayer : BaseLayer{
    int nowIndex_; 
    CCSprite *btnA_ ;
    CCSprite *btnB_;
    CCSprite *btnC_ ;
    CCLabelTTF *btnA_label_;
    CCLabelTTF *btnB_label_  ;
    CCLabelTTF *btnC_label_ ;
    CCSprite *hero_run_  ;
    CCSprite *hero_jump_ ;
    CCSprite *hero_change_;
    CCSprite *help_scroll_;
    
     CCSprite *help1_arrow_;
     CCSprite *help2_arrow_;
     CCSprite *help3_arrow_;
    
    
}
+ (id)scene;
@end
