//
//  MenuShoppingLayer
//  RunTwo
//
//  Created by mjsong on 13-10-8.
//
//

#import "MenuShoppingLayer.h" 
#import "MenuAchieveLayer.h"  
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "InAppRageIAPHelper.h"
#import "IAPHelper.h"
#import "MenuNavInfo.h"
#import "GameLayer.h"

@implementation MenuShoppingLayer
@synthesize hud = _hud;

+(id)scene
{
    CCScene *scene = [CCScene node];
    [scene setTag:T_SCENE_MENU];
    MenuShoppingLayer *nowLayer = [MenuShoppingLayer node];
    [scene addChild:nowLayer];  
    return scene;
}


- (id)init
{
    if (self = [super init]) {   
         
        CCSprite *star_title_1000 = [CCSprite spriteWithFile:@"menu_star_title_5000.png" ];
        CCSprite *star_title_3000 = [CCSprite spriteWithFile:@"menu_star_title_15000.png" ]; 
        CCSprite *life_title_1 = [CCSprite spriteWithFile:@"menu_life_title_1.png" ];
        CCSprite *life_title_3 = [CCSprite spriteWithFile:@"menu_life_title_3.png" ]; 
        CCSprite *buyStar1000ByDollar = [CCSprite spriteWithFile:@"menu_dollar_099.png" ]; 
        CCSprite *BuyStar3000ByDollar = [CCSprite spriteWithFile:@"menu_dollar_199.png" ]; 
        CCSprite *buylife1ByStar = [CCSprite spriteWithFile:@"menu_star_500.png" ];
        CCSprite *buylife3ByStar = [CCSprite spriteWithFile:@"menu_star_1000.png" ]; 
        CCMenuItemSprite *itemTitleStar1000  =  [ CCMenuItemSprite itemWithNormalSprite:star_title_1000 selectedSprite:nil
                                                                         target:nil selector:nil ]; 
        CCMenuItemSprite *itemTitleStar3000  =  [ CCMenuItemSprite itemWithNormalSprite:star_title_3000 selectedSprite:nil
                                                                                  target:nil selector:nil ]; 
        CCMenuItemSprite *itemTitleLife1  =  [ CCMenuItemSprite itemWithNormalSprite:life_title_1 selectedSprite:nil
                                                                                 target:nil selector:nil ]; 
        CCMenuItemSprite *itemTitleLife3  =  [ CCMenuItemSprite itemWithNormalSprite:life_title_3 selectedSprite:nil
                                                                                 target:nil selector:nil ]; 
        
        CCMenuItemSprite *itembuyStar1000ByDollar  =  [ CCMenuItemSprite itemWithNormalSprite:buyStar1000ByDollar selectedSprite:nil
                                                                                        target:self selector:@selector(toBuy1000StarByDollar:) ] ;
        CCMenuItemSprite *itemBuyStar3000ByDollar  =  [ CCMenuItemSprite itemWithNormalSprite:BuyStar3000ByDollar selectedSprite:nil
                                                                                    target:self selector:@selector(toBuy3000StarByDollar:) ];  
        CCMenuItemSprite *itemBuylife1ByStar =  [ CCMenuItemSprite itemWithNormalSprite:buylife1ByStar selectedSprite:nil
                                                                                    target:self selector:@selector(toBuyLife1ByStar:) ];
        CCMenuItemSprite *itemBuylife3ByStar =  [ CCMenuItemSprite itemWithNormalSprite:buylife3ByStar selectedSprite:nil
                                                                                 target:self selector:@selector(toBuyLife3ByStar:) ]; 
        menuStar1000_ = [CCMenu menuWithItems: itemTitleStar1000,itembuyStar1000ByDollar,   nil];  
        menuStar3000_ = [CCMenu menuWithItems: itemTitleStar3000,itemBuyStar3000ByDollar,   nil]; 
        
        menuLife1_ = [CCMenu menuWithItems: itemTitleLife1,itemBuylife1ByStar,   nil];
        menuLife3_ = [CCMenu menuWithItems: itemTitleLife3,itemBuylife3ByStar,   nil]; 
        
        CGPoint commonTop = G_STYLE_MENULAYER_MARGIN_TOP; 
        int marginTop = 35 ; 
        [menuLife1_ setPosition:ccp(commonTop.x, commonTop.y )]; 
        [menuLife3_ setPosition:ccp(commonTop.x, commonTop.y - getRS(marginTop*1))];
        [menuStar1000_ setPosition:ccp(commonTop.x, commonTop.y -getRS(marginTop*2) )];
        [menuStar3000_ setPosition:ccp(commonTop.x, commonTop.y -  getRS(marginTop*3)  )];
        
        
        [menuLife1_ alignItemsHorizontallyWithPadding:10];
        [menuLife3_ alignItemsHorizontallyWithPadding:10];
        [menuStar3000_ alignItemsHorizontallyWithPadding:10];
        [menuStar1000_ alignItemsHorizontallyWithPadding:10];
        
        [menuStar1000_ setVisible: false ];
        [menuStar3000_ setVisible: false ];  
        [self addChild: menuLife1_];
        [self addChild: menuLife3_];
        
        [self addChild: menuStar1000_];
        [self addChild: menuStar3000_]; 
        
        MenuNavInfo *backNav = [[[MenuNavInfo alloc]init:T_SCENE_INDEX]autorelease];
        [self addChild: backNav];
        
    }
    [self initPayment]; 
    return self;
}
//初始化 用户信息
- (void)initPayment{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    NSString *Warning =NSLocalizedString(@"Warning", @"");
    NSString *NoInternet =NSLocalizedString(@"NoInternet", @"");
    
    
    if (netStatus == NotReachable) { 
        [self showHuDByStr:Warning :NoInternet:G_ALERT_DELAY_TIMES];
    } else {
        if ([InAppRageIAPHelper sharedHelper].products == nil ||  [[InAppRageIAPHelper sharedHelper].products count]<2 ) {
            [[InAppRageIAPHelper sharedHelper] requestProducts];
            self.hud= [MBProgressHUD showHUDAddedTo:[SOXGameUtil getBaseRootView].view animated:YES];
            _hud.labelText = NSLocalizedString(@"LoadingPurchases", @"");
            // _hud.detailsLabelText = @"Please try again later.";
            _hud.mode = MBProgressHUDModeIndeterminate;
            //加长加载时间
            [self performSelector:@selector(timeoutLoadPurchases:) withObject:nil afterDelay:5.0];//付款加载时间 10
        }else{
            //直接从缓存加载
            NSArray *array= [InAppRageIAPHelper sharedHelper].products;
            if([array count]>=2){  
                [menuStar1000_ setVisible:true];
                [menuStar3000_ setVisible:true];
            }
        }
    }
}
 
