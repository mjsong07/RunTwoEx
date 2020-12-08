 

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "BaseSprite.h"
#import "HeroInfo.h" 
#import "SOXEnum.h"
@interface Hero : BaseSprite{

}

//人物基本信息

@property(nonatomic,assign)JumpState jumpState;//跳跃 状态
@property(nonatomic,assign)JumpLevelState jumpLevelState;//跳跃 等级
@property(nonatomic,assign)PowerState powerState;//无敌 状态
@property(nonatomic,assign)RoleState nowRoleState;//角色  类型 蓝色 粉红
@property(nonatomic,assign)int lifes;//生命数量
@property(nonatomic,assign)double stars; //生命数量
@property(nonatomic,assign)float perfectTime;//无敌时间



//人物跑步显示的位置
@property(nonatomic,assign)CGPoint runPosion;

//人物创建位置
@property(nonatomic,assign)CGPoint createPosion;


 


@property(nonatomic,assign)float nowRiseCnt;//当前上升总距离   
@property(nonatomic,assign)float nowRiseSpeed;//当前上升 速度
@property(nonatomic,assign)float nowDropSpeed;//当前下降 速度


@property(nonatomic,assign)float nowRiseAcc;//当前上升 加速度
@property(nonatomic,assign)float nowDropAcc;;//当前下降 加速度




@property(nonatomic,assign)BumpBox bumpBox;//人物 碰撞box 用于初始化 赋值
@property(nonatomic,assign)CGRect nowBumpBox;//当前 碰撞box
@property(nonatomic,assign)HeroInfo* heroInfo;
//基类已实现
//@property(nonatomic,assign)ActionState nowActState; //基本动作
//@property(nonatomic,assign)DropState dropState;//下降 

//actions
@property(nonatomic,retain)id defImgAct; 
@property(nonatomic,retain)CCAction *runAct; 
@property(nonatomic,retain)CCAction *jumpAct;
@property(nonatomic,retain)CCAction *scrollAct; 
@property(nonatomic,retain)CCAction *hurtAct; 
@property(nonatomic,retain)CCAction *powerPerfectAct;
@property(nonatomic,retain)CCAction *deadAct;  
//动画
@property(nonatomic,retain)CCAction *defAct; 

@property(nonatomic,retain)id runImgAct; 
@property(nonatomic,retain)id jumpImgAct;

@property(nonatomic,retain)id jumpImgAct2;
@property(nonatomic,retain)id scrollImgAct; 
@property(nonatomic,retain)id hurtImgAct; 



+(Hero*) sharedHero;
//基本动作
- (void)defaultDo; //基本默认

- (void)run; //跑
- (void)jump;//跳
- (void)drop;//掉落
- (void)drop:(float)distance;
- (void)rise;//上升
- (void)scroll;//滚动
- (void)change;//切换角色
- (void)hurt; //受伤
- (void)dead;//死亡


- (void)again;//复活


- (void)initCreate;//


- (void)updateHeroLifes:(int)i;//更新生命
- (void)updateHeroStars:(double)i;//更新星星
- (void)setHeroMoveLeft;//设置人朝着左边
- (void)setHeroMoveRight;//设置人朝着右边
- (void)stopNowAction;//停止当前 动作

//- (void)update:(ccTime)dt; //定时任务 

- (CGRect)getBumpRectTop;
//获取  碰击 x
- (CGRect)getBumpRectBody ;
//获取  碰击 y
- (CGRect)getBumpRectBottom;
//获取  碰击 滚动
- (CGRect)getBumpRectScrollBody;

//获取  碰击 滚动
- (CGRect)getBumpRectScrollBottom;


@end
