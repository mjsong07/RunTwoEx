//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface SOXShareUtil : NSObject
+ (void)showSharePage: (NSString*)shareType :(NSString*)content :(UIViewController*) baseRootView;
@end
