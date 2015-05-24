//
//  CellShopDetail.h
//  Zouni
//
//  Created by aokuny on 15/5/23.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"
#import "UIButton+WebCache.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ShopModel.h"

@interface CellShopDetail : UITableViewCell
@property(nonatomic,strong)ShopModel *shopModel;
@end
