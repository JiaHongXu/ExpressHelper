//
//  CompanyBean.m
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/16.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "CompanyBean.h"

@implementation CompanyBean
- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    if (self = [super init]) {
        _companyName = name;
        _companyUrl = url;
        _isDetail = NO;
    }
    return self;
}

#pragma mark - Setter
- (void)setDaoFu:(NSString *)daoFu {
    if ([daoFu isEqualToString:@""]) {
        _daoFu = @"无";
    } else {
        _daoFu = daoFu;
    }
}

- (void)setAddress:(NSString *)address {
    if ([address isEqualToString:@""]) {
        _address = @"无";
    } else {
        _address = address;
    }
}

- (void)setBaseInfo:(NSString *)baseInfo {
    if ([baseInfo isEqualToString:@""]) {
        _baseInfo = @"无";
    } else {
        _baseInfo = baseInfo;
    }
}

- (void)setContact:(NSString *)contact {
    if ([contact isEqualToString:@""]) {
        _contact = @"无";
    } else {
        _contact = contact;
    }
}

- (void)setMoreInfo:(NSString *)moreInfo {
    if ([moreInfo isEqualToString:@""]) {
        _moreInfo = @"无";
    } else {
        _moreInfo = moreInfo;
    }
}

- (void)setAvailabeRange:(NSString *)availabeRange {
    if ([availabeRange isEqualToString:@""]) {
        _availabeRange = @"无";
    } else {
        _availabeRange = availabeRange;
    }
}

- (void)setUnavailableRange:(NSString *)unavailableRange {
    if ([unavailableRange isEqualToString:@""]) {
        _unavailableRange = @"无";
    } else {
        _unavailableRange = unavailableRange;
    }
}
@end
