//
//  ShopDetailViewController.h
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "ShopModel.h"
#import "CellShopDetail.h"
#import "UMSocial.h"
#import "FGalleryViewController.h"

@interface ShopDetailViewController : ZNBaseViewController<UITableViewDelegate,UITableViewDataSource,FGalleryViewControllerDelegate
//,UMSocialDataDelegate
>
@property(nonatomic,strong)ShopModel *shopModel;
@property(nonatomic,strong)NSString *shopId;
@end
