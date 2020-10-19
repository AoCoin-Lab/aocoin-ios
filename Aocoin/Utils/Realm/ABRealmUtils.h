//
//  ABRealmUtils.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/23.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REALM_VERISON 1

NS_ASSUME_NONNULL_BEGIN

@interface ABRealmUtils : NSObject



+(ABRealmUtils*)shareUtils;

//钱包
-(RLMRealm*)walletsRealm;

//钱包
-(RLMRealm*)walletsRealm:(NSString*)chainName;

//所有公链的钱包
-(NSMutableArray*)loadAllWalletList;

//当前用户的余额，传入币的id
-(NSDecimalNumber*)balanceById:(NSString*)Id;

//币model，传入币的id
-(ABCoinModel*)coinModelById_CONTAINS_C:(NSString*)tokenID;

//币model，传入币的abbr
-(ABCoinModel*)coinModelByaAbbr:(NSString*)abbr;

@end

NS_ASSUME_NONNULL_END
