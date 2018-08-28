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
    // 步数
    NSSet *set = [NSSet setWithObjects:
                  [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],nil];
    
    return set;
}

+ (void)requsetDefaultAuth:(void(^)(BOOL suc, NSString *msg))complention{
    
    HKHealthStore *store = [self singleStore];
    if (![HKHealthStore isHealthDataAvailable]){
        // 设备不支持 HealthKit
        if (complention){
            complention(NO, @"设备不支持HealthKit");
        }
        return;
    }
    
    // 请求相应健康权限
    NSSet *hkset = [self defaultHKSet];
    [store requestAuthorizationToShareTypes:hkset readTypes:hkset completion:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"auth success = %@, error = %@",@(success), error);
        
        if (complention){
            complention(success, error.localizedDescription);
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

+ (void)read{
    
    HKHealthStore *store = [self singleStore];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            NSLog(@"An error occured fetching the user's tracked food. In your app, try to handle this gracefully. The error was: %@.", error);
            abort();
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            
            for (HKQuantitySample *sample in results) {

                double count = [sample.quantity doubleValueForUnit:[HKUnit countUnit]];
                NSLog(@"count = %@",@(count));

            }

        });
    }];
    
    [store executeQuery:query];
    
    
}

+ (void)saveHKObject:(HKObject *)obj completion:(void (^) (BOOL suc, NSError *error))completion{
    
    if (![obj isKindOfClass:[HKObject class]]){
        return;
    }
    HKHealthStore *store = [self singleStore];
    // 保存健康数据
    [store saveObject:obj withCompletion:^(BOOL success, NSError * _Nullable error) {
        
        if (completion){
            
            completion(success, error);

        }
        
    }];
    
}


@end
