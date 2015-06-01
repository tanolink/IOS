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
#import "MyCenterViewController.h"

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
    /**
     * 筛选工具栏高度
     */
    float _barheight;
    
    int btnSelTag;
}

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setBackBarButton];
//    [self setLeftNabBar];
    [self setRightButton];
    [self BuildUI];
    [self initData];
}
#pragma 初始化页面
-(void)BuildUI{
    // 设置左侧按钮
    [self setBackBarButton];
    
    // 中间的title选择城市
    [self setTitleContentView];
    
    // 初始化筛选导航栏
    [self initTBar];
    // 初始化表格
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setAllowsSelection:NO];
    _gTableView.tableHeaderView = headerView;
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
-(void) setBackBarButton{
    UIButton *button = [self buttonWithTitle:nil image:[UIImage imageNamed:@"default_avatar"]  highligted:[UIImage imageNamed:@"default_avatar"]  target:self action:@selector(goToMyCenter)];
    float headerSize = 30;
    CGRect rect = CGRectMake(0, 0,headerSize,headerSize);
    button.layer.cornerRadius = headerSize / 2.f;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.f;
    button.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
    button.frame = rect;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void) setTitleContentView{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *aTitle = [userDefaults objectForKey:@"CityNameCN"];

    UIButton* actionCityButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,40, 40)];
    [actionCityButton setTitle:aTitle forState:UIControlStateNormal];
    actionCityButton.tag=0;
    actionCityButton.titleLabel.font = DEFAULT_FONT(15);
    [actionCityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionCityButton addTarget:self action:@selector(goToSelectCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* classicAction = [self buttonWithTitle:nil image:[UIImage imageNamed:@"arrow_down"]  highligted:[UIImage imageNamed:@"arrow_down"]  target:self action:@selector(goToSelectCity)];
    classicAction.tag=1;
    
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,60, 40)];
    [titleView addSubview:actionCityButton];
    [titleView addSubview:classicAction];
    self.navigationItem.titleView=titleView;
    [classicAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionCityButton);
        make.left.equalTo(actionCityButton.mas_right);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
}
-(void) goToMyCenter{
    MyCenterViewController *myCenterVC = [MyCenterViewController new];
    [self.navigationController pushViewController:myCenterVC animated:YES];
}
-(void) goToSelectCity{
    CityListViewController *cityListVC = [[CityListViewController alloc]init];
    cityListVC.isNeedBack = YES;
    [self.navigationController pushViewController:cityListVC animated:YES];
}

#pragma mark - 初始化筛选栏
-(void)initTBar{
    _barheight = 40;
//    self.defaultChoiceSelType = @"";
//    self.defaultChoiceSelSort= @"";
    NSArray *ctbData = @[@[@"类型",@"tab_arrow"],@[@"排序",@"tab_arrow"]];
    headerView = [[CTCBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,_barheight) andArrData:ctbData bSpera:YES andBlock:^(NSUInteger idx) {
        if (idx == 0) {
            [self.chocieViewType showInView:self.view andDefaultSel:self.defaultChoiceSelType];
            [self.chocieViewSort closePopupWindow];
        } else if(idx == 1){
            [self.chocieViewSort showInView:self.view andDefaultSel:self.defaultChoiceSelSort];
            [self.chocieViewType closePopupWindow];
        }
    }];
}

-(CTBView*)chocieViewType {
    if (!_chocieViewType) {
        _chocieViewType =  [[CTBView alloc]initWithArrData:@[
//                                                         CELLDICTIONARYBUILT(@"全部", @"0"),
                                                         CELLDICTIONARYBUILT(@"综合百货", @"1"),
                                                         CELLDICTIONARYBUILT(@"服饰", @"2"),
                                                         CELLDICTIONARYBUILT(@"鞋帽", @"3"),
                                                         CELLDICTIONARYBUILT(@"箱包", @"4"),
//                                                         CELLDICTIONARYBUILT(@"家用电器", @"5"),
//                                                         CELLDICTIONARYBUILT(@"化妆品", @"6"),
                                                         CELLDICTIONARYBUILT(@"其他", @"7"),
                                                        ]
                                            andOffSetY:_barheight delegate:self];
    }
    return _chocieViewType;
}
-(CTBView*)chocieViewSort {
    if (!_chocieViewSort) {
        _chocieViewSort =  [[CTBView alloc]initWithArrData:@[CELLDICTIONARYBUILT(@"默认排序", @"5"),
                                                         CELLDICTIONARYBUILT(@"按距离从近到远", @"1"),
                                                         CELLDICTIONARYBUILT(@"按评分从高到低", @"2"),
                                                         CELLDICTIONARYBUILT(@"按评分从低到高", @"4"),
                                                         ]
                                            andOffSetY:_barheight delegate:self];
    }
    return _chocieViewSort;
}

