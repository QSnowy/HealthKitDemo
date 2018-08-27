//
//  Common.h
//  epico
//
//  Created by ChatLink on 2018/1/23.
//  Copyright © 2018年 ChatLink. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <Foundation/Foundation.h>
// APP KEYS
static NSString * const KBaiduMapAPIKey  = @"3pGSZnFxZhKZGWUkGDiDGGsI43j1dUe6";
static NSString * const KWeiXinAppID     = @"wxe7c33f3063273dd9";
static NSString * const KWeiXinAppSecret = @"958a07bed06c303352a92d2775d441a8";

// NOTICE
// 物业更改通知
#define TENANTCHANGENOTICE    @"TenantChangeNotification"

#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define RGB(r, g, b) RGBA(r,g,b,1)

// 常用全局宏
#define KTopEdgeHeight           (kDeviceiPhoneX ? 88 : 64)
#define KBottomEdgeHeight        (kDeviceiPhoneX ? 34 : 0)

#define kNaviBarHeight           44
#define kTabBarHeight            (kDeviceiPhoneX ? 83 : 49)
#define kStatusBarHeight         (kDeviceiPhoneX ? 44 : 20)
#define kMainButtonHeight        45
#define kTableSectionSpace       6

#define kDeviceIsLandscape       (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
#define kDeviceScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define kDeviceScreenHeight      ([UIScreen mainScreen].bounds.size.height)
#define lesserIOS8               (kDeviceVersion < 8.0f)
#define kDeviceiPhoneX            kDeviceScreenHeight == 812
// 当前屏幕宽高，兼容横屏
#define kScreenWidth             ((lesserIOS8 && kDeviceIsLandscape) ? kDeviceScreenHeight : kDeviceScreenWidth)
#define kScreenHeight            ((lesserIOS8 && kDeviceIsLandscape) ? kDeviceScreenWidth : kDeviceScreenHeight)
// 系统版本号
#define kDeviceVersion           ([[[UIDevice currentDevice] systemVersion] floatValue])
// app版本号
#define kAppVersion              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppBundleVersion        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 沙盒doc路径
#define kDocPath                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// log输出
#if DEBUG
#define CCLog(...)   printf("%f %s\n",[[NSDate date] timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define CCLog(...)
#endif

// 按钮背景图片
#define MAINBUTTONBG   [UIImage imageNamed:@"btn_bg"]
// 字体大小
#define FontWithSize(size)       [UIFont systemFontOfSize:size]
#define BoldFontWithSize(size)   [UIFont boldSystemFontOfSize:size];

#endif /* Common_h */
