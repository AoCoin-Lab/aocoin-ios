//
//  ABPlistUtils.h
//  Aocoin
//  Created by 邢现庆 on 2020/5/26.
//  Copyright © 2020 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABChainUtils : NSObject

//所有公链
+(NSMutableArray*)allChains;

//根据公链名字获取公链model
+(ABChainModel*)chainModelByName:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
