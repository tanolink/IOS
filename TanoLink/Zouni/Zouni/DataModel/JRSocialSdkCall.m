//
//  JRSocialSdkCall.m
//  JuranClient
//
//  Created by Marin on 14-9-17.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "JRSocialSdkCall.h"
#import "JRAppUtil.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
@interface JRSocialSdkCall () <TencentSessionDelegate, WeiboAuthDelegate>
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@property (nonatomic, assign) time_t loginTime;
@end

@implementation JRSocialSdkCall
+ (JRSocialSdkCall *)sharedInstance
{
    static JRSocialSdkCall* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:QQHLSDKAppKey andDelegate:self];
        self.tencentWbApi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI andAuthModeFlag:0 andCachePolicy:0] ;
        _loginTime = 0;
    }
    return self;
}

+(void)loginQQ {
    [[JRSocialSdkCall sharedInstance] loginQQ];
}

+(void)loginTencentWeibo:(id )controller {
    [[JRSocialSdkCall sharedInstance] wbLogin:controller];
}

-(void)wbLogin : (UIViewController *)controller{
    [_tencentWbApi loginWithDelegate:self andRootController:controller];
}

-(void)loginQQ {
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            /*kOPEN_PERMISSION_ADD_ALBUM,
                             kOPEN_PERMISSION_ADD_IDOL,
                             kOPEN_PERMISSION_ADD_ONE_BLOG,
                             kOPEN_PERMISSION_ADD_PIC_T,
                             kOPEN_PERMISSION_ADD_SHARE,
                             kOPEN_PERMISSION_ADD_TOPIC,
                             kOPEN_PERMISSION_CHECK_PAGE_FANS,
                             kOPEN_PERMISSION_DEL_IDOL,
                             kOPEN_PERMISSION_DEL_T,
                             kOPEN_PERMISSION_GET_FANSLIST,
                             kOPEN_PERMISSION_GET_IDOLLIST,
                             kOPEN_PERMISSION_GET_INFO,
                             kOPEN_PERMISSION_GET_OTHER_INFO,
                             kOPEN_PERMISSION_GET_REPOST_LIST,
                             kOPEN_PERMISSION_LIST_ALBUM,
                             kOPEN_PERMISSION_UPLOAD_PIC,
                             kOPEN_PERMISSION_GET_VIP_INFO,
                             kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                             kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                             kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,*/
                            nil];
    time_t currentTime;
    time(&currentTime);
    
    if ((currentTime - _loginTime) > 2)
    {
        /*NSArray *permissions = @[@"all"];*/
        [_tencentOAuth authorize:permissions inSafari:YES];
        _loginTime = currentTime;
    }
}

-(void) loginSina :(JRLoginViewController *)loginViewController{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = SINAWEIBOREDIRECTURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": NSStringFromClass(loginViewController.class),
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}


#pragma mark - 腾讯QQ,QQ空间
-(void)tencentDidLogin {
    
    NSString *msg =[NSString stringWithFormat:@"accessToken, %@,openid, %@", _tencentOAuth.accessToken, _tencentOAuth.openId];
    
    JMLog(msg);
    
    showAlertMessage(msg);
    [_tencentOAuth getUserInfo];
    [_tencentOAuth getVipInfo];
}

- (void)getUserInfoResponse:(APIResponse*) response {
    JMLog(@"%@",response.jsonResponse);
}

-(void)getVipInfoResponse:(APIResponse *)response {
    JMLog(@"%@",response.jsonResponse);
}

-(void)tencentDidLogout {
    
}

-(void)tencentDidNotLogin:(BOOL)cancelled {
    
}

-(void)tencentDidNotNetWork {
    
}

#pragma mark - 腾讯微博API回调

- (void)DidAuthFinished:(WeiboApiObject *)wbobj {
    /*http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns*/
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyy.MMMM.dd GGG hh:mm aaa" options:0 locale:[NSLocale currentLocale]]];
    NSString *expiresString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:wbobj.expires]];
    NSString *msg =[NSString stringWithFormat:@"openid, %@, accessToken, %@, expiresString,%@", wbobj.openid, wbobj.accessToken, expiresString];
    JMLog(msg);
    
    showAlertMessage(msg);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.tencentWbApi cancelAuth];
    });
    
}

- (void)DidAuthCanceled:(WeiboApiObject *)wbobj {
    
}

- (void)DidAuthFailWithError:(NSError *)error {
    NSString *str = [[NSString alloc] initWithFormat:@"get token error, errcode = %@",error.userInfo];
    JMLog(@"%@", str);
}



- (void)didCheckAuthValid:(BOOL)bResult suggest:(NSString*)strSuggestion {
    
}

- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno {
    
}

- (void)didFailWithError:(NSError *)error reqNo:(int)reqno {
    showAlertError(error);
}

- (void)didNeedRelogin:(NSError *)error reqNo:(int)reqno {
    showAlertError(error);
}

#pragma mark - 腾讯互联API分享parse

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQZONENOTSUPPORTTEXT:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"空间分享不支持纯文本分享，请使用图文分享" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQZONENOTSUPPORTIMAGE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"空间分享不支持纯图片分享，请使用图文分享" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - 平台分享
-(void)shareQQ {
    /*[self.tencentOAuth sendStory:[@{} mutableCopy] friendList:nil];*/
    //    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:@"13213241"];
    //    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    //
    NSString *utf8String = @"http://www.163.com";
    NSString *title = @"新闻标题";
    NSString *description = @"新闻描述";
    NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    
    
    QQApiSendResultCode  sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

-(void)shareQQZone {
    /*[self.tencentOAuth sendStory:[@{} mutableCopy] friendList:nil];*/
    //    UIImage *img =[UIImage imageNamed:@"close.png"];
    //    NSData *imgData =  UIImageJPEGRepresentation(img, 1);
    //
    //    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imgData previewImageData:imgData title:@"分享" description:@"asdfasdfa"];
    //
    //    /*QQApiTextObject *txtObj = [QQApiTextObject objectWithText:@"13213241"];*/
    //    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    
    
    NSString *utf8String = @"http://www.163.com";
    NSString *title = @"新闻标题";
    NSString *description = @"新闻描述";
    NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode  sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
    
}

-(void)shareTencentWeibo {
    UIImage *pic = [UIImage imageNamed:@"close.png"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"hi,weibo sdk", @"content",
                                   pic, @"pic",
                                   nil];
    [self.tencentWbApi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text =@"测试通过WeiboSDK发送文字到微博!";
    
    /*if (self.textSwitch.on)
     {
     message.text = @"测试通过WeiboSDK发送文字到微博!";
     }
     
     if (self.imageSwitch.on)
     {
     WBImageObject *image = [WBImageObject object];
     image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
     message.imageObject = image;
     }
     
     if (self.mediaSwitch.on)
     {
     WBWebpageObject *webpage = [WBWebpageObject object];
     webpage.objectID = @"identifier1";
     webpage.title = @"分享网页标题";
     webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
     webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
     webpage.webpageUrl = @"http://sina.cn?a=1";
     message.mediaObject = webpage;
     }*/
    
    return message;
}

-(void)shareSinaWeibo:(JRLoginViewController *)loginViewController {
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{@"ShareMessageFrom":NSStringFromClass( loginViewController.class),
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    /*request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;*/
    
    [WeiboSDK sendRequest:request];
}
@end
