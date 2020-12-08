//
//  MenuLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//
 

@interface MenuTopInfo : BaseSprite{  
    
    CCLabelTTF *labelLife_ ;
    CCLabelTTF *labelStar_ ;
    CCSprite *star_ ;
    CCSprite *life_ ;
    CCSprite *frame_ ; 
}

- (void)reloadInfo;
@end
