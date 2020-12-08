//
//  Config.h
//  RunTwo
//
//  Created by mjsong on 13-5-23.
//
//

#import <Foundation/Foundation.h>


#define G_STYLE_GAMELAYER_TOOLBAR_MARGIN_TOP getRS(68)  //公用工具栏 离顶部的高度48 68
//公用工具栏 离顶部的高度
#define G_STYLE_MENULAYER_NOW_STAR_LIFE_POINT ccp(G_SCREEN_SIZE.width-getRS(45), G_SCREEN_SIZE.height-getRS(10))
//菜单 公用离顶部距离
#define G_STYLE_MENULAYER_MARGIN_TOP ccp(G_SCREEN_SIZE.width/2 , G_SCREEN_SIZE.height/2+getRS(40))
#define G_STYLE_MENULAYER_MARGIN_TOP2 ccp(G_SCREEN_SIZE.width/2- getRS(60),G_SCREEN_SIZE.height-getRS(120)  )


@interface SOXStyle : NSObject{
    
}
@end
