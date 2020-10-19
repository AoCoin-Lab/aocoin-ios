
//  ABMessageBgView.m
//  Aocoin
//  Created by 邢现庆 on 2019/9/11.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABMessageBgView.h"

@implementation ABMessageBgView

-(instancetype)init{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-StatusBarAndNavigationBarHeight-44);
    }
    return self;
}

-(instancetype)initWithHeight:(CGFloat)height{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
        self.frame = CGRectMake(0, 0, ScreenWidth, height);
    }
    return self;
}


@end
