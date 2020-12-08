//
//  SOXMapUtil.m
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import "SOXObjCacheUtil.h"
@implementation SOXObjCacheUtil

static ThingCache* instanceOfThingCacheNotMove;
static ThingCache* instanceOfThingCache;

+(void)initAllThingCache {
    //加在资源 图片
    [self loadAllFrameCache];
    instanceOfThingCache = [[ThingCache objInit]retain]; 
}


+ (void)loadAllFrameCache
{
    //加在资源 图片
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    /*[frameCache addSpriteFramesWithFile:@"hero.plist"];
    [frameCache addSpriteFramesWithFile:@"bg.plist"];
    [frameCache addSpriteFramesWithFile:@"ad.plist"];
    [frameCache addSpriteFramesWithFile:@"thing.plist"];*/
}

+(ThingCache*)sharedThingCache {
    return instanceOfThingCache;
}

+(ThingCache*)sharedThingCacheNotMove {
    return instanceOfThingCacheNotMove;
}


@end
