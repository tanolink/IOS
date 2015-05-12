//
//  ZNAppDelegate.m
//  JuranClient
//
//  Created by Marin on 14-9-16.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "ZNAppDelegate.h"
//#import "WeiboSDK.h"
//#import "WXApi.h"
//#import "WeiboApi.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <ShareSDK/ShareSDK.h>
#import "ZNAppUtil.h"
#import "ZNClientInfo.h"
#import "APService.h"
@implementation ZNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*参数为ShareSDK官网中添加应用后得到的AppKey*/
//    _viewDelegate = [[AGViewDelegate alloc] init];
    

//    [ShareSDK registerApp:shareSdkAppKey];
//    [self registerAllSocialApp];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    MainViewController *mainViewController = [[MainViewController alloc] init];
    /*self.mainViewController = mainViewController;*/
    
    self.window.rootViewController = mainViewController;
    
    //self.window.rootViewController = [MasonryViewController new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];

    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];

    [self.window makeKeyAndVisible];
    

    [self initPushService :launchOptions];
    return YES;
}

-(void)registerAllSocialApp {
//    
//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//    [ShareSDK  connectSinaWeiboWithAppKey:SINAWEIBOAppKey
//                                appSecret:SINAWEIBOAppSecret
//                              redirectUri:SINAWEIBOREDIRECTURI
//                              weiboSDKCls:[WeiboSDK class]];
//    
//    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
//    [ShareSDK connectTencentWeiboWithAppKey:TencentWeiboAppKey
//                                  appSecret:TencentWeiboAppKeySecret
//                                redirectUri:TencentWeiboREDIRECTURI
//                                   wbApiCls:[WeiboApi class]];
//
//    
//    //添加微信应用 注册网址 http://open.weixin.qq.com
//    [ShareSDK connectWeChatWithAppId:WXSDKAppKey appSecret:WXSDKAppSecret wechatCls:[WXApi class]];
//    
//    
//    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
//    [ShareSDK connectQZoneWithAppKey:QQHLSDKAppKey
//                           appSecret:QQHLSDKAppSecret
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    /*手机QQ开发者平台注册的appId*/
//    //添加QQ应用  注册网址  http://mobile.qq.com/api/
//    [ShareSDK connectQQWithQZoneAppKey:QQHLSDKAppKey
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
//
////    /*服务器托管模式初始化时*/
////    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
////    [ShareSDK importQQClass:[QQApiInterface class]
////            tencentOAuthCls:[TencentOAuth class]];
//    
//    
//    //添加网易微博应用 注册网址  http://open.t.163.com
//    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
//                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
//                            redirectUri:@"http://www.shareSDK.cn"];
}

//- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
//{
//    /*微信委托,如果没有集成微信SDK，可以传入nil*/
//    return [ShareSDK handleOpenURL:url
//                        wxDelegate:self];
//}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return [ShareSDK handleOpenURL:url
//                 sourceApplication:sourceApplication
//                        annotation:annotation
//                        wxDelegate:self];
//}

-(void)loginStateChange : (NSNotification *)notification{
    [[ZNClientInfo sharedClinetInfo]clearGuidAndToken];
    self.window.rootViewController = [[MainViewController alloc] init];
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    ZNBaseNavigationController *loginNav = [[ZNBaseNavigationController alloc]initWithRootViewController:loginVC];
//    MainViewController *mainVC = (MainViewController*)self.window.rootViewController;
//    [mainVC.selectedViewController presentViewController:loginNav animated:YES completion:nil];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
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
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
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