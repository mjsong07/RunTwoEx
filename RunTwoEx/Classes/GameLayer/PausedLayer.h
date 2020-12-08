//
//  PausedLayer
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "CCLayer.h" 
@interface PausedLayer : CCLayer{
    CCMenu *menu_;
    CCMenu *menu2_;
}
- (void)showLayer;
- (void)hiddenLayer;
@end
