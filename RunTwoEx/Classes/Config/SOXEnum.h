//
//  Defines.h
//  PompaDroid
//
//  Created by Allen Benson G Tan on 10/21/12.
//
//
 

typedef enum _SoundType{
    T_SOUND_NULL,
    T_SOUND_MENU,
    T_SOUND_GAME
} SoundType;

//游戏场景切换
typedef enum _TargetScene{
    T_SCENE_NULL,
    T_SCENE_LOGO,
    T_SCENE_MENU,  //通用
    T_SCENE_INDEX, 
    T_SCENE_SCORE,
    T_SCENE_SETTING,
    T_SCENE_SHARE,
    T_SCENE_GAME_LAYER,
    T_SCENE_HELP,
    T_SCENE_PAUSE, 
    T_SCENE_SHOPPING,
    T_SCENE_ACHIEVE,
    T_SCENE_TEST,
    T_SCENE_MAX
} TargetScene; 

//主要背景层级
enum T_LAYER
{
    T_LAYER_NULL = 0,
    T_LAYER_BG=1,//底 大背景  如果太阳 云层
    T_LAYER_BG_TMX=2,// 地图 背景
    T_LAYER_BG_AD_BEFORE=3,// 前端广告背景
    T_LAYER_BG_AD_AFTER=33,// 后端广告背景
    T_LAYER_INPUT=4,// 系统操作按钮 
    T_LAYER_GAME=5,//主游戏层级
    T_LAYER_THING=6,//物件 障碍 层
    T_LAYER_PAUSED=7,//暂停 层
    T_LAYER_SCORE=8,//分数 层
    T_LAYER_CHARTOP= 9 //游戏文字
};
//对象层级
enum T_OBJ
{  
    T_OBJ_HERO=10,
    T_OBJ_TMX_MAP=11,
    T_OBJ_HERO_INFO=12,//人物信息
    T_OBJ_HERO_INFO_STAR=13,//金币
    T_OBJ_HERO_INFO_LIFE=14,//生命
    T_OBJ_GAME_LAYER_INFO=15,//生命
    T_OBJ_THING_CACHE=16,//缓冲
    T_OBJ_THING_CACHE_NO_MOVE=17,//缓冲 静态
    T_OBJ_MENU_PAUSED=18,//暂停按钮
    T_OBJ_SCORE_TIME=19//暂停按钮
};


enum T_Level
{
    T_LEVEL_EASY0=0,
    T_LEVEL_EASY1,
    T_LEVEL_EASY2,
    T_LEVEL_EASY3,
	T_LEVEL_NORMAL1,
    T_LEVEL_NORMAL2,
    T_LEVEL_NORMAL3,
    T_LEVEL_HARD1,
    T_LEVEL_HARD2,
    T_LEVEL_HARD3,
    T_LEVEL_NORMAL_COMMON_FAST,
    T_LEVEL_HARD_COMMON_FAST
};

enum T_Map
{
    T_Map_0=0,
    T_Map_1,
    T_Map_2,
    T_Map_3,
	T_Map_4,
    T_Map_5,
    T_Map_6
};

enum T_Char_Level
{
    T_Char_LEVEL_EASY=0,
	T_Char_LEVEL_NORMAL,
    T_Char_LEVEL_HARD,
    
};


//基本动作
typedef enum _ActionState
{
    kActionStateNone = 0,
    kActionStateDef,
    //实际切换动作-------
    kActionStateHurt,
    kActionStateRun, 
    kActionStateJump,
    kActionStateScroll,
    kActionStateDead,
    //-----------------
    //只用于 区分 tag  不赋值 
     kActionStatePowerPerfect 
} ActionState;


//并行---基本动作----------start
//无敌状态 
typedef enum _PowerState
{
    kPowerStateNone = 0,
    kPowerStatePerfect
} PowerState;

//跳跃 状态 往上 还是往下
typedef enum _JumpState
{
    kJumpStateNone = 0, 
    kJumpStateUp,
    kJumpStateDown
} JumpState; 
//单跳 双跳
typedef enum _JumpLevelState
{
    kJumpLevelNone = 0,
    kJumpLevel1,
    kJumpLevel2
} JumpLevelState;

//速度状态
typedef enum _SpeedState
{
    kSpeedStateSlow = 0,
    kSpeedStateNormal = 1,
    kSpeedStateFast = 2
} SpeedState;


//下降状态  
typedef enum _DropState
{
    kDropStateNone = 0,
    kDropStateDown
} DropState;

//角色切换
typedef enum _RoleState
{
	kRoleStateBlue = 0,
	kRoleStatePink
} RoleState;


//并行---基本动作----------end

//structures
typedef struct _BumpBox
{
    CGRect ori;//正常
    CGRect scroll;//滚动 
} BumpBox;

typedef enum _CrashType
{
      CrashTypeTop = 0,//上
      CrashTypeBody = 1,//中
      CrashTypeBottom = 2,//下
} CrashType;

//物品颜色
typedef enum _ColorType
{
    ColorTypeNull=-1,
	ColorTypeBlue=0,
    ColorTypePink=1,
	ColorTypeRed=2,
	ColorTypeBlack=3,
	ColorTypeMax
} ColorType;

//实际 物件类别
typedef enum _ThingObjType
{
    ThingObjNull=-1,
	ThingObjStar=0,
	ThingObjLine=1,//  ThingObjLife=4,
    ThingObjBox=2,
    ThingObjLife=3,
    ThingObjFloor=4,
	ThingObjMax=5
} ThingObjType;

//成就类型
typedef enum _AchieveType
{
    AchieveTypeScore=0,
	AchieveTypeDistance=1,
    AchieveTypeLife=2,
	AchieveTypeStar=3,
	AchieveTypeMax=4
} AchieveType;
 
typedef enum _AchieveLevel
{
    AchieveLevel1=1,
	AchieveLevel2=2,
    AchieveLevel3=3,
	AchieveLevel4=4
} AchieveLevel; 
