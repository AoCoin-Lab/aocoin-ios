//
//  ABAssetsCell.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/14.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABAssetsCell.h"

@interface ABAssetsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end

@implementation ABAssetsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = VC_BACKGROUND_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 9;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setCoinModel:(ABCoinModel *)coinModel{
    _coinModel = coinModel;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",coinModel.abbr];
    //个数
    NSDecimalNumber* result = [ABValueUtils balanceByPrecision:coinModel.balance precision:coinModel.precision];
    if (![ABValueUtils isEmpty:result.stringValue]) {
        self.valueLabel.text = [ABValueUtils AB_SeparateNumberText:[NSString stringWithFormat:@"%@",result]];
    }else{
        self.valueLabel.text = @"0";
    }
    self.iconImg.image = [UIImage imageNamed:coinModel.imageSrc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
