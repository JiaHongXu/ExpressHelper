//
//  CompanyDetailViewController.h
//  ExpressHelper
//
//  Created by 307A on 2016/10/31.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "BaseViewController.h"
@class CompanyBean;

@interface CompanyDetailViewController : BaseViewController
- (instancetype)initWithCompany:(CompanyBean *)company;
@end
