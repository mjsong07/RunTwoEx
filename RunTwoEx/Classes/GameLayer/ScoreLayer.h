//
//  ScoreLayer
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "CCLayer.h"
@interface ScoreLayer : CCLayer{ 
    CCLabelTTF *labelNowDistance_;
    CCLabelTTF *labelNowStar_;
    CCLabelTTF *labelNowScore_;
    CCMenu *menu_;
    CCMenu *menuBack_; 
    
    
    NSMutableDictionary* nowScoreMapDict_;
} 
- (void)showLayer;


- (NSMutableDictionary*)updateDBScoreInfo;
- (void)hiddenLayer;
@end
