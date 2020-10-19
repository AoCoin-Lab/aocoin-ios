//
//  ABCoinModel.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/28.
//Copyright © 2019 Xing. All rights reserved.
//

#import "ABCoinModel.h"

@implementation ABCoinModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}


@end
