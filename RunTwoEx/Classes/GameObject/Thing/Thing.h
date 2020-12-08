//
//  Thing.h
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "BaseSprite.h"
#import "BaseThing.h"
@interface Thing : BaseThing{
    
}
+ (id)objInit:(ColorType)thingType :(ThingObjType)objType;
- (id)initWithImage:(ColorType)thingType :(ThingObjType)objType;
 @end
