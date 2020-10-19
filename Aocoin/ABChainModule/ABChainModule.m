//
//  ABChainModule.m
//  Aocoin
//  Created by 邢现庆 on 2020/6/2.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABChainModule.h"
//#import "ABTRONModule.h"
//#import "ABETHModule.h"
#import "ABKulupuModule.h"
#import "ABKusamaModule.h"
#import "ABPolkadotModule.h"

@implementation ABChainModule

+(ABChainModule*)chainModule{
    return [self chainModuleWithName:[ABUserDefault objectForKey:Current_Chain]];
}

+(ABChainModule*)chainModuleWithName:(NSString*)chainName{
    if ([chainName isEqualToString:Chain_Kusama]) {
        return [[ABKusamaModule alloc]init];
    }
    if ([chainName isEqualToString:Chain_Kulupu]) {
        return [[ABKulupuModule alloc]init];
    }
    return [[ABPolkadotModule alloc]init];
}

//当前账户是否存在
-(BOOL)isAlreadyExists:(NSString*)chainName address:(NSString*)address{
    [[ABRealmUtils shareUtils]walletsRealm:chainName];
    ABUserModel* model = [ABUserModel objectForPrimaryKey:address];
    if (model) {
        return YES;
    }
    return NO;
}
@end
