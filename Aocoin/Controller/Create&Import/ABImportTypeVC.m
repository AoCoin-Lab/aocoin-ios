//
//  ABImportTypeVC.m
//  Aocoin
//  Created by 邢现庆 on 2020/3/11.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABImportTypeVC.h"
#import "ABAddWalletsCell.h"
#import "ABMnemonicImportVC.h"
#import "ABPrivateImportVC.h"
#import "ABKeystoreImportVC.h"


@interface ABImportTypeVC ()

@end

@implementation ABImportTypeVC

static NSString* ident = @"ABAddWalletsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导入钱包";
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @{@"title":@"助记词",@"image":@"mnemonic_icon",},
                      @{@"title":@"私钥",@"image":@"private_icon",},
                      @{@"title":@"Keystore",@"image":@"keystore_icon",},nil];
    
    [self initUI];
    
}

-(void)initUI{
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABAddWalletsCell class]) bundle:nil] forCellReuseIdentifier:ident];
}

#pragma mark -- UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = VC_BACKGROUND_COLOR;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABAddWalletsCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    NSDictionary* dic = self.dataArray[indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.iconImg.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


@end
