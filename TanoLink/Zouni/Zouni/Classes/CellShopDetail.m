//
//  CellShopDetail.m
//  Zouni
//
//  Created by aokuny on 15/5/23.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "CellShopDetail.h"

@implementation CellShopDetail{
//    UIView *_bgScrollView;
    //    图片
    UIButton *_imgView;
    //    图片遮罩
    UIView  *_shadeView;
    //    名称
    UILabel *_labShopName;
    //    评分
    UILabel *_labScore;
    //    店铺英文名
    UILabel *_labShopClass;
    //  星星
    UIImageView *imgStarGray1;
    UIImageView *imgStarGray2;
    UIImageView *imgStarGray3;
    UIImageView *imgStarGray4;
    UIImageView *imgStarGray5;
    //  星星数组
    NSMutableArray *_mutArrayStars;
    //  按钮描述
    UIButton *_btnShopFavorite;
    //  收藏描述
    UILabel *_labFavorite;
    //  地图分割线
    UIView *_lineView;
    //  地图
    GMSMapView *mapView_;
    
    // 店铺描述
    UILabel *_labShopDesc;
    UILabel *_txtShopDesc;
    
    // 店铺网址
    UIView *_lineShopWebsite;
    UILabel *_labShopWebsite;
    UILabel *_labShopWebsiteAr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutUI];
    [self initData];
}

-(void)buildUI{
//    _bgScrollView = [[UIView alloc]initWithFrame:CGRectZero];
    
    _labShopName = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labShopName setFont:DEFAULT_BOLD_FONT(17)];
    [_labShopName setNumberOfLines:0];
    [_labShopName setTextColor:ZN_FONNT_01_BLACK];
    [_labShopName setLineBreakMode:NSLineBreakByTruncatingTail];
    
    _labShopClass = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labShopClass setFont:DEFAULT_FONT(12)];
    [_labShopClass setTextColor:ZN_FONNT_03_LIGHTGRAY];
    [_labShopClass setNumberOfLines:0];
    [_labShopClass setLineBreakMode:NSLineBreakByTruncatingTail];
    
    _labScore = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labScore setFont:DEFAULT_FONT(12)];
    [_labScore setTextColor:ZN_FONNT_01_BLACK];
    [_labScore setNumberOfLines:0];
    [_labScore setLineBreakMode:NSLineBreakByTruncatingTail];
    
    _imgView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgView setUserInteractionEnabled:NO];
    
    _shadeView = [[UIView alloc]initWithFrame:CGRectZero];
    _shadeView.backgroundColor = RGBCOLOR_WithAlpha(0,0,0,0);
    
    imgStarGray1 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [imgStarGray1 setImage:[UIImage imageNamed:@"xing01"]];
    [_shadeView addSubview:imgStarGray1];
    imgStarGray2 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [imgStarGray2 setImage:[UIImage imageNamed:@"xing01"]];
    [_shadeView addSubview:imgStarGray2];
    imgStarGray3 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [imgStarGray3 setImage:[UIImage imageNamed:@"xing01"]];
    [_shadeView addSubview:imgStarGray3];
    imgStarGray4 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [imgStarGray4 setImage:[UIImage imageNamed:@"xing01"]];
    [_shadeView addSubview:imgStarGray4];
    imgStarGray5 = [[UIImageView alloc]initWithFrame:CGRectZero];
    [imgStarGray5 setImage:[UIImage imageNamed:@"xing01"]];
    [_shadeView addSubview:imgStarGray5];
    _mutArrayStars = [NSMutableArray arrayWithArray:@[imgStarGray1,imgStarGray2,imgStarGray3,imgStarGray4,imgStarGray5]];
    
    _btnShopFavorite = [[UIButton alloc]initWithFrame:CGRectZero];
    [_btnShopFavorite setImage:[UIImage imageNamed:@"view_noCollection"] forState:UIControlStateNormal];
    _labFavorite = [[UILabel alloc] initWithFrame: CGRectZero];
    [_labFavorite setFont:DEFAULT_FONT(10)];
    [_labFavorite setTextColor:ZN_FONNT_03_LIGHTGRAY];
    [_labFavorite setText:@"收藏"];
    [_labFavorite setTextAlignment:NSTextAlignmentCenter];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.shopModel.PX floatValue]
                                                            longitude:[self.shopModel.PY floatValue]
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    _labShopDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labShopDesc setFont:DEFAULT_BOLD_FONT(15)];
    [_labShopDesc setNumberOfLines:0];
    [_labShopDesc setTextColor:ZN_FONNT_01_BLACK];
    [_labShopDesc setText:@"店铺介绍"];
    
    _txtShopDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [_txtShopDesc setFont:DEFAULT_BOLD_FONT(12)];
    [_txtShopDesc setTextColor:ZN_FONNT_02_GRAY];
    [_txtShopDesc setTextAlignment:NSTextAlignmentLeft];
    [_txtShopDesc setNumberOfLines:0];
    
    _lineShopWebsite = [[UIView alloc] init];
    _lineShopWebsite.backgroundColor = ZN_BORDER_LINE_COLOR;
    
    _labShopWebsite = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labShopWebsite setFont:DEFAULT_BOLD_FONT(15)];
    [_labShopWebsite setNumberOfLines:0];
    [_labShopWebsite setTextColor:ZN_FONNT_01_BLACK];
    [_labShopWebsite setText:@"商店网址"];
    
    _labShopWebsiteAr = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labShopWebsiteAr setFont:DEFAULT_BOLD_FONT(12)];
    [_labShopWebsiteAr setNumberOfLines:0];
    [_labShopWebsiteAr setTextColor:RGBCOLOR(74,144,226)];
    [_labShopWebsiteAr setTextAlignment:NSTextAlignmentLeft];
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
//    [_bgScrollView setBackgroundColor:[UIColor whiteColor]];
    [_shadeView addSubview:_labShopName];
    [_shadeView addSubview:_labShopClass];
    [_shadeView addSubview:_labScore];
    [_shadeView addSubview:_btnShopFavorite];
    [_shadeView addSubview:_labFavorite];
    [_shadeView addSubview:_lineView];
    
