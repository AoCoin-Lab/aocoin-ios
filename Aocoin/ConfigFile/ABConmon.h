//
//  ABConmon.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/8.
//  Copyright © 2019 Xing. All rights reserved.
//

#ifndef ABConmon_h
#define ABConmon_h

#ifdef DEBUG
#define NSLog(xx, ...)  NSLog(@"%s(%d)%s:\n " xx, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__)

#else
#define NSLog(...)
#endif

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
//获取当前系统的版本号
#define VERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

/** 设备高度 **/
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
/** 设备宽度 **/
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//----------

// Navigation bar height.
#define  NavigationBarHeight  44.f
// Status bar height.
#define  StatusBarHeight      ((iPhoneX == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.f : 20.f)
// Tabbar height.
#define  TabbarHeight         ((iPhoneX == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.f : 49.f )
// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin    ((iPhoneX == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  ((iPhoneX == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.f : 64.f)
//----------

//不同屏幕尺寸
#define RealScreenHeight    [UIScreen mainScreen].bounds.size.height
//4||4s
#define is35Inch   ((NSInteger)RealScreenHeight == 480 ? YES : NO)
//5||5s
#define is4Inch   ((NSInteger)RealScreenHeight == 568 ? YES : NO)
//6
#define is47Inch  ((NSInteger)RealScreenHeight == 667 ? YES : NO)
//6 plus
#define is55Inch  ((NSInteger)RealScreenHeight == 736 ? YES : NO)
//判断 iPhone X
#define iPhoneX (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
//判断 iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断 iPhoneXsw
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断 iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断 是不是iphoneX 系列
#define IS_IPHONE_X_LIST ((iPhoneX == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? YES : NO)

// iPhone and iPod touch style UI
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// iPad style UI
#define IS_IPAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)



typedef void(^NoParame)(void);
typedef void(^ReturnAlert)(UIAlertController* alertViewController);
typedef void(^CallBackBlock)(void);

#endif
