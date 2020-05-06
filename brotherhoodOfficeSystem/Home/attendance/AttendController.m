//
//  AttendController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AttendController.h"
#import "ClockView.h"
#import "clockModel.h"
#import "RecordClockvc.h"
@interface AttendController ()<ClockonDelegate,BMKLocationManagerDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置对象
@property (nonatomic, strong) BMKGeoCodeSearch * geocodeSearch;
@property(nonatomic,strong) ClockView *clockon;
@property (nonatomic, assign) CGFloat longitude;  // 经度
@property (nonatomic, assign) CGFloat latitude; // 纬度
@property(nonatomic,strong) NSString *addrstr;//位置
@end

@implementation AttendController
-(void)viewWillDisappear:(BOOL)animated {

    // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.geocodeSearch.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"考勤";
    self.view.backgroundColor =[UIColor whiteColor];
    self.clockon = [[ClockView alloc]initWithFrame:CGRectMake(0, 0,ScreenW,ScreenH-SK_TabbarSafeBottomMargin)];
    self.clockon.clockonDelegate = self;
    [self.view addSubview: self.clockon];
    //如果需要持续定位返回地址信息（需要联网），请设置如下：
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}

#pragma mark - Lazy loading
- (BMKLocationManager *)locationManager {
    if (!_locationManager) {
        //初始化BMKLocationManager类的实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置定位管理类实例的代理
        _locationManager.delegate = self;
        //设定定位坐标系类型，默认为 BMKLocationCoordinateTypeGCJ02
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设定定位精度，可自定义 默认为 kCLLocationAccuracyBest
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        ///设定定位的最小更新距离 默认为 kCLDistanceFilterNone。
        _locationManager.distanceFilter=kCLDistanceFilterNone;
        //设定定位类型，默认为 CLActivityTypeAutomotiveNavigation
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //定位是否会被系统自动暂停
        _locationManager.allowsBackgroundLocationUpdates = YES;
        
       [_locationManager setLocatingWithReGeocode:YES];
        //指定定位是否会被系统自动暂停，默认为NO
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.allowsBackgroundLocationUpdates = NO;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

- (BMKUserLocation *)userLocation {
    if (!_userLocation) {
        //初始化BMKUserLocation类的实例
        _userLocation = [[BMKUserLocation alloc] init];
    }
    return _userLocation;
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error {
    NSLog(@"定位失败");
}
// 定位SDK中，位置变更的回调
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error){
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (location) {
NSLog(@"=======++++++%f",location.location.coordinate.latitude);
        _latitude=location.location.coordinate.latitude;
        _longitude= location.location.coordinate.longitude;
        _addrstr=location.rgcData.locationDescribe;
NSLog(@"=======++++++%f",location.location.coordinate.longitude);
        //反编译
     [self ReverseGeoCode:location.location];
        //加载数据
           [self updatClock];
              if (location.rgcData) {
                  NSLog(@"城市 = %@",location.rgcData.province);
                  NSLog(@"区镇 = %@",location.rgcData.district);
                  NSLog(@"街道 = %@",location.rgcData.street);
                  NSLog(@"街道号 = %@",location.rgcData.streetNumber);
                  NSLog(@"具体描述 = %@",location.rgcData.locationDescribe);
                  NSLog(@"建筑物名称= %@",location.buildingName);
                 

        [NSString stringWithFormat:@"定位地址：%@%@%@%@%@", location.rgcData.province, location.rgcData.district, location.rgcData.street,location.rgcData.streetNumber,location.rgcData.locationDescribe];
              }

    }
}

-(void)Clockontap{
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/clock/doClock",kAPI_URL];
    NSDictionary *dict =@{@"ticket":kFetchMyDefault(@"ticket"),@"latitude":@"114.483211,380.02155",@"time":[YearsTime getHhmmss] ,@"addrName":self.addrstr};
      [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
          NSMutableArray *arr=[NSMutableArray array];
          if ([responseObject[@"code"] intValue]==0) {
              for (NSDictionary *dict in responseObject[@"data"]) {
                clockModel *clmodel=[clockModel clockDetWithDict:dict];
                  [arr addObject:clmodel];
              }
              [ self.clockon addClockonarray:arr addrestr:self.addrstr];
            }
      } failure:^(NSError *error) {
          
      } view:self.view MBPro:YES];
    
    
}
-(void)updatClock{
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/clock/getMyState",kAPI_URL];
    NSDictionary *dict =@{@"ticket":kFetchMyDefault(@"ticket"),@"latitude":[NSString stringWithFormat:@"%f", self.latitude],@"longitude":[NSString stringWithFormat:@"%f",self.longitude]};
    [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
        NSMutableArray *arr=[NSMutableArray array];
        if ([responseObject[@"code"] intValue]==0) {
            for (NSDictionary *dict in responseObject[@"data"]) {
              clockModel *clmodel=[clockModel clockDetWithDict:dict];
                [arr addObject:clmodel];
            }
            [ self.clockon addClockonarray:arr addrestr:self.addrstr];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
   
}
#pragma mark-进入考勤查询
-(void)AccessDateAttendancetap{
    RecordClockvc *recordVC=[[RecordClockvc alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
#pragma mark - <反编译>
-(void)ReverseGeoCode:(CLLocation*)location{
    //初始化请求参数类BMKReverseGeoCodeOption的实例
    BMKReverseGeoCodeSearchOption *reverseGeoCodeOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    //经纬度
    reverseGeoCodeOption.location = location.coordinate;
    //是否访问最新版行政区划数据（仅对中国数据生效）
    reverseGeoCodeOption.isLatestAdmin = YES;
    [self ReversesearchData:reverseGeoCodeOption];
    
}
- (void)ReversesearchData:(BMKReverseGeoCodeSearchOption *)option {
    //初始化BMKGeoCodeSearch实例
    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    //设置反地理编码检索的代理
    geoCodeSearch.delegate = self;
    //初始化请求参数类BMKReverseGeoCodeOption的实例
    BMKReverseGeoCodeSearchOption *reverseGeoCodeOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    // 待解析的经纬度坐标（必选）
    reverseGeoCodeOption.location = option.location;
    //是否访问最新版行政区划数据（仅对中国数据生效）
    reverseGeoCodeOption.isLatestAdmin = option.isLatestAdmin;
    /**
   根据地理坐标获取地址信息：异步方法，返回结果在BMKGeoCodeSearchDelegate的
     onGetAddrResult里
     reverseGeoCodeOption 反geo检索信息类
     成功返回YES，否则返回NO
     */
    BOOL flag = [geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    if (flag) {
        NSLog(@"反地理编码检索成功");
    } else {
        NSLog(@"反地理编码检索失败");
    }
}
#pragma mark - <BMKGeoCodeSearchDelegate>
/**
 反向地理编码检索结果回调
 @param searcher 检索对象
 @param result 反向地理编码检索结果
 @param error 错误码，@see BMKCloudErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    [NSString stringWithFormat:@"%@",result.address];
    //找到了当前位置城市后就关闭服务
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopUpdatingHeading];
  if (error == BMK_SEARCH_NO_ERROR) {
         NSString *address = result.address;  //地址名称
         NSString *sematicDescription = result.sematicDescription;  //结合当前位置POI的语义化结果描述
         NSString *businessCircle = result.businessCircle;  //商圈名称
         BMKAddressComponent *addressDetail = result.addressDetail;  //层次化地址信息
         NSArray *poiList = result.poiList;  //地址周边POI信息，成员类型为BMKPoiInfo
         NSLog(@"我的位置在 %@ 结合当前位置POI的语义化结果描述:%@ 商圈名称:%@ 层次化地址信息:%@ 地址周边POI信息，成员类型为BMKPoiInfo:%@",address,sematicDescription,businessCircle,addressDetail,poiList);
            
     }
}


@end
