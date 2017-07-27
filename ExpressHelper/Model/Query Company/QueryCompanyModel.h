//
//  QueryCompanyModel.h
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/4.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "BaseModel.h"
@class CompanyBean;
@interface QueryCompanyModel : BaseModel
- (instancetype)initWithCompany:(CompanyBean *)company;

- (void)refresh;
@end
