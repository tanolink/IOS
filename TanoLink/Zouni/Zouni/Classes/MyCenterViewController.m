//
//  MyCenterViewController.m
//  个人中心首页
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "MyCenterViewController.h"
#import "CExpandHeader.h"
#import "ZNAppUtil.h"
#import "UIButton+Block.h"
#import "UIButton+WebCache.h"
#import "MyInfoViewController.h"
#import "InviteCodeViewController.h"
#import "MyFavoriteViewController.h"

@interface MyCenterViewController (){
    CExpandHeader *_header;
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    /**
     * 用户头像
     */
    UIImageView *_imageHeader;
}

@end

@implementation MyCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setTitle:@"我的"];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,470/2.5)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,470/2.5)];
    [imageView setImage:[UIImage imageNamed:@"header_bg"]];
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [customView addSubview:imageView];

    [_gTableView setBackgroundColor:[UIColor grayColor]];
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _gTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _header = [CExpandHeader expandWithScrollView:_gTableView expandView:customView];
    [self.view addSubview:_gTableView];
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    float headerSize = 60;
    headerBtn.layer.cornerRadius = headerSize / 2.f;
    headerBtn.layer.masksToBounds = YES;
    headerBtn.layer.borderWidth = 2.f;
    headerBtn.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
    [headerBtn setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    [customView addSubview:headerBtn];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(headerSize));
        make.height.equalTo(@(headerSize));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(customView).offset(-5);
    }];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:@"Alice Alarez"];
    [label setFont:DEFAULT_FONT(16)];
    [label setTextColor:[UIColor whiteColor]];
    [customView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerBtn.mas_bottom).offset(15);
        make.centerX.equalTo(headerBtn);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    [headerBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        MyInfoViewController *myInfoVC = [MyInfoViewController new];
        [self.navigationController pushViewController:myInfoVC animated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellValue1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(indexPath.row > 0){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if(indexPath.row == 1){
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage imageNamed:@"my_collection_icon"];
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"最近浏览";
        cell.imageView.image = [UIImage imageNamed:@"my_record_icon"];
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"邀请码";
        cell.imageView.image = [UIImage imageNamed:@"my_code_icon"];
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"my_set_icon"];
    }
    UIView *_lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    [cell addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.top.equalTo(cell.textLabel.mas_bottom);
        make.left.equalTo(cell.imageView.mas_left);
        make.right.equalTo(cell).offset(-12);
    }];
    [cell.textLabel setFont:DEFAULT_FONT(15)];
    [cell.textLabel setTextColor:ZN_FONNT_01_BLACK];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGSize itemSize = CGSizeMake(23,23);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        // 我的收藏
        MyFavoriteViewController *myFavoiteVC = [[MyFavoriteViewController alloc]init];
        [self.navigationController pushViewController:myFavoiteVC animated:YES];
    }else if(indexPath.row == 2){
        
    }else if(indexPath.row == 3){
        // 邀请码
        InviteCodeViewController *inviteCodeVC = [InviteCodeViewController new];
        [self.navigationController pushViewController:inviteCodeVC animated:YES];
    }else if(indexPath.row == 4){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
