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
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BMKLocationKit/BMKLocationComponent.h>
//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchResult.h>
@interface AttendController ()<ClockonDelegate,BMKLocationManagerDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationProvider *_locService;  //定位

    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
}
@property(nonatomic,strong) ClockView *clockon;
@property (nonatomic, assign) CGFloat longitude;  // 经度
@property (nonatomic, assign) CGFloat latitude; // 纬度
@end

@implementation AttendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"考勤";
    self.view.backgroundColor =[UIColor whiteColor];
    self.clockon = [[ClockView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin)];
           self.clockon.clockonDelegate = self;
       [self.view addSubview: self.clockon];
    [self updatClock];
}
-(void)Clockontap{
    
}
-(void)updatClock{
 
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/clock/getMyState",kAPI_URL];
    NSDictionary *dict =@{@"ticket":kFetchMyDefault(@"ticket"),@"coor":@"114.483211,380.02155"};
    [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
        NSMutableArray *arr=[NSMutableArray array];
        if ([responseObject[@"code"] intValue]==0) {
NSArray *arre= @[@{@"time":@"11:20:00",@"clockAddr":@"盛景大厦",@"clockTime":@"11:20:00",@"realClockAddr":@"11:20:00"},@{@"time":@"11:20:00",@"clockAddr":@"盛景大厦",@"clockTime":@"11:20:00"}];
            for (NSDictionary *dict in responseObject[@"data"]) {
              clockModel *clmodel=[clockModel clockDetWithDict:dict];
                [arr addObject:clmodel];
            }
            [ self.clockon addClockonarray:arr];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
   
}
/*
- (void)startLocation
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //启动LocationService
    [_locService startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
   // NSLog(@"当前位置信息：didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //地理反编码
    _latitude=userLocation.location.coordinate.latitude;
    _longitude=userLocation.location.coordinate.longitude;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
       // NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
       // NSLog(@"反geo检索发送失败");
    }
}
 //地图定位
 - (BMKLocationService *)locationService
 {
     if (!_locationService)
     {
         _locationService = [[BMKLocationService alloc] init];
         _locationService.delegate = self;
     }
     return _locationService;
 }
 //检索对象
 - (BMKGeoCodeSearch *)geocodeSearch
 {
     if (!_geocodeSearch)
     {
         _geocodeSearch = [[BMKGeoCodeSearch alloc] init];
         _geocodeSearch.delegate = self;
     }
     return _geocodeSearch;
 }
 #pragma mark ----反向地理编码
 - (void)reverseGeoCodeWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
 {
     
     //发起反向地理编码检索
     CLLocationCoordinate2D coor;
     coor.latitude = [latitude doubleValue];
     coor.longitude = [longitude doubleValue];
     BMKReverseGeoCodeSearchOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc] init];
     reverseGeocodeSearchOption.location = coor;
     BOOL flag = [self.geocodeSearch reverseGeoCode:reverseGeocodeSearchOption];;
     if (flag)
     {
         NSLog(@"反地理编码成功");
     }
     else
     {
         NSLog(@"反地理编码失败");
     }
 }
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    //NSLog(@"address:%@----%@",result.addressDetail,result.address);
    _ctiy=[NSString stringWithFormat:@"%@",result.address];
    //找到了当前位置城市后就关闭服务
    [_locService stopUserLocationService];
    //addressDetail:     层次化地址信息
    
    //address:    地址名称
    
    //businessCircle:  商圈名称
    
    // location:  地址坐标
    
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
  if (error == BMK_SEARCH_NO_ERROR) {
         NSString *address = result.address;  //地址名称
         NSString *sematicDescription = result.sematicDescription;  //结合当前位置POI的语义化结果描述
         NSString *businessCircle = result.businessCircle;  //商圈名称
         BMKAddressComponent *addressDetail = result.addressDetail;  //层次化地址信息
         NSArray *poiList = result.poiList;  //地址周边POI信息，成员类型为BMKPoiInfo
         NSLog(@"我的位置在 %@ 结合当前位置POI的语义化结果描述:%@ 商圈名称:%@ 层次化地址信息:%@ 地址周边POI信息，成员类型为BMKPoiInfo:%@",address,sematicDescription,businessCircle,addressDetail,poiList);
                 [self.locationService stopUserLocationService]; //定位取消
     }
}
*/
@end
