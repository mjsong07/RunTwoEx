//
//  MenuShoppingLayer
//  RunTwo
//
//  Created by mjsong on 13-10-8.
//
//

#import "MenuShareLayer.h" 
#import "MenuScoreInfo.h"
#import "ShareManager.h"
@implementation MenuShareLayer 

+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuShareLayer *nowLayer = [MenuShareLayer node];
    [scene addChild:nowLayer];  
    return scene;
}


- (id)init
{
    if (self = [super init]) { 
        double nowScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
        MenuScoreInfo *scoreInfo = [[[MenuScoreInfo alloc]init]autorelease];
        MenuNavInfo *backNav = [[[MenuNavInfo alloc]init:T_SCENE_INDEX]autorelease];
        
        [scoreInfo setPosition: G_STYLE_MENULAYER_MARGIN_TOP2 ]; 
      //  [shareInfo setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height-210 ) ];
       
        
        [self addChild: backNav]; 
       // [self addChild:shareInfo];
        [self addChild:scoreInfo];
        
        CCDelayTime *delay  = [CCDelayTime actionWithDuration:0.5f];
        id fun = [CCCallFunc actionWithTarget:self selector:(@selector(autoShowSharePage))];
        
        id seq = [CCSequence actions: delay,fun,nil];
        [self runAction:seq];
    } 
    return self;
}

- (void)autoShowSharePage{
   // [[labelNowScore_ string ]doubleValue] ;
    
    NSString *strScoreDB =[SOXDBUtil loadInfo:G_KEY_LEADERBOARD_SCORE];//@"99999";
    if(![SOXUtil isNotNull:strScoreDB]) {
        strScoreDB = @"0";
    }
    double  score =[strScoreDB doubleValue] ;
    NSString *shareContent =NSLocalizedString(@"shareContent", @"");
    if( score<=0){
        
    }else{
        NSString *shareScoreContent =NSLocalizedString(@"shareScoreContent", @"");
        NSString *shareScoreContentBy =NSLocalizedString(@"shareScoreContentBy", @"");
        NSString *strScore =[SOXUtil notRounding:score afterPoint:0];
        shareContent = [NSString  stringWithFormat:@"%@ %@ %@!",shareScoreContent,strScore,shareScoreContentBy];
    }
    UIImage *image= [SOXGameUtil makeaShot];
    [ShareManager showShareComponentWithText:shareContent image:image urlString:G_KEY_SOX_RUNTWO_URL];
}
@end
