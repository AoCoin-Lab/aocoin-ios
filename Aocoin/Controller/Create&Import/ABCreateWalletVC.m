//
//  ABCreateWalletVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/11.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABCreateWalletVC.h"
#import "ABTarbarController.h"
#import "ABNameTextField.h"

@interface ABCreateWalletVC ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdConditionView_H;
@property (weak, nonatomic) IBOutlet ABNameTextField *nameTF;
@property (weak, nonatomic) IBOutlet ABPasswordTextField *pwdTF;
@property (weak, nonatomic) IBOutlet ABPasswordTextField *pwdVerifyTF;
@property (weak, nonatomic) IBOutlet UILabel *conditon_A_label;
@property (weak, nonatomic) IBOutlet UILabel *conditon_a_label;
@property (weak, nonatomic) IBOutlet UILabel *conditionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLengthLabel;
@property (weak, nonatomic) IBOutlet UITextView *protocolTV;
@property (weak, nonatomic) IBOutlet UIButton *selProtocolBtn;
@property (weak, nonatomic) IBOutlet ABButton *nextBtn;

@property (assign, nonatomic) BOOL is_conditon_A;
@property (assign, nonatomic) BOOL is_conditon_a;
@property (assign, nonatomic) BOOL is_conditionNum;
@property (assign, nonatomic) BOOL is_conditionLength;
@property (nonatomic,strong) UITextField * currentTextfield;
@property (assign, nonatomic) BOOL keyboardIsShown;

@property (weak, nonatomic) IBOutlet UILabel *pwdTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *conditonView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPwdTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *confirmPwdView;


@end



@implementation ABCreateWalletVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //键盘弹起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.createType == ABWalletCreateType_Create) {
        self.userModel = [[ABUserModel alloc]init];
        self.userModel.chainName = self.chainName;
    }
    
    [self initUI];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

-(void)initUI{
    
    switch (self.createType) {
        case ABWalletCreateType_Create:
            self.title = @"创建钱包";
            break;
        case ABWalletCreateType_MnemonicImport:
            self.title = @"助记词导入";
            break;
        case ABWalletCreateType_PrivateKeyImport:
            self.title = @"私钥导入";
            break;
        case ABWalletCreateType_KeystoreImport:
            self.title = @"Keystore导入";
            self.pwdTitleLabel.hidden = YES;
            self.pwdView.hidden = YES;
            self.conditonView.hidden = YES;
            self.confirmPwdTitleLabel.hidden = YES;
            self.confirmPwdView.hidden = YES;
            break;
        default:
            break;
    }
    self.pwdConditionView_H.constant = 0;
    self.selProtocolBtn.selected = YES;
    self.contentView_H.constant = 515;

    [self resetVerifyPwdCondition];
    [self initTextView];
}

-(void)tap{
    [self tipsAnimation:0 content_H:515];
    [self.view endEditing:YES];
}

-(void)tipsAnimation:(CGFloat)pwd_h content_H:(CGFloat)content_H{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3
                     animations:^{
        self.pwdConditionView_H.constant = pwd_h;
        self.contentView_H.constant = content_H;
        [self.view layoutIfNeeded];
    }];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    if (self.keyboardIsShown) {
        return;
    }
    NSDictionary *useInfo = [notification userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    
    CGRect startRact = [self.currentTextfield convertRect:self.currentTextfield.bounds toView:self.view.window];
    if (startRact.origin.y + startRact.size.height > ScreenHeight - keyboardHeight) {
        CGFloat offset = startRact.origin.y + startRact.size.height - (ScreenHeight - keyboardHeight);
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y - offset;
            self.view.frame = frame;
        }];
    }
    self.keyboardIsShown = YES;
}

-(void)keyboardWillHide:(NSNotification *)notification{
    if (self.view.frame.origin.y != StatusBarAndNavigationBarHeight) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    self.keyboardIsShown = NO;
}

-(void)initTextView{
    NSString* text = @"我悉知以下事项:\n● 我已仔细阅读并同意 服务及隐私条款\n● 密码用于保护私钥和交易授权，强度非常重要\n● 澳波钱包不储存密码，也无法帮您找回，请务必记牢";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"ProvidentFundshuaxin://"
                             range:[[attributedString string] rangeOfString:@"服务及隐私条款"]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.protocolTV.attributedText = attributedString;
    self.protocolTV.linkTextAttributes = @{NSForegroundColorAttributeName: COLOR(25, 102, 255, 1.0) ,
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    self.protocolTV.textColor = [UIColor lightGrayColor];
    self.protocolTV.delegate = self;
}

- (IBAction)pwdTFValueChanged:(ABTextField *)sender {
    [self resetVerifyPwdCondition];
    [self verifyPwdCondition:sender.text];
}

- (IBAction)selectProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [self.nextBtn setEnabled:NO];
        [self.nextBtn setBackgroundColor:TIPS_COLOR];
    }else{
        [self.nextBtn setEnabled:YES];
        [self.nextBtn setBackgroundColor:THEME_GREEN];
    }
}

