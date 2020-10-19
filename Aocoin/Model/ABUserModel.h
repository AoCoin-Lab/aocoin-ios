//
//  ABUserModel.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/22.
//Copyright © 2019 Xing. All rights reserved.
//
#import "ABCoinModel.h"
#import <Realm/Realm.h>


@interface ABUserModel : RLMObject

+(ABUserModel*)defaultUser;//全局对象
-(ABUserModel*)updateUserModelWithModel:(ABUserModel*)model;//更新全局对象
-(void)resetModel;//清空
-(void)setDefaultTokens;

@property NSString* chainName;//当前钱包属于哪条公链：TRON / ETH
@property NSString* username;//用户名
@property NSString* password;//密码
@property NSString* mnemonic;//助记词
@property NSString* address;//地址
@property NSString* keystore;//
@property NSString* privateKey;//私钥
@property RLMArray<ABCoinModel>* tokenBalances;// 用户要展示的币 Balance
@end

RLM_ARRAY_TYPE(ABUserModel)
