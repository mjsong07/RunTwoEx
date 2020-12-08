//
//  BGLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "BgTmxLayer.h"
#import "BGSprite.h"
#import "GameLayer.h"
#import "CCAnimationHelper.h"
#import "GameLayerInfo.h" 
@implementation BgTmxLayer


static BgTmxLayer* bgTmxLayer;
+(BgTmxLayer*) sharedBgTmxLayer
{
    if(bgTmxLayer == nil){
        bgTmxLayer = [[BgTmxLayer alloc] init];
    }
	return bgTmxLayer;
}



- (id)init
{
	if ((self = [super init])) {
        tmxCnt_ = 5;
        nowTileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        nowTileStartPointDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        baseTileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level0TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level1TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level2TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level3TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level4TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level5TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        level6TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        char0TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        char1TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        char2TileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:tmxCnt_];
        
        
        
        //固定 每关 5小关卡

        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level0_%d.tmx",i];
            //NSString *fileName = @"level6_2.tmx";
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level0TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level1_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level1TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level2_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level2TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level3_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level3TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level4_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level4TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }

        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level5_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level5TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"level6_%d.tmx",i];
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [level6TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        
        
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"char0_%d.tmx",i];
          //  NSString *fileName = @"char0_0.tmx";
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [char0TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"char1_%d.tmx",i];
           //  NSString *fileName = @"char1_0.tmx";
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [char1TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        for (int i = 0; i < tmxCnt_ ; i++) {
            NSString *fileName = [NSString stringWithFormat:@"char2_%d.tmx",i];
          //   NSString *fileName = @"char0_0.tmx";
            CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:fileName];
            [tileMap setVisible:false];
            [self addChild:tileMap  z:2 tag:T_OBJ_TMX_MAP];
            [char2TileMapDict_ setObject:tileMap forKey:[SOXUtil intToString:i] ];
        }
        
        
        //警告 FloorLayer 或者 ThingLayer  has no tiles 是因为 确实没有放置任何 东西
        //cocos2d: Warning: TMX Layer 'FloorLayer' has no tiles
        
        
        //重新设置 坐标 x
        [self resetAllPostion];  
	}  
	return self;
}
 
- (int)getRandomObjKey{
    id obj= nil;
    int deadCnt = 0;//防止 死循环
    int i = 0; 
    while (obj ==nil && deadCnt < 30 ) { 
         i= rand()%nowTmxCnt_;
        obj=  [tempKeyDict_ objectForKey:[SOXUtil intToString:i]];
        deadCnt++;
    } 
    return i;
}
//复制信息
- (void)tempDictdeepCopy{
     tempKeyDict_ = [NSMutableDictionary dictionary];
    for (id keys in  baseTileMapDict_) {
        [tempKeyDict_ setObject:keys forKey:keys]; 
    }
}
- (void)baseDictdeepCopy:(NSMutableDictionary*)dict{
    int keyStart = [baseTileMapDict_ count]; 
    for (id key in dict) { 
        CCTMXTiledMap *map= (CCTMXTiledMap*)[dict objectForKey:key];
        [baseTileMapDict_ setObject:map forKey:[SOXUtil intToString:keyStart]]; 
        keyStart++;
    }
}
//初始化 当前 基本得 集合 通过 多个地图 合并
- (void)initBaseTileMapDict{ 
    [baseTileMapDict_ removeAllObjects];
    
        if([SOXConfig getNowGameLevel]==T_LEVEL_EASY0){//第0关  学习过程
//            [self baseDictdeepCopy:level0TileMapDict_];
            [self setSingleMapByLevel];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_EASY1){ //第1关
//              [self baseDictdeepCopy:level1TileMapDict_];
             [self setNumMapByMapLevelIndex:1 :T_Map_1];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_EASY2){ //第2关
//            [self baseDictdeepCopy:level2TileMapDict_];
             [self setNumMapByMapLevelIndex:1 :T_Map_2];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_EASY3){ //第box0关
            [self createGameCharMap:T_Char_LEVEL_EASY];
        }
         else if([SOXConfig getNowGameLevel]==T_LEVEL_NORMAL1){//第3关
//            [self baseDictdeepCopy:level3TileMapDict_];
             [self setNumMapByMapLevelIndex:3 :T_Map_3];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_NORMAL2){//第4关
//           [self baseDictdeepCopy:level4TileMapDict_];
            [self setNumMapByMapLevelIndex:3 :T_Map_4];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_NORMAL3){//第box1关
           [self createGameCharMap:T_Char_LEVEL_NORMAL];
        }
    
         else if([SOXConfig getNowGameLevel]==T_LEVEL_HARD1){
            [self baseDictdeepCopy:level5TileMapDict_];
             [self setNumMapByMapLevelIndex:3 :T_Map_5];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_HARD2){
            [self baseDictdeepCopy:level6TileMapDict_];
            [self setNumMapByMapLevelIndex:3:T_Map_6];
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_HARD3){//第box2关
            [self createGameCharMap:T_Char_LEVEL_HARD];
        }
    
        else if([SOXConfig getNowGameLevel]==T_LEVEL_NORMAL_COMMON_FAST){//1-4关 加速  默认为 10   关卡和 box 各2次 ，先运行关卡
            int nowTimes=[SOXConfig getNowMapRunTimes];
            if(nowTimes%2 != 0){//求余
                [self createGameCharMap:T_Char_LEVEL_NORMAL];
            }else{
                [self setNormalAllMap];
                
                
                
            }
            
        } else if([SOXConfig getNowGameLevel]==T_LEVEL_HARD_COMMON_FAST){//1-6关 加速  默认为14
            int nowTimes=[SOXConfig getNowMapRunTimes];
            if(nowTimes%2 != 0){//求余 
                [self createGameCharMap:T_Char_LEVEL_HARD];
            }else{
                [self setHardAllMap];
            }
        } 
}


