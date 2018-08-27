//
//  UIAlertController+QSExtension.m
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import "UIAlertController+QSExtension.h"

@implementation UIAlertController (QSExtension)

+ (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message presentdViewController:(UIViewController *)viewController{
    
    if (!viewController){
        return;
    }
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertCtrl addAction:confirm];
    [viewController presentViewController:alertCtrl animated:YES completion:nil];
    
    
}

@end
