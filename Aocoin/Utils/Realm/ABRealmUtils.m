//
//  ABRealmUtils.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/23.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABRealmUtils.h"



@implementation ABRealmUtils

static ABRealmUtils *shareUtils = nil;

+(ABRealmUtils*)shareUtils{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUtils = [[ABRealmUtils alloc] init];
    });
    return shareUtils;
}

-(RLMRealm*)walletsRealm{
    return [self walletsRealm:[ABUserDefault objectForKey:Current_Chain]];
}

//钱包
-(RLMRealm*)walletsRealm:(NSString*)chainName{
    NSString* name = [NSString stringWithFormat:@"%@WalletList",chainName];
    [self setReamlWithName:name];
    RLMRealm *realm = [RLMRealm defaultRealm];
    return realm;
}

//所有公链的钱包
-(NSMutableArray*)loadAllWalletList{
    NSMutableArray* chainArray = [ABChainUtils allChains];
    NSMutableArray* userArray = [NSMutableArray array];
    for (ABChainModel* model in chainArray) {
        RLMRealm *realm = [self walletsRealm:model.name];
        
        RLMResults* users = [ABUserModel allObjectsInRealm:realm];
        [userArray addObject:users];
    }
    return userArray;
}

- (void)setReamlWithName:(NSString *)name {
    //先获取默认配置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // 使用默认的目录，替换默认的文件名
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:name]
                      URLByAppendingPathExtension:@"realm"];
    //TODO://此处暂不加密，需要时自己加
//    config.encryptionKey = [self getKey];
    config.schemaVersion = REALM_VERISON;
    // 将这个配置应用到默认的 Realm 数据库当中
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

-(NSDecimalNumber*)balanceById:(NSString*)Id{
    ABCoinModel* trc = [self coinModelById_CONTAINS_C:Id];
    NSDecimalNumber* balance = [ABValueUtils balanceByPrecision:trc.balance precision:trc.precision];
    return balance;
}

-(ABCoinModel*)coinModelById_CONTAINS_C:(NSString*)tokenID{
    RLMArray* TRCarray = [ABUserModel defaultUser].tokenBalances;
    NSPredicate * p = [NSPredicate predicateWithFormat:@"Id CONTAINS[c] %@",tokenID];
    ABCoinModel* model = [[TRCarray objectsWithPredicate:p] firstObject];
    return model;
}

-(ABCoinModel*)coinModelByaAbbr:(NSString*)abbr{
    RLMArray* tokens = [ABUserModel defaultUser].tokenBalances;
    NSPredicate* p = [NSPredicate predicateWithFormat:@"abbr CONTAINS[c] %@",abbr];
    ABCoinModel* model = [[tokens objectsWithPredicate:p]firstObject];
    return model;
}


@end
