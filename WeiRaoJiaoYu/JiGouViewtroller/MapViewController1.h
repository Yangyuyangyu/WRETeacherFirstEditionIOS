//
//  MapViewController1.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/6/6.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface MapViewController1 : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService *_locService;
    BMKPointAnnotation* pointAnnotation;
}

@property (nonatomic, strong, readonly)BMKGeoCodeSearch* geocodesearch;//地图编码

@property (nonatomic, copy) NSString *class_id;
@end
