//
//  ABChainCell.m
//  Aocoin
//  Created by 邢现庆 on 2019/10/18.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABChainCell.h"

@implementation ABChainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = COLOR(245, 247, 253, 1);
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
}

-(void)setChainModel:(ABChainModel *)chainModel{
    _chainModel = chainModel;
    self.iconIMG.image = [UIImage imageNamed:chainModel.imageNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.iconIMG.image = [UIImage imageNamed:self.chainModel.imageSelected];
        self.contentView.backgroundColor = self.selectColor ? self.selectColor : [UIColor whiteColor];
    }else{
        self.iconIMG.image = [UIImage imageNamed:self.chainModel.imageNormal];
        self.contentView.backgroundColor = self.normalColor ? self.normalColor : COLOR(245, 247, 253, 1);
    }
}

@end
