//
//  MemberInfo
//
//  Created by   on 15/6/7
//  Copyright (c) 2015 TanoLInk. All rights reserved.
//
#import "JSONModel.h"
#import <Foundation/Foundation.h>
@protocol MemberInfo
@end
@interface MemberInfo : JSONModel <NSCoding, NSCopying>

@property (nonatomic, strong) NSString <Optional>*mobileVerified;
@property (nonatomic, strong) NSString <Optional>*updatedAt;
@property (nonatomic, strong) NSString <Optional>*weChatToken;
@property (nonatomic, strong) NSString <Optional>*userPhotoId;
@property (nonatomic, strong) NSString <Optional>*rongCloudToken;
@property (nonatomic, strong) NSString <Optional>*mobile;
@property (nonatomic, strong) NSString <Optional>*sex;
@property (nonatomic, strong) NSString <Optional>*regFrom;
@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*password;
@property (nonatomic, strong) NSString <Optional>*token;
@property (nonatomic, strong) NSString <Optional>*emailVerified;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*objectId;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*cityId;
@property (nonatomic, strong) NSString <Optional>*email;
@property (nonatomic, strong) NSString <Optional>*createdAt;

//+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
//- (instancetype)initWithDictionary:(NSDictionary *)dict;
//- (NSDictionary *)dictionaryRepresentation;

@end
