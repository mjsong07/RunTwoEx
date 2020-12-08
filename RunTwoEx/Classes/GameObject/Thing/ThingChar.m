//
//  Thing.m
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "ThingChar.h"
@implementation ThingChar

+ (id)objInit:(ColorType)colorType
{
    ThingChar *base = [(ThingChar*)[self alloc] initWithImage:colorType];
  //  [base initAllAction];
	return [base autorelease];
}

+ (id)objBigInit
{
    ThingChar *base = [(ThingChar*)[self alloc] initWithBigImage];
    //  [base initAllAction];
	return [base autorelease];
}

//重写方法
-(void)setColor:(ccColor3B)color{
   CCSprite *bg= (CCSprite*)[self getChildByTag:0];
    [bg setColor:color];
}

-(void)setOpacity:(GLubyte)opacity{
    CCSprite *bg= (CCSprite*)[self getChildByTag:0];
    [bg setOpacity:opacity];
}

- (id)initWithImage:(ColorType)colorType
{
    NSString *imgName = @"box.png";// @"star0.png";box_big.png
     if (self = [super init]) {
        self.objType = ThingObjBox;
        self.thingType = colorType;
         CCSprite *bg= [CCSprite spriteWithFile:imgName ];
         if( colorType == ColorTypeBlue){
             [bg setColor:ccSOX_BLUE];
         } else if( colorType ==  ColorTypePink){
             [bg setColor:ccSOX_PINK];
         }
         
        label_= [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:getRS(32)];
        [self addChild:bg z:1 tag:0];
        [self addChild:label_ z:1 tag:1];
    }
	return self;
}

- (id)initWithBigImage
{
    NSString *imgName = @"box_big.png";// @"star0.png";box_big.png
    if (self = [super init]) {
        self.objType = ThingObjBox;
        self.thingType = ColorTypeBlue;
        CCSprite *bg= [CCSprite spriteWithFile:imgName ];
        [bg setColor:ccSOX_BLUE];
        label_= [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:getRS(32)];
        [self addChild:bg z:1 tag:0];
        [self addChild:label_ z:1 tag:1];
    }
	return self;
}


- (void)setChar:(NSString*)strChar {
    self.strChar = [strChar retain];
    [label_ setString:strChar];
}

- (void)initAllAction{
    id rep = [CCRepeatForever actionWithAction:self.baseImgAct];
    self.baseAct= [CCSequence actions:rep, nil];
}

- (void)baseDo{
    [self runAction:self.baseAct];
}
@end
