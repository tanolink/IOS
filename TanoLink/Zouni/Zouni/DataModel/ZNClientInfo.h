//
//  ZNClientInfo.h
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ImageQuality {HighDefinition =1,Common =2};

@interface ZNClientInfo : NSObject

@property (assign, nonatomic) BOOL isLogin;
@property(nonatomic, strong)NSString *guid;
@property(nonatomic, strong)NSString *token;
@property (nonatomic, assign) BOOL isReachNetwork;

+ (instancetype)sharedClinetInfo;
+ (BOOL)isLogin;
+ (NSURL *) JR_urlForStoreName:(NSString *)storeFileName;
+ (NSURL *) JR_addStoreNamed:(NSString *) storeFileName;

-(void)saveLoginGuid:(NSString *)guid token:(NSString *)tokenStr;
-(void)loadGuidAndToken;
-(void)clearGuidAndToken;
-(void) clearAllUserInfo;
/*
 * 是否根据网络智能读取图片
 */
+(NSString *) isIntelligence;
-(void) saveIntelligence:(NSString *)intelligence;
+(enum ImageQuality)getImageQualityType;
-(void) saveImageQualityType:(enum ImageQuality) ImageQuality;

@end
