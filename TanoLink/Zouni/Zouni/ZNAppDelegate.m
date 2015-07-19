//
//  ZNAppDelegate.m
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "ZNAppDelegate.h"
#import "ZNAppUtil.h"
#import "ZNClientInfo.h"
#import "APService.h"
#import "CityListViewController.h"
#import "MyCenterViewController.h"
#import "ShopListViewController.h"
//#import <GoogleMaps/GoogleMaps.h>
#import "InterfaceViewController.h"
#import "UMSocial.h"
#import "KitMapViewController.h"
#import "GuideViewController.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSinaHandler.h"

@implementation ZNAppDelegate
//static NSString *const kAPIKey = @"AIzaSyBUyVmigb163ipK0MyITVJt76RR0XBwnKk";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 友盟
    [UMSocialData setAppKey:UMengAppKey];
    // 微信
    [UMSocialWechatHandler setWXAppId:@"wxc38a3e3ef8f78503" appSecret:@"d61bc62f323b94cf6abd0c973daba6ca"
                                  url:@"http://www.tanolink.com"];
    [UMSocialQQHandler setQQWithAppId:@"1104725612" appKey:@"3A8aYBWIQMo4pxSR" url:@"http://www.tanolink.com"];
    
    // 新浪
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    // 新浪 非原生
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 分享
    // 分享APP
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
    // 如果不是APP，择分享的后的链接
    //微信
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.tanolink.com";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.tanolink.com";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"走你app带您进入日本美食购物天堂";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"走你app带您进入日本美食购物天堂";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"走你app带您进入日本美食购物天堂";
    [UMSocialData defaultData].extConfig.qqData.title = @"走你app带您进入日本美食购物天堂";
    [UMSocialData defaultData].extConfig.emailData.title = @"走你app带您进入日本美食购物天堂";
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults objectForKey:@"ISFirst"]){
//    if(YES){
        GuideViewController *guide = [GuideViewController new];
        self.window.rootViewController = guide;
        [self.window makeKeyAndVisible];
        return YES;
    }
    
    if(NO){
        // 调试接口
//        InterfaceViewController *interfaceTest = [InterfaceViewController new];
//        self.window.rootViewController = interfaceTest;
        // 调试地图
//        KitMapViewController *kvc = [KitMapViewController new];
//        self.window.rootViewController = kvc;
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults objectForKey:@"CityId"]){
//            MainViewController *mainViewController = [[MainViewController alloc] init];
//            CityModel *cityModel = [CityModel new];
//            cityModel.CityNameCN = [userDefaults objectForKey:@"CityNameCN"];
//            cityModel.CityId = [userDefaults objectForKey:@"CityId"];
//            mainViewController.cityModel = cityModel;
//            self.window.rootViewController = mainViewController;
            ShopListViewController *shopListVC = [ShopListViewController new];
            CityModel *cityModel = [CityModel new];
            cityModel.CityNameCN = [userDefaults objectForKey:@"CityNameCN"];
            cityModel.CityId = [userDefaults objectForKey:@"CityId"];
            shopListVC.cityModel = cityModel;
            ZNBaseNavigationController *shopNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:shopListVC];
            self.window.rootViewController = shopNavController;
        }else{
            CityListViewController *cityListVC = [[CityListViewController alloc]init];
            ZNBaseNavigationController *cityNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:cityListVC];
            self.window.rootViewController = cityNavController;
        }
    }
    
    [[ZNClientInfo sharedClinetInfo] loadPermit];
    [[ZNClientInfo sharedClinetInfo] loadMemberInfo];

    [self.window makeKeyAndVisible];
    return YES;
}

-(void)loginStateChange : (NSNotification *)notification{
    self.window.rootViewController = [[MainViewController alloc] init];
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    ZNBaseNavigationController *loginNav = [[ZNBaseNavigationController alloc]initWithRootViewController:loginVC];
//    MainViewController *mainVC = (MainViewController*)self.window.rootViewController;
//    [mainVC.selectedViewController presentViewController:loginNav animated:YES completion:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    [[ZNClientInfo sharedClinetInfo] loadPermit];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma Weixin
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}



#pragma mark - 初始化jpush

-(void)initPushService : (NSDictionary *)launchOptions{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];

    [APService setTags:[NSSet setWithObjects:@"tag4",@"tag5",@"tag6",nil] alias:@"别名" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [APService handleRemoteNotification:userInfo];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    [APService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNoData);
}
#endif


- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *log = [NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content];
    
    NSLog(@"%@", log);
    
    showAlertMessage(log);
    
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
