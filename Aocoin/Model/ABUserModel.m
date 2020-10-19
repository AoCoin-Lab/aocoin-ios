//
//  ABUserModel.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/22.
//Copyright © 2019 Xing. All rights reserved.
//

#import "ABUserModel.h"

@implementation ABUserModel

static ABUserModel *userModel = nil;
static dispatch_once_t onceToken;

/** 设置主键 */
+(NSString *)primaryKey{
    return @"address";
}

+(ABUserModel*)defaultUser{
    dispatch_once(&onceToken, ^{
        userModel = [[ABUserModel alloc] init];
    });
    return userModel;
}

-(ABUserModel*)updateUserModelWithModel:(ABUserModel*)model{
    userModel = model;
    return userModel;
}

-(void)resetModel{
    onceToken = 0;
    userModel = nil;
}

+ (NSArray *)ignoredProperties{
    
    return @[];
}

-(void)setDefaultTokens{
    NSArray* array;
    
    if([[ABUserDefault objectForKey:Current_Chain] isEqualToString:Chain_Polkadot]){
        array = [self pokadotDefaultTokens];
    }else if([[ABUserDefault objectForKey:Current_Chain] isEqualToString:Chain_Kusama]){
        array = [self kusamaDefaultTokens];
    }else if([[ABUserDefault objectForKey:Current_Chain] isEqualToString:Chain_Kulupu]){
        array = [self kulupuDefaultTokens];
    }
    for (NSDictionary* dic in array) {
        ABCoinModel* model  = [[ABCoinModel alloc]init];
        model.balance = [NSString stringWithFormat:@"%@",[dic objectForKey:@"balance"]];
        model.Id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Id"]];
        model.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        model.abbr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"abbr"]];
        model.precision = [NSString stringWithFormat:@"%@",[dic objectForKey:@"precision"]];
        model.imageSrc = [NSString stringWithFormat:@"%@",[dic objectForKey:@"imageSrc"]];
        [self.tokenBalances addObject:model];
    }
}

-(NSArray*)pokadotDefaultTokens{
    return @[
        @{
            @"balance":@"0",
            @"Id": @"DOT",
            @"name":@"DOT",
            @"abbr": @"DOT",
            @"precision": @"10",
            @"type":@"",
            @"imageSrc":@"Polkadot_selected",
            @"price":@"0",
        }
    ];
}

-(NSArray*)kusamaDefaultTokens{
    return @[
        @{
            @"balance":@"0",
            @"Id": @"KSM",
            @"name":@"KSM",
            @"abbr": @"KSM",
            @"precision": @"12",
            @"type":@"",
            @"imageSrc":@"Kusama_selected",
            @"price":@"0",
        }
    ];
}

-(NSArray*)kulupuDefaultTokens{
    return @[
        @{
            @"balance":@"0",
            @"Id": @"KLP",
            @"name":@"KLP",
            @"abbr": @"KLP",
            @"precision": @"12",
            @"type":@"",
            @"imageSrc":@"Kulupu_selected",
            @"price":@"0",
        }
    ];
}



@end
