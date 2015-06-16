//
//  KitMapViewController.m
//  Zouni
//
//  Created by aokuny on 15/6/9.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "KitMapViewController.h"

@interface KitMapViewController (){
    MKMapView * _mapView;
}

@end

@implementation KitMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.mapType = MKMapTypeStandard;//标准模式
//    _mapView.showsUserLocation = YES;//显示自己
    _mapView.zoomEnabled = YES;//支持缩放
    _mapView.delegate = self;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    
    CLLocationCoordinate2D pos = {35.700852, 139.771860};
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(pos,2000, 2000);//以pos为中心，显示2000米
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];//适配map view的尺寸
    [_mapView setRegion:adjustedRegion animated:YES];
    [self.view addSubview: _mapView];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(zoomToAnnotations) userInfo:nil repeats:NO];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0,0,15, 15)];
    
    [self.view addSubview:button];
    
    
    _locationmanager = [[CLLocationManager alloc]init];
    //设置定位的精度
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    //实现协议
    _locationmanager.delegate = self;
    //开始定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [_locationmanager requestWhenInUseAuthorization ];
    }
    [_locationmanager startUpdatingLocation];

}

-(void)zoomToAnnotations {
    CLLocationCoordinate2D pos = {35.700852, 139.771860};
    // 添加Annotation
    MKPointAnnotation *annotaion = [[MKPointAnnotation alloc] init];
    annotaion.coordinate = pos;
    annotaion.title = @"唐吉坷得";
    annotaion.subtitle = @"秋叶原店";
    [_mapView addAnnotation: annotaion];

    // 指定新的显示区域
    [_mapView setRegion:MKCoordinateRegionMake(annotaion.coordinate, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    // 选中标注
    [_mapView selectAnnotation:annotaion animated:YES];
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
//    annotationView.rightCalloutAccessoryView =  button;
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
     // [manager stopUpdatingLocation];
 }
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"ddddddddddddddddddddddddddddddddddddddddddddddddddddd");
}
#pragma mark MKMapViewDelegate的代理方法

//更新当前位置调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
}
//选中注释图标
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"ssssssssssss");
}
//地图的显示区域改变了调用
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
