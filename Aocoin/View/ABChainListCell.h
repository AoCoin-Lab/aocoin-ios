//
//  ABChainListCell.h
//  Aocoin
//  Created by 邢现庆 on 2019/10/21.
//  Copyright © 2019 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABChainListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateIMG;

@property (nonatomic,strong) ABChainModel* chainModel;

@end

NS_ASSUME_NONNULL_END
