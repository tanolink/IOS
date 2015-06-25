//
//  CellShopDetail.m
//  Zouni
//
//  Created by aokuny on 15/5/23.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CellShopDetail.h"
#import "UIButton+Block.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

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
//    GMSMapView *mapView_;
    MKMapView * _mapView;
    
    // 交通信息
    UILabel *_labRoute;
    // 交通描述
    UILabel *_labRouteDesc;
    
    // 评论顶部的线
    UIView *_lineViewComment;
    
    // 店铺顶端的线
    UIView *_lineViewShop;
    // 店铺描述
    UILabel *_labShopDesc;
    UILabel *_txtShopDesc;
    
    // 店铺网址
    UIView *_lineShopWebsite;
    UILabel *_labShopWebsite;
    UILabel *_labShopWebsiteAr;
    // 是否收藏
    BOOL _isSelectFav;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}
-(void) setCellDataForModel:(ShopModel *) shopModel{
    self.shopModel = shopModel;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self initData];
    [self layoutUI];
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
    [_btnShopFavorite setImage:[UIImage imageNamed:@"view_selCollection"] forState:UIControlStateSelected];
    
    _labFavorite = [[UILabel alloc] initWithFrame: CGRectZero];
    [_labFavorite setFont:DEFAULT_FONT(10)];
    [_labFavorite setTextColor:ZN_FONNT_03_LIGHTGRAY];
    [_labFavorite setText:@"收藏"];
    [_labFavorite setTextAlignment:NSTextAlignmentCenter];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZN_BORDER_LINE_COLOR;
    
    _mapView = [[MKMapView alloc]init];
    _mapView.mapType = MKMapTypeStandard;//标准模式
    _mapView.zoomEnabled = YES;//支持缩放
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//显示自己
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self.contentView addSubview: _mapView];
    
    
    _labRoute = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labRoute setFont:DEFAULT_BOLD_FONT(15)];
    [_labRoute setNumberOfLines:0];
    [_labRoute setTextColor:ZN_FONNT_01_BLACK];
    [_labRoute setText:@"交通信息"];
    
    _labRouteDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labRouteDesc setFont:DEFAULT_BOLD_FONT(12)];
    [_labRouteDesc setTextColor:ZN_FONNT_02_GRAY];
    [_labRouteDesc setTextAlignment:NSTextAlignmentLeft];
    [_labRouteDesc setNumberOfLines:0];
    
    _lineViewComment = [[UIView alloc] init];
    _lineViewComment.backgroundColor = ZN_BORDER_LINE_COLOR;
    
    _btnShowComment  = [[UIButton alloc]initWithFrame:CGRectZero];
    [_btnShowComment setTitleColor:ZN_FONNT_01_BLACK forState:UIControlStateNormal];
    [_btnShowComment.titleLabel setFont:DEFAULT_FONT(12)];
    [_btnShowComment.titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    _lineViewShop = [[UIView alloc] init];
    _lineViewShop.backgroundColor = ZN_BORDER_LINE_COLOR;
    
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
    
//    _btnAlbum = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_btnAlbum setImage:[UIImage imageNamed:@"view_img_icon"] forState:UIControlStateNormal];
//    [_btnAlbum setBackgroundImage:[UIImage imageNamed:@"map_titBg"] forState:UIControlStateNormal];
    
    self._btnAlbum = [[UIButton alloc]initWithFrame:CGRectZero];
    [self._btnAlbum.titleLabel setFont:DEFAULT_FONT(10)];
    [self._btnAlbum.titleLabel setTintColor:[UIColor whiteColor]];
    [self._btnAlbum setBackgroundColor:[UIColor blackColor]];
    [self._btnAlbum.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    self._btnAlbum.layer.cornerRadius = 12;
    self._btnAlbum.alpha = 0.7;
    [self._btnAlbum.titleLabel setTintColor:[UIColor blackColor]];
    [self._btnAlbum setImage:[UIImage imageNamed:@"view_img_icon"] forState:UIControlStateNormal];
    [self._btnAlbum setTitleEdgeInsets:UIEdgeInsetsMake(0,3,0,0)];
    [self._btnAlbum setImageEdgeInsets:UIEdgeInsetsMake(4,-4,4,-4)];
    
    
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
//    [self.contentView addSubview: mapView_];
    
    [self.contentView addSubview:_labRoute];
    [self.contentView addSubview:_labRouteDesc];
    
    [self.contentView addSubview:_lineViewComment];
    [self.contentView addSubview:_btnShowComment];
    
    [self.contentView addSubview:_lineViewShop];
    [self.contentView addSubview:_labShopDesc];
    [self.contentView addSubview:_txtShopDesc];
    [self.contentView addSubview:_lineShopWebsite];
    [self.contentView addSubview:_labShopWebsite];
    [self.contentView addSubview:_labShopWebsiteAr];
    
     [self.contentView addSubview:self._btnAlbum];
    
//    [self.contentView addSubview:_bgScrollView];
//    [_labShopDesc setBackgroundColor:[UIColor orangeColor]];
//    [_txtShopDesc setBackgroundColor:[UIColor purpleColor]];
    
}
-(void)layoutUI{
    
//    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
//
    [_btnShopFavorite handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if(_btnShopFavorite.selected){
            NSDictionary *requestDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:
                                         self.shopModel.ShopID,@"shopId",nil];
            [ZNApi invokePost:ZN_DELFAVORITES_API parameters:requestDic1 completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
                if (respModel.success.intValue) {
                    [JGProgressHUD showSuccessStr:@"取消收藏成功！"];
                }
            }];
            _btnShopFavorite.selected = NO;
        }else{
            NSDictionary *requestDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:self.shopModel.ShopID,
                                         @"shopId",nil];
            [ZNApi invokePost:ZN_ADDFAVORITE_API parameters:requestDic1 completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
                if (respModel.success.intValue) {
                    [JGProgressHUD showSuccessStr:@"收藏成功！"];
                }
            }];
            _btnShopFavorite.selected = YES;
        }
    }];

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
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadeView.mas_bottom);
        make.width.equalTo(@(self.contentView.frame.size.width));
        make.height.equalTo(@(326/2-20));
    }];
    
    [_labRoute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mapView.mas_bottom).offset(8);
        make.left.equalTo(_labShopName);
        make.height.equalTo(@17);
        make.width.equalTo(@100);
    }];
    [_labRouteDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labRoute.mas_bottom).offset(8);
        make.left.equalTo(_labRoute);
        make.height.equalTo(@50);
        make.right.equalTo(self.contentView.mas_right).offset(-24/3);
    }];
    
    [_lineViewComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_labRouteDesc.mas_bottom);
    }];
    
    [_btnShowComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineViewComment.mas_bottom).offset(10);
        make.left.equalTo(_labRoute);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    
    [_lineViewShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_btnShowComment.mas_bottom).offset(2);
    }];
    
    [_labShopDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineViewShop.mas_bottom).offset(8);
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
    
    [self._btnAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@25);
    }];
    
}
-(void)initData{
//        [self showHudInView:self.contentView hint:nil];
//        __weak typeof(self) weakSelf = self;
//        NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:self.shopID,@"shopId",nil];
//        [ZNApi invokePost:ZN_SHOPDETAIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
//            if (resultObj) {
//                NSDictionary *shopModelDic = (NSDictionary *)resultObj;
//                NSLog(@"%@",shopModelDic);
//                NSError *err;
//                self.shopModel = [[ShopModel alloc]initWithDictionary:shopModelDic error:&err];
//            }
//        }];
    ShopModel *shopModel = self.shopModel;
    [_labShopName setText:shopModel.ShopName];
    [_labShopClass setText:shopModel.ShopENName];
    
    if(shopModel.FavoriteStatus.intValue){
        _btnShopFavorite.selected = YES;
    }
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
    if (shopModel.Route.length>0) {
        _labRouteDesc.text = shopModel.Route;
    }else{
        _labRouteDesc.text = @"暂无";
    }
    NSString *reviewCountCon;
    if(shopModel.ReviewCount.intValue>0){
        reviewCountCon = [NSString stringWithFormat:@"查看其他%@条评论",shopModel.ReviewCount];
    }else{
        reviewCountCon = @"暂无评论";
        [_btnShowComment setEnabled:NO];
    }
    [_btnShowComment setTitle:reviewCountCon forState:UIControlStateNormal];
    
    _txtShopDesc.text = shopModel.desc;
    _labShopWebsiteAr.text = shopModel.website;
    
    _btnShopFavorite.selected = shopModel.FavoriteStatus.intValue;
    NSDictionary *dicPXY = @{@"PX":shopModel.PX,@"PY":shopModel.PY,
                             @"Title":shopModel.ShopName,@"Desc":shopModel.ShopENName};
    [self zoomToAnnotations : dicPXY and: NO];
    if(shopModel.Images.count>0)
    [self._btnAlbum setTitle:[NSString  stringWithFormat:@"%d",(unsigned int)shopModel.Images.count] forState:UIControlStateNormal];
}

