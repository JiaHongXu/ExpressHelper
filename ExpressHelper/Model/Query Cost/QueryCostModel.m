//
//  QueryCostModel.m
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/4/25.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "QueryCostModel.h"

#import "RouteBean.h"

@interface QueryCostModel ()

@property (strong, nonatomic) NSString *from;
@property (strong, nonatomic) NSString *to;
@property (strong, nonatomic) NSString *weight;
@property (assign, nonatomic) NSInteger page;

@end

@implementation QueryCostModel
#pragma mark - Init Methods
- (instancetype)initFrom:(NSString *)from to:(NSString *)to weight:(NSString *)weight {
    if (self = [super init]) {
        _from = from;
        _to = to;
        _weight = weight;
        _page = 1;
    }
    
    return self;
}

#pragma mark - Public Methods
- (void)refresh {
    [QueryTool queryFrom:_from to:_to weight:_weight page:1 complete:^(NSArray<NSDictionary *> *resultArray, BOOL hasMore) {
        if (resultArray.count!=0) {
            [self.routeArray removeAllObjects];
            for (NSDictionary *dic in resultArray) {
                RouteBean *route = [[RouteBean alloc] initWithDic:dic];
                route.from = _from;
                route.to = _to;
                [_routeArray addObject:route];
            }
            _page++;
            self.successBlock(@"刷新成功");
            _hasMore = hasMore;
        } else {
            self.failureBlock(@"没有快递信息");
        }
    }];
}

- (void)loadMore {
    [QueryTool queryFrom:_from to:_to weight:_weight page:_page complete:^(NSArray<NSDictionary *> *resultArray, BOOL hasMore) {
        if (resultArray.count!=0) {
            for (NSDictionary *dic in resultArray) {
                RouteBean *route = [[RouteBean alloc] initWithDic:dic];
                route.from = _from;
                route.to = _to;
                [_routeArray addObject:route];
            }
            _page++;
            _hasMore = hasMore;
            self.successBlock(@"加载成功");
        } else {
            self.failureBlock(@"没有快递信息");
        }
    }];
}

#pragma mark - Getter
- (NSMutableArray<RouteBean *> *)routeArray {
    if (!_routeArray) {
        _routeArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _routeArray;
}
@end
