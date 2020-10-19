//
//  UINavigationController+Addition.m
//  JinRongProject
//
//  Created by ZXY on 2017/3/14.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "UINavigationController+Addition.h"
#import "RTRootNavigationController.h"
#import "NSObject+Runtime.h"
#import "UIViewController+Addition.h"

@implementation UINavigationController (Addition)
+(void)load{
    Class class = NSClassFromString(@"RTRootNavigationController");
    [class swizzleMethod:@selector(pushViewController:animated:) withMethod:@selector(AB_pushViewController:animated:)];
}
-(void)AB_pushViewController:(UIViewController*)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [viewController setBackItemViewWithImageName:@"back" itemAction:^{
        [self.view endEditing:YES];
        [self popViewControllerAnimated:YES];
    }];
    [self AB_pushViewController:viewController animated:animated];
}
@end
