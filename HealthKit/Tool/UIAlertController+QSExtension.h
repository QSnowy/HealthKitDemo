//
//  UIAlertController+QSExtension.h
//  HealthKit
//
//  Created by Joy on 2018/8/27.
//  Copyright © 2018年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (QSExtension)

+ (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message presentdViewController:(UIViewController *)viewController;

@end
