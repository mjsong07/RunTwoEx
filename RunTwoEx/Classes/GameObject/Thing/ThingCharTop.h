//
//  MenuLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//
 

@interface ThingCharTop : BaseSprite{
    
}

@property(nonatomic,assign)NSString* strVal;

 

- (id)initBase ;
- (id)initAll :(NSString*) strVal;

- (CGPoint)getCenterPosition ;

- (void)updateByStrVal;
- (void)success;
//失败
- (void)fail;
@end
