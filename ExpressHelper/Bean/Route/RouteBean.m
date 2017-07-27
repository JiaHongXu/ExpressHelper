//
//  RouteBean.m
//  ChaKD
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RouteBean.h"
#import "CompanyBean.h"

@implementation RouteBean

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _companyName = [dic objectForKey:@"from"];
        
        _fromCompany = [[CompanyBean alloc] initWithName:[dic objectForKey:@"from"] url:[dic objectForKey:@"fromUrl"]];
        _toCompany = [[CompanyBean alloc] initWithName:[dic objectForKey:@"to"] url:[dic objectForKey:@"toUrl"]];
        _cost = [[dic objectForKey:@"cost"] stringByReplacingOccurrencesOfString:@"元" withString:@""];
        _time = [dic objectForKey:@"time"];
        _daoFu = [dic objectForKey:@"daoFu"];
    }
    return self;
}

#pragma mark - Private
- (NSString *)generateCompanyName {
    NSArray<NSString *> *replaceSets = @[@"快递公司",
                                         @"分公司",
                                         @"公司",
                                         @"快递",
                                         [NSString stringWithFormat:@"%@市", _from],
                                         _from];
    NSString *name = _companyName;
    for (NSString *string in replaceSets) {
        name = [name stringByReplacingOccurrencesOfString:string withString:@""];
    }
    
    return [name stringByAppendingString:@"快递"];
}

#pragma mark - Getter
- (NSString *)companyName {
    return [self generateCompanyName];
}

@end
