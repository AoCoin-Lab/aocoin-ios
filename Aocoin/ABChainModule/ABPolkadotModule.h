//
//  ABPolkadotModule.h
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABChainModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABPolkadotModule : ABChainModule

-(NSInteger)ss58Format;

-(NSString*)endpoint;

@end

NS_ASSUME_NONNULL_END
