//
//  SOXMapUtil.m
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import "SOXMapUtil.h"
#import "CCTMXTiledMap.h"
#import "Hero.h"
@implementation SOXMapUtil   

//获取 当前 精灵 实际图片rect（） 通过动态输出的 textureRect（也就是实际显示图片的 大小）
+ (CGRect)spriteToRect:(CCSprite*)sp
{
    CGRect rect = CGRectMake(sp.position.x - sp.textureRect.size.width/2, sp.position.y - sp.textureRect.size.height/2, sp.textureRect.size.width, sp.textureRect.size.height);  
  return rect;
}

//获取 当前 精灵 实际图片rect（） 通过动态输出的 textureRect（也就是实际显示图片的 大小）
+ (CGRect)pointToRect:(CGPoint)position
{
    CGRect rect = CGRectMake( position.x ,  position.y , G_TILE_WIDTH, G_TILE_HEIGHT);
    return rect;
}


//获取 主角人物实际图片的rect    特殊处理 要处理滚动 rect高度 调小
+ (CGRect)spriteToRectByHero:(CCSprite*)sp
{
    Hero* hero = (Hero*)sp;
    CGRect rect;
    //如果当前是滚动 //微调  
    if(hero.nowActState == kActionStateScroll){ 
      rect = CGRectMake(sp.position.x - sp.textureRect.size.width/2,
                        sp.position.y - sp.textureRect.size.height-8,
                        sp.textureRect.size.width,
                        sp.textureRect.size.height);
    }else{ 
      rect = CGRectMake(sp.position.x - sp.textureRect.size.width/2, sp.position.y - sp.textureRect.size.height/2-10, sp.textureRect.size.width, sp.textureRect.size.height);
    } 
    return rect;
} 
//获取计算出 当前精灵在地图 的rect
+ (CGRect)spriteToRectByMap:(CCSprite*)sp :(float)subX
{
    CGPoint nowPoint =ccp(sp.position.x+subX, sp.position.y);//[SOXMapUtil getNowPointInMapLocation:sp.position tileMap:tileMap];
    CGRect rect = CGRectMake(nowPoint.x - sp.textureRect.size.width/2, nowPoint.y - sp.textureRect.size.height/2, sp.textureRect.size.width, sp.textureRect.size.height);
    return rect;
}

 

//检查人物是否 碰撞 地图
+ (Boolean)chkHeroBumpIsTouch:(CCSprite*)sp :(CrashType)crashType :(CCSprite*)chkMapSp :(float)subX
{
    Hero* hero = (Hero*)sp;
    CGRect rect2 ;
    CGRect rect1 = [SOXMapUtil spriteToRectByMap :chkMapSp :subX];
    if(hero.nowActState == kActionStateScroll){
        if(crashType == CrashTypeBody){
            rect2 =  [hero getBumpRectScrollBody];
        }else  if(crashType == CrashTypeBottom){
            rect2 =  [hero getBumpRectScrollBottom];
        }
    }else{
        if(crashType == CrashTypeTop){
            rect2 =  [hero getBumpRectTop];
        }else  if(crashType == CrashTypeBody){
            rect2 =  [hero getBumpRectBody];
        }else  if(crashType == CrashTypeBottom){
            rect2 =  [hero getBumpRectBottom];
        }
    }
    bool bol = false;
    if (CGRectIntersectsRect(rect1, rect2)) {
        bol = true;
    }
    return bol;
}

//检查人物是否 碰撞 地图
+ (Boolean)chkHeroIsTouchMapSp:(CCSprite*)hero :(CCSprite*)chkMapSp :(float)subX
{ 
    CGRect rect1 = [SOXMapUtil spriteToRectByMap:chkMapSp :subX];
    CGRect rect2 = [SOXMapUtil spriteToRectByHero:hero];
    bool bol = false;
    if (CGRectIntersectsRect(rect1, rect2)) {
        bol = true;
    }
    return bol;
}
 

