//
//  AppDelegate.m
//  RunTwoEx
//
//  Created by jason yang on 13-10-14.
//  Copyright jason yang 2013年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"  
#import "SOXSoundUtil.h" 
#import "GameLayer.h"
#import "InAppRageIAPHelper.h"
#import "GameCenterManager.h"
#import "ShareManager.h" 

@implementation AppDelegate

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
    //主要用来和OpenGL ES发送消息 沟通
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565
								   depthFormat:0
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
	//全局的单例 导演对象 一个app只有一个导演实例用来加载和切换场景
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	//是否全屏
	director_.wantsFullScreenLayout = YES;
	//是否现实FPS和SPF
	[director_ setDisplayStats:NO];
	
    
	//每分钟展示60帧 FPS=60
	[director_ setAnimationInterval:1.0/60];
	//绑定openglview对象到当前导演对象
	[director_ setView:glView];
	//2d模式 如果是3d模式 设置为kCCDirectorProjection3D
	[director_ setProjection:kCCDirectorProjection2D];
	// 设置高清模式适配retina屏幕
	//if( ! [director_ enableRetinaDisplay:YES] )
	//	CCLOG(@"Retina Display Not supported");
	
    //[director_ enableRetinaDisplay:YES];
    if(G_IS_IPAD){
        [director_ enableRetinaDisplay:NO];
    }else{
        [director_ enableRetinaDisplay: YES];
        
    }

    
    
    //新增 支持多点触屏
    [director_.view setMultipleTouchEnabled: true];
	//设置纹理格式
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	//自动设置图片的格式选择根据屏幕的类型和设备类型
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	//设置图像透明度
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	//初始化根处理器为导航处理器
	navController_ = [[MyRootNavigationController alloc] initWithRootViewController:director_]; 
    
	navController_.navigationBarHidden = YES;
    navController_.navigationBar.translucent = NO;
    
    
    
    [director_ setDelegate:navController_];
	[window_ setRootViewController:navController_];
	
	//主窗口可见
	[window_ makeKeyAndVisible];
     //[[UIApplication sharedApplication] setStatusBarHidden:TRUE];
   // [window_ set]
	     
    [SOXConfig initAll];
    [SOXSoundUtil initSoundMusic];//初始化音频
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]]; //实例化 支付接口
    SOXGameCenterUtil *gameCenterUtil = [SOXGameCenterUtil sharedSOXGameCenterUtil];//实例化 gameCenter 工具类
    [gameCenterUtil chkUserIsLoad]; //检测用户登录
    
    [SOXObjCacheUtil initAllThingCache];
    
    [ShareManager setWXApiKey:G_KEY_WECHAT_APPID];
	return YES;
} 
//退出游戏处理
- (void)applicationWillResignActive:(UIApplication *)application { 
    
    CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
    [SOXSoundUtil close_sound];
    //如果当前已经是  暂停 画面
    if ([[CCDirector sharedDirector]isPaused]) {
        
    }else{ 
        if( [navController_ visibleViewController] == director_ )
            [director_ pause]; 
        //[[CCDirector sharedDirector] pause];
        //如果当前 是游戏中 调用 暂停画面
        if(nowScene != nil && [nowScene tag]==T_SCENE_GAME_LAYER){
            [[GameHelper getGameLayer]toExitPause:self];
        }
    }
}
//还原游戏处理
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[CCDirector sharedDirector] setNextDeltaTimeZero:YES]; 
    
    CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
    [SOXSoundUtil open_sound];
    //如果当前 是游戏中 不自动继续播放动画  让用户自己点击继续
    if(nowScene != nil && [nowScene tag]==T_SCENE_GAME_LAYER){
        
    }else{
        if( [navController_ visibleViewController] == director_ )
            [director_ resume];
      //  [[CCDirector sharedDirector] resume];
    }
}


-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	
	[super dealloc];
}




@end
