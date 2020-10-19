//
//  JRBaseView.m
//  JinRongProject
//
//  Created by ZXY on 2017/2/21.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "ABAlertView.h"


@implementation ABAlertView

static bool ToastStatue;
static MBProgressHUD* hudAnimation;

#pragma mark -- 全局通用的AlertView
+(UIAlertController*)alertViewWith:(NSString*)title message:(NSString*)message cancelBtnTitle:(NSString*)cancelTitle okBtnTitle:(NSString*)okTitle cancelBtnAction:(NoParame)cancelBlock OkBtnAction:(ReturnAlert)okBlock presentController:(UIViewController*)presentVC
{

    UIAlertController* alertController = [self createAlertViewWith:title message:message cancelBtnTitle:cancelTitle okBtnTitle:okTitle cancelBtnAction:cancelBlock OkBtnAction:okBlock];
    [presentVC presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+(void)showHUD:(UIViewController*)popVC{
    if (hudAnimation) {
        return;
    }
    hudAnimation = [MBProgressHUD showHUDAddedTo:popVC.view animated:YES];
}

+(void)hidenHUD{
    [hudAnimation removeFromSuperview];
    hudAnimation = nil;
}

#pragma mark -- toast弹框
+(void)toastLabel:(NSString*)toastMessage inSuperView:(UIView*)superView {
    if (ToastStatue||[ABValueUtils isEmpty:toastMessage]) {
        return;
    }
    UIView *backView = [[UIView alloc] initWithFrame:superView.bounds];
    ToastStatue = YES;
    backView.backgroundColor = [UIColor clearColor];
    UIView *messageView = [[UIView alloc] init];
    messageView.center = superView.center;
    messageView.backgroundColor = COLOR(40, 47, 60, 1.0);
    messageView.layer.cornerRadius = 8;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = toastMessage;
    label.font = ABFont(F_14);
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    CGSize size = [toastMessage boundingRectWithSize:CGSizeMake(ScreenWidth-80-100, 999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ABFont(F_14)} context:nil].size;
    CGRect r = label.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    label.frame = r;
    
    CGRect mr = label.frame;
    mr.size.width = r.size.width+100;
    mr.size.height = r.size.height+40;
    messageView.frame = mr;
    
    messageView.center = CGPointMake(backView.frame.size.width/2, backView.frame.size.height/2);
    label.center = CGPointMake(messageView.frame.size.width/2, messageView.frame.size.height/2);
    
    [messageView addSubview:label];
    [backView addSubview:messageView];
    [superView addSubview:backView];
    
    NSInteger time = toastMessage.length > 10 ? 2 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [backView removeFromSuperview];
        ToastStatue = NO;
    });
}

+(UIAlertController*)createAlertViewWith:(NSString*)title
                                 message:(NSString*)message
                          cancelBtnTitle:(NSString*)cancelTitle
                              okBtnTitle:(NSString*)okTitle
                         cancelBtnAction:(NoParame)cancelBlock
                             OkBtnAction:(ReturnAlert)okBlock{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    alertController.view.backgroundColor = [UIColor whiteColor];
    alertController.view.layer.cornerRadius = 8;
    if (cancelTitle != nil) {
        UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [CancelAction setValue:COLOR(52, 52, 52, 1.0) forKey:@"titleTextColor"];
        [alertController addAction:CancelAction];
    }
    if (okTitle != nil) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (okBlock) {
                okBlock(alertController);
            }
        }];
        [okAction setValue:THEME_GREEN forKey:@"titleTextColor"];
        [alertController addAction:okAction];
    }
    return alertController;
}



@end
