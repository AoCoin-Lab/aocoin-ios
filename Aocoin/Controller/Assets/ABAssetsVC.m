//
//  ABAssetsVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/8/14.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABAssetsVC.h"
#import "ABAocoinVC.h"
#import "ABAssetsCell.h"
#import "ABCoinModel.h"
#import "ABTransferVC.h"
#import "ABWalletSwitchVC.h"
#import "MJRefresh.h"


@interface ABAssetsVC ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic,assign)CGFloat oldTronHeaderHeight;
@property (nonatomic,assign)CGFloat oldEthHeaderHeight;
@property (nonatomic,assign)CGFloat oldPolkadotHeaderHeight;
@property (strong, nonatomic) IBOutlet UIView *barView;
@property (copy, nonatomic) NSString *buyCoinUrlString;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *listTitleView;

@end

@implementation ABAssetsVC

static NSString* ident = @"ABAssetsCell";

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showUserInfo];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self addUserToken];
}


-(void)loadData{
    [[ABChainModule chainModule] getBalanceWithCallBack:^{
        [self.tableView reloadData];
        [self.tableView endRefrenshing];
    }];
}
-(void)addUserToken{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiSwitchWallet) name:Noti_SwitchWallets object:nil];
}

-(void)notiSwitchWallet{
    [self showUserInfo];
    [self.tableView reloadData];
    [self loadData];
}

-(void)showUserInfo{
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[ABUserModel defaultUser].username];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[ABUserModel defaultUser].address];
}

-(void)initUI{
    self.title = @"资产";
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABAssetsCell class]) bundle:nil] forCellReuseIdentifier:ident];
        
    self.barView.frame = CGRectMake(0, 0, 100, 28);
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:self.barView];
    item.width = 100;
    self.navigationItem.leftBarButtonItem = item;
    
    [self.tableView normalWithrefreshType:RefreshTypeDropDown firstRefresh:YES dropDownBlock:^{
        [self loadData];
    } upDropBlock:nil];
}

- (IBAction)switchWallet:(UIButton *)sender {
    ABWalletSwitchVC* vc = [[ABWalletSwitchVC alloc]initWithNibName:@"ABWalletSwitchVC" bundle:nil];
    RTRootNavigationController* nav = [[RTRootNavigationController alloc]initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor clearColor];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[UIApplication sharedApplication].delegate                   .window.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)receivables:(UIButton *)sender {
    [ABAlertView toastLabel:@"敬请期待" inSuperView:self.view];
}

- (IBAction)transfer:(UIButton *)sender {
    ABTransferVC* vc = [[ABTransferVC alloc]initWithNibName:@"ABTransferVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ABUserModel defaultUser].tokenBalances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABAssetsCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (indexPath.row < [ABUserModel defaultUser].tokenBalances.count) {
        cell.coinModel = [[ABUserModel defaultUser].tokenBalances objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.listTitleView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Noti_SwitchWallets object:nil];
}


@end
