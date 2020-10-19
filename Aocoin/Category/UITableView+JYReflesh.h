//
//  UITableView+JYReflesh.h
//  JinRongProject
//
//  Created by jiaoyu on 2017/3/8.
//  Copyright © 2017年 Xing All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RefreshType) {
    HeadRefreshType = 0,
    FooterRefreshType,
};
typedef void(^RefreshBlock)();
typedef void(^ReBackBlock)(RefreshType refreshType);
typedef NS_ENUM(NSInteger,JYRefreshType) {
    RefreshTypeDropDown = 0,  //只支持下拉
    RefreshTypeDropUp,        //只支持上拉
    RefreshTypeUpDown,        //支持上拉和下拉
};
@interface UITableView (JYReflesh)
//正常模式上拉下拉
-(void)normalWithrefreshType:(JYRefreshType)refreshType
                firstRefresh:(BOOL)firstRefresh
               dropDownBlock:(RefreshBlock)dropDownBlock
                 upDropBlock:(RefreshBlock)upDropBlock;

//gifRefresh
- (void)gifModelRefreshWithrefreshType:(JYRefreshType)refreshType
                          firstRefresh:(BOOL)firstRefresh
                         timeLabHidden:(BOOL)timeLabHidden
                        stateLabHidden:(BOOL)stateLabHidden
                         dropDownBlock:(RefreshBlock)dropDownBlock
                           upDropBlock:(RefreshBlock)upDropBlock;

/*所有网路请求回来后调用更换下刷新状态*/
-(void)reloadRefrshState:(NSArray*)rebackArray
               dataArray:(NSMutableArray*)dataArray;

-(void)endRefrenshing;

-(void)beginRefreshing;
@end
