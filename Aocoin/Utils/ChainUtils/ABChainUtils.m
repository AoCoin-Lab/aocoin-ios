//
//  ABPlistUtils.m
//  Aocoin
//  Created by 邢现庆 on 2020/5/26.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABChainUtils.h"

@implementation ABChainUtils


+(NSMutableArray*)allChains{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ABChain" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    NSArray* allKeys = [dic allKeys];//无序集合获取的顺序是乱的，手写一下
    NSArray* allKeys = @[Chain_Polkadot,Chain_Kusama,Chain_Kulupu];
    NSMutableArray* chains = [NSMutableArray array];
    for (NSString* key in allKeys) {
        NSDictionary* chainDic = [dic objectForKey:key];
        ABChainModel* model = [[ABChainModel alloc]init];
        [model setValuesForKeysWithDictionary:chainDic];
        [chains addObject:model];
    }
    return chains;
}

+(ABChainModel*)chainModelByName:(NSString*)name{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ABChain" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary* chainDic = [dic objectForKey:name];
    ABChainModel* model = [[ABChainModel alloc]init];
    [model setValuesForKeysWithDictionary:chainDic];
    return model;
}

@end
