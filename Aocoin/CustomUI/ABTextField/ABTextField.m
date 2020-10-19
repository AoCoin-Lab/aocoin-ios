//
//  ABTextField.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/11.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABTextField.h"

//@interface ABTextField()
//@property(nonatomic,assign)CGFloat plFontSize;
//
//@end


@implementation ABTextField


-(void)drawPlaceholderInRect:(CGRect)rect {
    
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName : self.font}];
//    if (placeholderSize.width > self.width) {
//        self.plFontSize = self.font.pointSize;
//        self.plFontSize = [self checkPlFontSize];
//        self.font = [UIFont fontWithName:PingFangSC_Regular size:self.plFontSize];
//    }
    if(self.textAlignment == NSTextAlignmentRight) {//右对齐
        [self.placeholder drawInRect:CGRectMake(rect.size.width-placeholderSize.width, (rect.size.height - placeholderSize.height)/2, placeholderSize.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName : TF_PLACEHOLDER_COLOR,NSFontAttributeName : self.font}];
    }else{//左对齐
        [self.placeholder drawInRect:CGRectMake(0, (rect.size.height - placeholderSize.height)/2, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName : TF_PLACEHOLDER_COLOR,NSFontAttributeName : self.font}];
    }
}
//
//
////缩小字体
//-(CGFloat)checkPlFontSize{
//    for (int i = 0 ; i < 10; i++) {
//        UIFont* font = [UIFont fontWithName:PingFangSC_Regular size:self.plFontSize];
//        CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName : font}];
//        if (placeholderSize.width > self.width) {
//            self.plFontSize = self.plFontSize*0.9;
//        }else{
//            return self.plFontSize;
//        }
//    }
//    return self.plFontSize;
//}
@end
