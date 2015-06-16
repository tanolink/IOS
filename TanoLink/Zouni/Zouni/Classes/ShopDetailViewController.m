//
//  ShopDetailViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ZNAppUtil.h"
#import "UMSocial.h"

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
//    [self setRightBarButtonItemImage:@"share_icon" target:self action:@selector(share)];
    
//    UIBarButtonItem *btnAction = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
//    self.navigationController.navigationItem.rightBarButtonItem = btnAction;
    
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
-(void) share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"556885e767e58e40ca001421"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,
                                                 UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail,nil]
                                       delegate:nil];
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
            cell.shopID = [NSString stringWithFormat:@"%@",self.shopId];
//        [cell setCellDataForModel:self.shopModel];
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
