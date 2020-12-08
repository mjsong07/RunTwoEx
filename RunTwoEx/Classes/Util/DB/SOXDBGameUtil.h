//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"
@interface SOXDBGameUtil : NSObject
 //获取当前星星
+ (double)loadNowStar;
 //获取当前最大生命
+ (int)loadNowLife;
//获取当前最远距离
+ (double)loadBestDistance;

+ (double)loadBestScore;

+ (double)loadBestStar;
+ (bool)loadIsDebug;

+ (bool)loadBMXCharIsRunning;
@end