//简单关卡 只拿一关 加快游戏节奏

- (void)setSingleMapByLevel   {
    //    int i = arc4random()%tmxCnt_;
//    NSString *randomI = 0;//[SOXUtil intToString:level];
//    NSMutableDictionary *levelXTileMapDict =  [self getLevelTIleMapDictByKey:randomI];
//    int randomIndex = 0;//arc4random()%tmxCnt_;
//    CCTMXTiledMap *map=  (CCTMXTiledMap*)[levelXTileMapDict objectForKey:[SOXUtil intToString:randomIndex]];
    
    
    //   NSString *fileName = @"char0_0.tmx";
    CCTMXTiledMap *tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"test0_0.tmx"];
    [baseTileMapDict_ setObject:tileMap forKey:@"0"];
}





//该方法 取出 制定某关地图 list 的某几个随机内容
- (void)setNumMapByMapLevelIndex:(int)cnt :(int)mapLevelIndex {
        NSMutableDictionary *nowMap =  [self getLevelTIleMapDictByKey:mapLevelIndex];
        //此处使用for 才能保证 没有重复
      /*  for (int i = 0; i < cnt; i++) {
            CCTMXTiledMap *map=  (CCTMXTiledMap*)[nowMap objectForKey:[SOXUtil intToString:randomIndex]];
             [baseTileMapDict_ setObject:map forKey:[SOXUtil intToString:i]];
        }*/
       NSMutableDictionary *randomDict =  [self getMapRandomDict];
        int  showCnt = 0;
        //此处使用for 才能保证 没有重复
        for (int i = 0; i < [randomDict count]; i++) {
            NSString *randomI = [randomDict objectForKey:[SOXUtil intToString:i]];
            CCTMXTiledMap *map=  (CCTMXTiledMap*)[nowMap objectForKey:randomI];
            if( map != nil){
               [baseTileMapDict_ setObject:map forKey:[SOXUtil intToString:randomI]];
                showCnt ++ ;
            }
            if(showCnt >= cnt){
                break ;
            }
        }
}


- (void)setNormalAllMap {
    [self setNumAllMapByCnt:2 :3 :T_LEVEL_NORMAL_COMMON_FAST];
}

- (void)setHardAllMap {
    [self setNumAllMapByCnt:3 :3 :T_LEVEL_HARD_COMMON_FAST];
}