- (void)toBuy1000StarByDollar: (id) sender
{
     [self toBuyCommonStarByDollar:G_PURCHASES_STAR_5000];  
}
- (void)toBuy3000StarByDollar: (id) sender
{
    [self toBuyCommonStarByDollar:G_PURCHASES_STAR_15000];
}
- (void)toBuyLife1ByStar: (id) sender
{ 
    [self toBuyCommonLifeByStar:G_PURCHASES_LIFE_1];
}
- (void)toBuyLife3ByStar: (id) sender
{
    [self toBuyCommonLifeByStar:G_PURCHASES_LIFE_3];
}
//共用 金钱购买星星 方法
- (void)toBuyCommonStarByDollar: (int) addStar
{
    [SOXSoundUtil play_button];
    int objectIndex = -1; // 0.99
  //  NSString *nowProductIdentifier=G_KEY_PURCHASES_STAR_099 ;
    if(addStar == G_PURCHASES_STAR_5000){
        objectIndex = 0;
        //nowProductIdentifier=G_KEY_PURCHASES_STAR_099;
    }else if(addStar == G_PURCHASES_STAR_15000){
        objectIndex = 1;
        //nowProductIdentifier=G_KEY_PURCHASES_STAR_199;
    }
    
    if(objectIndex>=0){ 
       // [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:nowProductIdentifier];
       // [self performSelector:@selector(timeoutToPurchases:) withObject:nil afterDelay:60*5];
        SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:objectIndex];
        if(product!=nil){
             [[InAppRageIAPHelper sharedHelper] buyProduct:product];
            [self performSelector:@selector(timeoutToPurchases:) withObject:nil afterDelay:60*5];
        }else{
            [SOXUtil showAlert:nil :NSLocalizedString(@"GetPurchaseNil", @"") ];
        }
    }else{
       // [SOXDebug logStr:@"Error objectIndex"];
    }
}
//共用 星星购买生命方法  该方法只弹出对话框
- (void)toBuyCommonLifeByStar: (int) addLifeCnt
{
    [SOXSoundUtil play_button];
    int subStars =0;// @"0.99";
    if(addLifeCnt == G_PURCHASES_LIFE_1){
        subStars = G_BUY_LIFE_USED_STAR_500;
    }else if(addLifeCnt == G_PURCHASES_LIFE_3){
         subStars = G_BUY_LIFE_USED_STAR_1000;
    }
    if(subStars>0){  
        double starCnt = [SOXDBGameUtil loadNowStar];
        int lifeCnt = [SOXDBGameUtil loadNowLife];
        bool isFlag = false;
        //必须满足1000个星星
        NSString *NotEnoughStarsToBuy =  NSLocalizedString(@"NotEnoughStarsToBuy", @"");
        NSString *Lifes =  NSLocalizedString(@"Lifes", @"");
        //Not enough Stars to buy ？ Lifes
        NSString  *message = [NSString stringWithFormat:@" %@ [%d %@]!",NotEnoughStarsToBuy,addLifeCnt,Lifes ];
        if(starCnt< subStars){
            [SOXUtil showAlert:nil :message];
        }else{
            //
            if(lifeCnt+addLifeCnt>G_LIFE_CNT_MAX){
                NSString *TheMaxLifeIs =  NSLocalizedString(@"TheMaxLifeIs", @"");
                //The Max Life is  ?
                NSString  *warryLifeMax= [NSString stringWithFormat:@"%@ [%d %@]!",TheMaxLifeIs,G_LIFE_CNT_MAX ,Lifes];
                [SOXUtil showAlert:nil :warryLifeMax];
            }
            else{
                isFlag = true;
            }
            if(isFlag){
                NSString  *DoYouWantToBuy = NSLocalizedString(@"DoYouWantToBuy", @"");
                NSString  *Lifes = NSLocalizedString(@"Lifes", @"");
                NSString  *strFor = NSLocalizedString(@"for", @"");
                NSString  *Stars = NSLocalizedString(@"Stars", @"");
                //Do you want to buy [%d Lifes] for %d Stars?
                NSString  *message1 = [NSString stringWithFormat:@"%@ [%d %@] %@ %d %@?",DoYouWantToBuy,addLifeCnt,Lifes,strFor,subStars,Stars ];
                NSString  *Cancel = NSLocalizedString(@"Cancel", @"");
                NSString  *Buy = NSLocalizedString(@"Buy", @"");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message1 delegate:self cancelButtonTitle:Cancel otherButtonTitles:Buy, nil];
                [alertView setTag:addLifeCnt]; //设置 唯一key
                [alertView show];
                [alertView release];
            }
        }
    } 
}

