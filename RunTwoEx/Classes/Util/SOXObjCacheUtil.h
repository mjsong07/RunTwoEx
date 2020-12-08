//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"
@interface SOXObjCacheUtil : NSObject
{
    
}

+(void)initAllThingCache ;
+(ThingCache*)sharedThingCache ;
+(ThingCache*)sharedThingCacheNotMove ;
@end
