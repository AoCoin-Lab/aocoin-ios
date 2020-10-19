//
//  LCAlertView.h
//  JinRongProject
//
//  Created by ZXY on 2017/2/21.
//  Copyright © 2017年 Xing All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ABConmon.h"

@interface ABAlertView : UIView

//直接弹出Alertview
+(UIAlertController*)alertViewWith:(NSString*)title
                           message:(NSString*)message
                    cancelBtnTitle:(NSString*)cancelTitle
                        okBtnTitle:(NSString*)okTitle
                   cancelBtnAction:(NoParame)cancelBlock
                       OkBtnAction:(ReturnAlert)okBlock
                 presentController:(UIViewController*)presentVC;

+(void)showHUD:(UIViewController*)popVC;

+(void)hidenHUD;
/**
 * 全局弹框自动消失
 */
+(void)toastLabel:(NSString*)toastMessage inSuperView:(UIView*)superView;

@end
