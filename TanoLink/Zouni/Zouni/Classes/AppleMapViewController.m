//
//  AppleMapViewController.m
//  Zouni
//
//  Created by aokuny on 15/6/11.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "AppleMapViewController.h"
#import "LocationChange.h"
#import "CheckInstalledMapAPP.h"
#import "UIButton+Block.h"

@interface AppleMapViewController (){
    MKMapView * _mapView;
}

@end

@implementation AppleMapViewController
-(void)loadView{
    [super loadView];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressStr = @"";
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.mapType = MKMapTypeStandard;//标准模式
    _mapView.zoomEnabled = YES;//支持缩放
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//显示自己
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self.view addSubview: _mapView];
    
    UIButton * buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"map_back"] forState:UIControlStateNormal];
    [buttonBack setFrame:CGRectMake(15,20,40,40)];
    [buttonBack handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self goBack];
    }];
    [self.view addSubview:buttonBack];
    
    UIButton * buttonLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLocation setImage:[UIImage imageNamed:@"map_current"] forState:UIControlStateNormal];
//    [buttonLocation setFrame:CGRectMake(15,self.view.bounds.size.height-44-15,44,44)];
    [buttonLocation handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self myLocation];
    }];
    [self.view addSubview:buttonLocation];
    [buttonLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
    
    if([self.PXYList count]>0){
        for (NSDictionary *dicPXY in self.PXYList) {
            [self zoomToAnnotations : dicPXY and: NO];
        }
    }else{
        for (NSDictionary *dicPXY in self.PXYList) {
            [self zoomToAnnotations : dicPXY and: YES];
        }
    }

    _locationmanager = [[CLLocationManager alloc]init];
    //设置定位的精度
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationmanager setDistanceFilter:kCLDistanceFilterNone];
    [_locationmanager setDelegate:self];
    //开始定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [_locationmanager requestWhenInUseAuthorization ];
    }
    [_locationmanager startUpdatingLocation];
}
-(void) goBack {
    [self.navigationController popViewControllerAnimated:YES];

}
-(void) myLocation{
    
    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
    theRegion.span.longitudeDelta= 0.005f;
    theRegion.span.latitudeDelta= 0.005f;
    CLLocationCoordinate2D coords = _mapView.userLocation.location.coordinate;
    theRegion.center.latitude=coords.latitude;
    theRegion.center.longitude =coords.longitude;
    [_mapView setRegion:theRegion animated:YES];
    
}
-(void)zoomToAnnotations : (NSDictionary *) dicPXY and: (BOOL) isSel{
    //    CLLocationCoordinate2D pos = {35.700852, 139.771860};
    CLLocationCoordinate2D pos = {[dicPXY[@"PX"] doubleValue],[dicPXY[@"PY"] doubleValue]};
    // 添加Annotation
    MKPointAnnotation *annotaion = [[MKPointAnnotation alloc] init];
    annotaion.coordinate = pos;
    annotaion.title = dicPXY[@"Title"];
    annotaion.subtitle = dicPXY[@"Desc"];
    [_mapView addAnnotation: annotaion];
    // 指定新的显示区域
    [_mapView setRegion:MKCoordinateRegionMake(annotaion.coordinate, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    // 选中标注
    [_mapView selectAnnotation:annotaion animated:isSel];
    //    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(zoomToAnnotations) userInfo:nil repeats:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if(annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
        [annotationView setCanShowCallout:YES];
        //        annotationView.image = [self scaleToSize:[UIImage imageNamed:@"map_doc"] size:CGSizeMake(80/3,110/3)];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0,0,15, 15)];
    annotationView.rightCalloutAccessoryView =  button;
    //    annotationView.pinColor = MKPinAnnotationColorRed;// 标注点颜色
    //    annotationView.animatesDrop = YES;
    annotationView.opaque = NO;
    annotationView.draggable = YES;
    annotationView.selected = YES;
    
    //    annotationView.calloutOffset = CGPointMake(15, 15);
    //    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_doc"]];
    //    annotationView.leftCalloutAccessoryView = imageView;
    return annotationView;
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
#pragma mark - 检测应用是否开启定位服务
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            [self openGPSTips];
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}
-(void)openGPSTips{
    UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alet show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation* location in locations) {
        NSLog(@"%@",location);
    }
    //停止定位
     [manager stopUpdatingLocation];
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self doAcSheet];
}

-(void)doAcSheet{
    NSArray *appListArr = [CheckInstalledMapAPP checkHasOwnApp];
    NSString *sheetTitle = [NSString stringWithFormat:@"导航到 %@",self.addressStr];
    
    UIActionSheet *sheet;
    if ([appListArr count] == 2) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1], nil];
    }else if ([appListArr count] == 3){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2], nil];
    }else if ([appListArr count] == 4){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3], nil];
    }else if ([appListArr count] == 5){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3],appListArr[4], nil];
    }
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == 0) {
            CLLocationCoordinate2D to;
            to.latitude = self.naviCoordsGd.latitude;
            to.longitude = self.naviCoordsGd.longitude;
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            toLocation.name = self.addressStr;
            [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil] launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }
    if ([btnTitle isEqualToString:@"google地图"]) {
        NSString *urlStr = [NSString stringWithFormat:@"comgooglemaps://?saddr=%.8f,%.8f&daddr=%.8f,%.8f&directionsmode=transit",self.nowCoords.latitude,self.nowCoords.longitude,self.naviCoordsGd.latitude,self.naviCoordsGd.longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }else if ([btnTitle isEqualToString:@"高德地图"]){
       NSString *strUrl = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=broker&backScheme=openbroker2&poiname=%@&poiid=BGVIS&lat=%.8f&lon=%.8f&dev=1&style=2",@"",self.naviCoordsGd.latitude,self.naviCoordsGd.longitude];
        NSURL *nsurl =[NSURL URLWithString:strUrl];
        [[UIApplication sharedApplication] openURL:nsurl];
        
    }else if ([btnTitle isEqualToString:@"百度地图"]){
        double bdNowLat,bdNowLon;
        bd_encrypt(self.nowCoords.latitude, self.nowCoords.longitude, &bdNowLat, &bdNowLon);
        
        NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%.8f,%.8f&destination=%.8f,%.8f&&mode=driving",bdNowLat,bdNowLon,self.naviCoordsBd.latitude,self.naviCoordsBd.longitude];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }else if ([btnTitle isEqualToString:@"显示路线"]){
        [self drawRout];
    }
}
-(void)drawRout{
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.nowCoords addressDictionary:nil];
    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:self.naviCoordsGd addressDictionary:nil];
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKMapItem *toItem   = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    
//    [self.regionMapView removeOverlays:self.regionMapView.overlays];
//    
//    if (ISIOS7) {//ios7采用系统绘制方法
//        [self.regionMapView removeOverlays:self.regionMapView.overlays];
//        [self findDirectionsFrom:fromItem to:toItem];
//    }else{//ios7以下借用google路径绘制方法
//        if (routes) {
//            routes = nil;
//        }
//        routes = [self calculateRoutesFrom];
//        [self updateRouteView];
//        [self centerMap];
//    }
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
//    NSLog(@"111");
    NSLog(@"%@",view);
    MKPinAnnotationView *s = (MKPinAnnotationView *)view;
    MKPointAnnotation *p = (MKPointAnnotation*)s.annotation;
    self.addressStr =  p.title;
    self.naviCoordsGd  = p.coordinate;
    self.naviCoordsBd = p.coordinate;
}
//地图的显示区域改变了调用
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
