//
//  ABAddWalletsCell.m
//  Aocoin
//  Created by 邢现庆 on 2020/4/1.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABAddWalletsCell.h"

@implementation ABAddWalletsCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = VC_BACKGROUND_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
