//
//  BGLayer.h
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "BgTmxLayer.h" 
@interface BgTmxLayer : CCLayer 
{
    NSMutableDictionary* tempKeyDict_; 
    NSMutableDictionary* nowTileStartPointDict_;
    NSMutableDictionary* nowTileMapDict_;
    NSMutableDictionary* baseTileMapDict_;
    NSMutableDictionary* level0TileMapDict_; 
    NSMutableDictionary* level1TileMapDict_; 
    NSMutableDictionary* level2TileMapDict_; 
    NSMutableDictionary* level3TileMapDict_;
    NSMutableDictionary* level4TileMapDict_;
    NSMutableDictionary* level5TileMapDict_; 
    NSMutableDictionary* level6TileMapDict_;
    
    NSMutableDictionary* char0TileMapDict_;
    NSMutableDictionary* char1TileMapDict_;
    NSMutableDictionary* char2TileMapDict_;
    int tmxCnt_;
    int nowTmxCnt_;
}



//开放 地图信息给外部访问
@property float tileMapHeightAll; 
@property float tileMapWidthAll; 
@property float tileMapSpeed; 

+(BgTmxLayer*) sharedBgTmxLayer;

- (void)reset;
- (void)updateTMX:(ccTime)delta; 
//获取当前用户 在地图 碰撞的 box
- (NSDictionary* )getTouchBoxPropByTileLayer:(NSString*)tileLayerName :(CGPoint)tilePos;


- (CGPoint)getTouchBoxPosByTileLayer:(NSString*)tileLayerName :(CGPoint)tilePos;
@end
