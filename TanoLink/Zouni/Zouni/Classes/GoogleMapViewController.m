//
//  GoogleMapViewController.m
//  Zouni 地图页面
//
//  Created by aokuny on 15/5/12.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "GoogleMapViewController.h"

@interface GoogleMapViewController ()

@end

@implementation GoogleMapViewController{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //北京 39.9024510000,116.4273010000
    // 创建一个GMSCameraPosition,告诉map在指定的zoom level下显示指定的点
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:39.9024510000
                                                            longitude:116.4273010000
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    self.view = mapView_;

    // 在map中间做一个标记
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(39.9076298843,116.4759538808);
    marker.appearAnimation = kGMSMarkerAnimationPop;

    marker.title = @"中青旅";
    marker.snippet = @"万达广场";
    marker.map = mapView_;
    

    //// 定位我的位置
    //// Listen to the myLocation property of GMSMapView.
//    [mapView_ addObserver:self
//               forKeyPath:@"myLocation"
//                  options:NSKeyValueObservingOptionNew
//                  context:NULL];

    
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
}
#pragma mark - KVO updates
//
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context {
//    if (!firstLocationUpdate_) {
//        // If the first location update has not yet been recieved, then jump to that
//        // location.
//        firstLocationUpdate_ = YES;
//        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
//        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
//                                                         zoom:14];
//    }
//}
//- (void)dealloc {
//    [mapView_ removeObserver:self
//                  forKeyPath:@"myLocation"
//                     context:NULL];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
