//
//  SettingViewController.m
//  设置
//
//  Created by aokuny on 15/5/30.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "ZNAppUtil.h"

@interface SettingViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    [self setBackBarButton];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    _gTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    _gTableView.backgroundView = nil;
    _gTableView.backgroundColor = [UIColor clearColor];
    [_gTableView setBackgroundColor:ZN_BACKGROUND_COLOR];
    [_gTableView setDelegate:self];
    [_gTableView setDataSource:self];
    [_gTableView setTableFooterView:[[UIView alloc]init]];
    [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _gTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _gTableView.scrollEnabled = NO;
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0,0,self.view.frame.size.width,16)];
    [view setBackgroundColor:ZN_BACKGROUND_COLOR];
    UIView *_lineView = [[UIView alloc] initWithFrame:CGRectMake(0,15,self.view.frame.size.width,.5)];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    [view addSubview:_lineView];
    _gTableView.tableHeaderView = view;
    [self.view addSubview:_gTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellValue1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        UIView *_lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
        [cell addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5);
            make.top.equalTo(cell.mas_bottom);
            make.left.equalTo(cell.mas_left);
            make.right.equalTo(cell);
        }];
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"意见反馈";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"清除缓存";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        unsigned long long fileSize = [[SDImageCache sharedImageCache] getSize];
        float mSize = fileSize/1024.0/1024.0;
        NSString *strRes;
        if(mSize == 0){
            strRes = @"无缓存";
        }else if (mSize<50) {
            strRes = [NSString stringWithFormat:@"小于%.2f M",mSize];
        }else if(mSize>1024){
            strRes = [NSString stringWithFormat:@"%.2f G",mSize/1024.0];
        }else{
            strRes = [NSString stringWithFormat:@"%.2f M",mSize];
        }
        cell.detailTextLabel.text = strRes;
        [cell.detailTextLabel setFont:DEFAULT_FONT(13)];
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"推荐好友";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"关于我们";
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"软件版本";
        cell.detailTextLabel.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    }
    [cell.textLabel setFont:DEFAULT_FONT(14)];
    [cell.textLabel setTextColor:ZN_FONNT_02_GRAY];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        //意见反馈
        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc]init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }else if(indexPath.row == 1){
        // 清除缓存
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"清除所有的缓存的图片，是否确定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setTag:100003333];
        [alert show];
    }else if(indexPath.row == 2){
        // 推荐好友
        [self share];
    }else if(indexPath.row == 3){
        // 关于我们
        AboutUsViewController *aboutUsVC = [AboutUsViewController new];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }else if(indexPath.row == 4){
        // 软件更新
        [self checkVersion];
    }
}
-(void) share{
    // 分享
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMengAppKey
                                      shareText:@"走你app是您在日本的私人贴身导游，美食购物优惠券让您随时享用。"
                                     shareImage:[UIImage imageNamed:@"Icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,
                                                 UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail,nil]
                                       delegate:self];
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        if([[[response.data allKeys] objectAtIndex:0] length]>0){
            [JGProgressHUD showSuccessStr:@"恭喜您分享成功!"];
        }
    }
}

#pragma mark 版本更新
-(void) checkVersion{
    [self showHudInView:self.view hint:@"正在检查版本..."];
    NSString *urlStr =[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",ZN_APPID];
    
    [ZNApi invokeGet:urlStr parameters:nil completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
            NSString *versionNative = @"";
            NSArray *configData = [resultObj valueForKey:@"results"];
            for (id config in configData){
                versionNative = [config valueForKey:@"version"];
            }
            NSString *localVersionKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
            if (localVersionKey.intValue < versionNative.intValue){
                NSString *msgcontent = [NSString stringWithFormat:@"已经发现新版本，是否确定更新？\n 当前版本:V%@ \n最新版本:V%@",localVersionKey,versionNative];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发现新版本" message:msgcontent delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert setTag:100001111];
                [alert setDelegate:self];
                [alert show];
            }else{
                [JGProgressHUD showHintStr:@"当前为最新版本，暂无更新！"];
            }
        }
        [self hideHud];
     }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100001111) {
        if (buttonIndex == 0) {
            return;
        }else if(buttonIndex == 1){
            NSString *downloadUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/bu-luo-chong-tu-clash-of-clans/id%@?mt=8",ZN_APPID];
            NSURL *url = [NSURL URLWithString:downloadUrl];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            } else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统更新" message:@"更新时出错，无法打开下载地址！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
    }else if (alertView.tag == 100003333) {
        if (buttonIndex == 0) {
            return;
        }else if(buttonIndex == 1){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [_gTableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"正在清除中...";
            [self performSelector:@selector(clearTmpPics) withObject:nil afterDelay:1];
        }
    }
}

- (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self performSelectorOnMainThread:@selector(updateRowData) withObject:nil waitUntilDone:YES];
}
-(void) updateRowData{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [_gTableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = @"无缓存";
    [JGProgressHUD showSuccessStr:@"清理完毕！"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
