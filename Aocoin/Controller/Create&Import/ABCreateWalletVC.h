//
//  ABCreateWalletVC.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/11.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ABWalletCreateType){
    ABWalletCreateType_Create,//默认创建
    ABWalletCreateType_Import,//导入
    ABWalletCreateType_MnemonicImport,//助记词导入
    ABWalletCreateType_PrivateKeyImport,//私钥导入
    ABWalletCreateType_KeystoreImport,//keystore导入
};


@interface ABCreateWalletVC : ABBaseViewController

@property(nonatomic,assign)ABWalletCreateType createType;

@property (nonatomic,copy)NSString* chainName;

@property(nonatomic,strong)ABUserModel* userModel;

@end

NS_ASSUME_NONNULL_END

