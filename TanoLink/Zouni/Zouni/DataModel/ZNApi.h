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
//#define JR_BASE_URL   @"http://...:/"
#endif


#define DefaultHeaderMD5 @"0,5848e1a72107f97600dc3c3f917d58f4"
#define DefautlKey @"1bf304dc01310c6b0aa7983ecc9e4d35"

/*发现*/
#define ZN_CITYLIST_API                 @"api/Cities"                      /*城市列表*/
#define ZN_SHOPLIST_API                 @"api/ShopList"                    /*城市下的店铺列表*/
#define ZN_SHOPDETAIL_API               @"api/ShopDetail"                  /*店铺详情*/
#define ZN_ADDFAVORITE_API              @"api/AddFavorite"                 /*增加收藏*/
#define ZN_DELFAVORITES_API             @"api/DelFavorites"                /*取消店铺收藏，单个、多个*/
#define ZN_COUPON_API                   @"api/Coupon"                      /*优惠券*/ //shopId=1&invitationCode=aaa

/*我的个人中心*/
#define ZN_LOGIN_API                    @"api/login"                       /*登录*/   // email=gdw&password=
#define ZN_REPWD_API                    @"api/repwd"                       /*修改密码*/ //email=&password=&code=8761


typedef void (^ZNObjectBlock)(id resultObj,NSString *msg,ZNRespModel *respModel);

@interface ZNApi : NSObject

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *headerPermit;
@end
