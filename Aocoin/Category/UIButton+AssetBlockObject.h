//
//  UIButton+AssetBlockObject.h
//  JinRongProject
//
//  Created by ZXY on 2017/2/21.
//  Copyright © 2017年 Xing All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TouchBlock)();
@interface UIButton (AssetBlockObject)
-(void)addTouchBlockHandler:(TouchBlock)handler forControlEvents:(UIControlEvents)controlEvent;
@end
