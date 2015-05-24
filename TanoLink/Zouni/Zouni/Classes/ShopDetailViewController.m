//
//  ShopDetailViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ZNAppUtil.h"


@interface ShopDetailViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
}
@end
@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setBackBarButton];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    if([_gTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_gTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:_gTableView];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indentifier = @"cellInd";
    CellShopDetail *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[CellShopDetail alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    cell.shopModel = self.shopModel;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550.00f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