//计算出 当前 人物 坐标   对应的 bg 瓦专对应的 地图坐标
+ (CGPoint)getPonitByMapTile:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap
{
	CGPoint pos = ccpSub(nowPiont, tileMap.position); 
	pos.x = (int)(pos.x / tileMap.tileSize.width);
    float tileMapHeightAll = tileMap.mapSize.height * tileMap.tileSize.height;
	pos.y = (int)((tileMapHeightAll - pos.y) / tileMap.tileSize.height); 
	return pos;
}
//根据当前 设置 得objLayer 的字典dict 信息 返回 实际页面的 点坐标
+ (CGPoint)getPointByObjLayerDict:(NSDictionary*)dict tileMap:(CCTMXTiledMap*)tileMap :(CGFloat)width :(CGFloat) height
{
    float x, y;
    //此处特殊处理  17 是实际地图显示的 时候偏差值
    x = [[dict valueForKey:@"x"] floatValue] + 17 ;//+ tileMap.position.x  ?? 
	y = [[dict valueForKey:@"y"] floatValue] + tileMap.position.y + height/2;
    return  ccp(x,y);
}

//计算出 当前 人物 坐标   对应的 bg 瓦专对应的 地图坐标 
+ (CGPoint)getNowPointInMapLocation:(CGPoint)nowPiont tileMap:(CCTMXTiledMap*)tileMap;
{ 
	CGPoint pos = ccpAdd(tileMap.position , nowPiont);
	return pos;
}
//检查 当前节点 是否 在  地图范围内
+ (bool)chkPointInTMX :(CGPoint)pos :(CCTMXTiledMap*)  tileMap
{
    if (pos.x >= 0 && pos.y >= 0 && pos.x < tileMap.mapSize.width && pos.y < tileMap.mapSize.height) {
        return true ;
    }
    return false;
}
//检查当前节点x,y 是否都小于0
+ (bool)chkPointIsLessZreo:(CGPoint)pos
{
    if( pos.x <=0 || pos.y <=0){
        return true;
    }
    return false;
}

//遍历地图tileLayer 所有信息
+ (CCArray*)mapIterator:(CCTMXTiledMap*)tileMap :(NSString *)objectLayerName
{
     CCArray *array=[CCArray arrayWithCapacity:10];
    CCTMXLayer *objectLayer = [tileMap layerNamed:objectLayerName];
    CGSize s = [objectLayer layerSize];
    for( int x=0; x<s.width;x++) { 
        for (int y=0; y<s.height; y++) {
            unsigned int tmpgid = [objectLayer tileGIDAt:ccp(x,y)];
            NSDictionary* properties = [tileMap propertiesForGID:tmpgid];
            if (properties)
            {
                NSString* ObjTypeId = [properties valueForKey:@"ObjTypeId"];
                [array addObject:ObjTypeId]; 
            }
        }
    }
    return true;
}


