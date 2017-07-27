//
//  QueryCompanyModel.m
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/4.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "QueryCompanyModel.h"
#import "CompanyBean.h"

@interface QueryCompanyModel ()
@property (weak, nonatomic) CompanyBean *company;
@end

@implementation QueryCompanyModel
- (instancetype)initWithCompany:(CompanyBean *)company {
    if (self = [super init]) {
        _company = company;
    }
    return self;
}

- (void)refresh {
    [QueryTool queryCompanyUrl:_company.companyUrl complete:^(NSDictionary *result) {
        if (result) {
            _company.address = [self standardStringFromHTML:[result objectForKey:@"地址："]];
            _company.contact = [self standardStringFromHTML:[result objectForKey:@"联系方式："]];
            _company.availabeRange = [self standardStringFromHTML:[result objectForKey:@"派送范围："]];
            _company.unavailableRange = [self standardStringFromHTML:[result objectForKey:@"不派送范围："]];
            _company.daoFu = [self standardStringFromHTML:[result objectForKey:@"是否到付："]];
            _company.moreInfo = [self standardStringFromHTML:[result objectForKey:@"备注："]];
            _company.baseInfo = [self standardStringFromHTML:[result objectForKey:@"总部介绍："]];
            _company.isDetail = YES;
            if (self.successBlock) {
                self.successBlock(@"获取成功");
            }
        } else {
            if (self.failureBlock) {
                self.failureBlock(@"获取失败");
            }
        }
    }];
}

- (NSString *)standardStringFromHTML:(NSString *)htmlStr {
    NSString *string = htmlStr;
    if ([string hasPrefix:@"\r\n"]) {
        string = [string stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return string;
}
@end
