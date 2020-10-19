//
//  BaseTableViewController.h
//  JinRongProject
//
//  Created by 邢现庆 on 2017/3/10.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "ABBaseViewController.h"


@interface ABBaseTableViewController : ABBaseViewController <UITableViewDelegate,UITableViewDataSource>

//m文件中已经进行初始化,子类可直接使用
@property(nonatomic,strong)NSMutableArray* dataArray;
//分页的页码，供列表页面使用，m文件中设置初始值为0，如果页码从1开始，需要在子类重新设置
@property(nonatomic,assign)NSInteger pageNum;
//tableview
@property(nonatomic,strong)UITableView* tableView;
//tableview frame
@property(nonatomic,assign)CGRect tableViewFrame;
//tableView style
@property(nonatomic,assign)UITableViewStyle tableViewStyle;

//初始化
- (id)initWithTableFrame:(CGRect)frame style:(UITableViewStyle)style;

@end