- (void)setNumAllMapByCnt:(int)mapCnt :(int)itemCnt :(int)speed {
    NSMutableDictionary *randomDict =  [self getMapRandomDict];
    if(randomDict != nil  && [randomDict count] > 0 ){
        int  showCnt = 0;
        //此处使用for 才能保证 没有重复
        for (int i = 0; i < [randomDict count]; i++) {
            NSString *randomI = [randomDict objectForKey:[SOXUtil intToString:i]];
            //特殊处理 一般等级的  不跑 第5，6 关
            if(speed == T_LEVEL_NORMAL_COMMON_FAST){
                if([@"5" isEqualToString:randomI] ){
                    continue;
                }else if([@"6" isEqualToString:randomI] ){
                    continue;
                }
            }
            if([randomI isEqualToString:@"0"]){//第 0 关卡不加载
                continue;
            }
            NSMutableDictionary *randomDict =  [self getLevelTIleMapDictByKey:[randomI intValue] ];
            if( randomDict != nil){
                [self setNumMapByMapLevelIndex:itemCnt :[randomI intValue]];//随机关 每个取 3个
                showCnt ++ ;
            }
            if(showCnt >= mapCnt){
                break ;
            }
        }
    }
}
/*
//该方法 取得的 每个集合5个关的 。。。
- (void)setNumAllMapByCnt:(int)cnt :(int)level {
    NSMutableDictionary *randomDict =  [self getMapRandomDict];
    if(randomDict != nil  && [randomDict count] > 0 ){
        int  showCnt = 0;
        //此处使用for 才能保证 没有重复
        for (int i = 0; i < [randomDict count]; i++) {
            NSString *randomI = [randomDict objectForKey:[SOXUtil intToString:i]];
            //特殊处理 一般等级的  不跑 第5，6 关
            if(level == T_LEVEL_NORMAL_COMMON_FAST){
                if([@"5" isEqualToString:randomI] ){
                    continue;
                }else if([@"6" isEqualToString:randomI] ){
                    continue;
                }
            }
            if([randomI isEqualToString:@"0"]){//第 0 关卡不加载
                continue;
            }
            
            NSMutableDictionary *randomDict =  [self getLevelTIleMapDictByKey:[randomI intValue] ];
            if( randomDict != nil){
                [self baseDictdeepCopy:randomDict];
                showCnt ++ ;
            }
            if(showCnt >= cnt){
                break ;
            }
        }
    }
}*/
- (NSMutableDictionary*)getLevelTIleMapDictByKey:(int)level {
    if(level == T_Map_0){
        return level0TileMapDict_;
    }else if(level == T_Map_1){
        return level1TileMapDict_;
    }else if(level == T_Map_2){
        return level2TileMapDict_;
    }else if(level == T_Map_3){
        return level3TileMapDict_;
    }else if(level == T_Map_4){
        return level4TileMapDict_;
    }else if(level == T_Map_5){
        return level5TileMapDict_;
    }else if(level == T_Map_6){
        return level6TileMapDict_;
    }
    return nil;
}



- (void)createGameCharMap:(int) gameCharLevel{
    int randomIndex = arc4random()%tmxCnt_;
    NSMutableDictionary *charTileMapDict = nil;
    if(gameCharLevel == T_Char_LEVEL_EASY){
        charTileMapDict = char0TileMapDict_;
    }else if(gameCharLevel == T_Char_LEVEL_NORMAL){
       charTileMapDict = char1TileMapDict_;
    }else if(gameCharLevel == T_Char_LEVEL_HARD){
        charTileMapDict = char2TileMapDict_;
    }
    if(charTileMapDict != nil){
        CCTMXTiledMap *map=  (CCTMXTiledMap*)[charTileMapDict objectForKey:[SOXUtil intToString:randomIndex]];
        [baseTileMapDict_ setObject:map forKey:@"0"];
        NSString *oriChar = [SOXMapUtil initBMXCharAll:gameCharLevel ];
        //调用显示 charTop 下拉界面
        [[GameHelper getGameLayer]initThingCharTop:oriChar];
    }
}