//实际购买生命 方法
- (void)buyCommonLifeByStar: (int) addLifeCnt
{ 
     double starCnt = [SOXDBGameUtil loadNowStar];
     int lifeCnt = [SOXDBGameUtil loadNowLife];
    
    double subCnt = 0;
    if(addLifeCnt == G_PURCHASES_LIFE_1){
        subCnt = G_BUY_LIFE_USED_STAR_500;
    }else{
        subCnt = G_BUY_LIFE_USED_STAR_1000;
    } 
     //更新当前星星数量 
     starCnt = starCnt - subCnt;
     lifeCnt = lifeCnt +addLifeCnt;
     [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:starCnt] ];
     [SOXDBUtil saveInfo:G_KEY_NOW_LIFE_CNT :[SOXUtil intToString:lifeCnt] ];
    NSString  *Buy =  NSLocalizedString(@"Buy", @"");
    NSString  *Lifes =  NSLocalizedString(@"Lifes", @"");
    NSString  *success =  NSLocalizedString(@"success", @"");
     NSString  *message2 = [NSString stringWithFormat:@"%@ [%d %@] %@!",Buy,addLifeCnt ,Lifes,success];
     [SOXUtil showAlert:nil :message2];
     //播放成功音乐
     [SOXSoundUtil play_shopSuccess];
     SOXGameCenterUtil *gameCenterUtil= [SOXGameCenterUtil sharedSOXGameCenterUtil];
     [gameCenterUtil calAchieveLife:lifeCnt];
     [super reloadInfo]; 
} 
//购买成功回调
- (void)productPurchased:(NSNotification *)notification {  
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSString *productIdentifier = (NSString *) notification.object; 
    //如果是 0。99
    double addStars = 0;
    if([G_KEY_PURCHASES_STAR_099 isEqualToString:productIdentifier]){
        addStars = G_PURCHASES_STAR_5000;
    }else if([G_KEY_PURCHASES_STAR_199 isEqualToString:productIdentifier]){
        addStars = G_PURCHASES_STAR_15000;
    }
    double starCnt = [SOXDBGameUtil loadNowStar];
    starCnt = starCnt +addStars ; 
    [SOXDBUtil saveInfo:G_KEY_NOW_STAR_CNT :[SOXUtil doubleToString:starCnt] ];
    SOXGameCenterUtil *gameCenterUtil = [SOXGameCenterUtil sharedSOXGameCenterUtil]; 
    [gameCenterUtil calAchieveStar:starCnt];
    [super reloadInfo];
    
     NSString *addStarsShow =[SOXUtil notRounding:addStars afterPoint:0];
    //Buy ？ Stars success
    NSString  *Buy =  NSLocalizedString(@"Buy", @"");
    NSString  *Stars =  NSLocalizedString(@"Stars", @"");
    NSString  *success =  NSLocalizedString(@"success", @"");
    NSString *message = [NSString stringWithFormat:@"%@ [%@ %@] %@!",Buy,addStarsShow,Stars,success];
    //播放成功音乐
    [SOXSoundUtil play_shopSuccess];
    [SOXUtil showAlert:nil :message];
}

