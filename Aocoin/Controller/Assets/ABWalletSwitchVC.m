//
//  AocoinSwitchVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/12/10.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABWalletSwitchVC.h"
#import "ABWalletSwitchCell.h"
#import "ABChainCell.h"
#import "ABAddWalletsVC.h"
#import "ABMessageBgView.h"

@interface ABWalletSwitchVC ()

@property RLMResults<ABUserModel*> * users;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *chainNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *navTable;
@property (weak, nonatomic) IBOutlet UITableView *walletsTable;

@property (nonatomic,strong)NSArray* chainArray;
@property (nonatomic,strong)NSArray* walletsData;

@property (nonatomic,copy)NSString* chainName;

@property (nonatomic,strong) ABMessageBgView* msgBgView;

@end

@implementation ABWalletSwitchVC


static NSString* walletIdent = @"ABWalletSwitchCell";

static NSString* chainIdent = @"ABChainCell";


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage* image = [UIImage AB_imageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chainArray = [ABChainUtils allChains];;
    
    [self initUI];
    
    [self loadWalletList];
    
    [self selectDefault];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor clearColor];
    self.walletsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.walletsTable.tableFooterView = [[UIView alloc]init];
    self.navTable.separatorColor = [UIColor clearColor];
    self.navTable.tableFooterView = [[UIView alloc]init];
    [self bgViewCornerRadius];
    
    [self.walletsTable registerNib:[UINib nibWithNibName:@"ABWalletSwitchCell" bundle:nil] forCellReuseIdentifier:walletIdent];
    [self.navTable registerNib:[UINib nibWithNibName:@"ABChainCell" bundle:nil] forCellReuseIdentifier:chainIdent];
}

-(void)bgViewCornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
}

-(void)loadWalletList{
    self.walletsData = [[ABRealmUtils shareUtils]loadAllWalletList];
}

-(void)selectDefault{
    self.chainName = [ABUserDefault objectForKey:Current_Chain];
    for (int i = 0; i < self.chainArray.count; i++) {
        ABChainModel* model = self.chainArray[i];
        if ([self.chainName isEqualToString:model.name]) {
            self.chainNameLabel.text = model.describe;
            self.users = self.walletsData[i];
            [self.navTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.walletsTable reloadData];
        }
    }
}

- (IBAction)close:(UIButton *)sender {
    WeakSelf(ABWalletSwitchVC);
    RTRootNavigationController* nav = (RTRootNavigationController*)self.navigationController;
    [nav dismissViewControllerAnimated:YES completion:^{
        [nav removeViewController:weakSelf];
    }];
}
- (IBAction)walletsAdd:(UIButton *)sender {
    ABAddWalletsVC* vc = [[ABAddWalletsVC alloc]initWithTableFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    vc.chainName = self.chainName;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)setting:(UIButton *)sender {
    
}

#pragma mark -- UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView isEqual:self.navTable] ? 59 : 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableView isEqual:self.navTable] ? self.chainArray.count : self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.navTable]) {
        ABChainCell* cell = [tableView dequeueReusableCellWithIdentifier:chainIdent];
        cell.chainModel = self.chainArray[indexPath.row];
        return cell;
    }

    ABWalletSwitchCell* cell = [tableView dequeueReusableCellWithIdentifier:walletIdent];
    ABUserModel* model = [self.users objectAtIndex:indexPath.row];
    cell.userModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:self.navTable]){
        if (self.walletsData.count == 0) return;
        ABChainModel* model = self.chainArray[indexPath.row];
        self.chainName = model.name;
        self.chainNameLabel.text = model.describe;
        self.users = self.walletsData[indexPath.row];
        [self.walletsTable reloadData];
        [self isShowBackgroundView];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ABUserModel* usermodel = [self.users objectAtIndex:indexPath.row];
    if ([usermodel.address isEqualToString:[ABUserModel defaultUser].address]&&
        [usermodel.chainName isEqualToString:[ABUserDefault objectForKey:Current_Chain]]) {
        return;
    }
    ABUserModel* newModel = [[ABUserModel defaultUser]updateUserModelWithModel:usermodel];
    [ABUserDefault setObject:self.chainName forKey:Current_Chain];
    [ABUserDefault setObject:newModel.address forKey:Current_user_adress];
    [ABUserDefault synchronize];
    [self.walletsTable reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_SwitchWallets object:nil];
}

-(void)isShowBackgroundView{
    [self.addBtn setHidden:NO];
    [self.settingBtn setHidden:NO];
    if (self.users.count == 0) {
        self.msgBgView.bgImage.image = [UIImage imageNamed:@"not_wallets"];
        self.msgBgView.titleLabel.text = @"暂无钱包";
        self.walletsTable.backgroundView = self.msgBgView;
    }else{
        self.walletsTable.backgroundView = [[UIView alloc]init];
    }
}

-(ABMessageBgView *)msgBgView{
    if (!_msgBgView) {
        _msgBgView = [[ABMessageBgView alloc]init];
        _msgBgView.backgroundColor = [UIColor whiteColor];
        _msgBgView.titleLabel_C.constant = 50;
        _msgBgView.titleLabel.textColor = COLOR(52, 52, 52, 1.0);
        _msgBgView.desLabel.textColor = COLOR(52, 52, 52, 1.0);
        _msgBgView.desLabel.text = @"";
    }
    return _msgBgView;
}
@end
