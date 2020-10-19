//
//  ABChainListVC.m
//  Aocoin
//  Created by 邢现庆 on 2019/10/21.
//  Copyright © 2019 Xing. All rights reserved.
//

#import "ABChainListVC.h"
#import "ABChainListCell.h"
#import "ABCreateWalletVC.h"
#import "ABImportTypeVC.h"

@interface ABChainListVC ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet ABButton *nextBtn;
@property (nonatomic,copy)NSString* chainName;

@end

@implementation ABChainListVC

static NSString* ident = @"chainListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"当前底层";
    
    self.dataArray = [ABChainUtils allChains];
    
    [self initUI];
    
    [self defaultSelect];
    
}

-(void)defaultSelect{
    WeakSelf(ABChainListVC);
    if (![ABValueUtils isEmpty:[ABUserDefault objectForKey:Current_Chain]]) {
        self.chainName = [ABUserDefault objectForKey:Current_Chain];
    }else{
        self.chainName = Chain_Polkadot;//默认
    }
    __block NSUInteger index;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ABChainModel* model = obj;
        if ([model.name isEqualToString:weakSelf.chainName]) {
            index = idx;
            *stop = YES;
        }
    }];
    [self configCurrentChain:index];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
}

-(void)initUI{
    self.tableViewFrame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-StatusBarAndNavigationBarHeight - 150);
    self.tableViewStyle = UITableViewStylePlain;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = BLACK_TABLE_SEPARATOR_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    self.footerView.frame = CGRectMake(0, ScreenHeight -80-StatusBarAndNavigationBarHeight, ScreenWidth, 80);
    [self.view addSubview:self.footerView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABChainListCell class]) bundle:nil] forCellReuseIdentifier:ident];
}

- (IBAction)next:(ABButton *)sender {
    switch (self.createType) {
        case ABWalletCreateType_Create:{
            ABCreateWalletVC* creatVC = [[ABCreateWalletVC alloc]initWithNibName:@"ABCreateWalletVC" bundle:nil];
            creatVC.createType = self.createType;
            creatVC.chainName = self.chainName;
            [self.navigationController pushViewController:creatVC animated:YES];
        }
            break;
        case ABWalletCreateType_Import:{
            ABImportTypeVC* vc = [[ABImportTypeVC alloc]initWithTableFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
            vc.chainName = self.chainName;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABChainListCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    cell.chainModel = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [self configCurrentChain:indexPath.row];
}

-(void)configCurrentChain:(NSInteger)index{
    ABChainModel* model = self.dataArray[index];
    self.chainName = model.name;
}

@end
