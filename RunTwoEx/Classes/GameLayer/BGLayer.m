//
//  BGLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-16.
//
//

#import "BGLayer.h"
#import "BGSprite.h" 
#import "CCAnimationHelper.h"
@implementation BGLayer 
- (id)init
{
	if ((self = [super init])) { 
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"bg.png"];
		spriteBatch_ = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch_ z:1 tag:T_LAYER_BG ];
		//numStripes_ = 2;
       // baseArray_ = [[CCArray alloc] initWithCapacity:numStripes_];
		/*for (int i = 0; i < numStripes_; i++) {
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			BGSprite* sprite = [BGSprite spriteWithSpriteFrameName:frameName];
            sprite.anchorPoint = ccp(0, 0.5);
            [sprite setPosition:ccp( G_SCREEN_SIZE.width,G_SCREEN_SIZE.height-G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP+20)];
            [spriteBatch_ addChild:sprite z:i tag:i];  
            [baseArray_ addObject:sprite];
		}*/
        
        NSString* frameName0 = @"bg0.png";
        BGSprite* sprite0 = [BGSprite spriteWithSpriteFrameName:frameName0];
        sprite0.anchorPoint = ccp(0, 0.5);
        [sprite0 setPosition:ccp( G_SCREEN_SIZE.width,G_SCREEN_SIZE.height- G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP+getRS(20) )];
        [spriteBatch_ addChild:sprite0 z:0 tag:0];
        
        
        NSString* frameName1 = @"bg1.png";
        BGSprite* sprite1 = [BGSprite spriteWithSpriteFrameName:frameName1];
        sprite1.anchorPoint = ccp(0, 0.5);
        [sprite1 setPosition:ccp( G_SCREEN_SIZE.width,G_SCREEN_SIZE.height-G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP+getRS(20))];
        [spriteBatch_ addChild:sprite1 z:10 tag:10];
        
        
        NSString* frameName2 = @"bg1.png";
        BGSprite* sprite2 = [BGSprite spriteWithSpriteFrameName:frameName2];
        sprite2.anchorPoint = ccp(0, 0.5);
        [sprite2 setPosition:ccp( G_SCREEN_SIZE.width*2,G_SCREEN_SIZE.height-G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP+getRS(20) )];
        [spriteBatch_ addChild:sprite2 z:10 tag:10];
        
        
	}
	return self;
} 
- (void)updateBGLayer:(ccTime)delta
{ 
	BGSprite* sprite;
	CCARRAY_FOREACH([spriteBatch_ children], sprite)
	{ 
		CGPoint pos = sprite.position;
        int tag = sprite.tag;
      //  [SOXDebug logTagFloat:@"x" :pos.x];
        if(tag==0){//太阳
            pos.x -= [SOXConfig getSunBgLayerMoveSpeed];
        }else{
            pos.x -= [SOXConfig getSunBgLayerMoveSpeed]+0.1;
        }
		
		if (pos.x < -G_SCREEN_SIZE.width) {
			pos.x = (G_SCREEN_SIZE.width ) - 2;
		}
		sprite.position = pos;
	}
} 
- (void)dealloc
{
    //[baseArray_ release];
	[super dealloc];
} 
@end
