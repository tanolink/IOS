//
//  ZNApi.m
//  Zouni
//
//  Created by Aokuny on 14-10-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
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
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:ZN_BASE_URL]];
//      AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:DefaultHeaderMD5 forHTTPHeaderField:@"permit"];
        [requestSerializer setTimeoutInterval:60];
        [manager setRequestSerializer:requestSerializer];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
        self.manager = manager;
    }
    return self;
}

+ (void )invokePost:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock {
    if([ZNApi sharedInstance].headerPermit){
        [[ZNApi sharedInstance].manager.requestSerializer setValue:[ZNApi sharedInstance].headerPermit forHTTPHeaderField:@"permit"];
    }else{
        [[ZNApi sharedInstance].manager.requestSerializer setValue:DefaultHeaderMD5 forHTTPHeaderField:@"permit"];
    }
    NSLog(@"===============permit===========%@",[[ZNApi sharedInstance].manager.requestSerializer valueForHTTPHeaderField:@"permit"]);

    AFHTTPRequestOperationManager *manager  = [ZNApi sharedInstance].manager;
    NSLog(@"请求接口：%@\n参数：%@",[[NSURL URLWithString:URLString relativeToURL:manager.baseURL] absoluteString], parameters);
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"返回信息:%@",responseObject);

        ZNRespModel *respBody = [[ZNRespModel alloc]initWithDictionary:responseObject error:nil];
        
//        NSLog(@"返回信息:%@",respBody);

        if (!respBody) {
            completeBlock(nil,nil,nil);
            showAlertMessage(kServiceErrStr);
            return ;
        }
        if (!respBody.success.intValue) {
            completeBlock(nil,respBody.msg,nil);
            showAlertMessage(respBody.msg);
            return;
        }
        completeBlock(respBody.data,respBody.msg,respBody);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil,nil);
        showAlertMessage(error.localizedDescription);
    }];
}

+ (void )invokePost1:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock1)completeBlock {
    if([ZNApi sharedInstance].headerPermit){
        [[ZNApi sharedInstance].manager.requestSerializer setValue:[ZNApi sharedInstance].headerPermit forHTTPHeaderField:@"permit"];
        NSLog(@"===============permit===========%@",[[ZNApi sharedInstance].manager.requestSerializer valueForHTTPHeaderField:@"permit"]);
    }
    AFHTTPRequestOperationManager *manager  = [ZNApi sharedInstance].manager;
    NSLog(@"请求接口：%@\n参数：%@",[[NSURL URLWithString:URLString relativeToURL:manager.baseURL] absoluteString], parameters);
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"返回信息:%@",responseObject);
        
        ZNRespModel1 *respBody = [[ZNRespModel1 alloc]initWithDictionary:responseObject error:nil];
        
        if (!respBody) {
            completeBlock(nil,nil,nil);
            showAlertMessage(kServiceErrStr);
            return ;
        }
        if (!respBody.success.intValue) {
            completeBlock(nil,nil,nil);
            showAlertMessage(respBody.msg);
            return;
        }
        completeBlock(respBody.Data,respBody.msg,respBody);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil,nil);
        showAlertMessage(error.localizedDescription);
    }];
}


+ (void )invokeGet:(NSString *)URLString parameters:(id)parameters completion: (ZNObjectBlock)completeBlock {
    AFHTTPRequestOperationManager *manager  = [ZNApi sharedInstance].manager;
    NSLog(@"请求接口：%@\n参数：%@",[[NSURL URLWithString:URLString relativeToURL:manager.baseURL] absoluteString], parameters);
    if (!manager.reachabilityManager.reachable) {
        NSDictionary *userInfo = @{  NSLocalizedDescriptionKey: NSLocalizedString(@"网络不给力", nil)};
        NSError *error = [NSError errorWithDomain:@"com.app" code:111 userInfo:userInfo];
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil,nil);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertMessage(error.localizedDescription);
            });
        });
        return;
    }
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completeBlock(responseObject,nil,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        completeBlock(nil,nil,nil);
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
