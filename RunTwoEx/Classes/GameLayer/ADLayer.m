//
//  BGLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "ADLayer.h"
#import "BGSprite.h"
#import "GameLayer.h"
#import "CCAnimationHelper.h"
@implementation ADLayer


+ (id)objInit:(int)layerType :(int)cnt
{
	return [[[self alloc ]init:layerType:cnt] autorelease];
}
- (id)init:(int)layerType :(int)cnt
{
	if ((self = [super init])) {
        layerType_ = layerType;
        NSString *imageName= nil;
        if(layerType == T_LAYER_BG_AD_BEFORE){
            imageName = @"adb";
        }else{
            imageName = @"ad"; 
        }
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"ad.png"];
		spriteBatch_ = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch_ z:1 tag:T_LAYER_BG_AD_BEFORE ];
		numStripes_ = cnt;
        baseArray_ = [[CCArray alloc] initWithCapacity:numStripes_];
		for (int i = 0; i < numStripes_; i++) {
			NSString* frameName = [NSString stringWithFormat:@"%@%i.png",imageName, i];
			BGSprite* sprite = [BGSprite spriteWithSpriteFrameName:frameName];  
            sprite.anchorPoint = ccp(0, 0.5f);
            [spriteBatch_ addChild:sprite z:0 ];
            [baseArray_ addObject:sprite]; 
		}
        nowTileMapDict_ = [[NSMutableDictionary alloc] initWithCapacity:3]; 
    } 
     
    [self resetAllPostion];
	return self; 
}

 


////重新设置 当前所有 地图得  x坐标
- (void)resetAllPostion{
    tempKeyDict_ = [[NSMutableDictionary dictionary]retain];
    for (int i = 0; i < numStripes_; i++) {
        [tempKeyDict_ setObject:[baseArray_ objectAtIndex:i ] forKey:[SOXUtil intToString:i]];
    }
    //打乱 当前得 排序方式 
    for (int i = 0; i < numStripes_; i++) {
        int objKey= [SOXUtil getRandomByDict :tempKeyDict_ ];
        id newObj= [baseArray_ objectAtIndex:objKey ]; 
        [nowTileMapDict_ setObject:newObj forKey:[SOXUtil intToString:i]];
        [tempKeyDict_ removeObjectForKey:[SOXUtil intToString:objKey]];
    } 
    
    
    [tempKeyDict_ release];
    int  tmpInt= rand()%5+4;
    //设置 随机开始的 位置
    float nowWidth =  G_SCREEN_SIZE.width*tmpInt;//G_SCREEN_SIZE.width*6;//从屏幕得 最右边开始//0;//
    for (int i = 0; i < numStripes_; i++) {
        BGSprite* bg  = (BGSprite*)[nowTileMapDict_ objectForKey:[SOXUtil intToString:i]];
        if ( bg !=nil ) {
            [bg setVisible:true]; 
            if(layerType_ == T_LAYER_BG_AD_BEFORE){
                int  tmpInt= rand()%50;
                bg.position=  ccp(getRS(nowWidth),getRS(0+tmpInt));
            }else{
                int  tmpInt= rand()%90;
                bg.position=  ccp(getRS(nowWidth),getRS(40+tmpInt));
            }
          //  bg.position = ccp(nowWidth ,bg.position.y );
            nowWidth += 4000;//4000;//不同 广告的距离
        }
    }
    adLayerWidthAll_ = nowWidth;
}
- (void)updateADLayer:(ccTime)delta
{
    
	BGSprite *tileMap;
    for (int i = 0; i < [nowTileMapDict_ count ]; i++)
	{
        tileMap = [nowTileMapDict_ objectForKey:[SOXUtil intToString:i]];
        if ( tileMap !=nil ) {
            CGPoint pos = tileMap.position;
           
            if(i == 0){
                if (pos.x < -(adLayerWidthAll_)) { 
                    [self resetAllPostion];
                    break;
                }
            }
            int speed = 0;
            if(layerType_ == T_LAYER_BG_AD_BEFORE){
                speed = [SOXConfig getAD_BeforeLayerMoveSpeed];
            }else{
                speed = [SOXConfig getADBgLayerMoveSpeed];
            } 
            pos.x -= speed;//速度
            tileMap.position = pos;
        }
    }
} 

- (void)dealloc
{
	[nowTileMapDict_ release];
    [baseArray_ release];
	[super dealloc];
}

@end