//获取 指定长度的 随机数
- (NSMutableDictionary*)getMapRandomDict  {
    NSMutableDictionary *tempKeyDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *returnDict= [NSMutableDictionary dictionary];
   for (int i = 0; i <= 6; i++) {
       [tempKeyDict setObject:[SOXUtil intToString:i] forKey:[SOXUtil intToString:i]];
    }
    for (int i = 0; i <= 6; i++) {
        int objKey= [SOXUtil getRandomByDict :tempKeyDict ];
        [returnDict setObject:[SOXUtil intToString:objKey] forKey:[SOXUtil intToString:i]];
        [tempKeyDict removeObjectForKey:[SOXUtil intToString:objKey]];
    }
    return returnDict;
}



////重新设置 当前所有 地图得  x坐标
- (void)resetAllPostion{
    _tileMapWidthAll= 0;
    [self initBaseTileMapDict];
    nowTmxCnt_ = [baseTileMapDict_ count];
    ThingCache *thingCache = [SOXObjCacheUtil sharedThingCache];
    [thingCache hiddenAll]; 
    [nowTileMapDict_ removeAllObjects];
    [nowTileStartPointDict_ removeAllObjects];  
    tempKeyDict_ = [NSMutableDictionary dictionary];
    for (id keys in  baseTileMapDict_) {
        [tempKeyDict_ setObject:keys forKey:keys];
    } 
    //打乱 当前得 排序方式
    int cnt= [baseTileMapDict_  count];
    for (int i = 0; i < cnt; i++) {
        //int  objKey= [self getRandomObjKey];
        int objKey= [SOXUtil getRandomByDict :tempKeyDict_ ];
        id newObj=  [baseTileMapDict_ objectForKey:[SOXUtil intToString:objKey]];
        [nowTileMapDict_ setObject:newObj forKey:[SOXUtil intToString:i]];  
        [tempKeyDict_ removeObjectForKey:[SOXUtil intToString:objKey]];
    } 
    ThingLayer *thingLayer=  [GameHelper getThingLayer];
    
    float nowWidth = 0; //从屏幕得 最右边开始
    
    //判断当前 游戏如果是第一关卡 拉长第一个场景距离
    if([SOXConfig getNowGameLevel] == T_LEVEL_EASY0){
        nowWidth =  G_SCREEN_SIZE.width+200;//
    }else{
        nowWidth =  G_SCREEN_SIZE.width+10;//
    }
    
    for (int i = 0; i < [nowTileMapDict_  count]; i++) {
         CCTMXTiledMap* tileMap  = [nowTileMapDict_ objectForKey:[SOXUtil intToString:i]];
        if ( tileMap !=nil ) {
//            [tileMap setVisible:true]; 
            float  tileMapWidth = tileMap.mapSize.width * tileMap.tileSize.width;
            tileMap.position = ccp(nowWidth ,tileMap.position.y );
            //根据地图 初始化 
            [thingLayer initAllThings:tileMap :nowWidth]; 
            NSNumber *number=[NSNumber numberWithFloat:nowWidth]; 
            [nowTileStartPointDict_ setObject:number forKey:[SOXUtil intToString:i]];
             nowWidth=nowWidth+tileMapWidth;//- G_SCREEN_SIZE.width
             _tileMapWidthAll =nowWidth  ;
        }
    }
    [thingCache setPosition:ccp(0, thingCache.position.y)] ; 
}
 
- (CCTMXTiledMap*)getNowshowingDict
{
    CCTMXTiledMap *tileMap; 
    for (int i = 0; i < [nowTileMapDict_ count ]; i++)
	{
        tileMap = [nowTileMapDict_ objectForKey:[SOXUtil intToString:i]];
        if ( tileMap !=nil ) {
            CGPoint pos = tileMap.position;
            if (pos.x>=-(tileMap.contentSize.width)+(82+16) && pos.x <=(82+16) ) { 
                return tileMap;
            }
        }
	}
    return nil;
}


- (void)reset{
    
 [self resetAllPostion];
}


