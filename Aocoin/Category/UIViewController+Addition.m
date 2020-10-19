//
//  UIViewController+Addition.m
//  JinRongProject
//
//  Created by ZXY on 2017/3/1.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "UIViewController+Addition.h"
#import "objc/runtime.h"
#import "UIButton+AssetBlockObject.h"
static char closeItemBlockKey;
static UIButton *lc_backButton;
@implementation UIViewController (Addition)

-(void)setBackItemViewWithImage:(NSString*)backImage
                 closeItemImage:(NSString*)closeItemImage
                      itemAction:(ItemBlock)backAction
                closeItemAction:(ItemBlock)closeItemAction{
    lc_backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lc_backButton.frame = CGRectMake(0, 0, 30, 20);
    [lc_backButton setImage:[UIImage imageNamed:backImage] forState:(UIControlStateNormal)];
    lc_backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [lc_backButton addTouchBlockHandler:^{
        if (backAction) {
            backAction();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *fixBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFixedSpace) target:nil action:nil];
    fixBtnItem.width = -6;
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lc_backButton];
    
    UIButton *secendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    secendBtn.frame = CGRectMake(0, 0, 30, 20);
    [secendBtn setImage:[UIImage imageNamed:closeItemImage] forState:(UIControlStateNormal)];
    secendBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [secendBtn addTouchBlockHandler:^{
        if (closeItemAction) {
            closeItemAction();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:secendBtn];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:fixBtnItem, barBtnItem, closeItem, nil];
}


-(void)setBackItemViewWithImageName:(NSString*)imageName itemAction:(ItemBlock)backAction{
    lc_backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    lc_backButton.frame = CGRectMake(0, 0, 50, 20);
    [lc_backButton setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    lc_backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [lc_backButton addTouchBlockHandler:^{
        if (backAction) {
            backAction();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lc_backButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:barBtnItem, nil];
}
/** 重写返回按钮的触发事件方法 */
-(void)resetBackAction:(ItemBlock)backAction{
    [lc_backButton removeTarget:nil action:nil forControlEvents:(UIControlEventTouchUpInside)];
    [lc_backButton addTouchBlockHandler:^{
        backAction();
    } forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)closeItemAction{
    ItemBlock block = objc_getAssociatedObject(self, &closeItemBlockKey);
    if (block) {
        block();
    }
}

-(void)setRightItemLabel:(NSString*)title itemAction:(ItemBlock)rightAction{
    CGSize size = [title boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PingFangSC_Regular size:F_14]} context:nil].size;
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    button.titleLabel.font = [UIFont fontWithName:PingFangSC_Regular size:F_14];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.minimumScaleFactor = 0.5;
    UIBarButtonItem *fixBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFixedSpace) target:nil action:nil];
    fixBtnItem.width = -6;
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixBtnItem,rightBtnItem, nil];
    if (rightAction) {
        [button addTouchBlockHandler:^{
            rightAction();
        } forControlEvents:(UIControlEventTouchUpInside)];
    }
}

-(void)setRightItemWithImage:(NSString*)imageName action:(ItemBlock)action{

    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 20);
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTouchBlockHandler:^{
        if (action) {
            action();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barItem, nil];
}

-(void)setRightItemWithImage:(NSString*)imageName
                 secendImage:(NSString*)secendImage
                      action:(ItemBlock)action
                secendAction:(ItemBlock)secendAction{

    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 24, 20);
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTouchBlockHandler:^{
        if (action) {
            action();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *secendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    secendBtn.frame = CGRectMake(0, 0, 24, 20);
    [secendBtn setImage:[UIImage imageNamed:secendImage] forState:(UIControlStateNormal)];
    secendBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [secendBtn addTouchBlockHandler:^{
        if (secendAction) {
            secendAction();
        }
    } forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:secendBtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:item,barItem, nil];
}

@end
