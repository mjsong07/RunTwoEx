//
//  GameSettingLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-11.
//
//

#import "MenuScoreLayer.h"  
#import "MenuNavInfo.h"
#import "GameCenterManager.h" 


@implementation MenuScoreLayer
+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuScoreLayer *nowLayer = [MenuScoreLayer node];
    [scene addChild:nowLayer];
    return scene;
}
- (id)init
{
    if (self = [super init]) {  
        CCSprite *achieveImg = [CCSprite spriteWithFile:@"menu_achieve.png" ]; 
        CCSprite *rankImg = [CCSprite spriteWithFile:@"menu_rank.png" ];  
        CCSprite *settingsImg = [CCSprite spriteWithFile:@"menu_settings.png" ]; 
        CCMenuItemSprite *itemAchieve =  [ CCMenuItemSprite itemWithNormalSprite:achieveImg selectedSprite:nil
                                                                        target:self selector:@selector(toAchieve:) ];
        
        CCMenuItemSprite *itemRankAchieve =  [ CCMenuItemSprite itemWithNormalSprite:rankImg selectedSprite:nil
                                                                          target:self selector:@selector(toGameCenterLeaderboard:) ]; 
        
        CCMenuItemSprite *itemSettings =  [ CCMenuItemSprite itemWithNormalSprite:settingsImg selectedSprite:nil
                                                                          target:self selector:@selector(toSettings:) ]; 
        
        CCMenu *bigMenu = [CCMenu menuWithItems:itemRankAchieve, itemAchieve,itemSettings,nil]; 
        MenuNavInfo *backNav = [[[MenuNavInfo alloc]init:T_SCENE_INDEX]autorelease];
        
        menuScoreInfo_ = [[[MenuScoreInfo alloc] init]autorelease];
        [menuScoreInfo_ setPosition:G_STYLE_MENULAYER_MARGIN_TOP2];
        [bigMenu alignItemsHorizontally];
        [bigMenu alignItemsHorizontallyWithPadding:1];
     	[bigMenu setPosition:ccp(G_SCREEN_SIZE.width/2,G_SCREEN_SIZE.height-getRS(210)) ];
        
        [self addChild: backNav z:1 tag:2 ];
        [self addChild: bigMenu z:1 tag:2 ];  
        [self addChild:menuScoreInfo_];
        
        self.reach = [Reachability reachabilityForInternetConnection];
        self.netStatus = [self.reach currentReachabilityStatus];
    }
    return self;
}

- (void)dismissHUD:(id)arg {
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
    self.hud = nil;
}
//用于提示框
- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay {
    self.hud= [MBProgressHUD showHUDAddedTo:[SOXGameUtil getBaseRootView].view animated:YES];
    _hud.labelText = title;
    _hud.detailsLabelText = message;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:delay];
}


//gamecenter排行榜
- (void)toGameCenterLeaderboard:(id) sender
{

//    [gameCenterUtil chkUserIsLoad]; //检测用户登录    由于登录 已调用 这个 屏蔽
    NSString *Warning =NSLocalizedString(@"Warning", @"");
    NSString *NoInternet =NSLocalizedString(@"NoInternet", @"");
    
    if (self.netStatus == NotReachable) { 
        [self showHuDByStr:Warning :NoInternet:G_ALERT_DELAY_TIMES];
    } else { 
        //每次 点击 排行榜 直接提交 当前分数
        SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
        
        double totalDistance = [SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_DISTANCE];
        double intScore =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_SCORE];
        double intStarCnt =[SOXDBUtil loadInfoReturnDouble:G_KEY_LEADERBOARD_STAR];
        
        [gameCenterUtil submitLeaderboardScore:totalDistance :G_KEY_LEADERBOARD_DISTANCE];//更新最新gamecenter 距离 
        [gameCenterUtil submitLeaderboardScore:intScore :G_KEY_LEADERBOARD_SCORE];//更新最新gamecenter 分数 
        [gameCenterUtil submitLeaderboardScore:intStarCnt :G_KEY_LEADERBOARD_STAR];//更新最新gamecenter 距离 
         
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if (leaderboardController != NULL)
        {
            leaderboardController.category = G_KEY_LEADERBOARD_SCORE;
            leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
            leaderboardController.leaderboardDelegate = self;
            [[SOXGameUtil getBaseRootView] presentModalViewController: leaderboardController animated: YES];
        }  
    } 
}
//本地游戏成就
- (void)toAchieve: (id) sender
{ 
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_ACHIEVE];
	[[CCDirector sharedDirector] replaceScene:newScene];
}
//游戏设置
- (void)toSettings: (id) sender
{
    [SOXSoundUtil play_button];
    [[CCDirector sharedDirector]resume];
    CCScene* newScene = [SceneSwitch showScene:T_SCENE_SETTING];
	[[CCDirector sharedDirector] replaceScene:newScene];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[[SOXGameUtil getBaseRootView] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[[SOXGameUtil getBaseRootView] dismissModalViewControllerAnimated:YES];
}
- (void)toGameCenterAchieve:(id) sender
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL)
	{
		achievements.achievementDelegate = self;
		[[SOXGameUtil getBaseRootView] presentModalViewController: achievements animated: YES];
	}
}

- (void)dealloc
{
    [_hud release];
    [_reach release]; 
    [super dealloc];
}


@end
