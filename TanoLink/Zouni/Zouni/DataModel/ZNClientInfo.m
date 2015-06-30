//
//  ZNClientInfo.m
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "ZNClientInfo.h"
#import "ZNAppUtil.h"

@implementation ZNClientInfo
+ (instancetype)sharedClinetInfo
{
    static ZNClientInfo* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+(BOOL)isLogin {
    if ([ZNClientInfo sharedClinetInfo].memberInfo) {
        return YES;
    }
    return NO;
}

+ (NSString *) JR_directory:(int) type
{
    return [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES) lastObject];
}
+ (NSString *)JR_applicationDocumentsDirectory
{
	return [self JR_directory:NSDocumentDirectory];
}

+ (NSString *)ZN_applicationStorageDirectory
{
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    return [[self JR_directory:NSApplicationSupportDirectory] stringByAppendingPathComponent:applicationName];
}

+ (NSURL *) ZN_urlForStoreName:(NSString *)storeFileName
{
	NSArray *paths = [NSArray arrayWithObjects:[self JR_applicationDocumentsDirectory], [self ZN_applicationStorageDirectory], nil];
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    for (NSString *path in paths)
    {
        NSString *filepath = [path stringByAppendingPathComponent:storeFileName];
        if ([fm fileExistsAtPath:filepath])
        {
            return [NSURL fileURLWithPath:filepath];
        }
    }
    //set default url
    return [NSURL fileURLWithPath:[[self ZN_applicationStorageDirectory] stringByAppendingPathComponent:storeFileName]];
}

+ (void) ZN_createPathToStoreFileIfNeccessary:(NSURL *)urlForStore
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *pathToStore = [urlForStore URLByDeletingLastPathComponent];
    
    NSError *error = nil;
    BOOL pathWasCreated = [fileManager createDirectoryAtPath:[pathToStore path] withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (!pathWasCreated)
    {
    }
}

+ (NSURL *) ZN_addStoreNamed:(NSString *) storeFileName
{
    NSURL *url = [ZNClientInfo ZN_urlForStoreName:storeFileName];
    [ZNClientInfo ZN_createPathToStoreFileIfNeccessary:url];
    return url;
}

-(id)init {
    self = [super init];
    if (self) {
        [self loadMemberInfo];
    }
    return self;
}
/*保存用户信息*/
-(void)saveMemberInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.memberInfo];
    [userDefaults setObject:data forKey:@"MemberInfo"];
    [userDefaults synchronize];
    [self loadMemberInfo];
}
/*保存用户信息*/
-(void)saveMemberInfo:(MemberInfo *) memberInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:memberInfo];
    [userDefaults setObject:data forKey:@"MemberInfo"];
    [userDefaults synchronize];
    [self loadMemberInfo];
}
/*加载用户信息*/
-(void) loadMemberInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"MemberInfo"];
    MemberInfo *memberInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.memberInfo = memberInfo;
}

/**
 *  用户退出登录，清除所有用户信息。
 */
-(void) clearAllUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"MemberInfo"];
    [userDefaults removeObjectForKey:@"permit"];
    [userDefaults removeObjectForKey:@"loginState"];
    [userDefaults removeObjectForKey:@"CityId"];
    [userDefaults removeObjectForKey:@"CityNameCN"];
    [userDefaults synchronize];
    self.memberInfo = nil;
    self.permit = nil;
}

-(void) savePermit:(NSString *)permit{
    ZNApi.sharedInstance.headerPermit = permit;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:permit forKey:@"permit"];
    [userDefaults synchronize];
}
-(void) loadPermit{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.permit = [userDefaults objectForKey:@"permit"];
    if(self.permit){
        ZNApi.sharedInstance.headerPermit = self.permit;
    }
}
@end
