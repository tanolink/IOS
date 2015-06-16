//
//  ZNClientInfo.h
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberInfo.h"
@interface ZNClientInfo : NSObject

@property (assign, nonatomic) BOOL isLogin;
@property (nonatomic, assign) BOOL isReachNetwork;
@property (nonatomic, strong) MemberInfo *memberInfo;
@property (nonatomic, strong) NSString *permit;

+ (instancetype)sharedClinetInfo;
+ (BOOL)isLogin;
+ (NSURL *) ZN_urlForStoreName:(NSString *)storeFileName;
+ (NSURL *) ZN_addStoreNamed:(NSString *) storeFileName;

-(void) loadMemberInfo;
-(void) saveMemberInfo:(MemberInfo *) memberInfo;
-(void) loadPermit;
-(void) savePermit:(NSString *)permit;
-(void) clearAllUserInfo;

@end
