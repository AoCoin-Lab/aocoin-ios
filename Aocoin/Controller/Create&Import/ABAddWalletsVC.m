//
//  ABAddWalletsVC.m
//  Aocoin
//  Created by 邢现庆 on 2020/4/1.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABAddWalletsVC.h"
#import "ABAddWalletsCell.h"
#import "ABMnemonicImportVC.h"
#import "ABPrivateImportVC.h"
#import "ABKeystoreImportVC.h"
#import "ABCreateWalletVC.h"

@interface ABAddWalletsVC ()

@property(nonatomic,strong)NSArray* sectionTitleArray;

@end

@implementation ABAddWalletsVC

static NSString* ident = @"ABAddWalletsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加钱包";
    
    NSArray* importArray = @[@{@"title":@"助记词",@"image":@"mnemonic_icon",},
                             @{@"title":@"私钥",@"image":@"private_icon",},
                             @{@"title":@"Keystore",@"image":@"keystore_icon",}];
    NSArray* createArray = @[@{@"title":@"创建钱包",@"image":@"create_icon"}];

    self.sectionTitleArray = @[@"导入钱包",@"创建钱包"];
    self.dataArray = [NSMutableArray arrayWithObjects:importArray,createArray,nil];

    [self initUI];
    
}

-(void)initUI{
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGFLOAT_MIN)];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABAddWalletsCell class]) bundle:nil] forCellReuseIdentifier:ident];
}

#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 32)];
    view.backgroundColor = VC_BACKGROUND_COLOR;
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(15,10, ScreenWidth-30, 22)];
    label.text = self.sectionTitleArray[section];
    label.textColor = TF_PLACEHOLDER_COLOR;
    label.font = [UIFont fontWithName:PingFangSC_Regular size:F_12];
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABAddWalletsCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    NSArray* array = self.dataArray[indexPath.section];
    NSDictionary* dic = array[indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.iconImg.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [self goImport:indexPath];
            break;
        case 1:
            [self goCreate:indexPath];
            break;
        default:
            break;
    }
}

-(void)goImport:(NSIndexPath*)indexPath{
    switch (indexPath.row) {
            case 0:{
                ABMnemonicImportVC* vc = [[ABMnemonicImportVC alloc]initWithNibName:@"ABMnemonicImportVC" bundle:nil];
                vc.chainName = self.chainName;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                ABPrivateImportVC* vc = [[ABPrivateImportVC alloc]initWithNibName:@"ABPrivateImportVC" bundle:nil];
                vc.chainName = self.chainName;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{
                ABKeystoreImportVC* vc = [[ABKeystoreImportVC alloc]initWithNibName:@"ABKeystoreImportVC" bundle:nil];
                vc.chainName = self.chainName;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
}

-(void)goCreate:(NSIndexPath*)indexPath{
    ABCreateWalletVC* creatVC = [[ABCreateWalletVC alloc]initWithNibName:@"ABCreateWalletVC" bundle:nil];
    creatVC.createType = ABWalletCreateType_Create;
    creatVC.chainName = self.chainName;
    [self.navigationController pushViewController:creatVC animated:YES];
}


@end
