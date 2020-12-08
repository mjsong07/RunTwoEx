//
//  log.m
//  RunTwo
//
//  Created by mjsong on 13-5-28.
//
//

#import "SOXDebug.h"
#import "Hero.h"
@implementation SOXDebug

+ (void)logInt:(int)i
{
    CCLOG(@"now i:%i",i);
}

+ (void)logBol:(bool)bol
{
    if (bol) {
        CCLOG(@"now bol:是");
    }else{
        CCLOG(@"now bol:否");
    } 
}

+ (void)logFloat:(float)f
{
    CCLOG(@"logF f:%f",f);
}

+ (void)logStr:(NSString* )str
{
    CCLOG(@"logTest str:%@",str);
}

+ (void)logTagStr:(NSString* )tag :(NSString* )str
{
    CCLOG(@"logTest %@ :%@",tag,str);
}

+ (void)logTagInt:(NSString* )tag :(int)i
{
    CCLOG(@"logTest %@ :%d",tag,i);
}

+ (void)logTagFloat:(NSString* )tag :(float)f
{
    CCLOG(@"logTest %@ :%f",tag,f);
}

+ (void)logActionState:(Hero*)hero
{
    CCLOG(@"logActionState %i",hero.nowActState);
}

+ (void)logSprite:(BaseSprite*)sprite
{
    if (sprite != nil) { 
        CCLOG(@"start------------------");
        [SOXDebug logPonit:sprite.position];
        [SOXDebug logHW:sprite]; 
        CCLOG(@"nowActState:%d",sprite.nowActState);
        CCLOG(@"dropState:%d",sprite.dropState); 
        CCLOG(@"nowActState:%d",sprite.nowActState);
        CCLOG(@"end------------------"); 
    }
}

+ (void)logHero:(id)sprite
{
    if (sprite != nil) {
        Hero *hero=(Hero*)sprite;
         CCLOG(@"start------------------");
        [SOXDebug logPonit:hero.position];
        [SOXDebug logHW:hero];
        CCLOG(@"nowActState:%d",hero.nowActState);
        CCLOG(@"dropState:%d",hero.dropState); 
        CCLOG(@"jumpState:%d",hero.jumpState); 
        CCLOG(@"jumpLevelState:%d",hero.jumpLevelState);
        CCLOG(@"nowActState:%d",hero.nowActState);
        CCLOG(@"end------------------"); 
    }
}


+ (void)logPonit:(CGPoint)point
{
    CCLOG(@"logPonit x:%f,y:%f",point.x,point.y); 
}

+ (void)logAnchorPoint:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logAXY x:%f,y:%f",s.anchorPoint.x,s.anchorPoint.y);
    }
} 
+ (void)logHW:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logHW w:%f,h:%f",s.contentSize.width,s.contentSize.height);
    }
}

+ (void)logImgHW:(id)sprite
{
    if (sprite != nil) {
        CCSprite *s=(CCSprite*)sprite;
        CCLOG(@"logHW w:%f,h:%f",s.textureRect.size.width,s.textureRect.size.height);
    }
}

+ (void)testLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 1000000000; i++)
	{
		a = a / b;
	}
} 
/*
+ (void)drawRectFaster:(CGRect)rect
{
	CGPoint pos1, pos2, pos3, pos4;
	pos1 = ccp(rect.origin.x, rect.origin.y);
	pos2 = ccp(rect.origin.x, rect.origin.y + rect.size.height);
	pos3 = ccp(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	pos4 = ccp(rect.origin.x + rect.size.width, rect.origin.y);
	
//    ccDrawLine(pos1, pos2);
    
	CGPoint vertices[8];
	vertices[0] = pos1;
	vertices[1] = pos2;
	vertices[2] = pos2;
	vertices[3] = pos3;
	vertices[4] = pos3;
	vertices[5] = pos4;
	vertices[6] = pos4;
	vertices[7] = pos1;
    
	glDisable(GL_TEXTURE_2D);
	//glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	//glDisableClientState(GL_COLOR_ARRAY);
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	//glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINES, 0, 8);
	
	// restore default state
	//glEnableClientState(GL_COLOR_ARRAY);
	//glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
}
*/

+ (void)drawRectFaster:(CGRect)rect
{
    glLineWidth( 5.0f );
    ccDrawColor4B(255,0,0,255);
	CGPoint pos1, pos2, pos3, pos4;
	pos1 = CGPointMake(rect.origin.x, rect.origin.y);
	pos2 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
	pos3 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	pos4 = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
	CGPoint vertices[8];
	vertices[0] = pos1;
	vertices[1] = pos2;
	vertices[2] = pos2;
	vertices[3] = pos3;
	vertices[4] = pos3;
	vertices[5] = pos4;
	vertices[6] = pos4;
	vertices[7] = pos1;
    ccDrawPoly( vertices, 8, false);
}

@end
