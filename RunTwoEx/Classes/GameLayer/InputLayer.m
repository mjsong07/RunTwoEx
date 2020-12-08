

#import "InputLayer.h"
#import "GameLayer.h"
#import "Hero.h"
#import "ThingLayer.h" 
@interface InputLayer (PrivateMethods)
- (void)addJumpButton;
- (void)addScrollButton;
- (void)addChangeButton;
@end

@implementation InputLayer

- (id)init
{
	if ((self = [super init])) {
		[self addJumpButton];
		[self addScrollButton];
        [self addChangeButton];
		//[self scheduleUpdate];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}
//切换角色
- (void)addChangeButton
{ 
    changeButton= [SneakyButton button];
	changeButton.isHoldable = YES;
	SneakyButtonSkinnedBase *skinBtn = [SneakyButtonSkinnedBase skinnedButton];
	skinBtn.position = ccp(getRS(90),getRS(90));
    // skinBtn.position = ccp(G_SCREEN_SIZE.width - buttonRadius * 1.5f-23, 60);
	skinBtn.defaultSprite = [CCSprite spriteWithFile:@"BUTTON_C1.png"];
	skinBtn.pressSprite = [CCSprite spriteWithFile:@"BUTTON_C2.png"];
	skinBtn.button = changeButton;
	[self addChild:skinBtn];
}

//滚动
- (void)addScrollButton
{ 
    scrollButton = [SneakyButton button];
	scrollButton.isHoldable = YES;
	SneakyButtonSkinnedBase *skinBtn = [SneakyButtonSkinnedBase skinnedButton];
	skinBtn.position = ccp(G_SCREEN_SIZE.width  -getRS(55),getRS(60));
	skinBtn.defaultSprite = [CCSprite spriteWithFile:@"BUTTON_A1.png"];
	skinBtn.pressSprite = [CCSprite spriteWithFile:@"BUTTON_A2.png"];
	skinBtn.button = scrollButton;
	[self addChild:skinBtn];
}

//跳
- (void)addJumpButton
{ 
    
	jumpButton = [SneakyButton button];
	jumpButton.isHoldable = YES;
	
	SneakyButtonSkinnedBase *skinBtn = [SneakyButtonSkinnedBase skinnedButton];
	skinBtn.position = ccp(G_SCREEN_SIZE.width + getRS(27) ,getRS(130));
	skinBtn.defaultSprite = [CCSprite spriteWithFile:@"BUTTON_B1.png"];
	skinBtn.pressSprite = [CCSprite spriteWithFile:@"BUTTON_B2.png"];
	skinBtn.button = jumpButton;
	[self addChild:skinBtn];
}
//
- (void)updateInput:(ccTime)delta{
    totalTime += delta;
    totalTime2 += delta;
    totalTime3 += delta; 
    Hero *hero = [GameHelper getHero];
	//大跳
    
	if (jumpButton.active && totalTime > nextShotTime ) {
        nextShotTime = totalTime + 0.5f;
        [hero jump];
    }
    //滚动
	if (scrollButton.active && totalTime2 > nextShotTime2  ) {
        nextShotTime2 = totalTime2 + 0.1f;
        [hero scroll];
    }
    //切换角色
	if (changeButton.active && totalTime3 > nextShotTime3 ) {
        nextShotTime3 = totalTime3 + 0.5f;
        [hero change];
    }
 	if (jumpButton.active == NO) {
		nextShotTime = 0;
	}
    //当不点击 或不再点击 滚动的时候
    if (scrollButton.active == NO) {
		nextShotTime2 = 0;
        if (hero.nowActState == kActionStateScroll) {
            [hero run];
        }
	}
    if (changeButton.active == NO) {
		nextShotTime3 = 0;
	}
}
@end
