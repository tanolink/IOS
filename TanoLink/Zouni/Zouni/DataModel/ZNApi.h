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

//#define MACRO_PRODUCT 1
//测试账号chensl2
#ifdef                MACRO_PRODUCT
#define JR_BASE_URL   @"http://10.199.5.236:8084"
#else
/*外网测试地址*/
#define JR_BASE_URL   @"http://124.207.66.50:10005/"
#endif

/*图片在另外一台服务器*/
#define JR_IMG_URL  @"http://10.199.5.57:8080/"

/*img/5445efcf498ee42b194dceef.img*/

// 应用ID 发布itunes时生成的ID
#define JR_APPID @"414478124"

/*登录注册*/
#define JR_LOGIN_API                  @"member/login.json"                      /*登录接口*/
#define JR_SENDSMSAUTH_API            @"member/sendSmsAuth.json"                /*手机验证码发送请求*/
#define JR_VALIDSMS_API               @"member/validSms.json"                   /*注册时验证手机验证码请求*/
#define JR_REGISTERUSER_API           @"member/registUser.json"                 /*消费者注册请求*/
#define JR_RESTPWD_API                @"member/resetPwd.json"                   /*手机找回密码-修改密码请求*/
#define JR_GETTOKENFORRESETPWD_API    @"member/getTokenForResetPwd.json"        /*手机找回密码-验证验证码请求*/


/*个人中心*/
#define JR_GETMEMBERDETAIL_API        @"member/getMemberDetail.json"            /*个人资料查看请求*/
#define JR_EDITMEMEBERINFO            @"member/editMemberInfo.json"             /*个人普通资料修改请求*/
#define JR_GETALLAREAINFO             @"location/getAllAreaInfo.json"           /*所在地省份等*/
#define JR_UPLOADHEADIMAGE            JR_BASE_URL"member/uploadHeadImage.htm"   /*个人头像修改请求*/
#define JR_CHANGEPWD                  @"member/changePwd.json"                  /*个人密码修改请求*/
#define JR_UPDATEBINDINGEMAIL         @"/member/updateBindingEmail.json"        /*个人邮箱修改发送新邮箱验证请求*/
#define JR_GETMYFAVPROJECT            @"/design/getMyFavProject.json"           //我的案例收藏列表请求
#define JR_SIGNIN                     @"/member/signin.json"                    //每日签到请求


/** 设置 */
#define JR_ADDFEEDBACK                JR_BASE_URL@"/support/addFeedback.json"   //问题反馈


/*设计师*/
#define JR_SEARCHDESIGNERLIST         @"/member/searchDesignerList.json"        /*设计师列表查看请求*/
#define JR_GETDESIGNERDETAIL          @"/member/getDesignerDetail.json"         /*设计师详情查看请求*/
#define JR_GETFOLLOWLIST              @"/member/getFollowList.json"             /*我的关注列表请求*/
#define JR_FOLLOWDESIGNER             @"/member/followDesigner.json"            /*关注设计师请求*/
#define JR_SELECTTAMEASUREREQ         @"/design/selectTaMeasureReq.json"        //选TA量房请求


// 案例
#define JR_CASELIST_API               @"/design/getprojlist.json"               /*案例列表数据请求*/
#define JR_CASEPRAISE_API             @"/design/givealike.json"                 /*案例点赞请求*/
#define JR_CASEFAVORITE_API           @"/design/addprjfavorite.json"            /*案例收藏请求*/
#define JR_CASEFAVORITEREMOVE_API     @"/design/removeprjfavorite.json"         /*案例取消收藏请求*/
#define JR_CASEDETAIL_API             @"/design/getprojdetail.json"             /*案例详情数据请求*/
#define JR_CASECOMMENT_API            @"/design/getComment.json"                /*案例评论列表*/
#define JR_CASEADDCOMMENT_API         @"/design/addComment.json"                /*案例发送评论*/

//需求
#define JR_PUBLISHDESIGN              @"/design/publishDesign.json"             //发布招标需求请求
#define JR_GETMYREQUESTLIST           @"/design/getMyRequestList.json"          //我的需求列表请求
#define JR_GETMYDESIGNREQDETAILINFO   @"/design/getMyDesignReqDetailInfo.json"  //我的需求详情请求
#define JR_REJECTDESIGNREQ            @"/design/rejectDesignReq.json"           //需求拒标请求
#define JR_REQSTOP                    @"/design/ReqStop.json"                   //需求终止请求
#define JR_PUBLISHDESIGN              @"/design/publishDesign.json"             //发布招标需求请求


//私信
#define JR_GETPRIVATELETTERLIST       @"/member/getPrivateLetterList.json"      //我的私信列表请求
#define JR_GETPRIVATELETTERDETAILLIST @"/member/getPrivateLetterDetailList.json"//我的私信详情请求
#define JR_DELETEPRIVATELETTER        @"/member/deletePrivateLetter.json"       //删除私信请求

//消息
//#define JR_GETMESSAGELIST             @"/member/getMessageList.json"          //我的消息列表
#define JR_GETMESSAGELIST             @"/info/get_msg_info.json"                //我的消息列表
#define JR_VIEWCOUNT                  @""                                       //消息阅读
#define JR_MSGDETAIL                  @"/info/get_msg_detail.json"              //我的消息详情
#define JR_DELETE                     @""                                       //

typedef void (^JRObjectBlock)(id resultObj, ZNRespHeadModel* head);

@interface ZNApi : NSObject

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (JRObjectBlock)completeBlock;

+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (JRObjectBlock)completeBlock;

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end
