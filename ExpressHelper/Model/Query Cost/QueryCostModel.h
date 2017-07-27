//
//  QueryCostModel.h
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/4/25.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "BaseModel.h"

@class RouteBean;

@interface QueryCostModel : BaseModel
@property (strong, nonatomic) NSMutableArray<RouteBean *> *routeArray;
@property (assign, nonatomic) BOOL hasMore;

- (instancetype)initFrom:(NSString *)from to:(NSString *)to weight:(NSString *)weight;

- (void)refresh;
- (void)loadMore;

@end
