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
#import "ATAppTransferManager.h"
#import "LoadingScreen.h"

@implementation MyRootNavigationController

// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskLandscape;
	
	// iPad only
	return UIInterfaceOrientationMaskLandscape;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
	// iPad only
	// iPhone only
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		//[director runWithScene: [IntroLayer scene]];
        //修改此处  改变第一个页面跳转
//        [[CCDirector sharedDirector] runWithScene: [LoadingScene sceneWithTargetScene:T_SCENE_INDEX]];
        
        [[CCDirector sharedDirector] runWithScene: [LoadingScreen scene]];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initGAD];
    [ATAppTransferManager setAppId:G_KEY_AT_APPKEY_RUNTWO];//初始化 应用互推
    UIColor *color =   [UIColor colorWithRed:((float) 0 / 255.0f)
                                       green:((float) 102 / 255.0f)
                                        blue:((float) 255 / 255.0f) alpha:1.0f];
    [ATAppTransferManager setBackColor:color];
    [ATAppTransferManager setAppBorderColor:[UIColor whiteColor]];
    [ATAppTransferManager setAppChangeInterval:5];
    
    
    
    [self hiddenGAD];//默认隐藏
    /* if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
            self.edgesForExtendedLayout = UIRectEdgeTop;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
    }*/
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initGAD
{ 
    CGRect rect = CGRectMake(0,0,//可以设置你广告的位置
                             GAD_SIZE_320x50.width,
                             GAD_SIZE_320x50.height);
    //[SOXDebug logPonit:rect.origin];
    //创建一个标准大小的屏幕
    bannerView_ = [[GADBannerView alloc] initWithFrame:rect];
    bannerView_.delegate = self;
    //指定广告的“单位标识符”。这是您的AdMob的发布者
    bannerView_.adUnitID = G_KEY_AD_ADMOB;
    //用户的广告，将它添加到视图
    [bannerView_ setRootViewController:self];
    [self.view addSubview:bannerView_];
    
    //启动一个通用请求加载广告。
    [bannerView_ loadRequest:[GADRequest request]]; 
}





//客户端接收到广告后调用
- (void)removeGAD
{
    if(bannerView_!=nil){
     [bannerView_ removeFromSuperview];
    } 
}


//客户端接收到广告后调用
- (void)hiddenGAD
{
    if(bannerView_!=nil){
        [bannerView_ setHidden:true];
    }
    [ATAppTransferManager hideTransferView];
}


//客户端接收到广告后调用
- (void)showGAD
{
    CCSprite *sprite = [ATAppTransferManager spriteWithAppId:G_KEY_AT_APPKEY_RUNTWO];
    if (sprite != nil) {
        [ATAppTransferManager showTransferViewWithPosition:CGPointMake(0, 0)];
    }else{//广告未下载完  调用admob
        if(bannerView_!=nil){
            [bannerView_ setHidden:false];
        }
    }
}



//客户端接收到广告后调用
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
}
//用户点击广告后调用
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    NSLog(@"用户点击");
    CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
    [SOXSoundUtil close_sound];
    //如果当前已经是  暂停 画面
    if ([[CCDirector sharedDirector]isPaused]) {
        
    }else{
        if( [self visibleViewController] == [CCDirector sharedDirector] )
            [[CCDirector sharedDirector] pause]; 
        //如果当前 是游戏中 调用 暂停画面
        if(nowScene != nil && [nowScene tag]==T_SCENE_GAME_LAYER){
            [[GameHelper getGameLayer]toExitPause:self];
        }
    }
    
    
}
//用户点击广告后切换回游戏时
- (void)adViewDidDismissScreen:(GADBannerView *)adView{
    [[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
    
    CCScene *nowScene = [[CCDirector sharedDirector] runningScene];
    [SOXSoundUtil open_sound];
    //如果当前 是游戏中 不自动继续播放动画  让用户自己点击继续
    if(nowScene != nil && [nowScene tag]==T_SCENE_GAME_LAYER){
        
    }else{
        if( [self visibleViewController] == [CCDirector sharedDirector]  ) 
            [[CCDirector sharedDirector] resume];
    }
}


@end