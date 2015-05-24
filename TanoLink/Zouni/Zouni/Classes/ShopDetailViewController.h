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
@interface ShopDetailViewController : ZNBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ShopModel *shopModel;
@end
