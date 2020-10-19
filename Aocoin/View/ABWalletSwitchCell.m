//  AocoinSwitchCell.hoinSwitchCell.m
//  Aocoin
//  Created by 邢现庆 on 2019/12/10.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABWalletSwitchCell.h"


@interface ABWalletSwitchCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectStatusIMG;

@end

@implementation ABWalletSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.borderWidth = 0.5f;
    self.bgView.layer.borderColor = COLOR(216, 219, 228, 1).CGColor;
}

-(void)setUserModel:(ABUserModel *)userModel{
    if (!userModel) return;
    _userModel = userModel;
    _nameLabel.text = [NSString stringWithFormat:@"%@",userModel.username];
    NSString* address = [userModel.address stringByReplacingCharactersInRange:NSMakeRange(6, userModel.address.length-9)
                                                                   withString:@"..."];
    _addressLabel.text = [NSString stringWithFormat:@"%@",address];
    if ([_userModel.address isEqualToString:[ABUserModel defaultUser].address]&&
        [_userModel.chainName isEqualToString:[ABUserDefault objectForKey:Current_Chain]]) {
        self.bgView.backgroundColor = COLOR(26, 27, 37, 1.0);
        [self.selectStatusIMG setHidden:NO];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.addressLabel.textColor = [UIColor whiteColor];
    }else{
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.selectStatusIMG setHidden:YES];
        self.nameLabel.textColor = COLOR(17, 22, 34, 1.0);
        self.addressLabel.textColor = COLOR(17, 22, 34, 1.0);;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
