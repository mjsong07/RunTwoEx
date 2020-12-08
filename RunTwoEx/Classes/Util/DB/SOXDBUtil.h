//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"
@interface SOXDBUtil : NSObject

+ (void)saveInfo:(NSString *)key :(NSString *) value;
+ (NSString *)loadInfo:(NSString *)key;
+ (void)initInfoByMenuItem:(CCMenuItemToggle *)menuItem :(NSString *)key;
+ (BOOL)updateInfoByInt:(NSString *)key :(int) value;
+ (BOOL)updateInfoByFloat:(NSString *)key :(float) value;

+ (BOOL)updateInfoByDouble:(NSString *)key :(double) value;
+ (int)loadInfoReturnInt:(NSString *)key;

+ (double)loadInfoReturnDouble:(NSString *)key;
+ (BOOL)loadInfoReturnBool:(NSString *)key; 

+ (BOOL)chkIsNeedUpdateByFloat:(NSString *)key :(float) value;

+ (BOOL)chkIsNeedUpdateByInt:(NSString *)key :(int) value;

+ (BOOL)chkIsNeedUpdateByDouble:(NSString *)key :(double) value;


+ (void)updateInfoByBool:(NSString *)key :(BOOL) value;
@end
