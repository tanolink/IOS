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
@property (nonatomic, strong) NSString <Optional>*cityNameEN;
@property (nonatomic, strong) NSString <Optional>*shopCount;
@property (nonatomic, strong) NSString <Optional>*cityPhoto;
@property (nonatomic, strong) NSString <Optional>*cityNameCN;
@property (nonatomic, strong) NSString <Optional>*cityId;
@end

@interface CityListModel : JSONModel
@property (nonatomic, strong) NSArray<CityModel> *cityList;
@end


