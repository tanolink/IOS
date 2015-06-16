//
//  HYBLocationManager.m
//  MMLocationManager
//
//  Created by sixiaobo on 14-7-17.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import "MapViewController.h"

#define  kLatestLongitude        @"kLatestLongitudeKey"  // 最新一次保存的纬度
#define  kLatestLatitude         @"kLatestLatitudeKey"   // 最新一次保存的经度
#define  kLatestStockAddress     @"kLatestStockAddress"  // 最新一次保存的库存地址
#define  kLatestCityID           @"kLatestCityID"        // 最新一次保存的地址

@interface HYBLocationManager (){
    NSUserDefaults *kUserDefaults;
}

@property (nonatomic, copy) HYBLocateCoordinateBlock locateCoordinateBlock;
@property (nonatomic, copy) HYBAddressBlock          addressBlock;
@property (nonatomic, copy) HYBLocationErrorBlock    errorBlock;

@end

@implementation HYBLocationManager

+ (HYBLocationManager *)sharedLocation {
    static HYBLocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedManager) {
            sharedManager = [[[self class] alloc] init];
        }
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.latestStockAddress = [defaults objectForKey:kLatestStockAddress];
        self.latestCityID = [defaults objectForKey:kLatestCityID];
        
        if (self.latestStockAddress == nil || self.latestCityID) {
            self.latestStockAddress = @"北京市|朝阳区";
            self.latestCityID = @"1,1,0";  // 北京省|北京市|朝阳区
            [defaults setObject:self.latestStockAddress forKey:kLatestStockAddress];
            [defaults setObject:self.latestCityID forKey:kLatestCityID];
            [defaults synchronize];
        }
        
        float longtitude = [defaults floatForKey:kLatestLongitude];
        float latitude = [defaults floatForKey:kLatestLatitude];
        self.latestCoordinate = CLLocationCoordinate2DMake(latitude, longtitude);
        self.isDeniedToAccessLocation = NO;
    }
    return self;
}

/*!
 *  @brief 获取地理坐标
 *  @param locationCoordinateBlock 获取到的地理坐标信息会在这个block中返回
 */
- (void)locateCoordinate:(HYBLocateCoordinateBlock)locateCoordinateBlock {
    self.locateCoordinateBlock = [locateCoordinateBlock copy];
    [self startLocating];
    return;
}

/*!
 *  @brief 获取坐标和地址
 *  @param coordinateBlock 获取到的地理坐标信息会在这个block中返回
 *  @param addressBlock    获取到的地址信息
 */
- (void)locateCoordinate:(HYBLocateCoordinateBlock)coordinateBlock
                 address:(HYBAddressBlock)addressBlock {
    self.locateCoordinateBlock = [coordinateBlock copy];
    self.addressBlock = [addressBlock copy];
    
    [self startLocating];
    return;
}

/*!
 *  @brief 获取地址
 *  @param addressBlock 获取到的地址信息
 */
- (void)locateAddress:(HYBAddressBlock)addressBlock error:(HYBLocationErrorBlock)errorBlock {
    self.addressBlock = [addressBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocating];
    return;
}

#pragma mark - Private
// 启动定位
- (void)startLocating {
    if (self.mapView) { // 每次定位时先销毁之前的
        self.mapView.delegate = nil;
        self.mapView = nil;
    }
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES; // 打开定位功能
    
    return;
}

// 停止定位
- (void)stopLocation {
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
    _mapView = nil;
    return;
}

- (void)setLatestCityID:(NSString *)lastestCityID {
    if (_latestCityID != lastestCityID) {
        _latestCityID = nil;
        _latestCityID = [lastestCityID copy];
    }
    [kUserDefaults setObject:_latestCityID forKey:kLatestCityID];
    [kUserDefaults synchronize];
    return;
}

- (void)setLatestStockAddress:(NSString *)latestStockAddress {
    if (_latestStockAddress != latestStockAddress) {
        _latestStockAddress = nil;
        _latestStockAddress = [latestStockAddress copy];
    }
    [kUserDefaults setObject:latestStockAddress forKey:kLatestStockAddress];
    [kUserDefaults synchronize];
    return;
}

#pragma mark - MKMapViewDelegate
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"开始定位");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    if ([self.showNetworkStateInController respondsToSelector:@selector(startNetworkAnimating)]) {
//        [self.showNetworkStateInController startNetworkAnimating];
//    }
    return;
}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    NSLog(@"停止定位");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    if ([self.showNetworkStateInController respondsToSelector:@selector(stopNetworkAnimating)]) {
//        [self.showNetworkStateInController stopNetworkAnimating];
//    }
    return;
}

// 定位失败处理
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [self stopLocation];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (error.code == kCLErrorDenied) {
        self.isDeniedToAccessLocation = YES;
    }
    if (self.errorBlock) {
        self.errorBlock(error);
    }
//    if ([self.showNetworkStateInController respondsToSelector:@selector(stopNetworkAnimating)]) {
//        [self.showNetworkStateInController stopNetworkAnimating];
//    }
    return;
}

// 定位成功处理
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocation *newLocation = userLocation.location;
    self.latestCoordinate = mapView.userLocation.location.coordinate;
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    // 保存地理坐标
    [standard setObject:@(self.latestCoordinate.longitude) forKey:kLatestLongitude];
    [standard setObject:@(self.latestCoordinate.latitude) forKey:kLatestLatitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 地理编码器
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 地理位置反编码
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            for (NSString *value in addressDic.allValues) {
                NSLog(@"value: %@", value);
            }
            NSString *state       = [addressDic objectForKey:@"State"];       // 省份名称
            NSString *city        = [addressDic objectForKey:@"City"];        // 城市名称
            NSString *district = [addressDic objectForKey:@"SubLocality"];    // 区
            self.latestStockAddress = [NSString stringWithFormat:@"%@|%@|%@",
                                       state, city ? city : state, district];
            [standard setObject:self.latestStockAddress forKey:kLatestStockAddress];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self stopLocation];
        
        if (self.locateCoordinateBlock) {
            self.locateCoordinateBlock(self.latestCoordinate);
            self.locateCoordinateBlock = nil;
        }
        
        if (self.addressBlock) {
            self.addressBlock(self.latestStockAddress);
            self.addressBlock = nil;
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        if ([self.showNetworkStateInController respondsToSelector:@selector(stopNetworkAnimating)]) {
//            [self.showNetworkStateInController stopNetworkAnimating];
//        }
    }];
    return;
}

@end
