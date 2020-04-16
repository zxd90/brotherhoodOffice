//
//  ZXDNetworking.h
//  Administration
//
//  Created by zhang on 2017/2/14.
//  Copyright © 2017年 九尾狐. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id responseObject);

/** 请求失败的Block */
typedef void(^Failure)(NSError *error);
@interface ZXDNetworking : NSObject

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString *)encryptStringWithMD5:(NSString *)inputStr;
//多余的cell线去掉
+(void)setExtraCellLineHidden: (UITableView *)tableView;
+(NSString*)substringToIndexString:(NSString*)string;
/**
 上传多张图片

 @param images 图片二进制数组
 @param success 成功回调Block
 @param failure 失败回调Block
 */
+ (void)POST:(NSString*)URLString parameters:(NSDictionary *)parameters uploadImageArrayWithImages:(NSArray<NSData *> *)images success:(void (^)(NSDictionary *obj))success failure:(void (^)(NSError *error))failure view:(UIView*)view;
/**
 *  封装的GET请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure view:(UIView*)view MBPro:(BOOL)MBPor;

/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure view:(UIView*)view;
/**
 *  封装POST图片上传(多张图片) // 可扩展成多个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picArray   存放图片模型(HDPicModle)的数组
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
@end
