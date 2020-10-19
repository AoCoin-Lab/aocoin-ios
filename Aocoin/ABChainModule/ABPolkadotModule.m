//
//  ABPolkadotModule.m
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABPolkadotModule.h"
#import "ABKusamaModule.h"
#import "ABKulupuModule.h"

@implementation ABPolkadotModule

//ss58Format：Polkadot -- 0 | Kusama -- 2 | Kulupu -- 16
-(NSInteger)ss58Format{
    return [ABChainUtils chainModelByName:Chain_Polkadot].ss58Format;
}

-(NSString*)endpoint{
    ABChainModel* model = [ABChainUtils chainModelByName:Chain_Polkadot];
    return [model.endpoint firstObject];
}

//创建钱包
-(void)createWalletWithPWD:(NSString*)password
                     Block:(void(^)(ABUserModel* userModel))block
                      fail:(void(^)(NSString *errorMsg))fail{
    [ABPolkadotJSUtils generateMnemonic:^(id responseData) {
        NSDictionary* dic = responseData;
        if ([ABValueUtils intValue:dic forKey:@"success"] == 1) {
            NSString* mnemonic = [dic objectForKey:@"body"];
            NSDictionary* params = @{@"keyType":@"mnemonic",
                                     @"key":mnemonic,
                                     @"password":password};
            [ABPolkadotJSUtils getAddressFromInfo:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                NSDictionary* res = responseData;
                if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
                    NSDictionary* bodyDic = [res objectForKey:@"body"];
                    NSString* address = [bodyDic objectForKey:@"address"];
                    NSString* rawSeed = [bodyDic objectForKey:@"rawSeed"];
                    NSDictionary* keystoreDic = [bodyDic objectForKey:@"keystore"];
                    NSString* keystore = [ABValueUtils dictionaryToString:keystoreDic];
                    NSDictionary* params = @{@"address":address,
                                             @"ss58Format":[NSNumber numberWithInteger:[self ss58Format]]};
                    [ABPolkadotJSUtils toAddress:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                        NSDictionary* resp = responseData;
                        if ([ABValueUtils intValue:resp forKey:@"success"] == 1) {
                            NSString* address = [resp objectForKey:@"body"];
                            ABUserModel* model = [[ABUserModel alloc]init];
                            model.address = address;
                            model.mnemonic = mnemonic;
                            model.keystore = keystore;
                            model.privateKey = rawSeed;
                            model.password = password;
                            block(model);
                        }else{
                            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                        }
                    }];
                }else{
                    fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                }
            }];
        }else{
            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
        }
    }];
}

//助记词导入
-(void)importWalletByMnemonic:(ABUserModel*)model
                        block:(void(^)(ABUserModel* userModel))block
                         fail:(void(^)(NSString *errorMsg))fail{
    NSDictionary* params = @{@"seed":model.mnemonic};
    [ABPolkadotJSUtils validateMnemonic:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        if ([ABValueUtils intValue:responseData forKey:@"success"] == 1 &&
            [ABValueUtils intValue:responseData forKey:@"body"] == 1) {
            NSDictionary* params = @{@"keyType":@"mnemonic",
                                     @"key":model.mnemonic,
                                     @"password":@""};
            [ABPolkadotJSUtils getAddressFromInfo:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                NSDictionary* res = responseData;
                if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
                    NSDictionary* bodyDic = [res objectForKey:@"body"];
                    NSString* address = [bodyDic objectForKey:@"address"];
                    NSString* rawSeed = [bodyDic objectForKey:@"rawSeed"];
                    NSDictionary* params = @{@"address":address,
                                             @"ss58Format":[NSNumber numberWithInteger:[self ss58Format]]};
                    [ABPolkadotJSUtils toAddress:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                        NSDictionary* resp = responseData;
                        if ([ABValueUtils intValue:resp forKey:@"success"] == 1) {
                            NSString* address = [resp objectForKey:@"body"];
                            if([self isAlreadyExists:model.chainName address:address]){
                                fail(@"钱包已存在，不需要导入");
                                return;
                            }
                            model.address = address;
                            model.privateKey = rawSeed;
                            block(model);
                        }else{
                            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                        }
                    }];
                }else{
                    fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                }
            }];
        }else{
            fail(@"助记词无效");
        }
    }];
}

