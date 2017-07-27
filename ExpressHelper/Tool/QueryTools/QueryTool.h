//
//  QueryFreight.h
//  ChaKD
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryTool : NSObject
/**
 * 查询两个城市间的快递运费
 * @param from 出发地
 * @param to 目的地
 * @param weight 重量
 * @param page 页数
 * @param complete 处理查询结果
 **/
+ (void)queryFrom:(NSString *)from to:(NSString *)to weight:(NSString *)weight page:(NSInteger)page complete:(void (^)(NSArray<NSDictionary *> *resultArray, BOOL hasMore))complete;

/**
 * 查询快递公司信息
 * @param companyUrl 查询运费里获得的公司网址 如 d.php?id=42&areacode=010
 * @param complete 处理查询结果
 **/
+ (void)queryCompanyUrl:(NSString *)companyUrl complete:(void (^)(NSDictionary *result))complete;
@end
