//
//  MapViewController1.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/6.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "MapViewController1.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "Repair.h"
#import "SVProgressHUD.h"

#import "UIImage+Rotate.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface MapViewController1 ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
//地址
@property (weak, nonatomic) IBOutlet UILabel *location;

//用户纬度
@property (nonatomic, copy, readonly) NSString *locaLatitude;

//用户经度
@property (nonatomic, copy, readonly) NSString *locaLongitude;

@property (nonatomic, strong)Repair *repair;
@end

@implementation MapViewController1
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSLog(@"请打开您的位置服务!");
    }
    self.navigationController.navigationBarHidden = YES;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.centerCoordinate = (CLLocationCoordinate2D){30.663479,104.072292};
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    [_locService startUserLocationService];
    _locService.distanceFilter = 200.0f;
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    [self onClickReverseGeocode];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signUp:) name:@"signUpInfoList" object:nil];
}

#pragma mark 地图将要消失
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    
    _locService = [[BMKLocationService alloc]init];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        //初始化BMKLocationService
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64+56, WIDTH, HEIGHT-64-56)];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.zoomLevel = 14;//地图的级别
    _repair = [[Repair alloc] init];
    
    [self.view addSubview:_mapView];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(WIDTH/2-50, HEIGHT-100, 120, 60);
    btn.backgroundColor=XN_COLOR_GREEN_MINT;
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=20;
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view from its nib.
}
- (void)signUp:(NSNotification *)bitice{
    if ([bitice.userInfo[@"code"] isEqualToNumber:@0]){
        [SVProgressHUD showSuccessWithStatus:@"签到成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"签到失败"];
    }
}


- (void)btnclick
{
    [_repair signUpInfoList:_class_id lng:_locaLongitude lat:_locaLatitude location:_location.text];
    
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}

- (IBAction)fanhui:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//反向地理编码
- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"我是谁%@",result.address);
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        NSLog(@"%@",result.address);
        _location.text = [NSString stringWithFormat:@"%@",item.title];
        _mapView.centerCoordinate = result.location;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//获取我的地址
- (void)onClickReverseGeocode
{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    _locaLatitude = [NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.latitude];
    _locaLongitude = [NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.longitude];
    if (_locaLongitude != nil && _locaLatitude != nil) {
        pt = (CLLocationCoordinate2D){[_locaLatitude floatValue], [_locaLongitude floatValue]};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//用户位置更新后，会调用此函数
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [self onClickReverseGeocode];
}

@end
