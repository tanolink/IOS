//
//  KitMapViewController.h
//  Zouni
//
//  Created by aokuny on 15/6/9.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KitMapViewController : ZNBaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

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
@end
