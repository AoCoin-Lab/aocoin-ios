//
//  ABTronVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/9.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABAocoinVC.h"
#import "ABCreateWalletVC.h"
#import "ABChainListVC.h"

@interface ABAocoinVC ()

@end

@implementation ABAocoinVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)createWallet:(UIButton *)sender {
    [self pushToSleectChain:ABWalletCreateType_Create];
}

- (IBAction)importWallet:(ABButton *)sender {
    [self pushToSleectChain:ABWalletCreateType_Import];
}

-(void)pushToSleectChain:(ABWalletCreateType)type{
    ABChainListVC* vc = [[ABChainListVC alloc]init];
    vc.createType = type;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
