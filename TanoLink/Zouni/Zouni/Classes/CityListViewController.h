//
//  CityListViewController.h
//  Zouni
//
//  Created by aokuny on 15/5/12.
//  Copyright (c) 2015年 TanoLink All rights reserved.
//

#import "ZNBaseViewController.h"

@interface CityListViewController : ZNBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) BOOL isNeedBack;
@end
