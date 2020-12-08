//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuAchieveInfo.h"  
#import "AchieveInfo.h"
@implementation MenuAchieveInfo 


- (NSString*)getImgName:(bool)flag :(NSString*)imgName
{
    NSString *str =imgName;
    if(flag== true){
         str = [NSString stringWithFormat:@"%@.png",imgName];
    }else{
        str = [NSString stringWithFormat:@"%@_flag.png",imgName];
    } 
    return str; 
}

- (id)init:(int)level
{
    if (self = [super init]) {
        //self.touchEnabled = false;
        AchieveInfo *score = [[[AchieveInfo alloc]init:level :AchieveTypeScore]autorelease];
        AchieveInfo *distance = [[[AchieveInfo alloc]init:level :AchieveTypeDistance]autorelease];
        AchieveInfo *life = [[[AchieveInfo alloc]init:level :AchieveTypeLife]autorelease];
        AchieveInfo *star = [[[AchieveInfo alloc]init:level :AchieveTypeStar]autorelease];
        int marginTop = 35;
        CGPoint commonTop = ccp(0 , 0);//  ccp(G_SCREEN_SIZE.width/2 , G_SCREEN_SIZE.height/2-50);
        score.position =  ccp(commonTop.x, commonTop.y+ getRS(marginTop*3) );
        distance.position =  ccp(commonTop.x, commonTop.y+ getRS(marginTop*1*2) );
         life.position =  ccp(commonTop.x, commonTop.y+getRS(marginTop*1)  );
        star.position =  ccp(commonTop.x, commonTop.y);  

        [self addChild: score];
        [self addChild: distance];
        [self addChild: life]; 
        [self addChild: star];  
    }
    return self;
}
 @end
