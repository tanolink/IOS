//
//  ShopListViewController.h
//  商铺列表
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "CityListModel.h"
#import "CTBView.h"
#import "CTCBar.h"
#import "CityListViewController.h"
#import "ZNBaseNavigationController.h"
@interface ShopListViewController : ZNBaseViewController<UITableViewDataSource,UITableViewDelegate,CTBViewDelegate>{
    CTCBar *headerView;
}
@property (nonatomic,strong) CityModel *cityModel;
@property (strong, nonatomic) CTBView *chocieViewSort;
@property (strong, nonatomic) CTBView *chocieViewType;
@property (strong, nonatomic) NSMutableDictionary *defaultChoiceSelSort;/*默认选择的排序*/
@property (strong, nonatomic) NSMutableDictionary *defaultChoiceSelType;/*默认选择的类型*/

@end
