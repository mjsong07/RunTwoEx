//
//  Effect.m
//  RunTwo
//
//  Created by mjsong on 13-5-23.
//
//
#import "GameLayerInfo.h"
#import "ThingCache.h"
#import "GameLayer.h"
@implementation GameLayerInfo

+ (id)gameLayerInfoInit
{ 
    GameLayerInfo *sprite=[[[self alloc] initAll]autorelease];
	return sprite;
}

- (id)initAll
{
    if ((self = [super init])) {
        NSString *strLevel = [NSString stringWithFormat:@"level:%i", [SOXConfig getNowGameLevel]]; 
         NSString *strSpeed = [NSString stringWithFormat:@"speed:%i",[SOXUtil floatToInt: [SOXConfig getNowMapMoveSpeed]]   ];
        
        
        NSString *strMapCnt = [NSString stringWithFormat:@"mapCnt:" ];
        
        
        NSString *strMapTimes = [NSString stringWithFormat:@"times:%i",[SOXUtil floatToInt: [SOXConfig getNowMapRunTimes]]   ];
        
        
        
        self.levelLabel= [CCLabelTTF labelWithString:strLevel fontName:@"Arial" fontSize:getRS(28)];
        self.speedLabel= [CCLabelTTF labelWithString:strSpeed fontName:@"Arial" fontSize:getRS(28)];
        self.mapCntLabel= [CCLabelTTF labelWithString:strMapCnt fontName:@"Arial" fontSize:getRS(28)];
        
        self.mapTimesLabel= [CCLabelTTF labelWithString:strMapTimes fontName:@"Arial" fontSize:getRS(28)];
        
        self.levelLabel.position = ccp(getRS(60) ,getRS(-30) );
        self.levelLabel.color = ccSOX_BLUE;
        [self addChild:self.levelLabel];
        self.speedLabel.position = ccp(getRS(60) ,getRS(-50) );
        self.speedLabel.color = ccSOX_BLUE;
        [self addChild:self.speedLabel];
        
        
        
        self.mapCntLabel.position = ccp(getRS(60) ,getRS(-80) );
        self.mapCntLabel.color = ccSOX_BLUE;
        [self addChild:self.mapCntLabel];
        
        self.mapTimesLabel.position = ccp(getRS(60) ,getRS(-110) );
        self.mapTimesLabel.color =ccSOX_BLUE ;
        [self addChild:self.mapTimesLabel];
        
        

	}
	return self;
}
- (void)dealloc
{
   // [_levelLabel release];
   // [_speedLabel release];
    [super dealloc];
}
@end
