//
//  Thing.m
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "Thing.h" 
@implementation Thing

+ (id)objInit:(ColorType)thingType :(ThingObjType)objType
{
    
    BaseSprite *base = [(Thing *)[self alloc] initWithImage:thingType :objType];
    [base initAllAction];
    
//   CCLabelTTF *number= [CCLabelTTF labelWithString:@"A" fontName:@"Arial" fontSize:30];
//    [base addChild:number];
//    [number setPosition:ccp(number.position.x+10, number.position.y+10)];
//    [number setColor:ccSOX_PINK];
	return [base autorelease];
}

- (id)initWithImage:(ColorType)thingType :(ThingObjType)objType
{
    NSString *imgName = @"star0.png";// @"star0.png";
    if (objType == ThingObjStar) {
        imgName = @"star";
    }else if (objType == ThingObjLine) {
        imgName = @"line";
    }else if (objType == ThingObjBox) {
        imgName = @"box";
    }else if (objType == ThingObjLife) {
        imgName = @"life";
    }else if (objType == ThingObjFloor) {
        imgName = @"floor";
    }
    if( thingType == ColorTypeBlue){
        imgName = [NSString stringWithFormat:@"%@%d.png",imgName,0];
    } else if( thingType ==  ColorTypePink){
         imgName = [NSString stringWithFormat:@"%@%d.png",imgName,1];
    }else  if( thingType == ColorTypeRed || thingType == ColorTypeBlack   ){
         imgName = [NSString stringWithFormat:@"%@.png",imgName];//红色 不多 直接不加尾数
    } 
    if ((self = [super initWithSpriteFrameName:imgName])) {
        self.objType = objType;
        self.thingType = thingType;
        CCAnimation* baseAction = nil; 
      //  baseAction = [CCAnimation animationWithFileSingle:imgName];
       // self.baseImgAct = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:baseAction]];
    }
   
	return self;
}
- (void)initAllAction{ 
    id rep = [CCRepeatForever actionWithAction:self.baseImgAct];
    self.baseAct= [CCSequence actions:rep, nil];
}

- (void)baseDo{
    [self runAction:self.baseAct]; 
}
@end
