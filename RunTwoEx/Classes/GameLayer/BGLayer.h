//
//  BGLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "BaseLayer.h" 
@interface BGLayer : CCLayer 
{
	CCSpriteBatchNode* spriteBatch_;  
   // CCArray* baseArray_;
    //int numStripes_; //背景数量
} 

- (void)updateBGLayer:(ccTime)delta;
@end
