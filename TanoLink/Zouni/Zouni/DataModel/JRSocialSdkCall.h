//
//  JRSocialSdkCall.h
//  JuranClient
//
//  Created by Marin on 14-9-17.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#define WiressSDKDemoAppKey     @"1103074867"
#define WiressSDKDemoAppSecret  @"0mV0MmY64ZK9zZSV"
#define REDIRECTURI             @"http://www.baidu.com"

#define QQHLSDKAppKey @"1103074867"
#define QQHLSDKAppSecret @"0mV0MmY64ZK9zZSV"

#define SINAWEIBOAppKey @"3749353156"
#define SINAWEIBOAppSecret @"c1730b2fefc30574f444a10e016d7d72"
#define SINAWEIBOREDIRECTURI @"http://www.sina.com"


#define WXSDKAppKey @""
#define WXSDKAppSecret @""
#define WXSDKREDIRECTURI @""

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboApi.h"
#import "JRLoginViewController.h"

@interface JRSocialSdkCall : NSObject

@property (nonatomic, strong) WeiboApi *tencentWbApi;

+(JRSocialSdkCall *)sharedInstance ;

+(void)loginQQ;
+(void)loginTencentWeibo:(id )controller;
-(void)loginSina :(JRLoginViewController *)loginViewController;

-(void)shareQQ;
-(void)shareQQZone;
-(void)shareTencentWeibo;
-(void)shareSinaWeibo:(JRLoginViewController *)loginViewController;
@end
