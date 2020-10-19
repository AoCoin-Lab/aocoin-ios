//
//  UITableView+JYReflesh.m
//  JinRongProject
//
//  Created by jiaoyu on 2017/3/8.
//  Copyright © 2017年 Xing All rights reserved.
//

#import "UITableView+JYReflesh.h"
#import "MJRefresh.h"


static RefreshType refreshTypeValue;

@interface UITableView ()

@property(nonatomic,strong)NSArray *idleImages;
@property(nonatomic,strong)NSArray *pullingImages;
@property(nonatomic,strong)NSArray *refreshingImages;

@end

@implementation UITableView (JYReflesh)
//正常模式下拉上拉刷新(firstRefresh第一次进入的时候是否要刷新,这个值只对下拉刷新有影响)
-(void)normalWithrefreshType:(JYRefreshType)refreshType
                firstRefresh:(BOOL)firstRefresh
               dropDownBlock:(RefreshBlock)dropDownBlock
                 upDropBlock:(RefreshBlock)upDropBlock{
    WeakSelf(UITableView);
    switch (refreshType) {
        case RefreshTypeDropDown:{
            weakSelf.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                refreshTypeValue = HeadRefreshType;
                if (dropDownBlock) {
                    dropDownBlock();
                }
            }];
            if (firstRefresh) {
                [weakSelf.mj_header beginRefreshing];
            }
        }
            break;
        case RefreshTypeDropUp:{
            MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                refreshTypeValue = FooterRefreshType;
                if (upDropBlock) {
                    upDropBlock();
                }
            }];
            weakSelf.mj_footer = footer;
            [weakSelf.mj_footer setAutomaticallyHidden:YES];
        }
            break;
        case RefreshTypeUpDown:{
            weakSelf.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                refreshTypeValue = HeadRefreshType;
                if (dropDownBlock) {
                    dropDownBlock();
                }
            }];
            if (firstRefresh) {
                [weakSelf.mj_header beginRefreshing];
            }
            weakSelf.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                refreshTypeValue = FooterRefreshType;
                if (upDropBlock) {
                    upDropBlock();
                }
            }];
            [weakSelf.mj_footer setAutomaticallyHidden:YES];
        }
            break;
        default:
            break;
    }
}



//gifRefresh
- (void)gifModelRefreshWithrefreshType:(JYRefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(RefreshBlock)dropDownBlock upDropBlock:(RefreshBlock)upDropBlock {
    if (refreshType == RefreshTypeDropDown) {
        //只支持下拉
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            refreshTypeValue = HeadRefreshType;
            if (dropDownBlock) {
                dropDownBlock();
            }
        }];
        [header setImages:self.idleImages forState:MJRefreshStateIdle];
        [header setImages:self.pullingImages forState:MJRefreshStatePulling];
        [header setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        header.stateLabel.hidden = stateLabHidden;
        self.mj_header = header;
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
    }else if (refreshType == RefreshTypeDropUp) {
        //初始化并指定方法
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            refreshTypeValue = FooterRefreshType;
            if (upDropBlock) {
                upDropBlock();
            }
        }];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
        
    }else if (refreshType == RefreshTypeUpDown) {
        //支持上拉和下拉加载
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            refreshTypeValue = HeadRefreshType;
            if (dropDownBlock) {
                dropDownBlock();
            }
        }];
        [header setImages:self.idleImages forState:MJRefreshStateIdle];
        [header setImages:self.pullingImages forState:MJRefreshStatePulling];
        [header setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        header.stateLabel.hidden = stateLabHidden;
        self.mj_header = header;
        if (firstRefresh) {
            [self.mj_header beginRefreshing];
        }
        //初始化并指定方法
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (upDropBlock) {
                upDropBlock();
            }
        }];
    }
}

// 必须在网络请求回来成功和失败里边都要调用，失败的情况返回的rebackArray 传递过来的是nil
// 但是dataArray务必始终都要把全局dataArray传递过来
// 且rebackArray和dataArray都必须是包装成model的对象不能是直接接口返回的
-(void)reloadRefrshState:(NSArray*)rebackArray dataArray:(NSMutableArray*)dataArray{
    switch (refreshTypeValue) {
        case HeadRefreshType:{
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:rebackArray];
            [self reloadData];
            [self.mj_header endRefreshing];
            if (self.mj_footer.state == MJRefreshStateNoMoreData) {
                [self.mj_footer resetNoMoreData];
            }
        }
            break;
        case FooterRefreshType:{
            [dataArray addObjectsFromArray:rebackArray];
            [self reloadData];
            if (rebackArray.count == 0) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mj_footer resetNoMoreData];
                [self.mj_footer endRefreshing];
            }
        }
            break;
        default:
            [self reloadData];
            break;
    }
}

-(void)endRefrenshing{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

-(void)beginRefreshing{
    [self.mj_header beginRefreshing];
}

@end

