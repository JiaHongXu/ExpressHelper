//
//  QueryFreight.m
//  ChaKD
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "QueryTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "JHTools.h"

@implementation QueryTool

#pragma mark - Public Methods
+ (void)queryFrom:(NSString *)from to:(NSString *)to weight:(NSString *)weight page:(NSInteger)page complete:(void (^)(NSArray<NSDictionary *> *resultArray, BOOL hasMore))complete {
    NSString *url = [[NSString alloc] initWithFormat:@"http://chakd.com/index.php?action=search&start=%@&end=%@&weight=%@&Submit=%@&page=%ld", from, to, weight, @"快递查询", (long)page];
    
    [self fetchHTML:url complete:^(NSData *data) {
        NSString *htmlStr = [[NSString alloc] initWithData:data
                                                  encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        if ([htmlStr containsString:@"您提交的"]&&[htmlStr containsString:@"在系统内有重复"]) {
            NSString *newFrom = from;
            NSString *newTo = to;
            if ([htmlStr containsString:@"的出发地"]) {
                newFrom = [from stringByAppendingString:@"市"];
            }
            if ([htmlStr containsString:@"的目的地"]) {
                newTo = [to stringByAppendingString:@"市"];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self queryFrom:newFrom
                             to:newTo
                         weight:weight
                           page:page
                       complete:complete];
            });
        } else {
            [self requestRouteArrayFromData:data
                                     result:^(NSArray<NSDictionary *> *routeArray, BOOL hasMore) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             complete(routeArray, hasMore);
                                         });
                                     }];
        }
    }];
}

+ (void)queryCompanyUrl:(NSString *)companyUrl complete:(void (^)(NSDictionary *result))complete {
    NSString *url = [[NSString alloc] initWithFormat:@"http://chakd.com/%@", companyUrl];
    
    [self fetchHTML:url complete:^(NSData *data) {
        [self requestCompanyDetailFromData:data result:^(NSDictionary *company) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(company);
            });
        }];
    }];
}

#pragma mark - Network Methods
+ (void)fetchHTML:(NSString *)url complete:(void(^)(NSData *data))complete {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 对 URL 编码
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *formattedUrl = [url stringByAddingPercentEscapesUsingEncoding:encoding];
        
        // 抓取网页数据
        NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:formattedUrl]];
        CFStringRef bgCFStr = CFStringCreateWithBytes(NULL, [htmlData bytes], [htmlData length], kCFStringEncodingGB_18030_2000, false);
        NSString *htmlStr = (__bridge NSString *)bgCFStr;
        
        NSLog(@"%@", htmlStr);
        // 释放 CF 对象
        CFRelease(bgCFStr);
        
        complete([htmlStr dataUsingEncoding:encoding]);
        
    });
}

#pragma mark - TFHpple Methods
+ (void)requestRouteArrayFromData:(NSData *)data result:(void(^)(NSArray<NSDictionary *> *routeArray, BOOL hasMore))result {
    // Create model
    NSString *startAddress;
    NSString *endAddress;
    NSString *startUrl;
    NSString *endUrl;
    NSString *cost;
    NSString *time;
    NSString *daoFu;
    NSMutableArray<NSDictionary *> *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Create parser
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//tr[@bgcolor='#FFFFFF']"];
    
    @autoreleasepool {
        for (TFHppleElement *element in dataArray) {
            NSArray *subElements;
            
            // from / to address
            subElements = [element searchWithXPathQuery:@"//div/a"];
            if (subElements.count==0) {
                continue;
            }
            startAddress = [subElements[0] content];
            endAddress = [subElements[1] content];
            
            startUrl = [subElements[0] objectForKey:@"href"];
            endUrl = [subElements[1] objectForKey:@"href"];
            
            subElements = [element searchWithXPathQuery:@"//div[@align='center']"];
            
            if (subElements==nil||subElements.count==0) {
                break;
            }
            
            // cost
            cost = [subElements[0] content];
            
            // time
            time = [subElements[1] content];
            
            // is DaoFu
            daoFu = [subElements[2] content];
            
            // store in array
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
            [resultDic setObject:cost forKey:@"cost"];
            [resultDic setObject:time forKey:@"time"];
            [resultDic setObject:startAddress forKey:@"from"];
            [resultDic setObject:endAddress forKey:@"to"];
            [resultDic setObject:startUrl forKey:@"fromUrl"];
            [resultDic setObject:endUrl forKey:@"toUrl"];
            [resultDic setObject:daoFu forKey:@"daoFu"];
            [resultArray addObject:[resultDic copy]];
        };
    }
    
    NSArray *pages = [xpathParser searchWithXPathQuery:@"//a"];
    BOOL hasMore = NO;
    for (TFHppleElement *element in pages) {
        if ([element.attributes[@"title"] isEqualToString:@"Next Page"]) {
            hasMore = YES;
            break;
        }
    }
    result(resultArray, hasMore);
}

+ (void)requestCompanyDetailFromData:(NSData *)data result:(void(^)(NSDictionary *company))result {
    NSString *title;
    NSString *detail;
    NSArray *subElements;
    NSMutableDictionary *company = [[NSMutableDictionary alloc] init];
    // Create parser
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *dataArray = [xpathParser searchWithXPathQuery:@"//tr[@class='unnamed1']"];
    for (TFHppleElement *element in dataArray) {
        subElements = [element searchWithXPathQuery:@"//td"];
        if (subElements.count==2) {
            title = [subElements[0] content];
            detail = [subElements[1] content];
        }
        
        [company setObject:detail forKey:title];
    }
    
    result(company);
}
@end
