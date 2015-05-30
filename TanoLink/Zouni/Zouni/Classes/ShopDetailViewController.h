//
//  ShopDetailViewController.h
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "ShopModel.h"
#import "CellShopDetail.h"
#import "UMSocial.h"
@interface ShopDetailViewController : ZNBaseViewController<UITableViewDelegate,UITableViewDataSource,UMSocialDataDelegate>
@property(nonatomic,strong)ShopModel *shopModel;
@end
