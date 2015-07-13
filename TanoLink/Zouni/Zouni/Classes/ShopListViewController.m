//
//  ShopListViewController.m
//  店铺列表
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopListViewController.h"
//#import "GoogleMapViewController.h"
#import "AppleMapViewController.h"
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置左侧按钮
    [self setBackBarButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightButton];
    [self BuildUI];
    [self initData];
}
#pragma 初始化页面
-(void)BuildUI{
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
    
    UIButton *button = [self buttonWithTitle:nil image:[UIImage imageNamed:@"default_avatar"]  highligted:nil  target:self action:@selector(goToMyCenter)];
    if([ZNClientInfo sharedClinetInfo].memberInfo.userPhoto){
        NSURL *caseurl = [NSURL URLWithString: [ZNClientInfo sharedClinetInfo].memberInfo.userPhoto];
        [button sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                           placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    }
    
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

//    UIButton* actionCityButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,40, 40)];
    UIButton* actionCityButton = [[UIButton alloc]initWithFrame:CGRectZero];

    [actionCityButton setTitle:aTitle forState:UIControlStateNormal];
    actionCityButton.tag=0;
    actionCityButton.titleLabel.font = DEFAULT_FONT(15);
    [actionCityButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    actionCityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [actionCityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [actionCityButton addTarget:self action:@selector(goToSelectCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* classicAction = [self buttonWithTitle:nil image:[UIImage imageNamed:@"arrow_down"]  highligted:[UIImage imageNamed:@"arrow_down"]  target:self action:@selector(goToSelectCity)];
    classicAction.tag=1;
    
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,200, 40)];
    [titleView addSubview:actionCityButton];
    [titleView addSubview:classicAction];
    self.navigationItem.titleView=titleView;
    [actionCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView);
        make.centerX.equalTo(titleView).offset(-15);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    [classicAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionCityButton);
        make.left.equalTo(actionCityButton.mas_right).offset(4);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    // test color
//    [actionCityButton setBackgroundColor:[UIColor orangeColor]];
//    [classicAction setBackgroundColor:[UIColor greenColor]];
//    [titleView setBackgroundColor:[UIColor redColor]];
    
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
        if (idx == 1000) {
            [self.chocieViewType showInView:self.view andDefaultSel:self.defaultChoiceSelType];
            _chocieViewType.isSingle = YES;
            [self.chocieViewSort closePopupWindowNotBack];
        } else if(idx == 1001){
            [self.chocieViewSort showInView:self.view andDefaultSel:self.defaultChoiceSelSort];
            _chocieViewType.isSingle = NO;
            [self.chocieViewType closePopupWindowNotBack];
        }
    }];
}

-(CTBView*)chocieViewType {
    if (!_chocieViewType) {
        _chocieViewType =  [[CTBView alloc]initWithArrData:@[
//                                                         CELLDICTIONARYBUILT(@"全部", @"0"),
                                                         CELLDICTIONARYBUILT(@"综合百货", @"15"),
                                                         CELLDICTIONARYBUILT(@"服饰", @"16"),
                                                         CELLDICTIONARYBUILT(@"鞋帽", @"17"),
                                                         CELLDICTIONARYBUILT(@"箱包", @"18"),
//                                                         CELLDICTIONARYBUILT(@"家用电器", @"5"),
//                                                         CELLDICTIONARYBUILT(@"化妆品", @"6"),
                                                         CELLDICTIONARYBUILT(@"其他", @"19"),
                                                        ]
                                            andOffSetY:_barheight delegate:self];
    }
    return _chocieViewType;
}
-(CTBView*)chocieViewSort {
    if (!_chocieViewSort) {
        _chocieViewSort =  [[CTBView alloc]initWithArrData:@[CELLDICTIONARYBUILT(@"默认排序", @"0"),
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
    
    UIButton *btn1 = (UIButton *)[headerView viewWithTag:1001];
    btn1.selected = NO;
    UIButton *btn0 = (UIButton *)[headerView viewWithTag:1000];
    btn0.selected = NO;
    // 重新加载排序后的数据
    [self loadNewData];
    [_gTableView reloadData];
}

#pragma 初始化数据
-(void) initData{
    _pageNumber = 1;
    _pageSize = 12;
    _dataMutableArray = [[NSMutableArray alloc]init];
//    [self performSelector:@selector(loadServerData) withObject:nil afterDelay:0.0f];
    [self loadServerData];
}
#pragma 下拉加载最新数据
-(void)loadNewData{
    [_dataMutableArray removeAllObjects];
    _pageNumber = 1;
    _pageSize = 12;
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
    NSString *cityID = self.cityModel.CityId;
    if (!(cityID.length>0)) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        cityID = [userDefaults stringForKey:@"CityId"];
    }
    NSString *sort = @"";
    if(self.defaultChoiceSelSort.count>0){
        int sortValue = 0;
        for (NSString *sel in [self.defaultChoiceSelSort allValues]) {
            if (![kNULLROWV isEqualToString:sel]) {
                sortValue += sel.integerValue;
            }
        }
        sort = [NSString stringWithFormat:@"%d",sortValue];
    }
    NSString *type = @"";
    if(self.defaultChoiceSelType.count>0){
        for (NSString *sel in [self.defaultChoiceSelType allValues]) {
            if (![kNULLROWV isEqualToString:sel]) {
                type = sel;
            }
        }
    }
    
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%d",_pageSize],@"size",
                                [NSString stringWithFormat:@"%d",_pageNumber],@"page",
                                @"500",@"distance",
                                type,@"shopClass",
                                sort,@"sort",
                                cityID,@"cityId",
//                                @"",@"px",@"",@"py",
//                                @"0",@"comments",
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
//    static NSString *Indentifier = @"cellInd";
    CellShopList *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
//    if (!cell) {
        cell = [[CellShopList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
//    }
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
//        GoogleMapViewController *gmapVC = [[GoogleMapViewController alloc]init];
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
            if ([ZNClientInfo sharedClinetInfo].permit.length>0) {
                CouponViewController *couponVC = [[CouponViewController alloc]init];
                couponVC.shopModel = shopModel;
                [self.navigationController pushViewController:couponVC animated:YES];
            }else{
                [JGProgressHUD showHintStr:@"请登录后查看优惠券信息"];
            }
        }else{
            [JGProgressHUD showHintStr:@"暂无优惠券信息"];
        }
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
    [self.chocieViewSort closePopupWindowNotBack];
    [self.chocieViewType closePopupWindowNotBack];
    [self hideHud];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setRightButton{
    [self setRightBarButtonItemImage:@"allMap" target:self action:@selector(pushToMap)];
}

-(void) pushToMap{
//    GoogleMapViewController *gooleMapVC = [[GoogleMapViewController alloc]init];
    AppleMapViewController *appleMapVC = [AppleMapViewController new];
    NSMutableArray *arrPXY = [NSMutableArray new];
    for (id o in _dataMutableArray) {
        NSDictionary *shopModelDic = (NSDictionary *)o;
        NSError *err = nil;
        ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:shopModelDic error:&err];
        NSDictionary *dicPXY = [[NSDictionary alloc]initWithObjectsAndKeys:shopModel.PX,@"PX",shopModel.PY,@"PY",
                                shopModel.ShopENName,@"Desc",shopModel.ShopName,@"Title",nil];
        [arrPXY addObject:dicPXY];
    }
    appleMapVC.PXYList = arrPXY;
    [self.navigationController pushViewController:appleMapVC animated:YES];
}

@end
