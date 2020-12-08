 

#import <Foundation/Foundation.h> 
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"


@interface SneakyButton (Extension)
+ (id)button;
+ (id)buttonWithRect:(CGRect)rect;
@end

@interface SneakyButtonSkinnedBase (Extension)
+ (id)skinnedButton;
@end

@interface SneakyJoystick (Extension)
+ (id)joystickWithRect:(CGRect)rect;
@end

@interface SneakyJoystickSkinnedBase (Extension)
+ (id)skinnedJoystick;
@end

