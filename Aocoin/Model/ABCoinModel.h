//
//  ABCoinModel.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/28.
//Copyright © 2019 Xing. All rights reserved.
//

#import <Realm/Realm.h>

@interface ABCoinModel : RLMObject

@property NSString* balance; // 余额
@property NSString* name; // 全称
@property NSString* Id;//id
@property NSString* abbr;//简称
@property NSString* precision;//精度
@property NSString* imageSrc;//图片

@end

RLM_ARRAY_TYPE(ABCoinModel)
