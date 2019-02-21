//
//  SSLocationTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/7.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSLocationTool.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface SSLocationTool()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>

@property (nonatomic, strong) BMKLocationManager *locationManager;

@end

@implementation SSLocationTool

static SSLocationTool * tools = nil;
+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[SSLocationTool alloc]init];
    });
    return tools;
}

- (void)startLocation
{
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"TALOsbEmPWzt7lm5QqGWaqC8yfD9AQjb" authDelegate:self];
}

- (void)startLongTimeLocation
{
    self.locationManager = [[BMKLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    self.locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
//    self.locationManager.allowsBackgroundLocationUpdates = YES;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
    self.locationManager.locationTimeout = 10;
    self.locationManager.reGeocodeTimeout = 10;
    
    //开始定位
    [    self.locationManager startUpdatingLocation];
    //结束定位
    //[    self.locationManager stopUpdatingLocation];

}

#pragma mark - BMKLocationManagerDelegate
/**
 *  @brief 连续定位回调函数。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param location 定位结果，参考BMKLocation。
 *  @param error 错误信息。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error{
    
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(39.911914, 116.509640);
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(coordinate2D.latitude,coordinate2D.longitude ));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(location.location.coordinate.latitude,location.location.coordinate.longitude));
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    if (distance < 100) {
        [ProgressHUD showSuccess:@"您已经到达指定地点"];
        
    }
}

- (void)sendMessageCode:(NSString *)code
{
//    https://192.168.1.18:8092/base/posiSms?phone=13366100567&code=19101
    
    //抽奖的说明
    SSAccount *account = [SSAccountTool share].account;
      NSString *url = [NSString stringWithFormat:@"%@?phone=%@&code=%@",SendMessageCode,account.phone,code];
    [FZHttpTool get:url parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
    } failure:^(NSError * _Nullable error) {
        
    }];
 }

/**
 * @brief 该方法为BMKLocationManager提供设备朝向的回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param heading 设备的朝向结果
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading{
    
}

- (void)initBaiduLocationCallBack:(void(^)(NSString *obj))callBack
{
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    //_locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            
            if (location.location) {
                NSLog(@"LOC = %@",location.location);
            }
            if (location.rgcData) {
                NSLog(@"rgc = %@",[location.rgcData description]);
            }
            callBack(location.rgcData.locationDescribe);
        }
        NSLog(@"netstate = %d",state);
        
    }];
}

- (void)fetchLocation
{
   
}


@end
