//
//  MemberInfo
//
//  Created by   on 15/6/7
//  Copyright (c) 2015 TanoLink. All rights reserved.
//

#import "MemberInfo.h"


NSString *const kuserMobileVerified = @"mobileVerified";
NSString *const kuserUpdatedAt = @"updatedAt";
NSString *const kuserWeChatToken = @"weChatToken";
NSString *const kuserUserPhotoId = @"userPhoto";
NSString *const kuserRongCloudToken = @"rongCloudToken";
NSString *const kuserMobile = @"mobile";
NSString *const kuserSex = @"sex";
NSString *const kuserRegFrom = @"regFrom";
NSString *const kuserCode = @"code";
NSString *const kuserPassword = @"password";
NSString *const kuserToken = @"token";
NSString *const kuserEmailVerified = @"emailVerified";
NSString *const kuserUsername = @"username";
NSString *const kuserObjectId = @"objectId";
NSString *const kuserNickname = @"nickname";
NSString *const kuserCityId = @"cityId";
NSString *const kuserEmail = @"email";
NSString *const kuserCreatedAt = @"createdAt";


//@interface MemberInfo ()

//- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

//@end

@implementation MemberInfo
//@synthesize mobileVerified = _mobileVerified;
//@synthesize updatedAt = _updatedAt;
//@synthesize weChatToken = _weChatToken;
//@synthesize userPhotoId = _userPhotoId;
//@synthesize rongCloudToken = _rongCloudToken;
//@synthesize mobile = _mobile;
//@synthesize sex = _sex;
//@synthesize regFrom = _regFrom;
//@synthesize code = _code;
//@synthesize password = _password;
//@synthesize token = _token;
//@synthesize emailVerified = _emailVerified;
//@synthesize username = _username;
//@synthesize objectId = _objectId;
//@synthesize nickname = _nickname;
//@synthesize cityId = _cityId;
//@synthesize email = _email;
//@synthesize createdAt = _createdAt;


