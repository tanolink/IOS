//
//  GoogleMapViewController.h
//  Zouni
//
//  Created by aokuny on 15/5/12.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GoogleMapViewController : ZNBaseViewController
/*地图核心坐标X*/
@property(nonatomic,strong) NSString *mainPX;
/*地图核心坐标Y*/
@property(nonatomic,strong) NSString *mainPY;
/*级别*/
@property(nonatomic,strong) NSString *mainZoom;
/*地图Maker坐标*/
@property(nonatomic,strong) NSArray *PXYList;
@end
