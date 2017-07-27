//
//  BaseModel.m
//
//  Created by 307A on 2017/1/18.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "BaseModel.h"
@implementation BaseModel

- (void)setBlockWithReturnBlock:(SuccessBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithErrorBlock:(ErrorBlock)errorBlock {
    _successBlock = successBlock;
    _failureBlock = failureBlock;
    _errorBlock = errorBlock;
}
@end