- (void)productPurchaseFailed:(NSNotification *)notification { 
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; 
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    if (transaction.error.code != SKErrorPaymentCancelled) {
         NSString *Error =NSLocalizedString(@"Error", @""); 
        [SOXUtil showAlert:Error :transaction.error.localizedDescription];
    } 
}

//查询当前 已购买信息
- (void)productsLoaded:(NSNotification *)notification {
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; 
    [MBProgressHUD hideHUDForView:[SOXGameUtil getBaseRootView].view animated:YES]; 
    NSArray *array= [InAppRageIAPHelper sharedHelper].products;
    if([array count]>=2){ 
        [menuStar1000_ setVisible:true];
        [menuStar3000_ setVisible:true];
    } 
}

- (void)dismissHUD:(id)arg { 
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
   self.hud = nil;
}
//用于提示框
- (void)showHuDByStr:(NSString*)title :(NSString*)message :(double)delay {
    self.hud= [MBProgressHUD showHUDAddedTo:[SOXGameUtil getBaseRootView].view animated:YES];
    _hud.labelText = title; 
    _hud.detailsLabelText = message; 
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:delay];
}
//加载付款信息超时
- (void)timeoutLoadPurchases:(id)arg {
     NSString *Warning =NSLocalizedString(@"Warning", @"");
    _hud.labelText = Warning;
    NSString *PleaseTryAgainLater =NSLocalizedString(@"PleaseTryAgainLater", @"");
    _hud.detailsLabelText = PleaseTryAgainLater;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:2];
    
}
- (void)timeoutToPurchases:(id)arg {
    //检测当前是否游戏中，游戏中 则 调用暂停画面
    [SOXGameUtil toChkNowIsPlayingToPause];
    NSString *PurchaseTimeout =NSLocalizedString(@"PurchaseTimeout", @"");
    [SOXUtil showAlert:nil :PurchaseTimeout];
}

- (void)updateInterfaceWithReachability: (Reachability*) curReach {
}

//星星购买 生命提示框结果回调
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   int tag= [alertView tag];
    if(buttonIndex == 1){//点击了确认
        if(tag == G_PURCHASES_LIFE_1){
            [self buyCommonLifeByStar:G_PURCHASES_LIFE_1];
        }else if(tag == G_PURCHASES_LIFE_3){
            [self buyCommonLifeByStar:G_PURCHASES_LIFE_3];
        } 
    }  
}
 
- (void)onExit
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[super onExit];
}

- (void)dealloc {
    [_hud release];
    _hud = nil;
    [super dealloc];
}



@end
