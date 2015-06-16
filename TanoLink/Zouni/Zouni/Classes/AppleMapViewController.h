//
//  AppleMapViewController.h
//  Zouni
//
//  Created by aokuny on 15/6/11.
//  Copyright (c) 2015年 TanaLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppleMapViewController : ZNBaseViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>
/*地图核心坐标X*/
@property(nonatomic,strong) NSString *mainPX;
/*地图核心坐标Y*/
@property(nonatomic,strong) NSString *mainPY;
/*级别*/
@property(nonatomic,strong) NSString *mainZoom;
/*地图Maker坐标*/
@property(nonatomic,strong) NSArray *PXYList;
@property(nonatomic,retain) CLLocationManager* locationmanager;
@property(nonatomic,retain) CLGeocoder* geocoder;



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
