//
//  HYBLocationManager.h
//  MMLocationManager
//
//  Created by sixiaobo on 14-7-17.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "HYBSuperBaseViewController.h"

/*!
 * @brief 地图相关功能封装类，提供获取地理坐标功能、获取地理坐标和地址功能、获取地址功能、
 *        获取城市功能
 */
@interface HYBLocationManager : NSObject <MKMapViewDelegate>

// 定位时会加载到此mapView上，但Frame是CGRectZero,所以如果要显示此视图，需要在外部手动修改
@property (nonatomic, strong) MKMapView              *mapView;

// 最近一次保存下来的用户的地理位置（经纬度）
@property (nonatomic, assign) CLLocationCoordinate2D latestCoordinate;

// 最近一次保存下来的cityid，格式为@"1,1,0"，分别是省ID，市ID，区ID，其中区ID如果没有，则可设置为0
@property (nonatomic, copy)   NSString               *latestCityID;

// 最近一次保存下来的库存地址，如北京省|北京市|朝阳区（非定位得到）
// 最近一次在保存下来的地址信息,这个是通过定位得到的信息，（下面的是定位得到）
// 如，
// 1、直辖市：@"北京市|北京市",
// 2、自治区的：@"广西壮族自治区|南宁市",
// 3、正常省份：@"广东省|中山市"
@property (nonatomic, copy)   NSString               *latestStockAddress;
@property (nonatomic, assign) BOOL                   isUsingLocation; // 是否是通过定位的

// 是否是用户选择了取消台允许用户访问用户位置
@property (nonatomic, assign) BOOL                   isDeniedToAccessLocation;
// 转圈圈显示需要的时候，就需要传这个参数
//@property (nonatomic, weak)   HYBSuperBaseViewController *showNetworkStateInController;

// 单例方法
+ (HYBLocationManager *)sharedLocation;

/*!
 *  @brief 获取地理坐标
 *  @param locationCoordinateBlock 获取到的地理坐标信息会在这个block中返回
 */
// lc2d 即是定位到的地理坐标
typedef void (^HYBLocateCoordinateBlock)(CLLocationCoordinate2D lc2d);
- (void)locateCoordinate:(HYBLocateCoordinateBlock)locateCoordinateBlock;

/*!
 *  @brief 获取坐标和地址
 *  @param coordinateBlock 获取到的地理坐标信息会在这个block中返回
 *  @param addressBlock    获取到的地址信息
 */
// lc2d 即是定位到的地理坐标
typedef void (^HYBAddressBlock)(NSString *address);
- (void)locateCoordinate:(HYBLocateCoordinateBlock)coordinateBlock
                 address:(HYBAddressBlock)addressBlock;

/*!
 *  @brief 获取地址
 *  @param addressBlock 获取到的地址信息
 */
typedef void (^HYBLocationErrorBlock) (NSError *error);
- (void)locateAddress:(HYBAddressBlock)addressBlock error:(HYBLocationErrorBlock)errorBlock;

@end