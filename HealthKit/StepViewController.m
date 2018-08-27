//
//  StepViewController.m
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "StepViewController.h"
#import "UIAlertController+QSExtension.h"
#import "HKHandle.h"
#import "WSDatePickerView.h"


@interface StepViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *stepTF;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;

@end

@implementation StepViewController
{
    
    NSUInteger            _stepCount;
    NSDate               *_startTime;
    NSDate               *_endTime;
    NSDateFormatter      *_formatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _stepTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

// MARK: - action

- (IBAction)chooseStartTime:(id)sender {
    [self.view endEditing:YES];

    __weak typeof(self) weakSelf = self;
    [self showPickerViewForType:DateStyleShowMonthDayHourMinute choosed:^(NSDate *date) {
        
        [weakSelf handleDate:date start:YES];

        
    } minLimit:nil maxLimit:[NSDate date]];

}
- (IBAction)chooseEndTime:(id)sender {
    
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    [self showPickerViewForType:DateStyleShowMonthDayHourMinute choosed:^(NSDate *date) {
        
        [weakSelf handleDate:date start:NO];
        
    } minLimit:nil maxLimit:[NSDate date]];
    
}
- (IBAction)writeSetp:(id)sender {
    [self.view endEditing:YES];

    if (_stepCount == 0 || _startTime == nil || _endTime == nil){
        [UIAlertController showSimpleAlertWithTitle:@"提示" message:@"请补充所有选项" presentdViewController:self];
        return;
    }
    
    // 步数
    HKQuantity *steps = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:_stepCount];
    
    HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount] quantity:steps startDate:_startTime endDate:_endTime device:[HKHandle defaultDevice] metadata:nil];
    
    [HKHandle saveHKObject:stepSample completion:^(BOOL suc, NSError *error) {
        
        if (suc){
            
            [UIAlertController showSimpleAlertWithTitle:@"提示" message:@"写入成功" presentdViewController:self];
            
        }else{
            
            NSString *errMsg = error.localizedDescription;
            [UIAlertController showSimpleAlertWithTitle:@"提示" message:errMsg presentdViewController:self];
            
        }
        
    }];
    
}
// MARK: - UITextInput delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    _stepCount = [textField.text integerValue];
    
}


// MARK: - other

- (void)showPickerViewForType:(WSDateStyle)type choosed:(void(^)(NSDate *date))choosed minLimit:(NSDate *)minLimit maxLimit:(NSDate *)maxLimit{
    
    WSDatePickerView *datePicker = [[WSDatePickerView alloc] initWithDateStyle:type CompleteBlock:^(NSDate *date) {
        if (choosed){
            choosed(date);
        }
    }];
    if ([minLimit isKindOfClass:[NSDate class]]){
        datePicker.minLimitDate = minLimit;
    }
    if ([maxLimit isKindOfClass:[NSDate class]]){
        datePicker.maxLimitDate = maxLimit;
    }
    [datePicker show];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)handleDate:(NSDate *)date start:(BOOL)start{
    
    if (!_formatter){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        _formatter = formatter;
    }
    
    NSString *dateString = [_formatter stringFromDate:date];
    
    if (start){
        _startTime = date;
        [_startTimeBtn setTitle:dateString forState:UIControlStateNormal];
        
    }else{
        _endTime = date;
        [_endTimeBtn setTitle:dateString forState:UIControlStateNormal];
    }
    
}

@end
