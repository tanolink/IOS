//
//  ShopListViewController.h
//  商铺列表
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "CityListModel.h"

@interface ShopListViewController : ZNBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) CityModel *cityModel;
@end