//+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDictionary:dict];
//}
/*
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mobileVerified = [self objectOrNilForKey:kuserMobileVerified fromDictionary:dict];
            self.updatedAt = [self objectOrNilForKey:kuserUpdatedAt fromDictionary:dict];
            self.weChatToken = [self objectOrNilForKey:kuserWeChatToken fromDictionary:dict];
            self.userPhotoId = [self objectOrNilForKey:kuserUserPhotoId fromDictionary:dict];
            self.rongCloudToken = [self objectOrNilForKey:kuserRongCloudToken fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kuserMobile fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kuserSex fromDictionary:dict];
            self.regFrom = [self objectOrNilForKey:kuserRegFrom fromDictionary:dict];
            self.code = [self objectOrNilForKey:kuserCode fromDictionary:dict];
            self.password = [self objectOrNilForKey:kuserPassword fromDictionary:dict];
            self.token = [self objectOrNilForKey:kuserToken fromDictionary:dict];
            self.emailVerified = [self objectOrNilForKey:kuserEmailVerified fromDictionary:dict];
            self.username = [self objectOrNilForKey:kuserUsername fromDictionary:dict];
            self.objectId = [self objectOrNilForKey:kuserObjectId fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:kuserNickname fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:kuserCityId fromDictionary:dict];
            self.email = [self objectOrNilForKey:kuserEmail fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kuserCreatedAt fromDictionary:dict];

    }
    return self;
}
*/
//- (NSDictionary *)dictionaryRepresentation
//{
//    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
//    [mutableDict setValue:self.mobileVerified forKey:kuserMobileVerified];
//    [mutableDict setValue:self.updatedAt forKey:kuserUpdatedAt];
//    [mutableDict setValue:self.weChatToken forKey:kuserWeChatToken];
//    [mutableDict setValue:self.userPhotoId forKey:kuserUserPhotoId];
//    [mutableDict setValue:self.rongCloudToken forKey:kuserRongCloudToken];
//    [mutableDict setValue:self.mobile forKey:kuserMobile];
//    [mutableDict setValue:self.sex forKey:kuserSex];
//    [mutableDict setValue:self.regFrom forKey:kuserRegFrom];
//    [mutableDict setValue:self.code forKey:kuserCode];
//    [mutableDict setValue:self.password forKey:kuserPassword];
//    [mutableDict setValue:self.token forKey:kuserToken];
//    [mutableDict setValue:self.emailVerified forKey:kuserEmailVerified];
//    [mutableDict setValue:self.username forKey:kuserUsername];
//    [mutableDict setValue:self.objectId forKey:kuserObjectId];
//    [mutableDict setValue:self.nickname forKey:kuserNickname];
//    [mutableDict setValue:self.cityId forKey:kuserCityId];
//    [mutableDict setValue:self.email forKey:kuserEmail];
//    [mutableDict setValue:self.createdAt forKey:kuserCreatedAt];
//
//    return [NSDictionary dictionaryWithDictionary:mutableDict];
//}
//
//- (NSString *)description 
//{
//    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
//}
//
//#pragma mark - Helper Method
//- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
//{
//    id object = [dict objectForKey:aKey];
//    return [object isEqual:[NSNull null]] ? nil : object;
//}
//

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.mobileVerified = [aDecoder decodeObjectForKey:kuserMobileVerified];
    self.updatedAt = [aDecoder decodeObjectForKey:kuserUpdatedAt];
    self.weChatToken = [aDecoder decodeObjectForKey:kuserWeChatToken];
    self.userPhoto = [aDecoder decodeObjectForKey:kuserUserPhotoId];
    self.rongCloudToken = [aDecoder decodeObjectForKey:kuserRongCloudToken];
    self.mobile = [aDecoder decodeObjectForKey:kuserMobile];
    self.sex = [aDecoder decodeObjectForKey:kuserSex];
    self.regFrom = [aDecoder decodeObjectForKey:kuserRegFrom];
    self.code = [aDecoder decodeObjectForKey:kuserCode];
    self.password = [aDecoder decodeObjectForKey:kuserPassword];
    self.token = [aDecoder decodeObjectForKey:kuserToken];
    self.emailVerified = [aDecoder decodeObjectForKey:kuserEmailVerified];
    self.username = [aDecoder decodeObjectForKey:kuserUsername];
    self.objectId = [aDecoder decodeObjectForKey:kuserObjectId];
    self.nickname = [aDecoder decodeObjectForKey:kuserNickname];
    self.cityId = [aDecoder decodeObjectForKey:kuserCityId];
    self.email = [aDecoder decodeObjectForKey:kuserEmail];
    self.createdAt = [aDecoder decodeObjectForKey:kuserCreatedAt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobileVerified forKey:kuserMobileVerified];
    [aCoder encodeObject:_updatedAt forKey:kuserUpdatedAt];
    [aCoder encodeObject:_weChatToken forKey:kuserWeChatToken];
    [aCoder encodeObject:_userPhoto forKey:kuserUserPhotoId];
    [aCoder encodeObject:_rongCloudToken forKey:kuserRongCloudToken];
    [aCoder encodeObject:_mobile forKey:kuserMobile];
    [aCoder encodeObject:_sex forKey:kuserSex];
    [aCoder encodeObject:_regFrom forKey:kuserRegFrom];
    [aCoder encodeObject:_code forKey:kuserCode];
    [aCoder encodeObject:_password forKey:kuserPassword];
    [aCoder encodeObject:_token forKey:kuserToken];
    [aCoder encodeObject:_emailVerified forKey:kuserEmailVerified];
    [aCoder encodeObject:_username forKey:kuserUsername];
    [aCoder encodeObject:_objectId forKey:kuserObjectId];
    [aCoder encodeObject:_nickname forKey:kuserNickname];
    [aCoder encodeObject:_cityId forKey:kuserCityId];
    [aCoder encodeObject:_email forKey:kuserEmail];
    [aCoder encodeObject:_createdAt forKey:kuserCreatedAt];
}
//
//- (id)copyWithZone:(NSZone *)zone
//{
//    MemberInfo *copy = [[MemberInfo alloc] init];
//    if (copy) {
//        copy.mobileVerified = [self.mobileVerified copyWithZone:zone];
//        copy.updatedAt = [self.updatedAt copyWithZone:zone];
//        copy.weChatToken = [self.weChatToken copyWithZone:zone];
//        copy.userPhotoId = [self.userPhotoId copyWithZone:zone];
//        copy.rongCloudToken = [self.rongCloudToken copyWithZone:zone];
//        copy.mobile = [self.mobile copyWithZone:zone];
//        copy.sex = [self.sex copyWithZone:zone];
//        copy.regFrom = [self.regFrom copyWithZone:zone];
//        copy.code = [self.code copyWithZone:zone];
//        copy.password = [self.password copyWithZone:zone];
//        copy.token = [self.token copyWithZone:zone];
//        copy.emailVerified = [self.emailVerified copyWithZone:zone];
//        copy.username = [self.username copyWithZone:zone];
//        copy.objectId = [self.objectId copyWithZone:zone];
//        copy.nickname = [self.nickname copyWithZone:zone];
//        copy.cityId = [self.cityId copyWithZone:zone];
//        copy.email = [self.email copyWithZone:zone];
//        copy.createdAt = [self.createdAt copyWithZone:zone];
//    }
//    return copy;
//}
@end
