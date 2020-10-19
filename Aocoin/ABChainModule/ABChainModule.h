//
//  ABChainModule.h
//  Aocoin
//  Created by 邢现庆 on 2020/6/2.
//  Copyright © 2020 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABUserModel.h"
#import "ABConmon.h"

NS_ASSUME_NONNULL_BEGIN



@interface ABChainModule : NSObject


//获取公链的module
+(ABChainModule*)chainModule;

//获取公链的module
+(ABChainModule*)chainModuleWithName:(NSString*)chainName;


//创建钱包
-(void)createWalletWithPWD:(NSString*)password
                     Block:(void(^)(ABUserModel* userModel))block
                      fail:(void(^)(NSString *errorMsg))fail;

//助记词导入
//参数 mnemonic
-(void)importWalletByMnemonic:(ABUserModel*)model
                        block:(void(^)(ABUserModel* userModel))block
                         fail:(void(^)(NSString *errorMsg))fail;

//私钥导入
-(void)importWalletByPrivateKey:(ABUserModel*)model
                          block:(void(^)(ABUserModel* userModel))block
                           fail:(void(^)(NSString *errorMsg))fail;

//Keystore导入
-(void)importWalletByKeystore:(ABUserModel*)model
                        block:(void(^)(ABUserModel* userModel))block
                         fail:(void(^)(NSString *errorMsg))fail;

//备份keystore
-(void)loadUserKeystore:(ABUserModel*)model
                      pwd:(NSString*)pwd
                    block:(void(^)(NSString *keystore))block
                     fail:(void(^)(NSString *errorMsg))fail;


//验证地址
-(void)verifyAddress:(NSString*)address
               block:(void(^)(void))block
                fail:(void(^)(NSString *errorMsg))fail;

//转账
-(void)transferWithUser:(ABUserModel*)userModel
         receiveAddress:(NSString*)receiveAddress
              coinModel:(ABCoinModel*)coinModel
                coinNum:(NSString*)coinNum
                  block:(void(^)(BOOL suc, NSString* errorMessage,NSString* hashStr,NSDictionary* _Nullable optionalDic))block;

//拉取转账结果
-(void)getTransactionStatus:(NSString*)hash
                      block:(void(^)(BOOL suc,
                                     NSInteger status,
                                     NSString* errorMessage,
                                     NSString* dateString,
                                     NSInteger blockNumber))block;

//当前账户是否存在
-(BOOL)isAlreadyExists:(NSString*)chainName address:(NSString*)address;

//获取余额
-(void)getBalanceWithCallBack:(CallBackBlock)callback;

//链接节点
-(void)connectNode:(ABUserModel*)userModel
             block:(void (^)(void))block
              fail:(void (^)(NSString * errorMsg))fail;

@end

NS_ASSUME_NONNULL_END
