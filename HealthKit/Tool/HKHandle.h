//
//  HKHandle.h
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HKHandle : NSObject

+ (HKHealthStore *)singleStore;

+ (NSSet *)defaultHKSet;

+ (void)requsetDefaultAuth:(void(^)(BOOL suc))complention;

+ (HKDevice *)defaultDevice;


+ (void)saveHKObject:(HKObject *)obj completion:(void (^) (BOOL suc, NSError *error))completion;

@end
