//
//  ABMessageBgView.h
//  Aocoin
//  Created by 邢现庆 on 2019/9/11.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABMessageBgView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabel_C;
@property (weak, nonatomic) IBOutlet UIView *bgView;

-(instancetype)initWithHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