-(void)ctbChocie:(NSMutableDictionary *)valueStr withCTB:(UIView *)ctb{
    if(ctb == self.chocieViewSort){
        self.defaultChoiceSelSort = valueStr;
    }else{
        self.defaultChoiceSelType = valueStr;
    }
    // 重新加载排序后的数据
//    [self loadNewData];
//    [_gTableView reloadData];
}

#pragma 初始化数据
-(void) initData{
    _pageNumber = 0;
    _pageSize = 12;
    _dataMutableArray = [[NSMutableArray alloc]init];
//    [self performSelector:@selector(loadServerData) withObject:nil afterDelay:0.0f];
    [self loadServerData];
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
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                                [NSString stringWithFormat:@"%d",_pageSize],@"size",
                                @"20",@"size",
                                @"1",@"page",
                                @"4",@"cityId",
//                                @"",@"px",@"",@"py",
//                                @"0",@"comments",
                                @"500",@"distance",
//                                @"1",@"shopClass",
                                @"5",@"sort",
                                nil];
    [ZNApi invokePost:ZN_SHOPLIST_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
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

//    // 模拟返回数据
//    ShopModel *shopM1 = [ShopModel new];
//    shopM1.shopID = @"123";
//    shopM1.shopName = @"银座 Ginza";
//    shopM1.shopClass = @"综合 服饰";
//    shopM1.shopPhone = @"13855559999";
//    shopM1.coupon = @"1";
//    shopM1.comments = @"";
//    shopM1.desc = @"是日本东京中央区的一个主要商业区，以高级购物商店闻名。其是东京的一个代表性地区，是日本现代景点的代表，也是世界三大名街之一。17 世纪初叶这里开设，在新桥与京桥两桥间，以高级购物商店闻名，是东京其中一个代表性地区，同时也是日本有代表性的最大最繁华的商业街区。";
//    shopM1.score = @"3.5";
//    shopM1.address = @"日本东京中央区";
//    shopM1.pX = @"39";
//    shopM1.pY = @"116";
//    shopM1.image = @"http://182.92.108.45/upload/2015/3/20/16/201504201630081429518608271.jpg";
//    
//    ShopModel *shopM2 = [shopM1 copy];
//    shopM2.score = @"5";
//    [_dataMutableArray addObjectsFromArray:@[shopM1,shopM2]];
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
    NSDictionary *shopModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    NSError *err = nil;
    ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:shopModelDic error:&err];
    [cell setCellDataForModel:shopModel];
    // 事件
    [cell._btnShopDetail handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc]init];
        shopDetailVC.shopModel = shopModel;
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }];
    [cell._btnShopMap handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        GoogleMapViewController *gmapVC = [[GoogleMapViewController alloc]init];
        NSDictionary *dicPXY = [[NSDictionary alloc]initWithObjectsAndKeys:shopModel.PX,@"PX",shopModel.PY,@"PY",
                             shopModel.ShopENName,@"Desc",shopModel.ShopName,@"Title",
                             nil];
        gmapVC.PXYList = @[dicPXY];
        gmapVC.mainPY = shopModel.PY;
        gmapVC.mainPX = shopModel.PY;
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
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.chocieViewSort closePopupWindow];
    [self.chocieViewType closePopupWindow];
    [self hideHud];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setRightButton{
    [self setRightBarButtonItemImage:@"allMap" target:self action:@selector(pushToGoogleMap)];
}

-(void) pushToGoogleMap{
    GoogleMapViewController *gooleMapVC = [[GoogleMapViewController alloc]init];
    
    NSDictionary *dicPXY = [[NSDictionary alloc]initWithObjectsAndKeys:@"35.66",@"PX",@"139.73",@"PY",
                            @"Donkihotei ropponki",@"Desc",@"Donkihotei",@"Title",nil];
    NSDictionary *dicPXY1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"35.71",@"PX",@"139.77",@"PY",
                             @"Donkihotei ueno",@"Desc",@"Donkihotei",@"Title",nil];
    NSDictionary *dicPXY2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"35.67",@"PX",@"139.77",@"PY",
                            @"Matsuya Ginza",@"Desc",@"Matsuya",@"Title",nil];
    NSDictionary *dicPXY3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"35.66",@"PX",@"139.7",@"PY",
                             @"Donkihotei sibuya",@"Desc",@"Donkihotei",@"Title",nil];
    gooleMapVC.PXYList = @[dicPXY,dicPXY1,dicPXY2,dicPXY3];
    
    [self.navigationController pushViewController:gooleMapVC animated:YES];
}

@end
