//
//  ZNApi.m
//  JuranClient
//
//  Created by huchu on 14-10-16.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "ZNApi.h"

@interface ZNApi () <UIAlertViewDelegate>

@end

@implementation ZNApi
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:JR_BASE_URL]];
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        [requestSerializer setTimeoutInterval:60];
        [manager setRequestSerializer:requestSerializer];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        self.manager = manager;
    }
    return self;
}

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (JRObjectBlock)completeBlock {
    
    AFHTTPRequestOperationManager *manager  = [ZNApi sharedInstance].manager;
    NSLog(@"请求接口：%@\n参数：%@",[[NSURL URLWithString:URLString relativeToURL:manager.baseURL] absoluteString], parameters);
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"后台响应包：%@",operation.responseString);
        
        ZNRespHeadModel *respHead = [[ZNRespHeadModel alloc]initWithDictionary:responseObject[@"respHead"] error:nil];
        
        if (!respHead) {
            completeBlock(nil,nil);
            showAlertMessage(kServiceErrStr);
            return ;
        }
        
        if ([respHead.respCode isEqualToString:@"TL"]) {
            completeBlock(nil,nil);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"服务提示" message:@"登录超时，请您重新登录" delegate:[ZNApi sharedInstance] cancelButtonTitle:@"取消"otherButtonTitles:@"登录", nil];
            [alert show];
            return;
        }
        
        if (![respHead.respCode isEqualToString:@"OK"]) {
            completeBlock(nil,nil);
            showAlertMessage(respHead.respDebug);
            return;
        }
        
        completeBlock(responseObject[@"respBody"],respHead);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil);
        showAlertMessage(error.localizedDescription);
    }];
}

+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (JRObjectBlock)completeBlock {
    AFHTTPRequestOperationManager *manager  = [ZNApi sharedInstance].manager;
    NSLog(@"请求接口：%@\n参数：%@",[[NSURL URLWithString:URLString relativeToURL:manager.baseURL] absoluteString], parameters);
    if (!manager.reachabilityManager.reachable) {
        NSDictionary *userInfo = @{  NSLocalizedDescriptionKey: NSLocalizedString(@"网络不给力", nil)};
        NSError *error = [NSError errorWithDomain:@"com.app" code:111 userInfo:userInfo];
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertMessage(error.localizedDescription);
            });
        });
        return;
    }
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completeBlock(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil);
        showAlertMessage(error.localizedDescription);
    }];
}
+ (BOOL)reachable
{
    NetworkStatus wifi = [[Reachability reachabilityForLocalWiFi]currentReachabilityStatus];
    //判断wifi是否可用
    NetworkStatus gprs = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus];
    //判断gprs是否可用
    if(wifi==NotReachable&&gprs==NotReachable)
    {
        return NO;
    }
    return YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil];
    }
}
@end
