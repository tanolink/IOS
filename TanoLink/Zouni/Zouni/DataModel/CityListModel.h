//
//  CityListModel.h
//  Zouni
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol CityModel
@end

@interface CityModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*CityNameEN;
@property (nonatomic, strong) NSString <Optional>*ShopCount;
@property (nonatomic, strong) NSString <Optional>*CityPhoto;
@property (nonatomic, strong) NSString <Optional>*CityNameCN;
@property (nonatomic, strong) NSString <Optional>*CityId;
@end

@interface CityListModel : JSONModel
@property (nonatomic, strong) NSArray<CityModel> *cityList;
@end