//    [_bgScrollView addSubview:_imgView];
//    [_bgScrollView addSubview:_shadeView];
//    [_bgScrollView addSubview: mapView_];
//    [_bgScrollView addSubview:_labShopDesc];
//    [_bgScrollView addSubview:_txtShopDesc];
//    [_bgScrollView addSubview:_labShopWebsite];
//    [_bgScrollView addSubview:_labShopWebsiteAr];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_shadeView];
    [self.contentView addSubview: mapView_];
    [self.contentView addSubview:_labShopDesc];
    [self.contentView addSubview:_txtShopDesc];
    [self.contentView addSubview:_lineShopWebsite];
    [self.contentView addSubview:_labShopWebsite];
    [self.contentView addSubview:_labShopWebsiteAr];
    
//    [self.contentView addSubview:_bgScrollView];
//    [_labShopDesc setBackgroundColor:[UIColor orangeColor]];
//    [_txtShopDesc setBackgroundColor:[UIColor purpleColor]];
    
}
-(void)layoutUI{
    
//    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
//    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(516/3));
    }];
    
    [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_imgView.mas_bottom);
        make.height.equalTo(@(250/3+34/3));
    }];
    
    [_labShopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadeView).offset(34/3);
        make.left.equalTo(_shadeView).offset(24/3);
        make.height.equalTo(@20);
    }];
    
    [_labShopClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopName.mas_bottom).offset(16/3);
        make.left.equalTo(_labShopName);
    }];
    
    float starsOffSet = 16/3;
    [imgStarGray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopClass.mas_bottom).offset(34/3);
        make.left.equalTo(_labShopClass.mas_left);
        make.height.equalTo(@16);
        make.width.equalTo(@16);
    }];
    [imgStarGray2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray1.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray2.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray3.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray4.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [_labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgStarGray5);
        make.left.equalTo(imgStarGray5.mas_right).offset(30/3);
        make.width.equalTo(@40);
        make.height.equalTo(@15);
    }];
    
    [_btnShopFavorite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopName.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView).offset(-38/2);
        make.width.equalTo(@(70/2));
        make.height.equalTo(@(70/2));
    }];
    [_labFavorite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnShopFavorite.mas_bottom).offset(16/3);
        make.centerX.equalTo(_btnShopFavorite);
        make.width.equalTo(@30);
        make.height.equalTo(@15);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.equalTo(_shadeView);
        make.right.equalTo(_shadeView);
        make.bottom.equalTo(_shadeView);
    }];
    
    [mapView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadeView.mas_bottom);
        make.width.equalTo(_shadeView);
        make.height.equalTo(@(326/2-20));
    }];
    
    [_labShopDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mapView_.mas_bottom).offset(8);
        make.left.equalTo(_labShopName);
        make.height.equalTo(@17);
        make.width.equalTo(@100);
    }];
    [_txtShopDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopDesc.mas_bottom).offset(8);
        make.left.equalTo(_labShopDesc);
        make.height.equalTo(@50);
        make.right.equalTo(self.contentView.mas_right).offset(-24/3);
    }];
    
    [_lineShopWebsite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_txtShopDesc.mas_bottom).offset(8);
    }];
    
    [_labShopWebsite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineShopWebsite.mas_bottom).offset(8);
        make.left.equalTo(_labShopDesc);
        make.size.equalTo(_labShopDesc);
    }];
    [_labShopWebsiteAr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopWebsite.mas_bottom).offset(8);
        make.left.equalTo(_labShopWebsite);
        make.height.equalTo(@30);
    }];
    
}
-(void)initData{
    //    [self showHudInView:self.view hint:nil];
    //    __weak typeof(self) weakSelf = self;
    //    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"4",@"shopId",nil];
    //    [ZNApi invokePost:ZN_SHOPDETAIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
    //        if (resultObj) {
    //            NSArray *shopModelDic = (NSArray *)resultObj;
    //            NSError *err;
    //            ShopModel *shopModel = [[ShopModel alloc]initWithDictionary:shopModelDic error:&err];
    //        }
    //        [weakSelf hideHud];
    //    }];
    ShopModel *shopModel = self.shopModel;
    [_labShopName setText:shopModel.ShopName];
    [_labShopClass setText:shopModel.ShopENName];
    NSString *imageUrl = @"";
    if ([shopModel.Images count]>0) {
        imageUrl =shopModel.Images[0];
    }
    NSURL *caseurl = [NSURL URLWithString:imageUrl];
    [_imgView sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"default_userhead"]];
    //处理星星
    int stars = (int)[shopModel.Score integerValue];
    for (int i=0 ; i< stars ;i++) {
        UIImageView *imgV = (UIImageView*)_mutArrayStars[i];
        [imgV setImage:[UIImage imageNamed:@"xing02"]];
    }
    if(stars>0){
        [_labScore setText:[NSString stringWithFormat:@"%@分",shopModel.Score]];
    }else{
        [_labScore setText:@"0 分"];
    }
    // 商铺标记
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([shopModel.PX doubleValue],[shopModel.PX doubleValue]);
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.title = shopModel.ShopENName;
    marker.snippet = shopModel.ShopENName;
    marker.map = mapView_;
    
    _txtShopDesc.text = shopModel.desc;
    _labShopWebsiteAr.text = shopModel.website;
    
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
