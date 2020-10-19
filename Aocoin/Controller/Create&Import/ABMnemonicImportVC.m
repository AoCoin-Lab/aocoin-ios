//
//  ABImportVC.m
//  Aocoin
//  Created by 邢现庆 on 2020/3/11.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABMnemonicImportVC.h"
#import "ABTarbarController.h"
#import "ABCreateWalletVC.h"


@interface ABMnemonicImportVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *mnemonicTV;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *mPlaceholder;
@property (nonatomic,strong)ABUserModel* userModel;
@end

@implementation ABMnemonicImportVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
        
}

-(void)initUI{
    self.userModel = [[ABUserModel alloc]init];
    self.userModel.chainName = self.chainName;
    self.title = @"助记词导入";
    self.headerTitleLabel.text = @"输入助记词";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//下一步
- (IBAction)commit:(ABButton *)sender {
    
    [self.view endEditing:YES];
    
    if ([ABValueUtils isEmpty:self.mnemonicTV.text]) {
        [ABAlertView toastLabel:@"请输入您的助记词" inSuperView:self.view];
        return;
    }
    if ([self.mnemonicTV.text componentsSeparatedByString:@" "].count > 12) {
        [ABAlertView toastLabel:@"助记词无效" inSuperView:self.view];
        return;
    }
    if ([self.mnemonicTV.text componentsSeparatedByString:@" "].count < 12) {
        [ABAlertView toastLabel:@"请输入全部助记词" inSuperView:self.view];
        return;
    }
    [ABAlertView showHUD:self];
    self.userModel.mnemonic = self.mnemonicTV.text;
    ABChainModule* chainModule = [ABChainModule chainModuleWithName:self.userModel.chainName];
    [chainModule importWalletByMnemonic:self.userModel
                                  block:^(ABUserModel* userModel) {
        [ABAlertView hidenHUD];
        [self pushToCreatVC];
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
}

-(void)pushToCreatVC{
    ABCreateWalletVC* creatVC = [[ABCreateWalletVC alloc]initWithNibName:@"ABCreateWalletVC" bundle:nil];
    creatVC.createType = ABWalletCreateType_MnemonicImport;
    creatVC.userModel = self.userModel;
    creatVC.chainName = self.chainName;
    [self.navigationController pushViewController:creatVC animated:YES];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.mPlaceholder.hidden = [ABValueUtils isEmpty:textView.text] ? NO : YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