//私钥导入
-(void)importWalletByPrivateKey:(ABUserModel*)model
                          block:(void(^)(ABUserModel* userModel))block
                           fail:(void(^)(NSString *errorMsg))fail{
    NSDictionary* params = @{@"keyType":@"rawSeed",
                             @"key":model.privateKey,
                             @"password":@""};
    [ABPolkadotJSUtils getAddressFromInfo:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            NSDictionary* bodyDic = [res objectForKey:@"body"];
            NSString* address = [bodyDic objectForKey:@"address"];
            NSDictionary* params = @{@"address":address,
                                     @"ss58Format":[NSNumber numberWithInteger:[self ss58Format]]};
            [ABPolkadotJSUtils toAddress:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                NSDictionary* resp = responseData;
                if ([ABValueUtils intValue:resp forKey:@"success"] == 1) {
                    NSString* address = [resp objectForKey:@"body"];
                    if([self isAlreadyExists:model.chainName address:address]){
                        fail(@"钱包已存在，不需要导入");
                        return;
                    }
                    model.address = address;
                    block(model);
                }else{
                    fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                }
            }];
        }else{
            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
        }
    }];
}

//Keystore导入
-(void)importWalletByKeystore:(ABUserModel*)model
                        block:(void(^)(ABUserModel* userModel))block
                         fail:(void(^)(NSString *errorMsg))fail{
    NSDictionary* params = @{@"keyType":@"keystore",
                             @"key":model.keystore,
                             @"password":model.password};
    [ABPolkadotJSUtils getAddressFromInfo:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            NSDictionary* bodyDic = [res objectForKey:@"body"];
            NSString* address = [bodyDic objectForKey:@"address"];
            NSDictionary* params = @{@"address":address,
                                     @"ss58Format":[NSNumber numberWithInteger:[self ss58Format]]};
            [ABPolkadotJSUtils toAddress:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
                NSDictionary* resp = responseData;
                if ([ABValueUtils intValue:resp forKey:@"success"] == 1) {
                    NSString* address = [resp objectForKey:@"body"];
                    if([self isAlreadyExists:model.chainName address:address]){
                        fail(@"钱包已存在，不需要导入");
                        return;
                    }
                    model.address = address;
                    block(model);
                }else{
                    fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
                }
            }];
        }else{
            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
        }
    }];
}

//重新生成keystore
-(void)loadUserKeystore:(ABUserModel*)model
                     pwd:(NSString*)pwd
                   block:(void(^)(NSString *keystore))block
                    fail:(void(^)(NSString *errorMsg))fail{
    if (![ABValueUtils isEmpty:model.keystore]) {
        block(model.keystore);
        return;
    }
    NSDictionary* params = [NSDictionary dictionary];
    if (![ABValueUtils isEmpty:model.mnemonic]) {
        params = @{@"keyType":@"mnemonic",
                   @"key":model.mnemonic,
                   @"password":model.password};
    }else if (![ABValueUtils isEmpty:model.privateKey]) {
        params = @{@"keyType":@"rawSeed",
                   @"key":model.privateKey,
                   @"password":model.password};
    }

    if ([ABValueUtils isEmpty:params]) {
        fail(@"助记词/私钥无效");
        return;
    }
    
    [ABPolkadotJSUtils getAddressFromInfo:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            NSDictionary* bodyDic = [res objectForKey:@"body"];
            NSDictionary* keystoreDic = [bodyDic objectForKey:@"keystore"];
            block([ABValueUtils dictionaryToString:keystoreDic]);
        }else{
            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
        }
    }];
}

//验证地址
-(void)verifyAddress:(NSString*)address
               block:(void(^)(void))block
                fail:(void(^)(NSString *errorMsg))fail{
    NSDictionary* params = @{@"address":address,
                             @"ss58Format":[NSNumber numberWithInteger:[self ss58Format]]};
    [ABPolkadotJSUtils verifyAddress:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            NSDictionary* bodyDic = [res objectForKey:@"body"];
            BOOL b = [[bodyDic objectForKey:@"isValid"]boolValue];
            if (b) {
                block();
            }else{
                fail([bodyDic objectForKey:@"message"]);
            }
        }else{
            fail([ABJSUtils js_errorMsg:[responseData objectForKey:@"errorMsg"]]);
        }
    }];
}

