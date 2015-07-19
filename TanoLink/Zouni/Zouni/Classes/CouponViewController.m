//
//  CouponViewController.m
//  优惠券
//
//  Created by aokuny on 15/5/18.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CouponViewController.h"
#import "ZNAppUtil.h"
#import "CouponDescViewController.h"
#import "UIButton+Block.h"
#import "UMSocial.h"
#import "CouponModel.h"
#import "UIButton+WebCache.h"

@interface CouponViewController (){
    // 白色背景
    UIView *_bgView;
    // 顶部黄色背景
    UIView *_topView;
    // logo 圆形
    UIButton *_btnLogoCircle;
    // logo 方形
    UIButton *_btnLogoRect;
    // 虚线
    UIImageView *_lineDashed;
    // 波浪线
    UIImageView *_lineWave;
    // 名称
    UILabel *_labTitle;
    // 地址
    UILabel *_labAddress;
    // 条形码
    UIButton *_imgCoupon;
    // 内容
    UILabel *_labCouponContent;
    // 使用描述
    UILabel *_labCouponDesc;
    // 如何使用
    UIButton *_btnCouponUseDesc;
    // 横线
    UIView *_lineView;
    // 分享按钮
    UIButton *_btnShare;
    // 保存按钮
    UIButton *_btnSaveToAlbum;
    // 分隔线
    UIImageView *_imageSplit;
    // 优惠券
    CouponModel *_couponModel;
    // 单独显示优惠券图片
    UIButton *btnCouponImg;
    // 说明
    NSString *howToUseCoupon;
}

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    [self setTitle:@"优惠券"];
    [self initData];
}
-(void) initData{
    [self showHudInView:self.view hint:@"正在加载优惠券..."];
    NSDictionary *requestDic= @{@"shopId":self.shopModel.ShopID};
    __weak typeof(self) weakSelf = self;
    [ZNApi invokePost:ZN_COUPON_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
        if (respModel.success.intValue>0) {
            NSLog(@"%@",resultObj);
//            NSError *err = nil;
//            CouponModel *_coupon;
//            _couponModel
//            _coupon = [[CouponModel alloc]initWithDictionary:(NSDictionary*)resultObj error:&err];
            // 判断类型
            if([resultObj[@"type"] integerValue] == 2){
                [self buildUI];
                [self layoutUI];
                [self initCouponData:resultObj];
            }else{
                [self buildUICouponImg:resultObj];
            }
        }else{
            [JGProgressHUD showHintStr:msg];
        }
        [weakSelf hideHud];
    }];
}
#pragma 图片类型的优惠券
-(void) buildUICouponImg:(NSDictionary *) dic {
    btnCouponImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCouponImg setUserInteractionEnabled:NO];
    [self.view addSubview:btnCouponImg];
    [btnCouponImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    NSURL *couponUrl = [NSURL URLWithString:dic[@"couponPhoto"]];
    [btnCouponImg sd_setBackgroundImageWithURL:couponUrl forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"default_userhead"]];
}
-(void)initCouponData:(NSDictionary *)dic{
    if([dic[@"address"]isEqual:[NSNull null]]){
        _labAddress.text = @"暂无";
    }else{
        _labAddress.text = dic[@"address"];
    }
    NSLog(@"%@",dic[@"specialDetail"]);
    if ([dic[@"special"] isEqual:[NSNull null]]) {
        _labCouponContent.text = @"暂无";
    }else{
        _labCouponContent.text = dic[@"special"];
    }
    if([dic[@"shopName"] isEqual:[NSNull null]]){
        _labTitle.text = @"暂无";
    }else{
        _labTitle.text = dic[@"shopName"];
    }
    howToUseCoupon = dic[@"specialDetail"];
    
    NSURL *couponUrl = [NSURL URLWithString:dic[@"couponPhoto"]];
    [_imgCoupon sd_setBackgroundImageWithURL:couponUrl forState:UIControlStateNormal
                              placeholderImage:[UIImage imageNamed:@"default_userhead"]];

}
-(void)buildUI{
    _bgView = [UIView new];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderColor = ZN_FONNT_02_GRAY.CGColor;
    _bgView.layer.borderWidth = 0.5;
    
    _topView = [UIView new];
    [_topView setBackgroundColor:RGBCOLOR(243,165,54)];
    _topView.layer.cornerRadius = 10;
    
    _btnLogoCircle = [UIButton buttonWithType:UIButtonTypeCustom];
    float headerSize = 130/3;
    _btnLogoCircle.layer.cornerRadius = headerSize / 2.f;
    _btnLogoCircle.layer.masksToBounds = YES;
    _btnLogoCircle.layer.borderWidth = 2.f;
    _btnLogoCircle.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
    [_btnLogoCircle setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    
    _btnLogoRect = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLogoRect.layer.cornerRadius = 5;
    _btnLogoRect.layer.masksToBounds = YES;
    _btnLogoRect.layer.borderWidth = 1.f;
    _btnLogoRect.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
//    [_btnLogoRect setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    [_btnLogoRect setImage:[UIImage imageNamed:@"Icon"] forState:UIControlStateNormal];

    _labTitle = [UILabel new];
//    [_labTitle setText:@"京王百货店（新宿店）"];
    [_labTitle setFont:DEFAULT_FONT(16)];
    [_labTitle setTextColor:[UIColor whiteColor]];
    [_labTitle setTextAlignment:NSTextAlignmentLeft];

    _labAddress = [UILabel new];
//    [_labAddress setText:@"地址：东京都新宿区西新宿1-1-4"];
    [_labAddress setFont:DEFAULT_FONT(13)];
    [_labAddress setTextColor:[UIColor whiteColor]];
    [_labAddress setTextAlignment:NSTextAlignmentLeft];

    _labCouponContent = [UILabel new];
//    [_labCouponContent setText:@"5%优惠+8%免税"];
    [_labCouponContent setFont:DEFAULT_FONT(26)];
    [_labCouponContent setTextColor:[UIColor whiteColor]];
    [_labCouponContent setTextAlignment:NSTextAlignmentCenter];
    
    // 优惠券图片
    _imgCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_imgCoupon setImage:[UIImage imageNamed:@"cnaidc"]];
    _imgCoupon.contentMode = UIViewContentModeScaleAspectFit;
    _imgCoupon.userInteractionEnabled = NO;
    
    _labCouponDesc = [UILabel new];
    [_labCouponDesc setText:@"请向商家出示此优惠券"];
    [_labCouponDesc setFont:DEFAULT_FONT(13)];
    [_labCouponDesc setTextColor:ZN_FONNT_02_GRAY];
    [_labCouponDesc setTextAlignment:NSTextAlignmentCenter];
    
    _lineDashed = [UIImageView new];
    [_lineDashed setImage:[UIImage imageNamed:@"lineDashed"]];
    
    _lineWave = [UIImageView new];
    [_lineWave setImage:[UIImage imageNamed:@"lineWave"]];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    
    _btnShare = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [_btnShare addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];

    _btnSaveToAlbum = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnSaveToAlbum setTitle:@"保存到相册" forState: UIControlStateNormal];
    [_btnSaveToAlbum addTarget:self action:@selector(longPressSavaImage:) forControlEvents:UIControlEventTouchUpInside];
    
    _imageSplit = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_imageSplit setImage:[UIImage imageNamed:@"split"]];
    
    _btnCouponUseDesc =[UIButton buttonWithType:UIButtonTypeSystem];
    [_btnCouponUseDesc setTitle:@"如何使用优惠券" forState:UIControlStateNormal];
    [_btnCouponUseDesc.titleLabel setTextColor:RGBCOLOR(74,144,226)];
    [_btnCouponUseDesc.titleLabel setFont:DEFAULT_FONT(13)];
    [_btnCouponUseDesc handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        CouponDescViewController *couponDescVC = [CouponDescViewController new];
        couponDescVC.howToUseCoupon = howToUseCoupon;
        [self.navigationController pushViewController:couponDescVC animated:YES];
    }];
    
    [_bgView addSubview:_topView];
    [_bgView addSubview:_lineDashed];
    [_bgView addSubview:_lineWave];
    [_bgView addSubview:_btnLogoCircle];
    [_bgView addSubview:_labCouponContent];
    [_bgView addSubview:_labTitle];
    [_bgView addSubview:_labAddress];
    [_bgView addSubview:_imgCoupon];
    [_bgView addSubview:_labCouponDesc];
    [_bgView addSubview:_btnLogoRect];
    [_bgView addSubview:_lineView];
    [_bgView addSubview:_btnShare];
    [_bgView addSubview:_btnSaveToAlbum];
    [_bgView addSubview:_imageSplit];
    [self.view addSubview:_bgView];
    [self.view addSubview:_btnCouponUseDesc];
    
    // test color
