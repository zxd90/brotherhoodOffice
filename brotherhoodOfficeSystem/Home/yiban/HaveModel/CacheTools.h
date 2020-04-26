//
//  CacheTools.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/25.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheTools : NSObject
/*
 *  获取path路径下文件夹的大小
 *  @param path 要获取的文件夹 路径
 *  @return 返回path路径下文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;
/**
 *  清除path路径下文件夹的缓存
 *  @param path  要清除缓存的文件夹 路径
 *
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
