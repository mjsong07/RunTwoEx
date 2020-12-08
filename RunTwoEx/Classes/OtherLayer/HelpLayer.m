//
//  GameSettingLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//

#import "HelpLayer.h"

@implementation HelpLayer
+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_HELP];
    HelpLayer *nowLayer = [HelpLayer node];
    [scene addChild:nowLayer];
    return scene;
}
- (id)init
{
    if (self = [super init]) {  
//        btnA_label_ = [CCSprite spriteWithFile:@"help_label_a.png" ];
//        btnB_label_ = [CCSprite spriteWithFile:@"help_label_b.png" ];
//        btnC_label_ = [CCSprite spriteWithFile:@"help_label_c.png" ];
        NSString  *help1 = NSLocalizedString(@"help1", @"");
        NSString  *help2 = NSLocalizedString(@"help2", @"");
        NSString  *help3 = NSLocalizedString(@"help3", @"");
        
           help1_arrow_ = [CCSprite spriteWithFile:@"arrow_right.png" ];
           help2_arrow_ = [CCSprite spriteWithFile:@"arrow_right.png" ];
           help3_arrow_ = [CCSprite spriteWithFile:@"arrow_left.png" ];
        
         btnA_label_ = [CCLabelTTF labelWithString:help1  fontName:@"HelveticaNeue" fontSize:getRS(20)];
         btnB_label_ = [CCLabelTTF labelWithString:help2  fontName:@"HelveticaNeue" fontSize:getRS(20)];
         btnC_label_ = [CCLabelTTF labelWithString:help3  fontName:@"HelveticaNeue" fontSize:getRS(20)];
         btnA_label_.color = ccSOX_BLUE;
         btnB_label_.color = ccSOX_BLUE;
         btnC_label_.color = ccSOX_BLUE;
        
        btnA_ = [CCSprite spriteWithFile:@"help_btn_a.png" ]; 
        btnB_ = [CCSprite spriteWithFile:@"help_btn_b.png" ];
        btnC_ = [CCSprite spriteWithFile:@"help_btn_c.png" ];
        hero_run_ = [CCSprite spriteWithFile:@"help_run.png" ];
        hero_jump_ = [CCSprite spriteWithFile:@"help_jump.png" ];
        help_scroll_ = [CCSprite spriteWithFile:@"help_scroll.png" ]; 
        hero_change_ = [CCSprite spriteWithFile:@"help_change_color.png" ]; 
        
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        nowIndex_ = 1;
     
        
        [btnC_ setPosition:ccp(getRS(30) , getRS(28))];
        [btnB_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(32), getRS(70))];
        [btnA_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(80), getRS(30))];
        
        [btnA_label_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(270), getRS(90)) ];
        
        [btnB_label_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(210), getRS(140)) ];
        [btnC_label_ setPosition:ccp(getRS(200), getRS(110)) ];
//        btnC_label_.anchorPoint = ccp(0, 0.5);
        
        [hero_run_ setPosition:ccp(getRS(80), getRS(40))];
        [hero_change_ setPosition:ccp(getRS(80), getRS(40))];

        [hero_jump_ setPosition:ccp(getRS(80), getRS(80))];
        [help_scroll_ setPosition:ccp(getRS(100), getRS(40))];
        
        
        
        [help1_arrow_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(140), getRS(70)) ];
        [help2_arrow_ setPosition:ccp(G_SCREEN_SIZE.width-getRS(100), getRS(120)) ];
        [help3_arrow_ setPosition:ccp(getRS(80), getRS(80))];
        
        
        [btnA_label_ setVisible:false];
        [btnB_label_ setVisible:false];
        [btnC_label_ setVisible:false];
        [hero_run_ setVisible:false];
        [hero_jump_ setVisible:false];
        [hero_change_ setVisible:false];
        [help_scroll_ setVisible:false];
        
        
        [help1_arrow_ setVisible:true];
        [help2_arrow_ setVisible:false];
        [help3_arrow_ setVisible:false];
        
        
        //默认显示滚动
        [btnA_label_ setVisible:true];
        [help_scroll_ setVisible:true];
        
         
        [self addChild:bgcolor z:-1 ];
        [self addChild:btnA_];
        [self addChild:btnB_];
        [self addChild:btnC_];
        [self addChild:btnA_label_];
        [self addChild:btnB_label_];
        [self addChild:btnC_label_];
        [self addChild:hero_run_];
        [self addChild:hero_jump_];
        [self addChild:hero_change_];
        [self addChild:help_scroll_];
        
        [self addChild:help1_arrow_];
        [self addChild:help2_arrow_];
        [self addChild:help3_arrow_];
        
        
        // [self addChild:bg z:-1 tag:2];
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [SOXSoundUtil play_button];
    nowIndex_++;
    if(nowIndex_==1){
        [help_scroll_ setVisible:true];
        [hero_jump_ setVisible:false]; 
        [hero_change_ setVisible:false]; 
        
        [btnA_label_ setVisible:true];
        [btnB_label_ setVisible:false];
        [btnC_label_ setVisible:false];
        
        
        [help1_arrow_ setVisible:true];
        [help2_arrow_ setVisible:false];
        [help3_arrow_ setVisible:false];
        
        
    }else if(nowIndex_==2){
        [help_scroll_ setVisible:false];
        [hero_jump_ setVisible:true];
        [hero_change_ setVisible:false];
        
        [btnA_label_ setVisible:false];
        [btnB_label_ setVisible:true];
        [btnC_label_ setVisible:false];
        
        
        [help1_arrow_ setVisible:false];
        [help2_arrow_ setVisible:true];
        [help3_arrow_ setVisible:false];

    }else if(nowIndex_==3){
        [help_scroll_ setVisible:false];
        [hero_jump_ setVisible:false];
        [hero_change_ setVisible:true];
        
        [btnA_label_ setVisible:false];
        [btnB_label_ setVisible:false];
        [btnC_label_ setVisible:true];
        
        
        [help1_arrow_ setVisible:false];
        [help2_arrow_ setVisible:false];
        [help3_arrow_ setVisible:true];

    }else{
        CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
        [[CCDirector sharedDirector] replaceScene:newScene];
    } 
} 
@end
