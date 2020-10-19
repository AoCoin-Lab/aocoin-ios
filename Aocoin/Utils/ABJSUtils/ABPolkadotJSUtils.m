//
//  ABPolkadotJSUtils.m
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABPolkadotJSUtils.h"

@implementation ABPolkadotJSUtils

//获取助记词
+(void)generateMnemonic:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"gm" data:nil responseBlock:responseBlock];
}

//验证助记词
+(void)validateMnemonic:(NSString*)data
          responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"mv" data:data responseBlock:responseBlock];
}

//验证私钥
+(void)validatePK:(NSString*)data
    responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"rv" data:data responseBlock:responseBlock];
}

//是否是激活地址
+(void)isActivateAddress:(NSString*)data
    responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"iaa" data:data responseBlock:responseBlock];
}

//地址转换
+(void)toAddress:(NSString*)data responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"tadr" data:data responseBlock:responseBlock];
}

//根据 助记词 | 私钥 | keystore获取账户
+(void)getAddressFromInfo:(NSString*)data
            responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"rc" data:data responseBlock:responseBlock];
}

//修改密码 返回新的 keystore
+(void)changePassword:(NSString*)data
        responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"cpas" data:data responseBlock:responseBlock];
}

//链接节点
+(void)connectNode:(NSString*)data
            responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"cond" data:data responseBlock:responseBlock];
}

//获取余额
+(void)getBalance:(NSString*)data
         responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"gblc" data:data responseBlock:responseBlock];
}
//获取交易手续费
+(void)getTransactionFee:(NSString*)data
         responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"tfe" data:data responseBlock:responseBlock];
}

//发送交易
+(void)sendTransaction:(NSString*)data
         responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"stx" data:data responseBlock:responseBlock];
}

//验证地址
+(void)verifyAddress:(NSString*)data
       responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"ckadr" data:data responseBlock:responseBlock];
}

//根据区块hash获取区块
+(void)getBlockByBlockHash:(NSString*)data
         responseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"gbbh" data:data responseBlock:responseBlock];
}

//获取最新的区块：
+(void)getLastBlockWithResponseBlock:(IdResponseBlock)responseBlock{
    [[ABJSUtils shareUtils] callMethedWithName:@"glb" data:@"" responseBlock:responseBlock];
}






@end