//    [_btnShare setBackgroundColor:[UIColor greenColor]];
    
}
-(void)layoutUI{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(36/3);
        make.left.equalTo(self.view).offset(36/3);
        make.right.equalTo(self.view).offset(-36/3);
        make.height.equalTo(@410);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView);
        make.left.equalTo(_bgView);
        make.right.equalTo(_bgView);
        make.height.equalTo(@(421/3-20));
    }];
    
    [_btnLogoCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(130/3));
        make.height.equalTo(@(130/3));
        make.left.equalTo(_topView).offset(36/3);
        make.top.equalTo(_topView).offset(36/3);
    }];
    
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView).offset(36/3+3);
        make.left.equalTo(_btnLogoCircle.mas_right).offset(36/3);
        make.right.equalTo(_topView).offset(-10);
        make.height.equalTo(@17);
    }];
    [_labAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labTitle.mas_bottom).offset(30/3);
        make.left.equalTo(_labTitle);
        make.right.equalTo(_labTitle);
        make.height.equalTo(@13);
    }];
//
    [_labCouponContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineDashed).offset(10);
        make.centerX.equalTo(_bgView);
        make.height.equalTo(@(90/3));
    }];

    [_imgCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineWave.mas_bottom).offset(20);
        make.left.equalTo(_bgView).offset(20);
        make.right.equalTo(_bgView).offset(-20);
        make.height.equalTo(@80);
    }];
    
    [_labCouponDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgCoupon.mas_bottom).offset(18);
        make.centerX.equalTo(_bgView);
        make.width.equalTo(@200);
    }];
