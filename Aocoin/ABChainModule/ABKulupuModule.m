//
//  ABKulupuModule.m
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABKulupuModule.h"

@implementation ABKulupuModule

//ss58Format：Polkadot -- 0 | Kusama -- 2 | Kulupu -- 16
-(NSInteger)ss58Format{
    return [ABChainUtils chainModelByName:Chain_Kulupu].ss58Format;
}

-(NSString*)endpoint{
    ABChainModel* model = [ABChainUtils chainModelByName:Chain_Kulupu];
    return [model.endpoint firstObject];
}

@end
