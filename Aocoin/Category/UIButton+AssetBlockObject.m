//
//  UIButton+AssetBlockObject.m
//  JinRongProject
//
//  Created by ZXY on 2017/2/21.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "UIButton+AssetBlockObject.h"
#import "objc/runtime.h"

static char TouchBlockKey;
@implementation UIButton (AssetBlockObject)
-(void)addTouchBlockHandler:(TouchBlock)handler forControlEvents:(UIControlEvents)controlEvent{
    objc_setAssociatedObject(self, &TouchBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(touchUpInSide:) forControlEvents:controlEvent];
}
-(void)touchUpInSide:(UIButton*)button{
    TouchBlock block = objc_getAssociatedObject(self, &TouchBlockKey);
    if (block) {
        block();
    }
}

@end