//
    [_lineDashed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView).offset(202/3);
        make.left.equalTo(_topView);
        make.width.equalTo(_topView);
        make.height.equalTo(@1);
    }];
//
    [_lineWave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(-6);
        make.left.equalTo(_topView);
        make.width.equalTo(_topView);
        make.height.equalTo(@8);
    }];
    
    
    [_btnLogoRect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(210/3));
        make.height.equalTo(@(210/3));
        make.centerX.equalTo(_bgView);
        make.top.equalTo(_labCouponDesc.mas_bottom).offset(18);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.top.equalTo(_bgView.mas_bottom).offset(-45);
        make.left.equalTo(_bgView);
        make.right.equalTo(_bgView);
    }];
    
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView).offset(5);
        make.left.equalTo(_bgView);
        make.right.equalTo(_btnSaveToAlbum.mas_left);
        make.width.equalTo(_btnSaveToAlbum);
        make.height.equalTo(@30);
    }];
    
    [_btnSaveToAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnShare);
        make.left.equalTo(_btnShare.mas_right);
        make.right.equalTo(_bgView);
        make.height.equalTo(_btnShare);
    }];
    
    [_imageSplit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnShare);
        make.bottom.equalTo(_btnShare);
        make.centerX.equalTo(_bgView);
    }];
    
    [_btnCouponUseDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_bottom).offset(48/3);
        make.right.equalTo(_bgView);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];

}
#pragma 分享
-(void) share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMengAppKey
                                      shareText:@"走你app是您在日本的私人贴身导游，美食购物优惠券让您随时享用。"
                                     shareImage:[UIImage imageNamed:@"Icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,
                                                 UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail,nil]
                                       delegate:self];
}
#pragma mark - 保存图片
-(void) longPressSavaImage:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *showSave = [[UIAlertView alloc]initWithTitle:@"将优惠券保存到相册？" message:@"" delegate:self cancelButtonTitle:@"保存" otherButtonTitles:@"取消", nil];
        [showSave setTag:11001];
        [showSave show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 11001) {
        if (buttonIndex == 0 ) {
            [self saveImageToAlbum];
        }
    }
}
-(void) saveImageToAlbum {
    UIImageWriteToSavedPhotosAlbum([_imgCoupon currentBackgroundImage], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存失败" ;
        [JGProgressHUD showErrorStr:msg];
    }else{
        msg = @"保存成功" ;
        [JGProgressHUD showSuccessStr:msg];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
