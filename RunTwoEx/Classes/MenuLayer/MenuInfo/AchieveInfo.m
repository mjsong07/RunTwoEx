//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "AchieveInfo.h"  
@implementation AchieveInfo  
- (id)init:(int)level :(AchieveType)achieveType
{
    if (self = [super init]) {
        
        CCMenu *menu ;
        NSString *nowKey =@"";
        NSString *nowKeyFlag =@"";
        CCSprite  *frame = [CCSprite spriteWithFile:@"achieve_frame.png" ];
        CCSprite  *flagSprite = [CCSprite spriteWithFile:@"menu_finish.png" ]; 
        
        CCSprite  *titleSprite = nil;
        [CCMenuItemFont setFontSize:getRS(25)];
        CCMenuItemFont *titleNum = [CCMenuItemFont itemWithString:@"0" target:nil selector:nil];
        titleNum.scale = 1;
        [titleNum setColor:ccSOX_BLUE];
        
        if(achieveType==AchieveTypeScore){
            nowKey =[ NSString stringWithFormat:@"%@%d",G_KEY_ACHIEVEMENT_SCORE_L,level];
            nowKeyFlag =[ NSString stringWithFormat:@"%@%d%@",G_KEY_ACHIEVEMENT_SCORE_L,level,G_KEY_ACHIEVEMENT_FLAG];
            titleSprite = [CCSprite spriteWithFile:@"achieve_score.png" ]; 
        }
        else  if(achieveType==AchieveTypeDistance){
            nowKey =[ NSString stringWithFormat:@"%@%d",G_KEY_ACHIEVEMENT_DISTANCE_L,level];
            nowKeyFlag =[ NSString stringWithFormat:@"%@%d%@",G_KEY_ACHIEVEMENT_DISTANCE_L,level,G_KEY_ACHIEVEMENT_FLAG];
            titleSprite = [CCSprite spriteWithFile:@"achieve_distance.png" ]; 
        }
        else if(achieveType==AchieveTypeLife){ 
            nowKey =[ NSString stringWithFormat:@"%@%d",G_KEY_ACHIEVEMENT_LIFE_L,level]; 
            nowKeyFlag =[ NSString stringWithFormat:@"%@%d%@",G_KEY_ACHIEVEMENT_LIFE_L,level,G_KEY_ACHIEVEMENT_FLAG];
            titleSprite = [CCSprite spriteWithFile:@"achieve_life.png" ]; 
        }
        else if(achieveType==AchieveTypeStar){ 
            nowKey =[ NSString stringWithFormat:@"%@%d",G_KEY_ACHIEVEMENT_STAR_L,level]; 
            nowKeyFlag =[ NSString stringWithFormat:@"%@%d%@",G_KEY_ACHIEVEMENT_STAR_L,level,G_KEY_ACHIEVEMENT_FLAG];
            titleSprite = [CCSprite spriteWithFile:@"achieve_star.png" ]; 
        }
       
        int num = [SOXConfig getAchieveNum:nowKey];
        [titleNum setString:[SOXUtil intToString:num]];
        BOOL  flag = [SOXDBUtil loadInfoReturnBool:nowKeyFlag];
        if(flag == true){
            flagSprite.color = ccSOX_PINK;
        }
        //flagSprite.color = ccSOX_BLUE;
        
        CCMenuItemSprite *itemTitle  = nil;
        if(titleSprite !=nil){
            itemTitle  =  [ CCMenuItemSprite itemWithNormalSprite:titleSprite selectedSprite:nil
                                                           target:nil selector:nil ];
            
        }
        
        
        CCMenuItemSprite *itemTitleNum =  [ CCMenuItemSprite itemWithNormalSprite:titleNum selectedSprite:nil
                                                                         target:nil selector:nil ];
        CCMenuItemSprite *itemFlag =  [ CCMenuItemSprite itemWithNormalSprite:flagSprite selectedSprite:nil
                                                                           target:nil selector:nil ];
        
        menu = [CCMenu menuWithItems: itemTitle, itemTitleNum, itemFlag ,nil];   
        itemTitle.position = ccp(getRS(-70), 0);
        if(achieveType==AchieveTypeScore){
            itemTitle.position = ccp(getRS(-65), 0);
        }

        itemTitleNum.position = ccp(getRS(10), 0);
        itemFlag.position = ccp(getRS(80), 0);
        [menu setPosition:ccp(0, 0)];
        [self addChild: frame];  
        [self addChild: menu]; 
    }
    return self;
}
 @end
