//
//  LoadingScreen.m
//
//  Created by Six Foot Three Foot on 28/05/12.
//  Copyright 2012 Six Foot Three Foot. All rights reserved.
//

#import "LoadingScreen.h"
#import "SimpleAudioEngine.h"
#import "SceneSwitch.h"

//The next scene you wish to transition to.

@implementation LoadingScreen

+(CCScene *) scene
{
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	
    NSString *className = NSStringFromClass([self class]);
    // 'layer' is an autorelease object.
    id layer = [NSClassFromString(className) node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}



#pragma mark初始化

-(id) init
{
    
    if ( ( self = [ super init] ) )
    {
        progress = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"menu_index_line.png"]];
        progress.color = ccSOX_PINK;
        [progress setPercentage:0.0f];
        progress.midpoint = ccp(0,0.5);
        progress.barChangeRate = ccp(1,0);
        progress.type = kCCProgressTimerTypeBar;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hero.plist"];
        Hero *hero = [Hero sharedHero];
        [hero run];
        
		NSString *strLoading =   NSLocalizedString(@"Loading", @"");
        CCLabelTTF *loadingText = [CCLabelTTF labelWithString:strLoading  fontName:@"HelveticaNeue" fontSize:getRS(20)];
        progress.position = G_SCREEN_CENTER;
        hero.position = ccp(G_SCREEN_CENTER.x, G_SCREEN_CENTER.y+getRS(40));//-getRS(28)
        hero.scale = 0.8;
        loadingText.position = ccp(G_SCREEN_CENTER.x,G_SCREEN_CENTER.y-getRS(35));
        loadingText.color = ccSOX_BLUE;
        CCLayerColor *bgcolor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild: bgcolor z:-1];
        [self addChild:hero];
        [self addChild:progress z:1];
        [self addChild:loadingText z:1];
    }
    
    return self;
}

-(void) onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"loading.plist"];
    NSDictionary *manifest = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *imageBaseArray   = [manifest objectForKey:@"Image_base"];//Image_base
    NSArray *imageHelpArray   = [manifest objectForKey:@"Image_help"];
    NSArray *imageButtonArray    = [manifest objectForKey:@"Image_button"];
    NSArray *imageAchieveArray   = [manifest objectForKey:@"Image_achieve"];
    NSArray *imageShoppingArray  = [manifest objectForKey:@"Image_shopping"];
    
    NSArray *plistArray          = [manifest objectForKey:@"Plist"];
    NSArray *soundArray   = [manifest objectForKey:@"Sound"];
    
    assetCount = ([imageBaseArray count] +[imageHelpArray count] +[imageButtonArray count] +[imageAchieveArray count] +
                   [imageShoppingArray count] +
                  [plistArray count] + [soundArray count]);
    progressInterval = 100.0 / (float) assetCount;
    
    if (soundArray)
        [self performSelectorOnMainThread:@selector(loadSounds:) withObject:soundArray waitUntilDone:YES];
    
    
    if (imageBaseArray)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:imageBaseArray waitUntilDone:YES];
    
    if (imageHelpArray)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:imageHelpArray waitUntilDone:YES];
    
    if (imageButtonArray)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:imageButtonArray waitUntilDone:YES];
    
    if (imageAchieveArray)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:imageAchieveArray waitUntilDone:YES];
    
    if (imageShoppingArray)
        [self performSelectorOnMainThread:@selector(loadImages:) withObject:imageShoppingArray waitUntilDone:YES];
    
    if (plistArray)
        [self performSelectorOnMainThread:@selector(loadSpriteFrameCache:) withObject:plistArray waitUntilDone:YES];
}


-(void) loadSounds:(NSArray *) soundClips
{
    for (NSString *soundClip in soundClips)
    {
        [[SimpleAudioEngine sharedEngine] preloadEffect:soundClip];
        [self progressUpdate];
    }
}


-(void) loadSpriteFrameCache:(NSArray *) spriteFrameCache
{
    for (NSString *spriteSheet in spriteFrameCache)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteSheet];
        [self progressUpdate];
    }
}

-(void) loadImages:(NSArray *) images
{
    for (NSString *image in images)
    {
        [[CCTextureCache sharedTextureCache] addImage:image];
        [self progressUpdate];
    }
}

-(void) progressUpdate
{
    if (--assetCount)
    {
        [progress setPercentage:(100.0f - (progressInterval * assetCount))];
    }
    else {
        CCProgressFromTo *ac = [CCProgressFromTo actionWithDuration:0.5 from:progress.percentage to:100];
        CCCallBlock *callbak = [CCCallBlock actionWithBlock:^(){
            [self loadingComplete];
            
        }];
        id action = [CCSequence actions:ac,callbak, nil];
        [progress runAction:action];
        
    }
    
}

-(void) loadingComplete
{
    CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0f];
    CCCallBlock *swapScene = [CCCallBlock actionWithBlock:^(void) {
        CCScene* newScene = [SceneSwitch showScene:T_SCENE_INDEX];
        [[CCDirector sharedDirector] replaceScene:newScene];
    }];
    
    CCSequence *seq = [CCSequence actions:delay, swapScene, nil];
    [self runAction:seq];
}

@end
