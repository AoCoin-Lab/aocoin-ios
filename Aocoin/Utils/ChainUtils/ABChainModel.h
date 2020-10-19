//
//  ABChainModel.h
//  Aocoin
//  Created by 邢现庆 on 2020/5/26.
//  Copyright © 2020 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ABChainModel : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *describe;
@property (nonatomic , copy) NSString *imageNormal;
@property (nonatomic , copy) NSString *imageSelected;
@property (nonatomic , strong) NSArray* endpoint;//节点数组
@property (nonatomic , assign) NSInteger ss58Format;//Polkadot -- 0 | Kusama -- 2 | Kulupu -- 16
@end

NS_ASSUME_NONNULL_END
