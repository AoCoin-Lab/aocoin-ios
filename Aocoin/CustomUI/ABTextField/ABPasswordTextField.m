//
//  ABPasswordTextField.m
//  Aocoin
//  Created by 邢现庆 on 2019/12/18.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABPasswordTextField.h"


static NSInteger textLength = 20;

@implementation ABPasswordTextField


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
    self.secureTextEntry = YES;
    [self addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)editChanged:(ABPasswordTextField*)textfield{
    if (textfield.text.length > textLength) {
        textfield.text = [textfield.text substringToIndex:textLength];
    }
}

@end
