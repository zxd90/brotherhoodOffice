//
//  CacheTools.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/25.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "CacheTools.h"

@implementation CacheTools
#pragma mark - 获取path路径下文件夹大小
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    //调试
    #ifdef DEBUG
        //如果文件夹不存在或者不是一个文件夹那么就抛出一个异常
        //抛出异常会导致程序闪退，所以只在调试阶段抛出，发布阶段不要再抛了,不然极度影响用户体验
        BOOL isDirectory = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
        if (!isExist || !isDirectory)
        {
            NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"please check your filePath!" userInfo:nil];
            [exception raise];

        }
        NSLog(@"debug");
    //发布
    #else
        NSLog(@"post");
    #endif
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr){
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        // 6. 获取每一个文件的大小
             NSInteger size = [dict[@"NSFileSize"] integerValue];
                // 7. 计算总大小
                totleSize += size;
            }
            //8. 将文件夹大小转换为 M/KB/B
            NSString *totleStr = nil;
            if (totleSize > 1000 * 1000){
                totleStr = [NSString stringWithFormat:@"%.1fM",totleSize / 1000.00f /1000.00f];
                
            }else if (totleSize > 1000){
                totleStr = [NSString stringWithFormat:@"%.1fKB",totleSize / 1000.00f ];
                
            }else{
                totleStr = [NSString stringWithFormat:@"%.1fB",totleSize / 1.00f];
            }
            return totleStr;
        }
#pragma mark - 清除path文件夹下缓存大小
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    // 如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subPathArr.count == 0) {
        ZLog(@"此缓存路径很干净,不需要再清理了");
        return NO;
    }
    NSString *filePath = nil;
    NSError *error = nil;
    BOOL flag = NO;
    for (NSString *subPath in subPathArr) {
        filePath = [path stringByAppendingPathComponent:subPath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:kCachePath]) {
              // 删除子文件夹
              BOOL isRemoveSuccessed =  [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
                if (isRemoveSuccessed) { // 删除成功
                    flag = YES;
                }
            }
        }
    if (NO == flag) {
           
           ZLog(@"提示:您已经清理了所有可以访问的文件,不可访问的文件无法删除");  // 调试阶段才打印
           
       }
    return YES;
}
@end
