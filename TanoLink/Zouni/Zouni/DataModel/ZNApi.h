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

// 应用ID 发布itunes时生成的ID
#define ZN_APPID @"1019363581"

//#define MACRO_PRODUCT 1
//测试账号chensl2
#ifdef                MACRO_PRODUCT
#define ZN_BASE_URL   @"http://182.92.108.45/"
#else
/*外网测试地址*/
#define ZN_BASE_URL   @"http://115.28.166.35:8888"
#endif

#define UMengAppKey @"556885e767e58e40ca001421"

#define DefaultHeaderMD5 @"0,5848e1a72107f97600dc3c3f917d58f4"
#define DefautlKey @"1bf304dc01310c6b0aa7983ecc9e4d35"

/*发现*/
#define ZN_CITYLIST_API                 @"api/Cities"                      /*城市列表*/
#define ZN_SHOPLIST_API                 @"api/ShopList"                    /*城市下的店铺列表*/
#define ZN_SHOPDETAIL_API               @"api/ShopDetail"                  /*店铺详情*/
#define ZN_ADDFAVORITE_API              @"api/AddFavorite"                 /*增加收藏*/
#define ZN_DELFAVORITES_API             @"api/DelFavorites"                /*取消店铺收藏，单个、多个*/
#define ZN_COUPON_API                   @"api/Coupon"                      /*优惠券*/ //shopId=1
#define ZN_MYFAVORITELIST_API           @"api/MyFavorites"                 /*我的收藏列表*/
#define ZN_SHOPCOMMENTS_API             @"api/comments"                    /*分页获取评论*///?shopId=234&page=1&size=10

/*我的个人中心*/
#define ZN_LOGIN_API                    @"api/login"                       /*登录*/   // email=gdw&password=
#define ZN_REPWD_API                    @"api/repwd"                       /*修改密码*/
#define ZN_VERIFY_API                   @"api/verify"                      /*邮箱、手机，获取验证码*/ //email=gaodawei@cxtech360.com
#define ZN_REGISTER_EMIL_API            @"api/register"                    /*注册*/
#define ZN_UPLOAD_IMAGE_API             ZN_BASE_URL"/api/UploadUserPhoto"  /*上传图片*/

#define ZN_BINDCODE_API                 @"api/BindCode"                     /*绑定码*////api/BindCode?code=xxxx
#define ZN_BINDEMAIL_API                @"api/BindEmail"                    /*绑定邮箱*/
#define ZN_CHANGEUSER_API               @"api/ChangeUser"                   // nickName=fds&upor
#define ZN_FORGETPWD_API                @"api/forgetPassword"               /*修改密码*/ //

#define ZN_BINDMOBILE_API               @"api/BindMobile"                    /*绑定手机mobile=xxx.xxx@.com&code=xxx*/

#define ZN_THIRDLOGIN_API               @"api/ThirdPartyLogin"               /*第三方登录loginName=&loginFrom=*/

/*设置*/
#define ZN_ADDFEEDBACK_API @"api/AddFeedback" /*反馈*///?content=fds&mobileType=ios


typedef void (^ZNObjectBlock)(id resultObj,NSString *msg,ZNRespModel *respModel);

typedef void (^ZNObjectBlock1)(id resultObj,NSString *msg,ZNRespModel1 *respModel);


@interface ZNApi : NSObject

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (void )invokePost1:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock1)completeBlock;

+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock;

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *headerPermit;

@end