//转账
-(void)transferWithUser:(ABUserModel*)userModel
         receiveAddress:(NSString*)receiveAddress
              coinModel:(ABCoinModel*)coinModel
                coinNum:(NSString*)coinNum
                  block:(void(^)(BOOL suc, NSString* errorMessage,NSString* hashStr,NSDictionary* _Nullable optionalDic))block{
    NSDecimalNumber* num = [ABValueUtils multiplyingPrecision:coinNum precision:coinModel.precision];
    NSDictionary* params = @{@"txInfo":@{
                                     @"module":@"balances",
                                     @"call":@"transfer",
                                     @"address":userModel.address, // 当前钱包地址
                                     @"proxy":@"",// 代理地址
                                     @"proxy": @"",
                                     @"password": userModel.password,
                                     @"pk":userModel.keystore,
                                     @"ss58": @"",
                                     @"tip": @"",//小费
                                    },
                             @"paramList":@[receiveAddress,num.stringValue],
    };
    [ABPolkadotJSUtils sendTransaction:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {//广播成功
            NSDictionary* bodyDic = [res objectForKey:@"body"];
//            block(YES,@"",[bodyDic objectForKey:@"hash"],bodyDic);
            BOOL b = [[bodyDic objectForKey:@"result"]boolValue];
            if (b) {
                block(YES,@"",[bodyDic objectForKey:@"hash"],nil);//交易成功
            }else{
                block(NO,@"失败",[bodyDic objectForKey:@"errorMsg"],nil);
            }
        }else{
            NSString* msg = [ABJSUtils js_errorMsg:[res objectForKey:@"errorMsg"]];
            msg = [NSString stringWithFormat:@"%@:%@",@"广播失败",msg];
            block(NO,msg,@"",nil);
        }
    }];
}

//通过区块hash 获取区块
-(void)getTransactionStatus:(NSString*)hash
                      block:(void(^)(BOOL suc,
                                     NSInteger status,
                                     NSString* errorMessage,
                                     NSString* dateString,
                                     NSInteger blockNumber))block{
    NSDictionary* params = @{@"blockHash":hash};
    [ABPolkadotJSUtils getBlockByBlockHash:[ABValueUtils dictionaryToString:params] responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            block(YES,1,@"",@"",[[res objectForKey:@"body"]integerValue]);
        }else{
            block(NO,-1,[ABJSUtils js_errorMsg:[res objectForKey:@"errorMsg"]],@"",0);
        }
    }];
}

//链接节点
-(void)connectNode:(ABUserModel*)userModel
             block:(void (^)(void))block
              fail:(void (^)(NSString * errorMsg))fail{
    NSDictionary* params = @{@"endpoint":[self endpoint]};
    [ABPolkadotJSUtils connectNode:[ABValueUtils dictionaryToString:params]
                                 responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            block();
        }else{
            fail([ABJSUtils js_errorMsg:[res objectForKey:@"errorMsg"]]);
        }
    }];
}


//获取余额
-(void)getBalanceWithCallBack:(CallBackBlock)callback{
    NSDictionary* params = @{@"endpoint":[self endpoint]};
    [ABPolkadotJSUtils connectNode:[ABValueUtils dictionaryToString:params]
                     responseBlock:^(id responseData) {
        NSDictionary* res = responseData;
        if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
            NSDictionary* balanceDic = @{@"address":[ABUserModel defaultUser].address};
            [ABPolkadotJSUtils getBalance:[ABValueUtils dictionaryToString:balanceDic]
                            responseBlock:^(id responseData) {
                NSDictionary* res = responseData;
                if ([ABValueUtils intValue:res forKey:@"success"] == 1) {
                    NSDictionary* bodyDic = [res objectForKey:@"body"];
                    RLMRealm *realm = [[ABRealmUtils shareUtils]walletsRealm];
                    [realm transactionWithBlock:^{
                        ABCoinModel* dot = [[ABUserModel defaultUser].tokenBalances firstObject];
                        dot.balance = [NSString stringWithFormat:@"%@",[bodyDic objectForKey:@"freeBalance"]];
                    }];
                    callback();
                }else{
                    [ABAlertView toastLabel:[ABJSUtils js_errorMsg:[res objectForKey:@"errorMsg"]]
                                inSuperView:[UIApplication sharedApplication].delegate.window];
                    callback();
                }
            }];
        }else{
            [ABAlertView toastLabel:[ABJSUtils js_errorMsg:[res objectForKey:@"errorMsg"]]
                        inSuperView:[UIApplication sharedApplication].delegate.window];
            callback();
        }
    }];
}
@end
