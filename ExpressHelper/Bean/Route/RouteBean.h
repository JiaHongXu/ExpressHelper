//
//  RouteBean.h
//  ChaKD
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CompanyBean;

@interface RouteBean : NSObject
@property (strong, nonatomic) NSString *from;
@property (strong, nonatomic) NSString *to;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *cost;
@property (strong, nonatomic) NSString *daoFu;              // 是否到付
@property (strong, nonatomic) CompanyBean *fromCompany;
@property (strong, nonatomic) CompanyBean *toCompany;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
