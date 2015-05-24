//
//  MyInfoViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/24.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "MyInfoViewController.h"
#import "CityListViewController.h"

@interface MyInfoViewController (){
    UITableView *_gTableView;
}

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBarButton];
    [self setTitle:@"个人中心"];
    
    _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,ScreenHeight)];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setBackgroundColor:ZN_BACKGROUND_COLOR];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    _gTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_gTableView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 3;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"cellValue1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.textLabel setFont:DEFAULT_FONT(14)];
            [cell.textLabel setTextColor:ZN_FONNT_02_GRAY];
            [cell.detailTextLabel setFont:DEFAULT_FONT(14)];
            [cell.detailTextLabel setTextColor:ZN_FONNT_03_LIGHTGRAY];
            UIView *_lineView = [[UIView alloc] init];
            _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
            [cell addSubview:_lineView];
            [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@.5);
                make.top.equalTo(cell.mas_bottom).offset(-0.5);
                make.left.equalTo(cell.mas_left);
                make.right.equalTo(cell);
            }];
        }
        // section 1
        if(indexPath.row == 0){
            // 头像
            cell.textLabel.text = @"头像";
            UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            float headerSize = 60;
            headerBtn.layer.cornerRadius = headerSize / 2.f;
            headerBtn.layer.masksToBounds = YES;
            headerBtn.layer.borderWidth = 2.f;
            headerBtn.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
            [headerBtn setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
            [cell.contentView addSubview:headerBtn];
            [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(headerSize));
                make.height.equalTo(@(headerSize));
                make.right.equalTo(cell).offset(-30);
                make.centerY.equalTo(cell);
            }];
        }else if(indexPath.row == 1){
            // 昵称
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = @"Alice Alarez";
        }else if(indexPath.row == 2){
            // 常住地
            cell.textLabel.text = @"常住地";
            cell.detailTextLabel.text = @"东京";
        }
        return cell;
    }
    else if(indexPath.section == 1){
        // section 2
        static NSString *cellIdentifier = @"cellValue1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            UIView *_lineView = [[UIView alloc] init];
            _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
            [cell addSubview:_lineView];
            [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@.5);
                make.top.equalTo(cell.mas_bottom).offset(-0.5);
                make.left.equalTo(cell.mas_left);
                make.right.equalTo(cell);
            }];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.textLabel setFont:DEFAULT_FONT(14)];
        [cell.textLabel setTextColor:ZN_FONNT_02_GRAY];
        [cell.detailTextLabel setFont:DEFAULT_FONT(14)];
        [cell.detailTextLabel setTextColor:ZN_FONNT_03_LIGHTGRAY];
        if(indexPath.row == 0){
            cell.textLabel.text = @"手机号码绑定";
            cell.detailTextLabel.text = @"15901437555";
        }
        else if(indexPath.row == 1){
            cell.textLabel.text = @"邮箱绑定";
            cell.detailTextLabel.text = @"aokuny@126.com";
        }
        else if(indexPath.row == 2){
            cell.textLabel.text = @"修改密码";
            cell.detailTextLabel.text = @"";
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"cellValue1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        UIButton *btnLoginOut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnLoginOut setTitle:@"退出登录" forState:UIControlStateNormal];
        [btnLoginOut setTitleColor:ZN_FONNT_02_GRAY forState:UIControlStateNormal];
        [btnLoginOut.titleLabel setTextColor:ZN_FONNT_02_GRAY];
        [btnLoginOut.titleLabel setFont:DEFAULT_FONT(14)];
        [btnLoginOut addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnLoginOut];
        [btnLoginOut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView);
            make.centerY.equalTo(cell);
        }];
        UIView *_lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
        [cell addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5);
            make.top.equalTo(cell.mas_bottom).offset(-0.5);
            make.left.equalTo(cell.mas_left);
            make.right.equalTo(cell);
        }];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,ScreenWidth, tableView.rowHeight)];
    [customView setBackgroundColor:ZN_BACKGROUND_COLOR];
    UIView *_lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    [customView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.top.equalTo(customView.mas_bottom).offset(-1);
        make.left.equalTo(customView.mas_left);
        make.right.equalTo(customView);
    }];
    return customView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 1){

        }else if(indexPath.row == 2){

        }else if(indexPath.row == 4){

        }
    }else{
        if (indexPath.row == 0) {
           
        }else if(indexPath.row == 1){
            
        }else if (indexPath.row == 2) {
            
        } else if(indexPath.row == 3){
            
        }
    }
}
#pragma mark -
- (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100002222) {
        if (buttonIndex == 0) {
            return;
        }else if(buttonIndex == 1){
            [[UIApplication sharedApplication] delegate].window.rootViewController = [[CityListViewController alloc] init];;
        }
    }
    if (alertView.tag == 100003333) {
        if (buttonIndex == 0) {
            return;
        }else if(buttonIndex == 1){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            [_gTableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"正在清除中...";
            [self performSelector:@selector(clearTmpPics) withObject:nil afterDelay:1];
        }
    }
}

#pragma mark 退出登录
-(void) loginOut:(id)sender{
    // 退出/注销
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"退出登录将清除用户信息，是否确定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setTag:100002222];
    [alert show];
}

@end
