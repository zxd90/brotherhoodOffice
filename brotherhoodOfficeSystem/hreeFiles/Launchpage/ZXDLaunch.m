//
//  ZXDLaunch.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/5/6.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ZXDLaunch.h"
@implementation ZXDLaunch

/**
 *  初始化广告页面
 */
+ (void)getAdvertisingImage {
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/startAdvertising",kAPI_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求超时时间
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 180.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *imageUrl=responseObject[@"data"][@"imgPath"];
             kSaveMyDefault(@"adImageName",imageUrl);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
       }];
   
}


@end
