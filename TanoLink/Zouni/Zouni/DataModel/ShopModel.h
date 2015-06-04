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
//@interface <#class name#> : <#superclass#>
//
//@end
@interface ShopModel : JSONModel
@property (nonatomic, assign) NSString <Optional>*ShopID;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*Score;
@property (nonatomic, strong) NSString <Optional>*Coupon;
@property (nonatomic, strong) NSString <Optional>*ShopPhone;
@property (nonatomic, strong) NSString <Optional>*Translate;
@property (nonatomic, strong) NSString <Optional>*ShopClass;
@property (nonatomic, strong) NSString <Optional>*Address;
@property (nonatomic, strong) NSString <Optional>*PX;
@property (nonatomic, strong) NSString <Optional>*ShopName;
@property (nonatomic, strong) NSString <Optional>*ShopENName;
@property (nonatomic, strong) NSArray <Optional>*Images;
@property (nonatomic, strong) NSString <Optional>*comments;
@property (nonatomic, strong) NSString <Optional>*PY;
@property (nonatomic, strong) NSString <Optional>*FavoriteStatus;
@property (nonatomic, strong) NSString <Optional>*JSLocation;
@property (nonatomic, strong) NSString <Optional>*hours;
@property (nonatomic, strong) NSString <Optional>*website;
@property (nonatomic, strong) NSString <Optional>*distance;
@property (nonatomic, strong) NSString <Optional>*Route;
@end
