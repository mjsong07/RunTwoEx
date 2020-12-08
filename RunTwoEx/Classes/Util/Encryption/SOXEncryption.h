//
//  SOXMapUtil.h
//  RunTwo
//
//  Created by mjsong on 13-5-27.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
@interface SOXEncryption : NSObject
+ (NSData*)Encrypt: (NSString*)val;
+ (NSString*)Decrypt: (NSData*)val;

@end
