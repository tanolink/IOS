//
//  CouponViewController.h
//  优惠券
//
//  Created by aokuny on 15/5/18.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "ShopModel.h"
#import "UMSocial.h"

@interface CouponViewController : ZNBaseViewController<UMSocialUIDelegate>
@property (nonatomic,strong) ShopModel *shopModel;
@end
