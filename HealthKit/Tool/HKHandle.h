//
//  HKHandle.h
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <HealthKit/HealthKit.h>
@import HealthKit;

@interface HKHandle : NSObject

// HealthKit 实例
+ (HKHealthStore *)singleStore;
// 默认要访问的HealthKit权限
+ (NSSet *)defaultHKSet;
// 请求获取HealthKit权限
+ (void)requsetDefaultAuth:(void(^)(BOOL suc, NSString *msg))complention;
// 写入数据的设备信息
+ (HKDevice *)defaultDevice;
// 读取健康数据
+ (void)readDataWithSampleType:(HKSampleType *)type completion:(void(^)(NSArray *results, NSError *error))completion;
+ (void)readStatisticsDataWithType:(HKQuantityType *)type option:(HKStatisticsOptions)option completion:(void(^)(HKStatistics *result, NSError *error))completion;
// 保存健康数据
+ (void)saveHKObject:(HKObject *)obj completion:(void (^) (BOOL suc, NSError *error))completion;

@end
