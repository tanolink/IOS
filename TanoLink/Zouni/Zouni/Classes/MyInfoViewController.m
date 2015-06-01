//
//  MyInfoViewController.m
//  个人信息
//
//  Created by aokuny on 15/5/24.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "MyInfoViewController.h"
#import "CityListViewController.h"
#import "ChangeNickNameViewController.h"
#import "ChangePwdViewController.h"
#import "BindEmailViewController.h"
#import "BindMobileViewController.h"

@interface MyInfoViewController (){
    UITableView *_gTableView;
}
@property (strong, nonatomic) UIImagePickerController *imagePicker;

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
            [headerBtn addTarget:self action:@selector(getPhotoFunction) forControlEvents:UIControlEventTouchUpInside];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            make.width.equalTo(cell);
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        if(indexPath.row == 0){
            // 头像
//            [self getPhotoFunction];
        }else if(indexPath.row == 1){
            // 昵称
            ChangeNickNameViewController *changeNickNameVC = [ChangeNickNameViewController new];
            [self.navigationController pushViewController:changeNickNameVC animated:YES];
        }else if(indexPath.row == 2){
            // 常住地
            
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            // 手机
            BindMobileViewController *bindMobileVC = [BindMobileViewController new];
            bindMobileVC.oldMobileStr = @"15901437555";
            [self.navigationController pushViewController:bindMobileVC animated:YES];
        }else if(indexPath.row == 1){
            // 邮箱
            BindEmailViewController *bindEmailVC = [BindEmailViewController new];
            bindEmailVC.oldMobileStr = @"aokuny@126.com";
            [self.navigationController pushViewController:bindEmailVC animated:YES];
        }else if (indexPath.row == 2) {
            // 修改密码
            ChangePwdViewController *changePwdVC = [ChangePwdViewController new];
            [self.navigationController pushViewController:changePwdVC animated:YES];
        }
    }
}


#pragma mark - action
- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}
- (void)moreViewPhotoAction
{
    // 弹出照片选择
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    self.imagePicker.allowsEditing = YES;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (void)moreViewTakePicAction
{
#if TARGET_IPHONE_SIMULATOR
    [JGProgressHUD showHintStr:@"模拟器不支持拍照"];
#elif TARGET_OS_IPHONE
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    self.imagePicker.allowsEditing = YES;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
#endif
}


#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self moreViewPhotoAction];
    } else if(buttonIndex == 0) {
        [self moreViewTakePicAction];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *orgImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 选择照片后重新生上传新图片
//    [self showHudInView:self.view hint:@"正在上传"];
    [JGProgressHUD showHintStr:@"正在上传头像..."];

//    dispatch_queue_t urls_queue = dispatch_queue_create("com.jrzj.com", NULL);
//    __block MyInfoViewController* weakSelf = self;
//    [self showHudInView:self.view hint:nil];
//    dispatch_async(urls_queue, ^{
//        NSURL *fileUrl = [JRClientInfo JR_addStoreNamed:@"feedBack"];
//        [UIImageJPEGRepresentation(orgImage, 1) writeToURL:fileUrl atomically:YES ];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf hideHud];
//            [weakSelf setImage:orgImage imageFilePath:fileUrl];
//        });
//    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getPhotoFunction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.navigationController.view];
    
}

#pragma mark - 清除图片缓存
- (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [_gTableView reloadData];
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
