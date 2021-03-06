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
#import "ZNBaseNavigationController.h"
#import "UIButton+WebCache.h"
#import "PickView.h"

@interface MyInfoViewController (){
    UITableView *_gTableView;
    ZHPickView *_pickview;
    UITextField *_textFieldCity;
    MemberInfo *_memberInfo;
    UIButton *headerBtn;
}
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
@implementation MyInfoViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_gTableView reloadData];
}
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
    
    _memberInfo = [ZNClientInfo sharedClinetInfo].memberInfo;
    
//    //    //Tap Touch
//    UITapGestureRecognizer *_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
//    _tapGesture.delegate = self;
//    _tapGesture.numberOfTapsRequired = 1;
//    _tapGesture.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer:_tapGesture];

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
            headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            float headerSize = 60;
            headerBtn.layer.cornerRadius = headerSize / 2.f;
            headerBtn.layer.masksToBounds = YES;
            headerBtn.layer.borderWidth = 2.f;
            headerBtn.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
            NSURL *caseurl = [NSURL URLWithString:_memberInfo.userPhoto];
            [headerBtn sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                                   placeholderImage:[UIImage imageNamed:@"default_avatar"]];
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
            cell.detailTextLabel.text = @"";
            if([ZNClientInfo sharedClinetInfo].memberInfo.nickname.length>0){
                cell.detailTextLabel.text = [ZNClientInfo sharedClinetInfo].memberInfo.nickname;
            }
        }else if(indexPath.row == 2){
            // 常住地
            cell.textLabel.text = @"常住地";
            _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
            _pickview.delegate = self;
            [_pickview setTag:indexPath.row+10000];
            
            _textFieldCity = [[UITextField alloc]init];
            [_textFieldCity setDelegate:self];
            [_textFieldCity setTag:indexPath.row+10000];
            _textFieldCity.placeholder = @"请选择";
            if([ZNClientInfo sharedClinetInfo].memberInfo.cityId){
                [_textFieldCity setText:[ZNClientInfo sharedClinetInfo].memberInfo.cityId];
            }

            [_textFieldCity setTextAlignment:NSTextAlignmentRight];
            [_textFieldCity setBackgroundColor:[UIColor whiteColor]];
            [_textFieldCity setTextColor:[UIColor grayColor]];
            [_textFieldCity setFont:DEFAULT_FONT(15)];
            [cell addSubview:_textFieldCity];
            _textFieldCity.inputView = _pickview;
            _textFieldCity.inputAccessoryView = nil;
            [_textFieldCity mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top);
                make.width.equalTo(@170);
                make.height.equalTo(@44);
                make.right.equalTo(cell.mas_right).offset(-32);
            }];
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
            cell.detailTextLabel.text = [ZNClientInfo sharedClinetInfo].memberInfo.mobile;
        }
        else if(indexPath.row == 1){
            cell.textLabel.text = @"邮箱绑定";
            cell.detailTextLabel.text = [ZNClientInfo sharedClinetInfo].memberInfo.email;
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
            bindMobileVC.oldMobileStr = [ZNClientInfo sharedClinetInfo].memberInfo.mobile;
            [self.navigationController pushViewController:bindMobileVC animated:YES];
        }else if(indexPath.row == 1){
            // 邮箱
            BindEmailViewController *bindEmailVC = [BindEmailViewController new];
            bindEmailVC.oldMobileStr = [ZNClientInfo sharedClinetInfo].memberInfo.email;
            [self.navigationController pushViewController:bindEmailVC animated:YES];
        }else if (indexPath.row == 2) {
            // 修改密码
            ChangePwdViewController *changePwdVC = [ChangePwdViewController new];
            [self.navigationController pushViewController:changePwdVC animated:YES];
        }
    }
}
#pragma mark ZhpickVIewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    [_textFieldCity setText:resultString];
    [self.view endEditing:NO];
    [_gTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [self showHudInView:self.view hint:@"正在修改城市..."];
    NSDictionary *requestDic= @{@"nickName":@"",@"upor":resultString};
    __weak typeof(self) weakSelf = self;
    [ZNApi invokePost:ZN_CHANGEUSER_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
        if (respModel.success.intValue>0) {
            [JGProgressHUD showSuccessStr:@"常驻地修改成功！"];
            // 更改本地常驻地
            [ZNClientInfo sharedClinetInfo].memberInfo.cityId = resultString;
            [[ZNClientInfo sharedClinetInfo] saveMemberInfo];
        }else{
            [JGProgressHUD showHintStr:msg];
        }
        [weakSelf hideHud];
    }];
}
-(void)cancelClick{
    [self.view endEditing:NO];
    [_gTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    ZHPickView *pickView = (ZHPickView *)textField.inputView;
    [pickView setDefaultSelectedWithValue:_textFieldCity.text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [_gTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
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
    [self showHudInView:self.view hint:@"正在上传头像..."];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
    [manager.requestSerializer setValue:[ZNApi sharedInstance].headerPermit forHTTPHeaderField:@"permit"];
    __weak typeof(self) weakSelf = self;
    [manager POST:ZN_UPLOAD_IMAGE_API parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(orgImage, 1)  name:@"file" fileName:@"userPhote.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation,NSDictionary *responseObject){
        [weakSelf hideHud];
        if([responseObject[@"success"] integerValue]>0){
            NSString *imgeUrl = responseObject[@"data"];
            NSURL *caseurl = [NSURL URLWithString:imgeUrl];
            [headerBtn sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                                   placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            // 修改本地图片
            [ZNClientInfo sharedClinetInfo].memberInfo.userPhoto = imgeUrl;
            [[ZNClientInfo sharedClinetInfo] saveMemberInfo];
        }else{
            [JGProgressHUD showErrorStr:responseObject[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf hideHud];
    }];

//    dispatch_queue_t urls_queue = dispatch_queue_create("com.tanolink", NULL);
//    __block MyInfoViewController* weakSelf = self;
//    [self showHudInView:self.view hint:nil];
//    dispatch_async(urls_queue, ^{
//        NSURL *fileUrl = [ZNClientInfo ZN_addStoreNamed:@"feedBack"];
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
            [[ZNClientInfo sharedClinetInfo] clearAllUserInfo];
            CityListViewController *cityListVC = [[CityListViewController alloc]init];
            ZNBaseNavigationController *cityNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:cityListVC];
            [[UIApplication sharedApplication] delegate].window.rootViewController = cityNavController;
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
