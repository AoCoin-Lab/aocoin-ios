//
//  ABKeystoreImportVC.m
//  Aocoin
//  Created by 邢现庆 on 2020/3/12.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABKeystoreImportVC.h"
#import "ABTarbarController.h"
#import "ABCreateWalletVC.h"

@interface ABKeystoreImportVC ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topHeaderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomHeaderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *keystoreTV;

@property (weak, nonatomic) IBOutlet ABPasswordTextField *pwdTF;

@property(nonatomic,strong)ABUserModel* userModel;

@end

@implementation ABKeystoreImportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

-(void)initUI{
    self.userModel = [[ABUserModel alloc]init];
    self.userModel.chainName = self.chainName;
    self.title = @"Keystore导入";
    self.topHeaderTitleLabel.text = @"输入Keystore";
    self.bottomHeaderTitleLabel.text = @"输入对应的密码";
}

- (IBAction)commit:(ABButton *)sender {
    if ([ABValueUtils isEmpty:self.keystoreTV.text]) {
        [ABAlertView toastLabel:@"请输入Keystore" inSuperView:self.view];
        return;
    }
    if ([ABValueUtils isEmpty:self.pwdTF.text]) {
        [ABAlertView toastLabel:@"请输入对应的密码" inSuperView:self.view];
        return;
    }
    [ABAlertView showHUD:self];
    self.userModel.keystore = self.keystoreTV.text;
    self.userModel.password = self.pwdTF.text;
    ABChainModule* chainModule = [ABChainModule chainModuleWithName:self.userModel.chainName];
    [chainModule importWalletByKeystore:self.userModel
                                  block:^(ABUserModel*userModel) {
        [ABAlertView hidenHUD];

        [self pushToCreatVC];
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
    return;
}

-(void)pushToCreatVC{
    ABCreateWalletVC* creatVC = [[ABCreateWalletVC alloc]initWithNibName:@"ABCreateWalletVC" bundle:nil];
    creatVC.createType = ABWalletCreateType_KeystoreImport;
    creatVC.userModel = self.userModel;
    [self.navigationController pushViewController:creatVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.keyPlaceholder.hidden = [ABValueUtils isEmpty:textView.text] ? NO : YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
