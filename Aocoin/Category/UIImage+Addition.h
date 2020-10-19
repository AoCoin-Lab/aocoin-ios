//
//  UIImage+Addition.h
//  Aocoin
//  Created by 邢现庆 on 2019/8/15.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Addition)
+(UIImage *)AB_makeImageWithView:(UIView *)view withSize:(CGSize)size;
+(UIImage *)AB_imageWithColor:(UIColor *)color;
+(UIImage *)AB_scaleToSize:(UIImage *)img size:(CGSize)size;
-(UIImage *)AB_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
