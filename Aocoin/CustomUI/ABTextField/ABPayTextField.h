//
//  LCPayTextField.h
//  JinRongProject
//
//  Created by 邢现庆 on 2017/11/30.
//  Copyright © 2017年 Xing All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTextField.h"

//用于输入金额的输入框
//使用时不需要设置delegate  只需要设置payTextFieldDelegate

@protocol ABPayTextFieldDelegate <UITextFieldDelegate>

@end


@interface ABPayTextField : ABTextField<UITextFieldDelegate>

@property (nonatomic, weak) id<ABPayTextFieldDelegate> payTextFieldDelegate;

//小数点后边的长度
@property (nonatomic,assign) NSInteger limited;

@end
