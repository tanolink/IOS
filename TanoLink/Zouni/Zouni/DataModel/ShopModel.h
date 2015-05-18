//
//  ShopModel.h
//  Zouni
//
//  Created by aokuny on 15/5/16.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "JSONModel.h"
@protocol ShopModel
@end
@interface ShopModel : JSONModel
@property (nonatomic, assign) NSString <Optional>*shopID;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*score;
@property (nonatomic, strong) NSString <Optional>*coupon;
@property (nonatomic, strong) NSString <Optional>*shopPhone;
@property (nonatomic, strong) NSString <Optional>*translate;
@property (nonatomic, strong) NSString <Optional>*shopClass;
@property (nonatomic, strong) NSString <Optional>*address;
@property (nonatomic, strong) NSString <Optional>*pX;
@property (nonatomic, strong) NSString <Optional>*shopName;
@property (nonatomic, strong) NSString <Optional>*image;
@property (nonatomic, strong) NSString <Optional>*comments;
@property (nonatomic, strong) NSString <Optional>*pY;

@end
