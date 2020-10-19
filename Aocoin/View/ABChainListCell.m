//
//  ABChainListCell.m
//  Aocoin
//  Created by 邢现庆 on 2019/10/21.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABChainListCell.h"

@implementation ABChainListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setChainModel:(ABChainModel *)chainModel{
    _chainModel = chainModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",chainModel.name];
    self.iconIMG.image = [UIImage imageNamed:chainModel.imageSelected];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.stateIMG.image = selected ? [UIImage imageNamed:@"chain_selected"] : [UIImage imageNamed:@"chain_unselect"];
}

@end
