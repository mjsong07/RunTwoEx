//
//  Debug.h
//  RunTwo
//
//  Created by mjsong on 13-5-28.
//
//

#import <Foundation/Foundation.h>
@class Hero;
@class BaseSprite;
@interface SOXDebug : NSObject

+ (void)logSprite:(BaseSprite*)sprite;
+ (void)logHero:(id)sprite;
+ (void)logStr:(NSString* )str;
+ (void)logTagStr:(NSString* )tag :(NSString* )str;
+ (void)logImgHW:(id)sprite; 

+ (void)logTagInt:(NSString* )tag :(int)i;
+ (void)logTagFloat:(NSString* )tag :(float)f;

+ (void)logActionState:(Hero*)hero; 
+ (void)logHW:(id)sprite; 
+ (void)logFloat:(float)f;
+ (void)logInt:(int)i;
+ (void)logBol:(bool)bol;
+ (void)logPonit:(CGPoint)point;
+ (void)logAnchorPoint:(id)sprite;

+ (void)testLongLoadingTime;
+ (void)drawRectFaster:(CGRect)rect;
@end