- (IBAction)next:(ABButton *)sender {
    [self.view  endEditing:YES];
    if ([ABValueUtils isEmpty:self.nameTF.text]) {
        [ABAlertView toastLabel:@"请设置您的钱包名称" inSuperView:self.view];
        return;
    }
    if (self.createType != ABWalletCreateType_KeystoreImport &&
        [ABValueUtils isEmpty:self.pwdTF.text]) {
        [ABAlertView toastLabel:@"请设置您的钱包密码" inSuperView:self.view];
        return;
    }
    if (self.createType != ABWalletCreateType_KeystoreImport &&
        ![ABValueUtils verifyPasswordFormat:self.pwdTF.text]) {
        [ABAlertView toastLabel:@"请确认您的密码由大小写字母和数字组成且不小于8位" inSuperView:self.view];
        return;
    }
    if (self.createType != ABWalletCreateType_KeystoreImport &&
        [ABValueUtils isEmpty:self.pwdVerifyTF.text]) {
        [ABAlertView toastLabel:@"请确认您的钱包密码" inSuperView:self.view];
        return;
    }
    if (self.createType != ABWalletCreateType_KeystoreImport &&
        ![self.pwdTF.text isEqualToString:self.pwdVerifyTF.text]) {
        [ABAlertView toastLabel:@"两次密码不一致" inSuperView:self.view];
        return;
    }
    
    if (self.createType != ABWalletCreateType_KeystoreImport) {
        self.userModel.password = self.pwdTF.text;
    }
    self.userModel.username = self.nameTF.text;
    
    if(self.createType == ABWalletCreateType_Create){
        [self createWallet];//创建
    }else{
        [self loadUserKeystore];
    }
}

//重新生成keystore
-(void)loadUserKeystore{
    [ABAlertView showHUD:self];
    ABChainModule* chainModule = [ABChainModule chainModuleWithName:self.userModel.chainName];
    [chainModule loadUserKeystore:self.userModel pwd:self.userModel.password block:^(NSString * _Nonnull keystore) {
        [ABAlertView hidenHUD];
        self.userModel.keystore = keystore;
        [self createFinished];
    } fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
}

-(void)createWallet{
    [ABAlertView showHUD:self];
    ABChainModule* chainModule = [ABChainModule chainModuleWithName:self.userModel.chainName];
    [chainModule createWalletWithPWD:self.pwdTF.text
                               Block:^(ABUserModel* userModel) {
        [ABAlertView hidenHUD];
        self.userModel.address = userModel.address;
        self.userModel.mnemonic = userModel.mnemonic;
        self.userModel.privateKey = userModel.privateKey;
        self.userModel.keystore = userModel.keystore;
        [self createFinished];
    }fail:^(NSString * _Nonnull errorMsg) {
        [ABAlertView hidenHUD];
        [ABAlertView toastLabel:errorMsg inSuperView:self.view];
    }];
}

-(void)createFinished{
    [ABUserDefault setObject:self.userModel.chainName forKey:Current_Chain];
    [ABUserDefault synchronize];
    [self.userModel setDefaultTokens];
    [[ABUserModel defaultUser] updateUserModelWithModel:self.userModel];
    [ABUserDefault setObject:[ABUserModel defaultUser].address forKey:Current_user_adress];
    [ABUserDefault synchronize];
    RLMRealm *realm = [[ABRealmUtils shareUtils]walletsRealm];
    [realm transactionWithBlock:^{
        [realm addObject:[ABUserModel defaultUser]];
    }];
    ABTarbarController* tabbar = [[ABTarbarController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabbar;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTextfield = textField;
    if ([textField isEqual:self.pwdTF]) {
        [self tipsAnimation:135 content_H:515+135];
    }else{
        [self tipsAnimation:0 content_H:515];
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.currentTextfield = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)resetVerifyPwdCondition{
    self.is_conditon_A = NO;
    self.is_conditon_a = NO;
    self.is_conditionNum = NO;
    self.is_conditionLength = NO;
    self.conditionLengthLabel.textColor = TIPS_HIGHLIGHT_COLOR;
    self.conditionNumLabel.textColor = TIPS_HIGHLIGHT_COLOR;
    self.conditon_a_label.textColor = TIPS_HIGHLIGHT_COLOR;
    self.conditon_A_label.textColor = TIPS_HIGHLIGHT_COLOR;
}

-(void)verifyPwdCondition:(NSString*)textString{
    NSInteger length = [textString length];
    
    [self resetVerifyPwdCondition];
    
    for (int i = 0; i < length; i++) {
        char commitChar = [textString characterAtIndex:i];
        NSString *temp = [textString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3 == strlen(u8Temp)){
            //NSLog(@"字符串中含有中文");
        }else if((commitChar>64)&&(commitChar<91)){
            self.is_conditon_A = YES;
            self.conditon_A_label.textColor = [UIColor whiteColor];
            //NSLog(@"字符串中含有大写英文字母");
        }else if((commitChar>96)&&(commitChar<123)){
            self.is_conditon_a = YES;
            self.conditon_a_label.textColor = [UIColor whiteColor];;
            //NSLog(@"字符串中含有小写英文字母");
        }else if((commitChar>47)&&(commitChar<58)){
            self.is_conditionNum = YES;
            self.conditionNumLabel.textColor = [UIColor whiteColor];;
            //NSLog(@"字符串中含有数字");
        }else{
            //NSLog(@"字符串中含有非法字符");
        }
    }
    if (length >= 8) {
        self.is_conditionLength = YES;
        self.conditionLengthLabel.textColor = [UIColor whiteColor];;
    }
}

#pragma mark ---- UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSRange range = [textView.text rangeOfString:@"服务及隐私条款"];
    if (NSEqualRanges(characterRange, range)) {
        //TODO://
        return YES;
    }
    return NO;
}

@end
