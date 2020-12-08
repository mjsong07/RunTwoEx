//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"
@interface SOXUtil : NSObject

+ (NSString*)floatToString:(float)f;
+ (NSString*)doubleToString:(double)d;
+ (NSString*) intToString:(int)i;

+ (int)floatToInt:(float)f; 
+ (int)intToFloat:(int)i; 
+ (int)intToDouble:(int)i;


+ (NSString *)getFormatTimeStr:(int)time;
+ (NSString *)getFormatAllTimeStr:(float)time;
+ (NSString *)getFormatAllDistanceStr:(float)time;
+ (NSString*)isNull:(NSString *)str;
+ (NSString*)isNotNull:(NSString *)str;
+ (int)getRandomByDict  :(NSMutableDictionary*)dict;
+ (NSString*)createRandomCharList :(NSString*)strChar :(int)createCnt;

+ (NSString *)notRounding:(double)price afterPoint:(int)position; 
+(void)showAlert:(NSString *)title :(NSString *)message ; 
@end
