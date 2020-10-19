//
//  ABPrivateImportVC.m
//  Aocoin
//  Created by 邢现庆 on 2020/3/12.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABPrivateImportVC.h"
#import "ABTarbarController.h"
#import "ABCreateWalletVC.h"

@interface ABPrivateImportVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *kPlaceholder;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *keyTV;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,strong)ABUserModel* userModel;
@end

@implementation ABPrivateImportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

-(void)initUI{
    self.userModel = [[ABUserModel alloc]init];
    self.userModel.chainName = self.chainName;
    self.title = @"私钥导入";
    self.headerTitleLabel.text = @"输入私钥";
}

-(void)verifyPK:(NSString*)pk{
    [ABAlertView showHUD:self];
    self.userModel.privateKey = pk;
    [[ABChainModule chainModuleWithName:self.userModel.chainName]importWalletByPrivateKey:self.userModel
                                                   block:^(ABUserModel* userModel) {
        [ABAlertView hidenHUD];
        self.keyTV.text = [NSString stringWithFormat:@"%@",pk];
        self.kPlaceholder.hidden = YES;
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        self.keyTV.text = @"";
        self.kPlaceholder.hidden = NO;
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
}

- (IBAction)commit:(ABButton *)sender {
    if ([ABValueUtils isEmpty:self.keyTV.text]) {
        [ABAlertView toastLabel:@"请输入您的钱包私钥" inSuperView:self.view];
        return;
    }
    [ABAlertView showHUD:self];
    self.userModel.privateKey = self.keyTV.text;
    ABChainModule* chainModule = [ABChainModule chainModuleWithName:self.userModel.chainName];
    [chainModule importWalletByPrivateKey:self.userModel
                                    block:^(ABUserModel * _Nonnull userModel) {
        [ABAlertView hidenHUD];
        [self pushToCreatVC];
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
}

-(void)pushToCreatVC{
    ABCreateWalletVC* creatVC = [[ABCreateWalletVC alloc]initWithNibName:@"ABCreateWalletVC" bundle:nil];
    creatVC.createType = ABWalletCreateType_PrivateKeyImport;
    creatVC.userModel = self.userModel;
    [self.navigationController pushViewController:creatVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    //私钥输入框不能输入空格和换行
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.kPlaceholder.hidden = [ABValueUtils isEmpty:textView.text] ? NO : YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //私钥输入框不能输入空格
    if ([text isEqualToString:@" "]){
        return NO;
    }
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
