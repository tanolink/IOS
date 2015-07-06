//
//  CouponModel.h
//
//  Created by Aokuny  on 15/6/30
//  Copyright (c) 2015 TanoLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol CouponModel
@end
@interface CouponModel : JSONModel
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *couponPhoto;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, strong) NSString *address;

@end
