//
//  BumpInfo.m
//  RunTwo
//
//  Created by mjsong on 13-5-28.
//
//

#import "BumpInfo.h"
#import "GameLayer.h"
#import "BgTmxLayer.h"
@implementation BumpInfo

+ (BumpInfo*)objInit
{
    BumpInfo *info=[[[BumpInfo alloc]init]autorelease] ;
    return info;
}


- (void)initBumpByHero:(CrashType)crashType   :(Hero *)hero
{
    id thingCache = [SOXObjCacheUtil sharedThingCache];
    self.isFloor =  [thingCache chkAllIsFloor:crashType :hero  ];
}

- (void)initBump:(BgTmxLayer *)bgTmxlayer :(CGPoint)nowPoint
{
    self.nowPoint = nowPoint;  
    NSDictionary *checkBox2 = [bgTmxlayer getTouchBoxPropByTileLayer:@"FloorLayer" :nowPoint]; 
    self.isFloor = [self chkBoxIsTrue:checkBox2 :@"isFloor"];  
}
- (bool)chkBoxIsTrue:(id)box :(NSString*)key
{
    bool flag=false;
    if (box != nil) {
        NSString* isProperty = [box valueForKey:key];
        if([isProperty boolValue] == YES) {
            flag=YES;
        }
    }
    return flag;
}

@end
