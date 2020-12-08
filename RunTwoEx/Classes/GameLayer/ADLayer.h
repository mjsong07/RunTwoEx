//
//  BGLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "ADLayer.h" 
@interface ADLayer : CCLayer
{
    NSMutableDictionary* tempKeyDict_;
    NSMutableDictionary* nowTileMapDict_;
	CCSpriteBatchNode* spriteBatch_;
    CCArray* baseArray_; 
	int numStripes_;  
    int layerType_;
    float adLayerWidthAll_;
} 

+ (id)objInit:(int)layerType :(int)cnt;
- (void)updateADLayer:(ccTime)delta;
@end
