//
//  ABJSUtils.h
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^IdResponseBlock)(id responseData);

@interface ABJSUtils : NSObject

+(ABJSUtils*)shareUtils;

+(NSString*)js_errorMsg:(id)error;

-(void)callMethedWithName:(NSString*)methedName
                     data:(NSString* _Nullable)data
            responseBlock:(IdResponseBlock)responseBlock;

@end

NS_ASSUME_NONNULL_END
