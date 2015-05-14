//
//  JRResModel.h
//  Zouni
//
//  Created by Aokuny on 14-10-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "JSONModel.h"

@interface ZNRespModel : JSONModel
@property (nonatomic,strong) NSString *success;
@property (nonatomic,strong) NSString <Optional>*msg;
@property (nonatomic,strong) NSDictionary <Optional>*data;
@end
