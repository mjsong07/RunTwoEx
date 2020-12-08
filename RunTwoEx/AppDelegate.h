//
//  AppDelegate.h
//  RunTwoEx
//
//  Created by jason yang on 13-10-14.
//  Copyright jason yang 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "GADBannerViewDelegate.h" 
#import "MyRootNavigationController.h"
@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyRootNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyRootNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
