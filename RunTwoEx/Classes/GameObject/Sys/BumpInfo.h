//
//  BumpInfo.h
//  RunTwo
//
//  Created by mjsong on 13-5-28.
//
//

#import <Foundation/Foundation.h>
@class BGLayer; 
#import "BgTmxLayer.h"
@interface BumpInfo : NSObject

@property CGPoint nowPoint ;
@property bool isBaffle;
@property bool isFloor;
@property bool isFloorNext; 
@property CGPoint nextPoint ;
@property bool isLife;
@property bool isEnd;

+ (BumpInfo*)objInit;//静态实列化方法
- (void)initBump:(BgTmxLayer *)bgTmxlayer :(CGPoint)nowPoint; //初始化 信息

- (void)initBumpByHero:(CrashType)crashType   :(Hero *)hero;
@end
