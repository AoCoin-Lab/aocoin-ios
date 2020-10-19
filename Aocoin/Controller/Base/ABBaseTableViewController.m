//
//  BaseTableViewController.m
//  JinRongProject
//
//  Created by 邢现庆 on 2017/3/10.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "ABBaseTableViewController.h"
#import "MJRefresh.h"

@interface ABBaseTableViewController ()

@end

@implementation ABBaseTableViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        _tableViewFrame = CGRectZero;
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}
- (id)initWithTableFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _tableViewStyle = style;
        _tableViewFrame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}

-(void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:_tableViewFrame style:_tableViewStyle];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = VC_BACKGROUND_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    //主要是为了解决在iPad上tableview的内边距过大
    if (IS_IPAD && @available(iOS 9.0,*)) self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    [self.view addSubview:self.tableView];
}
-(void)setTableViewFrame:(CGRect)tableViewFrame{
    _tableViewFrame = tableViewFrame;
    if (_tableView) {
        _tableView.frame = tableViewFrame;
    }
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSInteger)pageNum{
    if (!_pageNum) {
        _pageNum = 0;
    }
    return _pageNum;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
