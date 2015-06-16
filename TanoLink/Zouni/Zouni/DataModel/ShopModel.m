//
//  ShopModel.m
//  Zouni
//
//  Created by aokuny on 15/5/16.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
+(JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"Description":@"desc"}];
}
@end