-(void)zoomToAnnotations : (NSDictionary *) dicPXY and: (BOOL) isSel{
    CLLocationCoordinate2D pos = {[dicPXY[@"PX"] doubleValue],[dicPXY[@"PY"] doubleValue]};
    // 添加Annotation
    MKPointAnnotation *annotaion = [[MKPointAnnotation alloc] init];
    annotaion.coordinate = pos;
    annotaion.title = dicPXY[@"Title"];
    annotaion.subtitle = dicPXY[@"Desc"];
    [_mapView addAnnotation: annotaion];
    // 指定新的显示区域
    [_mapView setRegion:MKCoordinateRegionMake(annotaion.coordinate, MKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    // 选中标注
//    [_mapView selectAnnotation:annotaion animated:isSel];
    //    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(zoomToAnnotations) userInfo:nil repeats:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if(annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
//        [annotationView setCanShowCallout:YES];
//                annotationView.image = [self scaleToSize:[UIImage imageNamed:@"map_doc"] size:CGSizeMake(80/3,110/3)];
    }
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateNormal];
//    [button setFrame:CGRectMake(0,0,15, 15)];
//    annotationView.rightCalloutAccessoryView =  button;
    
//    annotationView.pinColor = MKPinAnnotationColorRed;// 标注点颜色
//    annotationView.animatesDrop = YES;
//    annotationView.opaque = NO;
//    annotationView.draggable = YES;
//    annotationView.selected = YES;
    
        annotationView.calloutOffset = CGPointMake(15, 15);
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_doc"]];
        annotationView.leftCalloutAccessoryView = imageView;
    return annotationView;
}
#pragma mark MKMapViewDelegate的代理方法

//更新当前位置调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 点击我的位置
    //    _mapView.centerCoordinate = userLocation.location.coordinate;
    self.nowCoords = [userLocation coordinate];
    
}
//选中注释图标
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    //    NSLog(@"111");
//    NSLog(@"%@",view);
//    MKPinAnnotationView *s = (MKPinAnnotationView *)view;
//    MKPointAnnotation *p = (MKPointAnnotation*)s.annotation;
//    self.addressStr =  p.title;
//    self.naviCoordsGd  = p.coordinate;
//    self.naviCoordsBd = p.coordinate;
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
