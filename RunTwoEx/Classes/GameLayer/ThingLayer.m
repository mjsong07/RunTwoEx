//
//  ThingLayer.m
//  RunTwo
//
//  Created by mjsong on 13-6-4.
//
//

#import "ThingLayer.h"
#import "ThingCache.h"
#import "CCTMXTiledMap.h"
#import "GameLayer.h" 
@implementation ThingLayer 

+ (id)objInit
{
	return [[[self alloc ]initWithMap] autorelease];
}
- (id)initWithMap  
{
    if(self = [super init]){ 
    } 
    return self; 
} 
//初始化 所有物体  地图开始 位置 ＋当前 地图块x 
- (void)initAllThings :(CCTMXTiledMap*)tileMap :(float)startPointX
{
    CCTMXLayer *objectLayer = nil;
    CCTMXLayer *floorLayer = nil;
    objectLayer = [tileMap layerNamed:@"ThingLayer"];
    
     floorLayer = [tileMap layerNamed:@"FloorLayer"];
    
    [objectLayer setVisible:false]; 
    CGSize layerSize = [objectLayer layerSize];
    float tilteMapWidth=    tileMap.position.x;
    //遍历每一个地图块
    id thingCache = [SOXObjCacheUtil sharedThingCache];
	for( int x=0; x<layerSize.width;x++) { 
        for (int y=0; y<layerSize.height; y++) {
            unsigned int tmpgid = [objectLayer tileGIDAt:ccp(x,y)];
            NSDictionary* properties = [tileMap propertiesForGID:tmpgid];
            if (properties)
            {
                 CGPoint nowPonit=ccp(getRS( x*32+16), getRS((layerSize.height-y)*32-16));//
                //   CGPoint nowPonit=ccp(x*G_TILE_WIDTH+G_TILE_WIDTH/2, (layerSize.height-y)*G_TILE_HEIGHT );//+32   //加上 每次地图得初始坐标x
                nowPonit=ccp(nowPonit.x+tilteMapWidth, nowPonit.y); 
                NSString* objType = [properties valueForKey:@"objType"];
                NSString* thingType = [properties valueForKey:@"colorType"];
                ThingObjType nowObjType=nil;
                ColorType nowColorType=nil; 
                if( [objType isEqualToString:@"star"] ){
                    nowObjType = ThingObjStar;
                } else  if( [objType isEqualToString:@"line"] ){
                    nowObjType = ThingObjLine;
                } else if( [objType isEqualToString:@"box"] ){
                    nowObjType = ThingObjBox;
                } else if( [objType isEqualToString:@"life"] ){
                    nowObjType = ThingObjLife;
                }
                if( [thingType isEqualToString:@"blue"] ){
                    nowColorType = ColorTypeBlue;
                } else  if( [thingType isEqualToString:@"pink"] ){
                    nowColorType = ColorTypePink;
                } else if( [thingType isEqualToString:@"red"] ){
                    nowColorType = ColorTypeRed;
                }
                
                
                if(nowObjType != ThingObjNull && nowColorType != ColorTypeNull){
                    //此处特殊处理  根据游戏的一定难度 自动 交换 颜色信息
                    if([SOXConfig getNowGameLevel] == T_LEVEL_HARD_COMMON_FAST){
                        if(nowColorType == ColorTypeBlue ||nowColorType == ColorTypePink ){
                           // int randomI = arc4random()%2;
                           // if(randomI == 0){//求余
                            int nowTimes=[SOXConfig getNowMapRunTimes];
                           // if(nowTimes>100){//如果已经超过100次 已经十分厉害  直接全部随机切换
                            
                           // }else{
                                if(nowTimes%3 == 0){//求余
                                    //开始
                                  //  [SOXDebug logStr:@"star to change thing color "];
                                    if(nowColorType == ColorTypeBlue){
                                        nowColorType =ColorTypePink;
                                    }else{
                                        nowColorType =ColorTypeBlue;
                                    }
                                }
                           // }
                        }
                    }
                    [thingCache showObj:nowColorType :nowObjType :nowPonit];
               }
            }
            
            unsigned int tmpgid2 = [floorLayer tileGIDAt:ccp(x,y)];
            NSDictionary* properties2 = [tileMap propertiesForGID:tmpgid2];
            if(properties2 != nil  ){
               
                 CGPoint nowPonit=ccp( getRS(x*32+16) , getRS((layerSize.height-y)*32-16));//
                //     CGPoint nowPonit=ccp(x*G_TILE_WIDTH+G_TILE_WIDTH/2, (layerSize.height-y)*G_TILE_HEIGHT );//+32   //-32
                //加上 每次地图得初始坐标x
                nowPonit=ccp(nowPonit.x+tilteMapWidth, nowPonit.y);
                NSString* isFloor = [properties valueForKey:@"isFloor"];
                ThingObjType nowObjType=ThingObjFloor;
                ColorType nowColorType=ColorTypeBlack; 
                [thingCache showObj:nowColorType :nowObjType :nowPonit];
            }
        }
	} 
}




 
//物件 也定时移动
- (void)updateThing:(ccTime)delta
{
   ThingCache *thingCache= [SOXObjCacheUtil sharedThingCache];
        if ( thingCache !=nil ) {
            CGPoint pos = thingCache.position;
            int speed= [SOXConfig getNowMapMoveSpeed]; 
            pos.x -= speed;//速度
            thingCache.position=pos;
        } 
}
 
@end
