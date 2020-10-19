//
//  ABBaseViewController.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/9.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABBaseViewController.h"
#import "ABAssetsVC.h"
#import "ABWalletSwitchVC.h"


@interface ABBaseViewController ()<UIGestureRecognizerDelegate>


@end

@implementation ABBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage* image = [UIImage AB_imageWithColor:NAV_BACKGROUND_COLOR];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = VC_BACKGROUND_COLOR;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = TRUE;
}


-(void)setTitle:(NSString *)title{
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 0, 0)];
    titleLable.font = ABBlodFont(F_18);
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = title;
    titleLable.shadowColor = [UIColor clearColor];
    titleLable.textColor = [UIColor whiteColor];
    [titleLable sizeToFit];//自动适配 宽高
    self.navigationItem.titleView = titleLable;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    BOOL rlt = FALSE;
    // 手势
    if(gestureRecognizer == self.navigationController.interactivePopGestureRecognizer){
        // 控制器堆栈
        if(self.navigationController.viewControllers.count >= 2){
            rlt = TRUE;
        }
    }
    return rlt;
}


@end
