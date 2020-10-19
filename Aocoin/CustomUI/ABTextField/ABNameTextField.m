//
//  ABNameTextField.m
//  Aocoin
//  Created by 邢现庆 on 2019/10/22.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABNameTextField.h"


static NSInteger textLength = 5;

@implementation ABNameTextField


-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    [self addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)editChanged:(ABNameTextField*)textfield{
    NSString *toBeString = textfield.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > textLength) {
                textfield.text = [toBeString substringToIndex:textLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > textLength) {
            textfield.text = [toBeString substringToIndex:textLength];
        }
    }
}

@end
