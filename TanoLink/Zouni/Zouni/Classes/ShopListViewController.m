//
//  ShopListViewController.m
//  店铺列表
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopListViewController.h"
#import "GoogleMapViewController.h"
#import "CellShopList.h"
#import "ShopModel.h"
#import "UIButton+Block.h"
#import "ShopDetailViewController.h"
#import "CouponViewController.h"
@interface ShopListViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    /**
     *  城市列表数据
     */
    NSMutableArray *_dataMutableArray;
    /**
     *  分页大小
     */
    int _pageSize;
    /**
     *  当前页数
     */
    int _pageNumber;
    /**
     *  无数据显示样式
     */
    UIView *_emptyView;
}

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
//    [self setTitle:self.cityModel.CityNameCN];
//    [self setRightBarButtonItemTitle:@"地图" target:self action:@selector(pushToGoogleMap)];
    [self BuildUI];
    [self initData];
}
#pragma 初始化页面
-(void)BuildUI{
    [self setTitle:@"选择城市"];
    // 是否显示返回按钮
    if(YES){
        [self setBackBarButton];
    }
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setAllowsSelection:NO];
    if([_gTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_gTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    __weak typeof(self) weakSelf = self;
    [_gTableView addHeaderWithCallback:^{
        [weakSelf loadNewData];
    }];
    [_gTableView addFooterWithCallback:^{
        [weakSelf loadMoreData];
    }];
    [self.view addSubview:_gTableView];
}
#pragma 初始化数据
-(void) initData{
    _pageNumber = 0;
    _pageSize = 12;
    _dataMutableArray = [[NSMutableArray alloc]init];
    [self performSelector:@selector(loadServerData) withObject:nil afterDelay:0.0f];
}
#pragma 下拉加载最新数据
-(void)loadNewData{
    [_dataMutableArray removeAllObjects];
    [self loadServerData];
}
#pragma mark 上拉加载更多数据
-(void)loadMoreData{
    ++_pageNumber;
    [self loadServerData];
}

#pragma mark 加载远程数据
-(void) loadServerData{
//    [self showHudInView:self.view hint:nil];
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                                [NSString stringWithFormat:@"%d",_pageSize],@"size",
//                                [NSString stringWithFormat:@"%d",_pageNumber],@"page",
//                                @"4",@"CityId",
//                                @"",@"px",@"",@"py",@"0",@"comments",
//                                @"500",@"distance",@"1",@"shopClass",@"5",@"sort",nil];
//    [ZNApi invokePost:ZN_SHOPLIST_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
//        if (resultObj) {
//            NSArray *dic = (NSArray *)resultObj;
//            NSLog(@"%@",dic);
//            [_dataMutableArray addObjectsFromArray:dic];
//            [_gTableView reloadData];
//            [_gTableView headerEndRefreshing];
//            [_gTableView footerEndRefreshing];
//            if ([_dataMutableArray count]==0) {
//                _gTableView.nxEV_emptyView = [self emptyView];
//            }
//        }
//        [weakSelf hideHud];
//    }];

    // 模拟返回数据
    ShopModel *shopM1 = [ShopModel new];
    shopM1.shopID = @"100";
    shopM1.shopName = @"银座 Ginza";
    shopM1.shopClass = @"综合 服饰";
    shopM1.shopPhone = @"13855559999";
    shopM1.coupon = @"1";
    shopM1.comments = @"";
    shopM1.desc = @"是日本东京中央区的一个主要商业区，以高级购物商店闻名。其是东京的一个代表性地区，是日本现代景点的代表，也是世界三大名街之一。17 世纪初叶这里开设，在新桥与京桥两桥间，以高级购物商店闻名，是东京其中一个代表性地区，同时也是日本有代表性的最大最繁华的商业街区。";
    shopM1.score = @"3.5";
    shopM1.address = @"日本东京中央区";
    shopM1.pX = @"39";
    shopM1.pY = @"116";
    shopM1.image = @"http://182.92.108.45/upload/2015/3/20/16/201504201630081429518608271.jpg";
    
    ShopModel *shopM2 = [shopM1 copy];
    
    [_dataMutableArray addObjectsFromArray:@[shopM1,shopM2]];
    [_gTableView reloadData];
    [_gTableView headerEndRefreshing];
    [_gTableView footerEndRefreshing];

}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataMutableArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *Indentifier = @"cellInd";
//    CellShopList *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
//    NSDictionary *cityModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
//    if (!cell) {
//        cell = [[CellShopList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
//    }
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    NSError *err = nil;
//    ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:cityModelDic error:&err];
//    [cell setCellDataForModel:shopModel];
//    return cell;
    
    static NSString *Indentifier = @"cellInd";
    CellShopList *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[CellShopList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    [cell setCellDataForModel:[_dataMutableArray objectAtIndex:indexPath.row]];
    
    // 事件
    [cell._btnShopDetail handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc]init];
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }];
    [cell._btnShopMap handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        GoogleMapViewController *gmapVC = [[GoogleMapViewController alloc]init];
        [self.navigationController pushViewController:gmapVC animated:YES];
    }];
    [cell._btnCoupon handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        CouponViewController *couponVC = [[CouponViewController alloc]init];
        [self.navigationController pushViewController:couponVC animated:YES];
    }];
    return cell;
}
#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 972/3-20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *cityModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
//    NSError *err = nil;
//    CityModel *cityModel = [[CityModel alloc]initWithDictionary:cityModelDic error:&err];
}

-(UIView *)emptyView{
    if (!_emptyView) {
        //        CustomEmptyView *emptyView = [[CustomEmptyView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-200)/2.f- 30,gTableView.frame.size.width, 200)];
        //        emptyView.textStr = [[NSAttributedString alloc]initWithString:@"暂无消息" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:DEFAULT_FONT(18)}];
        //        //emptyView.imageStr = @"emptyrequest";
        //        _emptyView = emptyView;
    }
    return _emptyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) pushToGoogleMap{
    GoogleMapViewController *gooleMapVC = [[GoogleMapViewController alloc]init];
    [self.navigationController pushViewController:gooleMapVC animated:YES];
}

@end
