//
//  CellShopList.h
//  ;
//
//  Created by aokuny on 15/5/16.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"
#import "ShopModel.h"

@interface CellShopList : UITableViewCell
//    店铺详情按钮
@property (nonatomic,strong) UIButton *_btnShopDetail;
//    地图按钮
@property (nonatomic,strong) UIButton *_btnShopMap;
//    领取优惠券按钮
@property (nonatomic,strong) UIButton *_btnCoupon;
//    是否为收藏
@property (nonatomic,assign) BOOL *isFavorite;

-(void) setCellDataForModel:(ShopModel *) shopModel;
@end
