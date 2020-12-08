//
//  MenuLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "MenuScoreInfo.h" 

@implementation MenuScoreInfo
 
- (id)init
{
	self = [super init];
	if (self) {
         
        CCSprite *starImg = [CCSprite spriteWithFile:@"menu_star.png" ];
        CCSprite *distanceImg = [CCSprite spriteWithFile:@"menu_distance.png" ];
        [starImg setColor:ccSOX_BLUE];
        [distanceImg setColor:ccSOX_BLUE];
        
        NSString  *BestScore = NSLocalizedString(@"BestScore", @"");
         NSString  *MaxDistance = NSLocalizedString(@"MaxDistance", @"");
         NSString  *MaxStar = NSLocalizedString(@"MaxStar", @"");
        
		CCMenuItemFont *titleScore= [CCMenuItemFont itemWithString:BestScore];
        CCMenuItemFont *titleDistance = [CCMenuItemFont itemWithString: MaxDistance];
        CCMenuItemFont *titleNowStars = [CCMenuItemFont itemWithString: MaxStar];
        
        
        titleScore.anchorPoint = ccp(0, 0.5);
        titleDistance.anchorPoint = ccp(0, 0.5);
        titleNowStars.anchorPoint = ccp(0, 0.5);
        
        NSString *strScoreDB =[SOXDBUtil loadInfo:G_KEY_LEADERBOARD_SCORE];//@"99999";
        if(![SOXUtil isNotNull:strScoreDB]) {
            strScoreDB = @"0";
        }
        
        NSString *strDistanceDB =[SOXDBUtil loadInfo:G_KEY_LEADERBOARD_DISTANCE];
        if(![SOXUtil isNotNull:strDistanceDB]) {
            strDistanceDB = @"0";
        }
        
        
        NSString *strStarCntDB =[SOXDBUtil loadInfo:G_KEY_LEADERBOARD_STAR];
        if(![SOXUtil isNotNull:strStarCntDB]) {
            strStarCntDB = @"0";
        }
        
        
        
        double doubleScore=[strScoreDB doubleValue] ;
        double doubleDistance=[strDistanceDB doubleValue] ;
        double doubleStarCnt=[strStarCntDB doubleValue] ;
        
        
        NSString *strScore = [SOXUtil notRounding:doubleScore afterPoint:0];
        NSString *strDistance = [SOXUtil notRounding:doubleDistance afterPoint:0];
        NSString *strStarCnt = [SOXUtil notRounding:doubleStarCnt afterPoint:0];
        
        
        
        
        
        CCMenuItemFont *labelScore = [CCMenuItemFont itemWithString:strScore target:nil selector:nil];
        CCMenuItemFont *labelTotalDistance = [CCMenuItemFont itemWithString:strDistance target:nil selector:nil];
        CCMenuItemFont *labelStarCnt = [CCMenuItemFont itemWithString:strStarCnt target:nil selector:nil];
        
        //如果 长度大于 8 设置字体为 18
        if(strScore.length > 8){
        [labelScore setFontSize:getRS(18)];
        }else{
        [labelScore setFontSize:getRS(30)];
        }
        [labelStarCnt setFontSize:getRS(18)];
        [labelTotalDistance setFontSize:getRS(18)];
        [labelStarCnt setColor:ccSOX_PINK];
        [labelScore setColor:ccSOX_PINK];
        [labelTotalDistance setColor:ccSOX_PINK];
        [titleScore setColor:ccSOX_BLUE];
        [titleDistance setColor:ccSOX_BLUE];
        [titleNowStars setColor:ccSOX_BLUE];
        
        [titleScore setPosition:ccp(getRS(-50), 0)];
        [titleDistance setPosition:ccp(getRS(-50),getRS(-25) )];
        [titleNowStars setPosition:ccp(getRS(-50), getRS(-50))];
        [labelScore setPosition:ccp(getRS(110), getRS(0))];
        [labelTotalDistance setPosition:ccp(getRS(110), getRS(-25))];
        [labelStarCnt  setPosition:ccp(getRS(110) ,getRS(-50) )];
        
        CCMenu *infoMenu = [CCMenu menuWithItems: labelStarCnt, labelScore, labelTotalDistance, titleScore,titleDistance,titleNowStars,   nil]; 
        
        [infoMenu setPosition:ccp(0,0) ];
        [self addChild: infoMenu z:1 tag:2 ]; 
	}
	return self;
} 
@end
