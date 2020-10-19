//
//  LCPayTextField.m
//  JinRongProject
//
//  Created by 邢现庆 on 2017/11/30.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "ABPayTextField.h"

@implementation ABPayTextField 

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (void)initSetup{
    self.limited = 4;
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(paste:)){//禁止粘贴
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.payTextFieldDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [self.payTextFieldDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.payTextFieldDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        return [self.payTextFieldDelegate textFieldDidEndEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        return [self.payTextFieldDelegate textFieldDidEndEditing:textField reason:reason];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //不能以小数点开头
    if ([string isEqualToString:@"."] && textField.text.length == 0) {
        return NO;
    }
    
    //只允许输入一个小数点
    if ([string isEqualToString:@"."] && [textField.text rangeOfString:@"."].location != NSNotFound) {
        return NO;
    }
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString insertString:string atIndex:range.location];
    NSInteger flag = 0;//标记小数点后边的下标
//    NSInteger index = 0;//标记小数点前边的下边
    const NSInteger limited = self.limited;//小数点后边的长度
//    const NSInteger limit = 9;//小数点前边的长度
    if (limited == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    for (NSInteger i = futureString.length-1; i>=0; i--) {
        if ([futureString characterAtIndex:i] == '.') {
//            index = 0;
            if (flag > limited) {
                return NO;
            }
            break;
        }
//        if (index >= limit) {
//            return NO;
//        }
        flag++;
//        index++;
    }
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.payTextFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.payTextFieldDelegate textFieldShouldClear:textField];
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.payTextFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.payTextFieldDelegate textFieldShouldReturn:textField];
    }
    return NO;
}


@end
