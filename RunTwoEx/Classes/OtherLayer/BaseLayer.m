//
//  BaseLayer.m
//  RunTwo
//
//  Created by mjsong on 13-5-9.
//
//

#import "BaseLayer.h"

@implementation BaseLayer 

- (id)init{
    if(self = [super init]){  
        self.TouchEnabled = YES;
        [CCMenuItemFont setFontName: @"Arial"];
		[CCMenuItemFont setFontSize:getRS(16)  ];
    }
    return self;
}
@end
