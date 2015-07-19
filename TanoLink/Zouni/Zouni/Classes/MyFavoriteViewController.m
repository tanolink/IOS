//
//  MyFavoriteViewController.m
//  我的收藏列表
//
//  Created by aokuny on 15/5/24.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "MyFavoriteViewController.h"
//#import "GoogleMapViewController.h"
#import "AppleMapViewController.h"
#import "CellShopList.h"
#import "ShopModel.h"
#import "UIButton+Block.h"
#import "ShopDetailViewController.h"
#import "CouponViewController.h"

@interface MyFavoriteViewController (){
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
    
    UIButton *btnDelFav;
    /*
     * 是否为编辑
     */
    bool isEditFiv;
    /**
     * 删除的店铺ID
     */
    NSMutableArray *arrDelShopID;
}

@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self BuildUI];
    [self initData];
}
#pragma 初始化页面
-(void)BuildUI{
    [self setTitle:@"我的收藏"];
    [self setRightBarButtonItemTitle:@"编辑" target:self action:@selector(editFavorite)];
    isEditFiv  = NO;
    // 初始化表格
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setAllowsSelection:NO];
    _gTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    _pageNumber = 1;
    _pageSize = 12;
    _dataMutableArray = [[NSMutableArray alloc]init];
    arrDelShopID = [NSMutableArray new];
//    [self performSelector:@selector(loadServerData) withObject:nil afterDelay:0.0f];
    [self loadServerData];
}
#pragma 下拉加载最新数据
-(void)loadNewData{
    _pageNumber = 1;
    _pageSize = 12;
    [arrDelShopID removeAllObjects];
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
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%d",_pageSize],@"size",
                                [NSString stringWithFormat:@"%d",_pageNumber],@"page",
                                @"5",@"comments",
                                nil];
    [ZNApi invokePost:ZN_MYFAVORITELIST_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
            NSArray *dic = (NSArray *)resultObj;
            NSLog(@"%@",dic);
            [_dataMutableArray addObjectsFromArray:dic];
            [_gTableView reloadData];
            [_gTableView headerEndRefreshing];
            [_gTableView footerEndRefreshing];
            if ([_dataMutableArray count]==0) {
                _gTableView.nxEV_emptyView = [self emptyView];
            }
        }
        [weakSelf hideHud];
    }];
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
        NSString *Indentifier = [NSString stringWithFormat:@"cellInd%ld",indexPath.row];
        CellShopList *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
        NSDictionary *cityModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
        if (!cell) {
            cell = [[CellShopList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSError *err = nil;
        ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:cityModelDic error:&err];
        if(isEditFiv){
            cell.isFavorite = YES;
        }
        [cell setCellDataForModel:shopModel];
        // 事件
        [cell._btnShopDetail handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc]init];
            shopDetailVC.shopModel = shopModel;
            [self.navigationController pushViewController:shopDetailVC animated:YES];
        }];
        [cell._btnShopMap handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            AppleMapViewController *appleMapVC = [AppleMapViewController new];
            NSDictionary *dicPXY = [[NSDictionary alloc]initWithObjectsAndKeys:shopModel.PX,@"PX",shopModel.PY,@"PY",
                                    shopModel.ShopENName,@"Desc",shopModel.ShopName,@"Title",nil];
            appleMapVC.PXYList = @[dicPXY];
            appleMapVC.mainPY = shopModel.PY;
            appleMapVC.mainPX = shopModel.PY;
            [self.navigationController pushViewController:appleMapVC animated:YES];
        }];
        [cell._btnCoupon handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            if (shopModel.Coupon.intValue>0) {
                CouponViewController *couponVC = [[CouponViewController alloc]init];
                couponVC.shopModel =shopModel;
                [self.navigationController pushViewController:couponVC animated:YES];
            }else{
                [JGProgressHUD showHintStr:@"暂无优惠券信息"];
            }
        }];
        [cell.btnSel handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            int shopId = cell.btnSel.tag - 1000.0;
            if(!cell.btnSel.selected){
                [arrDelShopID addObject:[NSString stringWithFormat:@"%d",shopId]];
            }else{
                [arrDelShopID removeObject:[NSString stringWithFormat:@"%d",shopId]];
            }
            cell.btnSel.selected = ! cell.btnSel.selected;
            if (arrDelShopID.count>0) {
                [btnDelFav setTitle:[NSString stringWithFormat:@"(%u)删除",(unsigned int)arrDelShopID.count] forState:UIControlStateNormal];
            }else{
                [btnDelFav setTitle:@"删除" forState:UIControlStateNormal];
            }
//            [btnDelFav.titleLabel setText:[NSString stringWithFormat:@"(%u)删除",(unsigned int)arrDelShopID.count]];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    self.navigationItem.rightBarButtonItem = nil;
    if ([_dataMutableArray count]>0) {
        [self setRightBarButtonItemTitle:@"编辑" target:self action:@selector(editFavorite)];
        return 60;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,1)];
    lineView.backgroundColor = [UIColor grayLineColor];
    
    UIView *bgFooterView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,50)];
    [bgFooterView setBackgroundColor:[UIColor whiteColor]];
    btnDelFav = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDelFav setFrame:CGRectMake(30,10,ScreenWidth-60,44)];
    [btnDelFav setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnDelFav setTitle:@"删除" forState:UIControlStateNormal];
    [btnDelFav.titleLabel setFont:DEFAULT_BOLD_FONT(15)];
    [btnDelFav handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if(arrDelShopID.count>0){
            NSString *shopIds = [arrDelShopID componentsJoinedByString:@","];
            NSDictionary *requestDic1 = [[NSDictionary alloc]initWithObjectsAndKeys: shopIds,@"shopIds",nil];
            [ZNApi invokePost:ZN_DELFAVORITES_API parameters:requestDic1 completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
                if (respModel.success.intValue) {
                    [JGProgressHUD showSuccessStr:@"删除成功！"];
                    [self initData];
                }
            }];
        }else{
            [JGProgressHUD showErrorStr:@"请选择要删除的店铺！"];
        }
    }];
    [bgFooterView addSubview:btnDelFav];
    return bgFooterView;
}

-(void)editFavorite{
    _gTableView.tableFooterView.hidden = NO;
    isEditFiv = !isEditFiv;
    [_gTableView reloadData];
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
}

@end
