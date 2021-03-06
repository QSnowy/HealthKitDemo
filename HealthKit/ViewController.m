//
//  ViewController.m
//  HealthKit
//
//  Created by Joy on 2018/8/23.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>
#import <HealthKitUI/HealthKitUI.h>
#import "UIAlertController+QSExtension.h"
#import "HKHandle.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *datasource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datasource = @[@"体能训练",@"行走步数",@"能量消耗",@"爬升楼层"];
    _tableView.tableFooterView = [UIView new];
    
    [self judgeAuth];
    
}
// 判断当前应用权限
- (void)judgeAuth {
    
    HKAuthorizationStatus status = [HKHandle currentHKAuthStatus];
    if (status == HKAuthorizationStatusNotDetermined) {
        
        [HKHandle requsetDefaultAuth:^(BOOL suc, NSString *msg) {
            
        }];
        
    }else if (status == HKAuthorizationStatusSharingDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前应用没有获取步数权限，请到设置页面授权" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"前往设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.class gotoAppSettingPage];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (IBAction)auth:(id)sender {
    
    [HKHandle requsetDefaultAuth:^(BOOL suc, NSString *msg) {
       
        if (!suc){
            [UIAlertController showSimpleAlertWithTitle:@"提示" message:msg presentdViewController:self];
        }
        
    }];
    
}


// MARK: - UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _datasource[indexPath.row];
    return cell;
    
}
// MARK: - UITable view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if (row == 0){
        
        // 体能训练
        HKQuantity *distance = [HKQuantity quantityWithUnit:[HKUnit mileUnit] doubleValue:3.2];
        HKQuantity *energyBurned = [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit] doubleValue:425.0];
        [NSDate date];
        NSDate *start = [NSDate dateWithTimeIntervalSinceNow:-1800];
        NSDate *end = [NSDate date];
        HKWorkout *run = [HKWorkout workoutWithActivityType:HKWorkoutActivityTypeRunning startDate:start endDate:end workoutEvents:nil totalEnergyBurned:energyBurned totalDistance:distance metadata:nil];
        [self saveHealthObject:run];
        
    }else if (row == 1){
        
        
        [self performSegueWithIdentifier:@"PushStep" sender:nil];

        
    }else if (row == 2){
        // 能量
        
    }else if (row == 3){
        // 楼层
        
    }

    
}

- (void)saveHealthObject:(HKObject *)obj{
    
    
    HKHealthStore *store = [HKHandle defaultHKStore];
    
    [HKHandle requsetDefaultAuth:^(BOOL success, NSString *msg) {
        
        if (!success){
            return ;
        }
        
        [store saveObject:obj withCompletion:^(BOOL success, NSError * _Nullable error) {
            
            if (success){
                
                [UIAlertController showSimpleAlertWithTitle:@"提示" message:@"写入成功" presentdViewController:self];
            }
            
        }];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)gotoAppSettingPage
{
    NSString *urlString = UIApplicationOpenSettingsURLString;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
    
}

@end
