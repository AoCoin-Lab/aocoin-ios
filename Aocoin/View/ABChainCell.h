//
//  ABChainCell.h
//  Aocoin
//  Created by 邢现庆 on 2019/10/18.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABChainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (nonatomic,strong)ABChainModel* chainModel;

@property (nonatomic,strong)UIColor* normalColor;
@property (nonatomic,strong)UIColor* selectColor;
@end

NS_ASSUME_NONNULL_END
