//
//  ShopCommentViewController.m
//  点评列表
//
//  Created by aokuny on 15/6/25.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopCommentViewController.h"

@interface ShopCommentViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    /**
     *  分页大小
     */
    int _pageSize;
    /**
     *  当前页数
     */
    int _pageNumber;
}

@end

@implementation ShopCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"全部点评"];
    // 初始化表格
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setAllowsSelection:NO];
    [self.view addSubview:_gTableView];
    __weak typeof(self) weakSelf = self;
    [_gTableView addHeaderWithCallback:^{
        [weakSelf loadNewData];
    }];
    [_gTableView addFooterWithCallback:^{
        [weakSelf loadMoreData];
    }];
    [self initData];
}
#pragma 初始化数据
-(void) initData{
    _pageNumber = 1;
    _pageSize = 12;
    _dataMutableArray = [[NSMutableArray alloc]init];
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
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                self.shopId,@"shopId",
                                [NSString stringWithFormat:@"%d",_pageSize],@"size",
                                [NSString stringWithFormat:@"%d",_pageNumber],@"page",
                                nil];
//    [ZNApi invokePost1:ZN_SHOPCOMMENTS_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel1 *respModel) {
//        if (resultObj) {
//            NSArray *dic = (NSArray *)resultObj;
//            [_dataMutableArray addObjectsFromArray:dic];
//            [_gTableView reloadData];
//            [_gTableView headerEndRefreshing];
//            [_gTableView footerEndRefreshing];
//        }
//        [weakSelf hideHud];
//    }];
        [ZNApi invokePost:ZN_SHOPCOMMENTS_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
            if (resultObj) {
                NSArray *dic = (NSArray *)resultObj;
                [_dataMutableArray addObjectsFromArray:dic];
                [_gTableView reloadData];
                [_gTableView headerEndRefreshing];
                [_gTableView footerEndRefreshing];
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
    
    static NSString *Indentifier = @"cellInd";
    CellCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[CellCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    NSDictionary *commentModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    NSError *err = nil;
    CommentModel *commentModel = [[CommentModel alloc]initWithDictionary:commentModelDic error:&err];
    [cell setCellDataForModel:commentModel];
    return cell;
}

#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *commentModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    NSError *err = nil;
    CommentModel *commentModel = [[CommentModel alloc]initWithDictionary:commentModelDic error:&err];
    return [CellCommentTableViewCell getCellHeightForModel:commentModel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