- (void)updateTMX:(ccTime)delta
{ 
	CCTMXTiledMap *tileMap; 
    for (int i = 0; i < [nowTileMapDict_ count ]; i++)
	{ 
        tileMap = [nowTileMapDict_ objectForKey:[SOXUtil intToString:i]];
        if ( tileMap !=nil ) {
            CGPoint pos = tileMap.position;
            if(i == 0){
                if (pos.x < -(_tileMapWidthAll)) { 
                    int nowTimes=[SOXConfig getNowMapRunTimes];
                    nowTimes++;
                    [SOXConfig setNowMapRunTimes:nowTimes];
                   // [SOXDebug logStr:@"reset the map"];
                    [self resetAllPostion];
                    
                    if(G_DEBUG_ENABLE == 1){
                        GameLayerInfo *info = [GameHelper getGameLayerInfo];
                        NSString *strLevel = [NSString stringWithFormat:@"level:%i", [SOXConfig getNowGameLevel]];
                        NSString *strSpeed = [NSString stringWithFormat:@"speed:%i",[SOXUtil floatToInt: [SOXConfig getNowMapMoveSpeed]]   ];
                        NSString *strMapCnt = [NSString stringWithFormat:@"mapCnt:%i", [nowTileMapDict_ count]];
                        
                        NSString *strMapTimes = [NSString stringWithFormat:@"times:%i",[SOXUtil floatToInt: [SOXConfig getNowMapRunTimes]]   ];
                        
                        
                        [info.levelLabel setString:strLevel];
                        [info.speedLabel setString:strSpeed];
                        [info.mapCntLabel setString:strMapCnt];
                        
                        [info.mapTimesLabel setString:strMapTimes];
                        
                        
                        
                    }
                    
                    break;
                }
            } 
            int speed= [SOXConfig getNowMapMoveSpeed]; 
            pos.x -= speed;//速度
            tileMap.position = pos; 
        }  
	} 
}  
 
//获取当前用户 碰撞的 box
- (NSDictionary* )getTouchBoxPropByTileLayer:(NSString*)tileLayerName :(CGPoint)tilePos
{ 
    // 由于有可能是 两个正在 连接得 地图 所以需要判断两个地图 
     NSDictionary *properties =nil;
    CCTMXTiledMap *tileMap = [self getNowshowingDict]; 
         CCTMXLayer* eventLayer = [tileMap layerNamed:tileLayerName]; 
         //此处特殊处理  如果地图的x坐标大于0,人物使用正常整个x坐标，如果地图小于0则使用需要补加32的x校验 
         CGPoint nowTilePos=tilePos;
         if(tileMap.position.x>0){//tilePos
          //new11= ccp(tilePos.x-32, tilePos.y);
         }else{
             
         } 
         CGPoint newTilePos = [SOXMapUtil getPonitByMapTile:nowTilePos tileMap:tileMap];
         bool flag = [SOXMapUtil chkPointInTMX:newTilePos :tileMap];
         if (flag == true) {
             int tileGID = [eventLayer tileGIDAt:newTilePos];
             if (tileGID != 0)
             {
                 properties = [tileMap propertiesForGID:tileGID];
                 return properties;
             }
         }  
    return properties;
}



//获取当前用户 碰撞的 box 的地图x,y
- (CGPoint)getTouchBoxPosByTileLayer:(NSString*)tileLayerName :(CGPoint)tilePos
{ 
    CCTMXTiledMap *tileMap = [self getNowshowingDict]; 
    //此处特殊处理  如果地图的x坐标大于0,人物使用正常整个x坐标，如果地图小于0则使用需要补加32的x校验
    CGPoint nowTilePos=tilePos; 
    CGPoint newTilePos = [SOXMapUtil getPonitByMapTile:nowTilePos tileMap:tileMap];
    return  newTilePos;
}

- (void)dealloc
{
    [nowTileMapDict_ release];
    [nowTileStartPointDict_ release];
    [baseTileMapDict_ release];
    [level0TileMapDict_ release];
    [level1TileMapDict_ release];
    [level2TileMapDict_ release];
    [level3TileMapDict_ release];
    [level4TileMapDict_ release];
    [level5TileMapDict_ release];
    [level6TileMapDict_ release];
    [char0TileMapDict_ release];
    [char1TileMapDict_ release];
    [char2TileMapDict_ release];
    
    
    
    
    [super dealloc];
}
 @end
