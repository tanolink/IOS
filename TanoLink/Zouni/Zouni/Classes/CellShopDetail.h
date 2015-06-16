//
//  CellShopDetail.h
//  Zouni
//
//  Created by aokuny on 15/5/23.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"
#import "UIButton+WebCache.h"
//#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import "ShopModel.h"

@interface CellShopDetail : UITableViewCell<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)ShopModel *shopModel;
@property(nonatomic,strong)NSString *shopID;
-(void) setCellDataForModel:(ShopModel *) shopModel;

//导航目的地2d,百度
@property(nonatomic,assign) CLLocationCoordinate2D naviCoordsBd;
//导航目的地2d,高德
@property(nonatomic,assign) CLLocationCoordinate2D naviCoordsGd;
//user最新2d
@property(nonatomic,assign) CLLocationCoordinate2D nowCoords;
//最近一次成功查询2d
@property(nonatomic,assign) CLLocationCoordinate2D lastCoords;
//最近一次请求的中心2d
@property(nonatomic,assign) CLLocationCoordinate2D centerCoordinate;
// 地址
@property(nonatomic,strong) NSString *addressStr;

@property(nonatomic,strong) NSDictionary *navDic;

@end
