//
//  CityListViewController.m
//  Zouni 城市列表页面
//
//  Created by aokuny on 15/5/12.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CityListViewController.h"
#import "ZNApi.h"
#import "CityListModel.h"
#import "ShopListViewController.h"
#import "CellCityList.h"
#import "MainViewController.h"
#import "ZNBaseNavigationController.h"

@interface CityListViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    /**
     *  城市列表数据
     */
    NSMutableArray *_dataMutableArray;
    /**
     *  无数据显示样式
     */
    UIView *_emptyView;
}
@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self BuildUI];
    [self initData];
}
#pragma 初始化页面
-(void)BuildUI{
    [self setTitle:@"选择城市"];
    // 是否显示返回按钮
    if(self.isNeedBack){
        [self setBackBarButton];
    }
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    if([_gTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_gTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    __weak typeof(self) weakSelf = self;
    [_gTableView addHeaderWithCallback:^{
        [weakSelf loadNewData];
    }];
//    [_gTableView addFooterWithCallback:^{
////        [weakSelf loadMoreData];
//    }];
    [self.view addSubview:_gTableView];
}
#pragma 初始化数据
-(void) initData{
    _dataMutableArray = [[NSMutableArray alloc]init];
//    [self performSelector:@selector(loadServerData) withObject:nil afterDelay:0.0f];
    [self loadServerData];
}
#pragma 下拉加载最新数据
-(void)loadNewData{
    [_dataMutableArray removeAllObjects];
    [self loadServerData];
}
#pragma mark 加载远程数据
-(void) loadServerData{
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    [ZNApi invokePost:ZN_CITYLIST_API parameters:nil completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
//            NSError *err = nil;
//            NSDictionary *dicCityList = [[NSDictionary alloc]initWithObjectsAndKeys:resultObj,@"cityList", nil];
//            CityListModel *cityListModel = [[CityListModel alloc]initWithDictionary:dicCityList error:&err];
//            if (err) {
//                [self hideHud];
//                showAlertMessage(err.localizedDescription);
//                return ;
//            }
//            [_dataMutableArray addObjectsFromArray:cityListModel.cityList];
            NSArray *dic = (NSArray *)resultObj;
            NSLog(@"%@",dic);
            [_dataMutableArray addObjectsFromArray:dic];
            [_gTableView reloadData];
            [_gTableView headerEndRefreshing];
            if ([_dataMutableArray count]==0) {
                _gTableView.nxEV_emptyView = [self emptyView];
            }
        }
        [weakSelf hideHud];
    }];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataMutableArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indentifier = @"cellInd";
    CellCityList *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    NSDictionary *cityModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[CellCityList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSError *err = nil;
    CityModel *cityModel = [[CityModel alloc]initWithDictionary:cityModelDic error:&err];
    [cell setCellDataForModel:cityModel];
    return cell;
}
#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160.00f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cityModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    NSError *err = nil;
    CityModel *cityModel = [[CityModel alloc]initWithDictionary:cityModelDic error:&err];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cityModel.CityId forKey:@"CityId"];
    [userDefaults setObject:cityModel.CityNameCN forKey:@"CityNameCN"];
    [userDefaults synchronize];
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.cityModel = cityModel;
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainViewController;
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
