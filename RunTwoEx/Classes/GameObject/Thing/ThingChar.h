//
//  Thing.h
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "BaseSprite.h"
#import "Thing.h"
#import "BaseThing.h"
@interface ThingChar : BaseThing{
    CCLabelTTF* label_;
}

- (id)initWithImage:(ColorType)colorType;
@property(nonatomic,assign)NSString* strChar;
- (void)setChar:(NSString*)strChar ;
+ (id)objInit:(ColorType)thingType;

+ (id)objBigInit;


- (id)initWithBigImage;
@end
