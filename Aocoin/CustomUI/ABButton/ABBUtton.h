//
//  ABButton.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/10.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABButton : UIButton

//渐变背景颜色
-(void)updateBackGroundColorToGradientColor;

//灰色背景颜色
-(void)updateBackGroundColorToGrayColor;

-(void)updateBackGroundColorToGrayColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
