//
//  ABTarbarController.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/9.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABTarbarController.h"
#import "ABAssetsVC.h"
#import "ABAboutVC.h"

@interface ABTarbarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@end

@implementation ABTarbarController

+ (void)initialize{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:THEME_GREEN,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [UITabBar appearance].translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = VC_BACKGROUND_COLOR;
    self.delegate = self;
    CGFloat height = ScreenHeight-StatusBarAndNavigationBarHeight-TabbarHeight;
    ABAssetsVC* assetsVC = [[ABAssetsVC alloc]initWithTableFrame:CGRectMake(0, 0, ScreenWidth, height)
                                                           style:UITableViewStyleGrouped];
    [self setUpChildControllerWith:assetsVC
                          norImage:[UIImage imageNamed:@"assets"]
                          selImage:[UIImage imageNamed:@"assets_selected"]
                             title:@"资产"];
    
    ABAboutVC* aboutVC = [[ABAboutVC alloc]initWithNibName:@"ABAboutVC" bundle:nil];
    [self setUpChildControllerWith:aboutVC
                          norImage:[UIImage imageNamed:@"user"]
                          selImage:[UIImage imageNamed:@"user_selected"]
                             title:@"关于"];
}

- (void)setUpChildControllerWith:(UIViewController *)childVc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title{
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:childVc];
    nav.delegate = self;
    childVc.title = title;
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -4);
    nav.tabBarItem.title = title;
    nav.navigationBar.layer.shadowOffset = CGSizeMake(ScreenWidth, 0);
    childVc.tabBarItem.image = norImage;
    childVc.tabBarItem.selectedImage = selImage;
    [self addChildViewController:nav];
}





@end
