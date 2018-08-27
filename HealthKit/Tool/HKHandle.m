//
//  HKHandle.m
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "HKHandle.h"

@implementation HKHandle

+ (HKHealthStore *)singleStore{
    
    static HKHealthStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[HKHealthStore alloc] init];
    });
    return store;
}

+ (NSSet *)defaultHKSet
{
    
    NSSet *set = [NSSet setWithObjects:
                  [HKObjectType workoutType],
                  [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling],
                  [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],nil];
    
    return set;
}

+ (void)requsetDefaultAuth:(void(^)(BOOL suc))complention{
    
    HKHealthStore *store = [self singleStore];
    if (![HKHealthStore isHealthDataAvailable]){
        
        if (complention){
            complention(NO);
        }
        return;
    }
    
    [store requestAuthorizationToShareTypes:[self defaultHKSet] readTypes:[self defaultHKSet] completion:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"auth success = %@, error = %@",@(success), error);
        
        if (complention){
            complention(success);
        }
        
    }];
    
}

+ (HKDevice *)defaultDevice{
    
    HKDevice *device = [[HKDevice alloc] initWithName:@"Honor 3"
                                         manufacturer:@"HUAWEI"
                                                model:@"sport circle"
                                      hardwareVersion:@"1.6.1"
                                      firmwareVersion:@"1.0.0"
                                      softwareVersion:@"5.5.0"
                                      localIdentifier:@"华为荣耀3手环"
                                  UDIDeviceIdentifier:@"4c29ff44-e385-4aa4-ad20-c5fa84314cdb"];
    return device;
}

+ (void)saveHKObject:(HKObject *)obj completion:(void (^) (BOOL suc, NSError *error))completion{
    
    HKHealthStore *store = [self singleStore];
    
    [store saveObject:obj withCompletion:^(BOOL success, NSError * _Nullable error) {
        
        if (completion){
            
            completion(success, error);

        }
        
    }];
    
}



@end
