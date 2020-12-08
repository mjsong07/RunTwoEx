 

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyExtensions.h"

@interface InputLayer : CCLayer 
{
    SneakyButton* jumpButton;
    SneakyButton* scrollButton;
    SneakyButton* changeButton;

    //SneakyJoystick* joystick; 
    ccTime totalTime;
	ccTime nextShotTime;
    ccTime totalTime2;
    ccTime nextShotTime2;
    ccTime totalTime3;
    ccTime nextShotTime3;
}

- (void)updateInput:(ccTime)delta;
@end
