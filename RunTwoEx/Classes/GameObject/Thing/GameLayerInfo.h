//
//  HeroInfo.h
//  RunTwo
//
//  Created by mjsong on 13-5-26.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"  
#import "BaseSprite.h"
@interface GameLayerInfo : CCSprite  {
}

+ (id)gameLayerInfoInit;
- (id)initAll;
@property(nonatomic,assign)CCLabelTTF* levelLabel;

@property(nonatomic,assign)CCLabelTTF* speedLabel;

@property(nonatomic,assign)CCLabelTTF* mapCntLabel;
    
 @property(nonatomic,assign)CCLabelTTF* mapTimesLabel;
    
    

@end
