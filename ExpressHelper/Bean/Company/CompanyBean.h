//
//  CompanyBean.h
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/16.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyBean : NSObject
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *companyUrl;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *contact;
@property (strong, nonatomic) NSString *availabeRange;
@property (strong, nonatomic) NSString *unavailableRange;
@property (strong, nonatomic) NSString *daoFu;
@property (strong, nonatomic) NSString *moreInfo;
@property (strong, nonatomic) NSString *baseInfo;

@property (assign, nonatomic) BOOL isDetail;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;
@end
