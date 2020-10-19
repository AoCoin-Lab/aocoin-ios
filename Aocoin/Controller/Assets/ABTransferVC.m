//
//  ABTransferVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/9/2.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABTransferVC.h"
#import "ABPayTextField.h"

@interface ABTransferVC ()<UITextFieldDelegate,ABPayTextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coinImg;
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet ABPayTextField *numberTF;
@property (weak, nonatomic) IBOutlet ABTextField *receiveAddressTF;
@property (nonatomic,copy)NSString* coinBalance;
@property (nonatomic,strong)UITextField* currentTextfield;
@property (nonatomic,assign)BOOL keyboardIsShown;
@property (nonatomic,strong)ABCoinModel* selectCoinModel;
@end

@implementation ABTransferVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"转账";
        
    self.numberTF.payTextFieldDelegate = self;
    
    [self updateCurrentCoinInfo:[[ABUserModel defaultUser].tokenBalances firstObject]];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    [self reloadAssetsData];
}

-(void)reloadAssetsData{
    [ABAlertView showHUD:self];
    [[ABChainModule chainModule]getBalanceWithCallBack:^{
        [ABAlertView hidenHUD];
        [self updateCurrentCoinInfo:[[ABUserModel defaultUser].tokenBalances firstObject]];
    }];
}

-(void)updateCurrentCoinInfo:(ABCoinModel*)coinModel{
    self.selectCoinModel = coinModel;
    self.coinNameLabel.text = self.selectCoinModel.abbr;
    self.coinImg .image = [UIImage imageNamed:self.selectCoinModel.imageSrc];
    self.numberTF.limited = [self.selectCoinModel.precision integerValue];
    self.coinBalance = [ABValueUtils balanceByPrecision:self.selectCoinModel.balance precision:self.selectCoinModel.precision].stringValue;
    self.balanceLabel.text = [NSString stringWithFormat:@"（余额：%@）",self.coinBalance];
}

- (IBAction)next:(ABButton *)sender {
    [self.view endEditing:YES];
    
    if ([ABValueUtils isEmpty:self.numberTF.text]) {
        [ABAlertView toastLabel:@"请输入数量" inSuperView:self.view];
        return;
    }
    if ([self.numberTF.text doubleValue] == 0) {
        [ABAlertView toastLabel:@"转账数量不能小于0" inSuperView:self.view];
        return;
    }
    if ([ABValueUtils compareDecimalNumberA:self.numberTF.text B:self.coinBalance] == NSOrderedDescending) {
        [ABAlertView toastLabel:@"余额不足" inSuperView:self.view];
        return;
    }
    if ([ABValueUtils isEmpty:self.receiveAddressTF.text]) {
        [ABAlertView toastLabel:@"请输入接收地址" inSuperView:self.view];
        return;
    }
    if ([self.receiveAddressTF.text isEqualToString:[ABUserModel defaultUser].address]) {
        [ABAlertView toastLabel:@"接收地址和发送地址不能相同" inSuperView:self.view];
        return;
    }

    [ABAlertView showHUD:self];
    [[ABChainModule chainModule]verifyAddress:self.receiveAddressTF.text block:^{
        [[ABChainModule chainModule]transferWithUser:[ABUserModel defaultUser]
                                      receiveAddress:self.receiveAddressTF.text
                                            coinModel:self.selectCoinModel
                                             coinNum:self.numberTF.text
                                               block:^(BOOL suc, NSString * _Nonnull errorMessage, NSString * _Nonnull hashStr,NSDictionary* _Nullable optionalDic) {
            [ABAlertView hidenHUD];
            [ABAlertView alertViewWith:@"提示"
                               message:suc ? @"成功":errorMessage
                        cancelBtnTitle:nil
                            okBtnTitle:@"确定"
                       cancelBtnAction:nil
                           OkBtnAction:nil
                     presentController:self];
        }];
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg  inSuperView:self.view];
    }];
}

-(void)tapGes{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]||
        [NSStringFromClass([touch.view class]) isEqualToString:@"ABTextField"]) {
        return NO;
    }else {
        [self.view endEditing:YES];
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