//初始化
+ (NSString*)initBMXCharAll:(int)gameCharLevel{
    NSString *keyChar = @"";
    int createNum = 0;
    if(gameCharLevel == T_Char_LEVEL_EASY){
        keyChar = G_KEY_THING_CHAR_EASY;
         createNum = G_THING_CHAR_CREATE_NUM_EASY;
    }else if(gameCharLevel == T_Char_LEVEL_NORMAL){
        keyChar = G_KEY_THING_CHAR_NORMAL;
        createNum = G_THING_CHAR_CREATE_NUM_NORMAL;
    }else if(gameCharLevel == T_Char_LEVEL_HARD){
        keyChar = G_KEY_THING_CHAR_NORMAL;
        createNum = G_THING_CHAR_CREATE_NUM_NORMAL;
    }
    
    NSArray *array = [keyChar componentsSeparatedByString:@";"];
    int randomI = rand()%array.count;
    NSString *oriStrChar  = array[randomI];//@"ABC";//
    NSString *createStrChar =[SOXUtil createRandomCharList:oriStrChar :createNum];
   // [SOXDebug logStr:createStrChar];
    [SOXDBUtil saveInfo:G_KEY_BMX_ORI_CHAR :oriStrChar];//原始的
    [SOXDBUtil saveInfo:G_KEY_BMX_CREATE_CHAR :createStrChar];//生成的
    [SOXDBUtil saveInfo:G_KEY_BMX_CREATE_TEMP_SHOW_CHAR :@"0"];//生成的临时int对象
    [SOXDBUtil saveInfo:G_KEY_BMX_NOW_CHAR :G_STR_NULL];//当前的   默认为空
    [SOXDBUtil saveInfo:G_KEY_BMX_IS_RUNNING_CHAR :G_STR_YES];//是否为 进行中
    return oriStrChar;
}
//获取当前 其中一个字符
+ (NSString*)getBMXCreateSingleCharVal
{
    NSString *returnStr = @"";
    bool isRunningFlag = [SOXDBUtil loadInfoReturnBool:G_KEY_BMX_IS_RUNNING_CHAR];
    if(isRunningFlag == true){
        NSString *createStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_CREATE_CHAR];
        int index = [SOXDBUtil loadInfoReturnInt:G_KEY_BMX_CREATE_TEMP_SHOW_CHAR];
         if(index < createStrChar.length){ 
            NSString *singleVal = [createStrChar substringWithRange:NSMakeRange(index, 1)];
            returnStr = singleVal;
             index++;
            //更新最新的 缓存对象
            [SOXDBUtil saveInfo:G_KEY_BMX_CREATE_TEMP_SHOW_CHAR :[SOXUtil intToString:index ] ];
         }
        //如果 已经生成完 ,剩下的 随机生成
        if([returnStr isEqualToString:@""]){
            NSString *oriStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_ORI_CHAR];
            int cnt = oriStrChar.length;
            int createIndex = 0 ;
            if(cnt!=0){
              createIndex = arc4random()%cnt;
            }
            
            NSString *singleVal = [oriStrChar substringWithRange:NSMakeRange(createIndex, 1)];
            returnStr = singleVal;
        }
    }
   
    
    return returnStr;
}

+ (void)updateBMXCharVal:(NSString*)nowSingleVal
{
    NSString *nowStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_NOW_CHAR];
    NSString *newStrChar = [ NSString stringWithFormat:@"%@%@",nowStrChar,nowSingleVal];
    [SOXDBUtil saveInfo:G_KEY_BMX_NOW_CHAR :newStrChar];
}
+ (int)getNowIndexBySingleCharVal
{
    NSString *nowStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_NOW_CHAR];
    int index = 0;
    if(nowStrChar.length > 0){
        index = nowStrChar.length;
        index--;
    }
    return index;
}

// 检查 碰撞的 是否为 实际许需要的 下一个文字
+ (bool)chkBMXSingleChar:(NSString*)nowSingleChar
{
    bool returnFLag = false;
    bool isRunningFlag = [SOXDBUtil loadInfoReturnBool:G_KEY_BMX_IS_RUNNING_CHAR];
    if(isRunningFlag == true){
        NSString *oriStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_ORI_CHAR];
        NSString *nowStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_NOW_CHAR];
        int index  = nowStrChar.length ;//当前的长度 下标刚好是 需要的下一个
        if(index < oriStrChar.length){
            NSString *oriSingleVal = [oriStrChar substringWithRange:NSMakeRange(index, 1)];
            if(nowSingleChar != nil && oriSingleVal !=nil ){
                if([oriSingleVal isEqualToString:nowSingleChar]){
                    returnFLag = true;
                }
            }
           
        }
    }
    return returnFLag;
}

// 检查 是否完成
+ (bool)chkBMXCharSuccess
{
    bool returnFLag = false;
    bool isRunningFlag = [SOXDBUtil loadInfoReturnBool:G_KEY_BMX_IS_RUNNING_CHAR];
    if(isRunningFlag == true){
        NSString *oriStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_ORI_CHAR];
        NSString *nowStrChar = [SOXDBUtil loadInfo:G_KEY_BMX_NOW_CHAR];
        if(oriStrChar !=nil  && nowStrChar!= nil){
            if([oriStrChar isEqualToString:nowStrChar]){
                returnFLag = true;
            }
        }
    }
    return returnFLag;
}

@end
