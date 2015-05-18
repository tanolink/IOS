//
//  ZNApi.h
//  Zouni
//
//  Created by Aokuny on 14-10-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGProgressHUD+Add.h"
#import "ZNRespModel.h"
#import "ZNAppUtil.h"
#import "Reachability.h"

#define MACRO_PRODUCT 1
//测试账号chensl2
#ifdef                MACRO_PRODUCT
#define JR_BASE_URL   @"http://182.92.108.45/"
#else
/*外网测试地址*/
#define JR_BASE_URL   @"http://...:/"
#endif


#define TestHeaderMD5 @"0,5848e1a72107f97600dc3c3f917d58f4"

/*发现*/
#define ZN_CITYLIST_API                 @"api/Cities"                      /*城市列表*/
#define ZN_SHOPLIST_API                 @"api/ShopList"                    /*城市下的店铺列表*/
#define ZN_SHOPDETAIL_API               @"api/ShopDetail"

/*我的个人中心*/

/*登录注册*/
#define ZN_LOGIN_API                  @"member/login.json"                      /*登录接口*/


typedef void (^ZNObjectBlock)(id resultObj,NSString *msg,ZNRespModel *respModel);

@interface ZNApi : NSObject

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (void )invokePostOne:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end
