//
//  BaseViewModel.h
//  ZhiFeiUser
//
//  Created by 307A on 2017/1/18.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSString *successMsg);
typedef void(^ErrorBlock)(NSString *errorMsg);
typedef void(^FailureBlock)(NSString *failureMsg);

@interface BaseModel : NSObject
@property (strong, nonatomic) SuccessBlock successBlock;
@property (strong, nonatomic) ErrorBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (SuccessBlock)successBlock
               WithFailureBlock: (FailureBlock)failureBlock
                 WithErrorBlock: (ErrorBlock) errorBlock;
@end
