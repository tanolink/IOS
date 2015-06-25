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
}

@end

@implementation ShopCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"全部点评"];
    
    _dataMutableArray = [NSMutableArray new];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"高大为",@"UserName",
                         @"123",@"CommentId",
                         @"113",@"UserId",
                         @"2015-02-16 12:23:22",@"Time",
                         @"这家店不错",@"Content",
                         @"5.5",@"Score",
                         @"",@"Images",
                         nil];
    //    {[http://xxxxx/images/xxxxxxxx.jpg”]}
    [_dataMutableArray addObject:dic];
    
    
    
    // 初始化表格
    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setAllowsSelection:NO];
    _gTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_gTableView];
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
    NSDictionary *shopModelDic = (NSDictionary *)[_dataMutableArray objectAtIndex:indexPath.row];
    NSError *err = nil;
//    ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:shopModelDic error:&err];
//    [cell setCellDataForModel:shopModel];
    // 事件
    
//    [cell.labUserName setText:shopModelDic[@"UserName"]];
        [cell.labUserName setText:@"ssss"];

    return cell;
}

#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
