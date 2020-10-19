//
//  UIViewController+Addition.h
//  JinRongProject
//
//  Created by ZXY on 2017/3/1.
//  Copyright © 2017年 Xing All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemBlock)(void);

@interface UIViewController (Addition)

/**
 *  导航上左侧一个图片的的返回“<"
 */
-(void)setBackItemViewWithImageName:(NSString*)imageName itemAction:(ItemBlock)backAction;

-(void)setBackItemViewWithImage:(NSString*)backImage
                 closeItemImage:(NSString*)closeItemImage
                     itemAction:(ItemBlock)backAction
                closeItemAction:(ItemBlock)closeItemAction;

/**
 *  导航上右侧一个图片的的按钮
 */
-(void)setRightItemWithImage:(NSString*)imageName action:(ItemBlock)action;

-(void)setRightItemLabel:(NSString*)title itemAction:(ItemBlock)rightAction;

-(void)setRightItemWithImage:(NSString*)imageName
                 secendImage:(NSString*)secendImage
                      action:(ItemBlock)action
                secendAction:(ItemBlock)secendAction;


/** 重写返回按钮的触发事件方法 */
-(void)resetBackAction:(ItemBlock)backAction;
@end
